#!/usr/bin/env Rscript
# =============================================================================
# Validate one chapter's figures against FIGURES.md.
#
# Usage (from the project root):
#   Rscript r_code/figures/check_chapter.R 01
#
# Hard failures (exit 1):
#   - a registered PNG is missing
#   - the PNG dimensions do not match the registry
#   - alt text is missing, multi-line, quoted, or repeats the caption
#   - a non-table placeholder has no registered figure
#   - an image path is absolute
#   - an image has no fig-alt attribute
#
# Warnings (exit 0):
#   - the figure is not embedded yet (run sync_chapter.R)
#   - the chapter embed and the registry disagree (run sync_chapter.R)
#   - duplicate base figure numbers
#   - low contrast or close colours in the rendered palette
#   - author notes recorded in the registry
# =============================================================================

source("r_code/figures/_book_figs.R")

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1) {
  stop("Usage: Rscript r_code/figures/check_chapter.R NN", call. = FALSE)
}
chapter <- as.integer(args[1])
chapter_file <- sprintf("chapters/chapter-%02d.md", chapter)

if (!file.exists(chapter_file)) {
  stop("chapter file not found: ", chapter_file, call. = FALSE)
}

reg <- read_registry(chapter)
lines <- readLines(chapter_file, warn = FALSE)

fails <- 0L
warns <- 0L

fail <- function(...) {
  fails <<- fails + 1L
  cat("FAIL  ", ..., "\n", sep = "")
}
warn <- function(...) {
  warns <<- warns + 1L
  cat("WARN  ", ..., "\n", sep = "")
}
pass <- function(...) cat("PASS  ", ..., "\n", sep = "")
info <- function(...) cat("INFO  ", ..., "\n", sep = "")

# ---- Registered figures -----------------------------------------------------

if (!length(reg$figures)) {
  info("no figures registered in ", registry_path(chapter), "; nothing to validate")
} else {
  for (entry in reg$figures) {
    label <- paste0("Figure ", entry$id)
    out_path <- file.path(chapter_dir(chapter), entry$file)

    if (!file.exists(out_path)) {
      fail(label, ": missing file ", out_path)
      next
    }

    dims <- tryCatch(
      system2(
        "identify",
        c("-format", shQuote("%w %h"), shQuote(out_path)),
        stdout = TRUE, stderr = FALSE
      ),
      error = function(e) character()
    )
    if (!length(dims) || !nzchar(dims[1])) {
      warn(label, ": could not read PNG dimensions (ImageMagick identify)")
    } else {
      px <- as.integer(strsplit(trimws(dims[1]), "\\s+")[[1]][1:2])
      expected <- round(c(entry$width_in, entry$height_in) * entry$dpi)
      if (any(abs(px - expected) > 2)) {
        fail(label, ": PNG is ", px[1], "x", px[2],
             " px, expected about ", expected[1], "x", expected[2])
      } else {
        pass(label, ": file and dimensions")
      }
    }

    alt_ok <- tryCatch({
      validate_alt(entry$alt, entry$caption)
      TRUE
    }, error = function(e) {
      fail(label, ": alt text: ", conditionMessage(e))
      FALSE
    })
    if (alt_ok) pass(label, ": alt text present")

    if (!is.null(entry$colour_audit)) {
      ca <- entry$colour_audit
      if (isTRUE(ca$min_contrast < 3)) {
        warn(label, sprintf(": minimum fill contrast is %.2f:1; rely on a dark outline and labels",
                            ca$min_contrast))
      }
      if (!is.null(ca$min_lab_distance) && isTRUE(ca$min_lab_distance < 20)) {
        warn(label, sprintf(": closest colour pair has Lab distance %.1f; add a redundant encoding",
                            ca$min_lab_distance))
      }
    }

    if (!is.null(entry$author_note) && nzchar(entry$author_note)) {
      info(label, " author note: ", entry$author_note)
    }

    embed_idx <- grep(entry$file, lines, fixed = TRUE)
    if (!length(embed_idx)) {
      warn(label, ": not embedded in the chapter yet (run sync_chapter.R)")
    } else if (length(embed_idx) > 1) {
      fail(label, ": appears on more than one chapter line")
    } else {
      embed_alt <- regmatches(
        lines[embed_idx],
        regexec('\\{fig-alt="([^"]*)"\\}', lines[embed_idx])
      )[[1]]
      if (length(embed_alt) < 2) {
        fail(label, ": image block has no fig-alt attribute")
      } else if (!identical(embed_alt[2], entry$alt)) {
        warn(label, ": chapter alt text differs from the registry (run sync_chapter.R)")
      } else {
        pass(label, ": chapter embed and alt text match the registry")
      }
    }
  }
}

# ---- Placeholders -----------------------------------------------------------

ph_lines <- grep("\\[Insert (Figure|Graph)", lines)
if (length(ph_lines)) {
  ph_ids <- sub(
    ".*\\[Insert (Figure|Graph) ([0-9]+\\.[0-9A-Za-z]+):.*",
    "\\2", lines[ph_lines]
  )
  is_table <- grepl(
    "\\btable\\b|Minitab|output table", lines[ph_lines], ignore.case = TRUE
  )

  for (i in seq_along(ph_lines)) {
    if (is_table[i]) {
      info("line ", ph_lines[i], ": table placeholder ", ph_ids[i],
           " (native table required, not an image)")
      next
    }
    registered <- any(vapply(
      reg$figures, function(e) identical(e$id, ph_ids[i]), logical(1)
    ))
    if (!registered) {
      fail("line ", ph_lines[i], ": placeholder ", ph_ids[i],
           " has no registered figure")
    }
  }

  base_ids <- sub("[A-Za-z]+$", "", ph_ids)
  dup <- base_ids[duplicated(base_ids) | duplicated(base_ids, fromLast = TRUE)]
  if (length(unique(dup))) {
    warn("duplicate base figure number(s): ",
         paste(sort(unique(dup)), collapse = ", "),
         ". Renumber the chapter or keep a letter suffix.")
  }
} else {
  info("no [Insert Figure ...] placeholders remain")
}

# ---- Image paths ------------------------------------------------------------

embeds <- grep("!\\[[^]]*\\]\\([^)]+\\)", lines)
if (length(embeds)) {
  for (i in embeds) {
    path <- sub(".*!\\[[^]]*\\]\\(([^)]+)\\).*", "\\1", lines[i])
    if (grepl("^/", path) || grepl("/home/", path, fixed = TRUE)) {
      fail("line ", i, ": absolute image path")
    } else if (!startsWith(path, sprintf("../figures/chapter_%02d/", chapter))) {
      warn("line ", i, ": image path is not ../figures/chapter_",
           sprintf("%02d", chapter), "/")
    }
  }
}

cat(sprintf("\nChapter %02d: %d failure(s), %d warning(s).\n", chapter, fails, warns))
if (fails > 0) quit(status = 1L)
