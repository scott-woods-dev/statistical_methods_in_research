# =============================================================================
# Shared figure system for "Statistical Methods in Research"
#
# Source this file from each r_code/figures/chapter_NN.R script:
#   source("r_code/figures/_book_figs.R")
#
# It provides:
#   book_theme()          one ggplot2 theme for every figure
#   book_palette          Okabe-Ito colours, safe for colour-vision deficiency
#   save_book_fig()       saves a 300-dpi PNG, validates alt text, audits
#                         colour contrast, and writes figures/chapter_NN/figures.yml
#   save_book_values()    writes figures/chapter_NN/values.yml with the
#                         chapter's statistics, model calls, and conventions
#   contrast_text()       picks white or dark text for a coloured fill
#
# The registries written by save_book_fig() and save_book_values() are
# generated. Do not edit them by hand; edit the caption, alt text, or values in
# the chapter's R script and rerun it.
# =============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(readr)
  library(scales)
  library(yaml)
  library(ragg)
  library(systemfonts)
  library(colorspace)
})

# ---- Book-wide constants ----------------------------------------------------

BOOK_DPI <- 300
BOOK_WIDTH <- 6.5
BOOK_HEIGHT <- 4.25
BOOK_BG <- "#FFFFFF"
BOOK_INK <- "#1A1A1A"
BOOK_MUTED <- "#4D4D4D"
BOOK_GRID <- "#E6E6E6"
BOOK_FONT <- "Inter"

# Okabe-Ito palette. The yellow is included for fills with a dark outline and
# direct labels, never as a line or text colour on white.
book_palette <- c(
  blue        = "#0072B2",
  vermillion  = "#D55E00",
  bluish_green = "#009E73",
  purple      = "#CC79A7",
  orange      = "#E69F00",
  sky_blue    = "#56B4E9",
  yellow      = "#F0E442",
  black       = "#000000"
)

# ---- Theme ------------------------------------------------------------------

assert_book_font <- function() {
  found <- systemfonts::match_fonts(BOOK_FONT)
  if (!nzchar(found$path[1])) {
    stop("Font '", BOOK_FONT, "' was not found. Install Inter or change BOOK_FONT.",
         call. = FALSE)
  }
  invisible(TRUE)
}

book_theme <- function(base_size = 12, base_family = BOOK_FONT) {
  assert_book_font()
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      text = element_text(colour = BOOK_INK),
      plot.title = element_blank(),
      plot.subtitle = element_text(
        colour = BOOK_INK, size = base_size * 1.02,
        margin = margin(b = 8)
      ),
      axis.title = element_text(colour = BOOK_INK, size = base_size),
      axis.text = element_text(colour = BOOK_INK, size = base_size * 0.9),
      axis.line = element_line(colour = BOOK_MUTED, linewidth = 0.4),
      axis.ticks = element_line(colour = BOOK_MUTED, linewidth = 0.4),
      panel.grid.major = element_line(colour = BOOK_GRID, linewidth = 0.35),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = BOOK_BG, colour = NA),
      plot.background = element_rect(fill = BOOK_BG, colour = NA),
      plot.margin = margin(10, 14, 10, 10),
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.title = element_text(colour = BOOK_INK, size = base_size * 0.9),
      legend.text = element_text(colour = BOOK_INK, size = base_size * 0.9),
      legend.key.height = unit(0.9, "lines"),
      legend.key.width = unit(1.2, "lines"),
      strip.text = element_text(
        colour = BOOK_INK, face = "bold", size = base_size * 0.95
      ),
      strip.background = element_rect(fill = "#F2F2F2", colour = NA)
    )
}

# ---- Contrast and colour audits ---------------------------------------------

# WCAG relative luminance for one or more hex colours.
wcag_luminance <- function(hex) {
  rgb <- grDevices::col2rgb(hex) / 255
  lin <- ifelse(rgb <= 0.04045, rgb / 12.92, ((rgb + 0.055) / 1.055)^2.4)
  as.numeric(0.2126 * lin[1, ] + 0.7152 * lin[2, ] + 0.0722 * lin[3, ])
}

