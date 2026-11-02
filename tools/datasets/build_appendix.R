#!/usr/bin/env Rscript
# Generates chapters/appendix-datasets.md from the per-dataset keys in data/
# (one <name>.md beside each <name>.csv, following data/DATASET_STYLE_GUIDE.md).
# The keys are the single source of truth. Never edit the appendix by hand.
#
#   Rscript tools/datasets/build_appendix.R                 write the appendix
#   Rscript tools/datasets/build_appendix.R --plain FILE    write a plain-Markdown
#       copy of the keys (no Quarto blocks) for the downloadable archive
#
# Every key is checked against its CSV before anything is written: the key must
# exist for each CSV, and the row count, column count, and variable names in the
# key must match the file. A mismatch stops the script with exit status 1.
#
# The "as of" date is the date of the last commit that touched data/, so
# rerunning the script on another day does not change the file.

args <- commandArgs(trailingOnly = TRUE)
root <- normalizePath(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "..", ".."))
setwd(root)

plain_out <- if (length(args) == 2 && args[1] == "--plain") args[2] else NULL

# ---- Parse each per-dataset key ----
section <- function(lines, name, file) {
  i <- grep(paste0("^## ", name, "\\s*$"), lines)
  if (length(i) != 1) stop(file, ": expected one '## ", name, "' section")
  rest <- lines[(i + 1):length(lines)]
  nxt <- grep("^## ", rest)
  body <- if (length(nxt)) rest[seq_len(nxt[1] - 1L)] else rest
  body <- body[!grepl("^-{3,}\\s*$", body)]
  while (length(body) && !nzchar(trimws(body[1]))) body <- body[-1]
  while (length(body) && !nzchar(trimws(body[length(body)]))) body <- body[-length(body)]
  body
}

key_files <- list.files("data", pattern = "\\.md$", full.names = TRUE)
key_files <- key_files[basename(key_files) != "DATASET_STYLE_GUIDE.md"]
key_files <- key_files[order(basename(key_files), method = "radix")]
problems <- character()

csvs <- list.files("data", pattern = "\\.csv$")
for (m in setdiff(csvs, sub("\\.md$", ".csv", basename(key_files))))
  problems <- c(problems, paste0(m, ": no matching key data/", sub("\\.csv$", ".md", m)))

datasets <- lapply(key_files, function(path) {
  lines <- readLines(path, encoding = "UTF-8", warn = FALSE)
  start <- grep("^# Dataset: `", lines)
  if (length(start) != 1) stop(path, ": expected exactly one '# Dataset: `file.csv`' heading")
  lines <- lines[start:length(lines)]
  file <- sub("^# Dataset: `(.+)`\\s*$", "\\1", lines[1])
  if (file != sub("\\.md$", ".csv", basename(path)))
    problems <<- c(problems, paste0(path, ": heading names ", file))
  fmt <- section(lines, "Format", path)
  vd <- grep("^### Variable Dictionary", fmt)
  if (length(vd) != 1) stop(path, ": expected one '### Variable Dictionary'")
  fmt_text <- fmt[seq_len(vd - 1L)]
  table <- fmt[(vd + 1L):length(fmt)]
  table <- table[nzchar(trimws(table))]
  # Pandoc sizes pipe-table columns by the dash counts in the separator row.
  # Give the variable names room (some are 23 characters) and keep "Categorical"
  # on one line in the PDF.
  stopifnot(grepl("^\\|[ :|-]+\\|\\s*$", table[2]))
  table[2] <- paste0("| :", strrep("-", 29), " | :", strrep("-", 14), " | :", strrep("-", 54), " |")

  # Check the key against the CSV.
  csv_path <- file.path("data", file)
  if (file.exists(csv_path)) {
    d <- utils::read.csv(csv_path, check.names = FALSE, stringsAsFactors = FALSE, nrows = -1)
    # Ignore trailing columns with no name and no values (smoking_bmi_bp.csv has six).
    blank <- names(d) == "" & vapply(d, function(x) all(is.na(x) | x == ""), logical(1))
    d <- d[, !blank, drop = FALSE]
    txt <- paste(fmt_text, collapse = " ")
    num <- function(re) {
      x <- regmatches(txt, regexec(re, txt))[[1]]
      if (length(x) < 2) NA_integer_ else as.integer(gsub(",", "", x[2]))
    }
    n_key <- num("\\*\\*([0-9,]+) observations\\*\\*")
    p_key <- num("\\*\\*([0-9,]+) variables\\*\\*")
    if (is.na(n_key) || n_key != nrow(d))
      problems <<- c(problems, sprintf("%s: key says %s rows, CSV has %d", file, n_key, nrow(d)))
    if (is.na(p_key) || p_key != ncol(d))
      problems <<- c(problems, sprintf("%s: key says %s variables, CSV has %d", file, p_key, ncol(d)))
    vars <- sub("^\\|\\s*`([^`]+)`.*$", "\\1", table[grepl("^\\|\\s*`", table)])
    if (!setequal(vars, names(d)) || anyDuplicated(vars))
      problems <<- c(problems, sprintf("%s: variable names differ. Key only: %s. CSV only: %s", file,
        paste(setdiff(vars, names(d)), collapse = ", "), paste(setdiff(names(d), vars), collapse = ", ")))
  } else {
    problems <<- c(problems, paste0(path, ": no matching CSV ", csv_path))
  }

  list(file = file,
       description = section(lines, "Description", path),
       format = fmt_text[nzchar(trimws(fmt_text))],
       table = table,
       details = section(lines, "Details", path),
       source = section(lines, "Source", path))
})