# WCAG 2.1 contrast ratio between foreground(s) and a background.
wcag_contrast <- function(fg, bg = BOOK_BG) {
  l1 <- wcag_luminance(fg)
  l2 <- wcag_luminance(rep(bg, length.out = length(fg)))
  hi <- pmax(l1, l2)
  lo <- pmin(l1, l2)
  (hi + 0.05) / (lo + 0.05)
}

# Choose the higher-contrast text colour for each fill.
contrast_text <- function(fill, light = "#FFFFFF", dark = BOOK_INK) {
  cw <- wcag_contrast(fill, light)
  cd <- wcag_contrast(fill, dark)
  ifelse(cw >= cd, light, dark)
}

# Report contrast and perceptual separation for a set of rendered colours.
audit_palette <- function(cols, label = "plot") {
  cols <- unique(cols[grepl("^#", cols)])
  if (!length(cols)) return(NULL)

  contrast <- wcag_contrast(cols, BOOK_BG)
  min_contrast <- min(contrast)

  if (length(cols) >= 2) {
    lab <- methods::as(colorspace::hex2RGB(cols), "LAB")
    d <- as.matrix(stats::dist(methods::slot(lab, "coords")))
    diag(d) <- Inf
    min_lab <- min(d)
  } else {
    min_lab <- NA_real_
  }

  message(sprintf(
    "[colour audit] %s: %d colours, min contrast vs white %.2f, min Lab distance %s",
    label, length(cols), min_contrast,
    if (is.na(min_lab)) "n/a" else sprintf("%.1f", min_lab)
  ))
  if (min_contrast < 3) {
    message("  note: at least one fill is below 3:1 against white. ",
            "Use a dark outline and direct labels, not colour alone.")
  }
  if (!is.na(min_lab) && min_lab < 20) {
    message("  note: two colours are close in perceptual space. ",
            "Make sure shape, linetype, or direct labels distinguish them.")
  }

  list(n_colours = length(cols), min_contrast = min_contrast,
       min_lab_distance = min_lab)
}

# Pull the hex colours actually used by the geoms in a built plot.
plot_colours <- function(plot) {
  built <- tryCatch(ggplot2::ggplot_build(plot), error = function(e) NULL)
  if (is.null(built)) return(character())
  vals <- unlist(lapply(built$data, function(d) {
    out <- character()
    if ("colour" %in% names(d)) out <- c(out, d$colour)
    if ("fill" %in% names(d)) out <- c(out, d$fill)
    out
  }), use.names = FALSE)
  unique(vals[!is.na(vals) & grepl("^#", vals)])
}

# Warn when colour is the only encoding. Direct labels count as redundancy.
check_redundant_encoding <- function(plot, direct_labels = FALSE) {
  mappings <- c(
    names(plot$mapping),
    unlist(lapply(plot$layers, function(l) names(l$mapping)))
  )
  colour_mapped <- any(mappings %in% c("colour", "color", "fill"))
  redundant <- any(mappings %in% c("shape", "linetype", "alpha"))
  if (colour_mapped && !redundant && !direct_labels) {
    message("[encoding audit] colour/fill is mapped without shape, linetype, ",
            "alpha, or direct labels. Add a redundant encoding or pass ",
            "direct_labels = TRUE.")
  }
  invisible(TRUE)
}

# ---- Validation -------------------------------------------------------------

validate_caption <- function(caption) {
  if (!is.character(caption) || length(caption) != 1 || !nzchar(caption)) {
    stop("caption must be a non-empty string", call. = FALSE)
  }
  if (grepl("[\r\n]", caption)) {
    stop("caption must be one line", call. = FALSE)
  }
  if (grepl("]", caption, fixed = TRUE)) {
    stop("caption must not contain ']' because it breaks the Markdown image",
         call. = FALSE)
  }
  invisible(TRUE)
}