if (length(problems)) {
  cat("Dataset keys do not match the data:\n", paste0("  ", problems, "\n"), sep = "")
  quit(status = 1)
}

# ---- Facts shared by both outputs ----
as_of <- local({
  d <- suppressWarnings(system2("git", c("log", "-1", "--format=%cs", "--", "data"),
                                stdout = TRUE, stderr = FALSE))
  d <- if (length(d) && nzchar(d[1])) as.Date(d[1]) else
    as.Date(max(file.mtime(list.files("data", full.names = TRUE))))
  paste0(format(d, "%B"), " ", as.integer(format(d, "%d")), ", ", format(d, "%Y"))
})

repo_url <- local({
  idx <- paste(readLines("index.md", encoding = "UTF-8", warn = FALSE), collapse = "\n")
  m <- regmatches(idx, regexpr("https://github\\.com/[^) \n]+", idx))
  if (length(m)) m else NA_character_
})

file_size <- function(path) {
  b <- file.size(path)
  if (b >= 1024^2) sprintf("%.1f MB", b / 1024^2) else sprintf("%d KB", as.integer(ceiling(b / 1024)))
}

n <- length(datasets)

# ---- Render ----
render <- function(plain) {
  out <- character()
  add <- function(...) out <<- c(out, ...)
  if (plain) {
    add("# Datasets", "")
    add(sprintf("Every dataset used in *Statistical Methods in Research* is a CSV file with one row per observation and one column per variable. Each section names the file, describes it, lists its variables, explains how the data were collected, and cites the source. Data files as of %s.", as_of), "")
  } else {
    add("<!-- Generated by tools/datasets/build_appendix.R from data/DATASET_KEY.md. Do not edit by hand. -->", "")
    add("# Datasets", "")
    add(sprintf("Every dataset used in this book is available as a CSV file, with one row per observation and one column per variable. Each section below names the file, describes it, lists its variables in a table, explains how the data were collected, and cites the source. Data files as of %s.", as_of), "")
    add("::: {.content-visible when-format=\"html\"}",
        sprintf("Download any file from its section, or get all %d files and this key together as [one ZIP archive](../data/statmethods-datasets.zip).", n),
        ":::", "")
    add("::: {.content-visible when-format=\"pdf\"}",
        if (is.na(repo_url)) "The PDF edition does not include the data files. Download them from the web edition of the book." else
          sprintf("The PDF edition does not include the data files. Download them from the web edition of the book or from the data folder of the repository: %s/tree/main/data", repo_url),
        ":::", "")
  }
  for (d in datasets) {
    add(sprintf("## `%s`", d$file), "")
    add(paste0("**Description.** ", d$description[1]), d$description[-1], "")
    add(paste0("**File.** ", paste(d$format, collapse = " ")), "")
    if (!plain) {
      add("::: {.content-visible when-format=\"html\"}",
          sprintf("[Download %s (CSV file, %s)](../data/%s)", d$file, file_size(file.path("data", d$file)), d$file),
          ":::", "")
    }
    add(d$table, "", sprintf(": Variables in `%s`, with data type and coding key.", d$file), "")
    add(paste0("**Details.** ", d$details[1]), d$details[-1], "")
    add(paste0("**Source.** ", d$source[1]), d$source[-1], "")
  }
  out
}

if (is.null(plain_out)) {
  writeLines(render(FALSE), "chapters/appendix-datasets.md", useBytes = TRUE)
  cat(sprintf("Wrote chapters/appendix-datasets.md (%d datasets, as of %s)\n", n, as_of))
} else {
  writeLines(render(TRUE), plain_out, useBytes = TRUE)
  cat(sprintf("Wrote %s\n", plain_out))
}