validate_alt <- function(alt, caption) {
  if (!is.character(alt) || length(alt) != 1 || !nzchar(alt)) {
    stop("alt text is required", call. = FALSE)
  }
  if (grepl("[\r\n]", alt)) {
    stop("alt text must be one line", call. = FALSE)
  }
  if (grepl('"', alt, fixed = TRUE)) {
    stop("alt text must not contain double quotes", call. = FALSE)
  }
  if (identical(trimws(tolower(alt)), trimws(tolower(caption)))) {
    stop("alt text must describe the data, not repeat the caption", call. = FALSE)
  }
  if (nchar(alt) < 40) {
    message("[alt audit] alt text is short (", nchar(alt),
            " characters). Aim for 60-300.")
  }
  if (nchar(alt) > 400) {
    message("[alt audit] alt text is long (", nchar(alt),
            " characters). Aim for 60-300.")
  }
  if (grepl("^(image|picture|graph|figure) of", alt, ignore.case = TRUE)) {
    message("[alt audit] start with the chart type, not 'image of'.")
  }
  colour_words <- grepl(
    "\\b(red|blue|green|orange|purple|yellow)\\b", alt, ignore.case = TRUE
  )
  other_cues <- grepl(
    "\\b(circle|triangle|square|diamond|dashed|dotted|solid|label|labelled|labeled)\\b",
    alt, ignore.case = TRUE
  )
  if (colour_words && !other_cues) {
    message("[alt audit] alt text mentions colour without a shape, linetype, ",
            "or label cue. Do not rely on colour alone.")
  }
  invisible(TRUE)
}

# ---- File naming and registry -----------------------------------------------

chapter_dir <- function(chapter) {
  file.path("figures", sprintf("chapter_%02d", as.integer(chapter)))
}

registry_path <- function(chapter) {
  file.path(chapter_dir(chapter), "figures.yml")
}

fig_stem <- function(chapter, id, type, slug) {
  if (!grepl("^[a-z][a-z0-9]*$", type)) {
    stop("type must be lowercase letters/digits, e.g. 'bar'", call. = FALSE)
  }
  if (!grepl("^[a-z0-9]+(_[a-z0-9]+)*$", slug)) {
    stop("slug must be lowercase with underscores, e.g. 'depression_status'",
         call. = FALSE)
  }
  parts <- strsplit(id, ".", fixed = TRUE)[[1]]
  if (length(parts) != 2) {
    stop("id must look like '1.2' or '1.9b'", call. = FALSE)
  }
  if (as.integer(parts[1]) != as.integer(chapter)) {
    stop("id chapter ", parts[1], " does not match chapter ", chapter,
         call. = FALSE)
  }
  num <- parts[2]
  main <- sub("^([0-9]+).*$", "\\1", num)
  suffix <- sub("^[0-9]+", "", num)
  sprintf("fig_%02d_%02d%s_%s_%s",
          as.integer(chapter), as.integer(main), suffix, type, slug)
}

read_registry <- function(chapter) {
  path <- registry_path(chapter)
  if (!file.exists(path)) return(list(figures = list()))
  reg <- yaml::read_yaml(path)
  if (is.null(reg$figures)) reg$figures <- list()
  reg
}

write_registry <- function(chapter, reg) {
  dir.create(chapter_dir(chapter), recursive = TRUE, showWarnings = FALSE)
  yaml::write_yaml(reg, registry_path(chapter))
}

script_name <- function() {
  arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
  if (length(arg)) sub("^--file=", "", arg[1]) else NA_character_
}

# ---- Save -------------------------------------------------------------------

#' Save one book figure, validate accessibility metadata, and register it.
#'
#' @param plot A ggplot object.
#' @param chapter Integer chapter number.
#' @param id Figure number as text, e.g. "1.2" or "1.9b".
#' @param type Short output type, e.g. "bar", "hist", "scatter", "box".
#' @param slug Lowercase underscore description, e.g. "depression_status".
#' @param caption Caption text without the "Figure X.Y:" prefix.
#' @param alt Alt text, one line, no double quotes.
#' @param match Optional unique text from the placeholder line. Use this when
#'   two placeholders share an id (for example, chapter 1 has two Figure 1.9s).
#' @param author_note Optional note for the author. Use it when the figure
#'   exposes a mismatch between the prose and the data.
save_book_fig <- function(plot, chapter, id, type, slug, caption, alt,
                          width = BOOK_WIDTH, height = BOOK_HEIGHT,
                          dpi = BOOK_DPI, direct_labels = FALSE,
                          match = NULL, author_note = NULL, quiet = FALSE) {
  if (!inherits(plot, "ggplot")) {
    stop("plot must be a ggplot object", call. = FALSE)
  }
  validate_caption(caption)
  validate_alt(alt, caption)

  ch <- as.integer(chapter)
  stem <- fig_stem(ch, id, type, slug)
  file <- paste0(stem, ".png")
  out_dir <- chapter_dir(ch)
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  out_path <- file.path(out_dir, file)

  check_redundant_encoding(plot, direct_labels = direct_labels)
  audit <- audit_palette(plot_colours(plot), label = paste0("Figure ", id))

  ggplot2::ggsave(
    filename = out_path, plot = plot, device = ragg::agg_png,
    width = width, height = height, units = "in", dpi = dpi, bg = BOOK_BG
  )
  if (!file.exists(out_path) || file.info(out_path)$size == 0) {
    stop("figure was not written: ", out_path, call. = FALSE)
  }

  entry <- list(
    id = id,
    file = file,
    type = type,
    caption = caption,
    alt = alt,
    width_in = unname(width),
    height_in = unname(height),
    dpi = unname(dpi),
    script = script_name()
  )
  if (!is.null(match)) entry$match <- match
  if (!is.null(author_note)) entry$author_note <- author_note
  if (!is.null(audit)) entry$colour_audit <- audit

  reg <- read_registry(ch)
  keep <- !vapply(reg$figures, function(e) identical(e$id, id), logical(1))
  reg$figures <- c(reg$figures[keep], list(entry))
  write_registry(ch, reg)

  markdown <- sprintf(
    '![Figure %s: %s](../figures/chapter_%02d/%s){fig-alt="%s"}',
    id, caption, ch, file, alt
  )

  if (!quiet) {
    message("Saved ", out_path, " (", width, " x ", height, " in at ",
            dpi, " dpi)")
    if (!is.null(author_note)) message("[author note] ", author_note)
    cat("\n", markdown, "\n", sep = "")
  }

  invisible(list(path = out_path, file = file, markdown = markdown,
                 entry = entry, audit = audit))
}

# ---- Chapter values registry ------------------------------------------------

values_path <- function(chapter) {
  file.path(chapter_dir(chapter), "values.yml")
}

# Convert data frames to row-oriented lists so values.yml reads as one record
# per term or group, not one block per data-frame column.
as_value_rows <- function(x) {
  if (is.data.frame(x)) {
    x[] <- lapply(x, function(v) if (is.factor(v)) as.character(v) else v)
    return(lapply(seq_len(nrow(x)), function(i) {
      as.list(x[i, , drop = FALSE])
    }))
  }
  if (is.list(x)) {
    return(lapply(x, as_value_rows))
  }
  x
}

#' Save the numeric values and model conventions used in a chapter.
#'
#' @param chapter Integer chapter number.
#' @param values Named list of values, grouped by table or figure.
#' @param conventions Named list describing contrasts, SS type, and other
#'   calculation choices that affect the numbers.
#' @param source Path to the script that produces the values.
#' @param quiet Suppress the confirmation message.
save_book_values <- function(chapter, values, conventions = NULL,
                             source = NULL, quiet = FALSE) {
  if (!is.list(values) || is.null(names(values))) {
    stop("values must be a named list", call. = FALSE)
  }
  ch <- as.integer(chapter)
  dir.create(chapter_dir(ch), recursive = TRUE, showWarnings = FALSE)
  out <- list(chapter = ch)
  if (!is.null(source)) out$source <- source
  script <- script_name()
  if (!is.na(script)) out$script <- script
  if (!is.null(conventions)) out$conventions <- conventions
  out$values <- as_value_rows(values)
  path <- values_path(ch)
  yaml::write_yaml(out, path)
  if (!quiet) message("Saved ", path)
  invisible(path)
}
