#!/usr/bin/env Rscript
# =============================================================================
# Replace [Insert Figure ...] placeholders with the Markdown image blocks
# recorded in figures/chapter_NN/figures.yml.
#
# Usage (from the project root):
#   Rscript r_code/figures/sync_chapter.R 01
#
# The script is idempotent. On a second run it finds the existing image block
# and replaces it with the same registry content, so manual drift is undone.
# It only touches lines that contain a figure placeholder or an existing
# book-figure image; the rest of the chapter is left alone.
# =============================================================================

source("r_code/figures/_book_figs.R")

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1) {
  stop("Usage: Rscript r_code/figures/sync_chapter.R NN", call. = FALSE)
}
chapter <- as.integer(args[1])
chapter_file <- sprintf("chapters/chapter-%02d.md", chapter)

if (!file.exists(chapter_file)) {
  stop("chapter file not found: ", chapter_file, call. = FALSE)
}

reg <- read_registry(chapter)
if (!length(reg$figures)) {
  stop("no figures registered for chapter ", chapter, call. = FALSE)
}

lines <- readLines(chapter_file, warn = FALSE)
replaced <- character()
missing <- character()

find_insert_line <- function(entry) {
  if (!is.null(entry$match) && nzchar(entry$match)) {
    idx <- grep(entry$match, lines, fixed = TRUE)
    idx <- idx[grepl("\\[Insert (Figure|Graph)", lines[idx])]
    return(idx)
  }
  escaped <- gsub(".", "\\.", entry$id, fixed = TRUE)
  pattern <- sprintf("\\[Insert (Figure|Graph) %s:", escaped)
  grep(pattern, lines, perl = TRUE)
}

for (entry in reg$figures) {
  markdown <- sprintf(
    '![Figure %s: %s](../figures/chapter_%02d/%s){fig-alt="%s"}',
    entry$id, entry$caption, chapter, entry$file, entry$alt
  )

  idx <- find_insert_line(entry)

  if (!length(idx)) {
    idx <- grep(entry$file, lines, fixed = TRUE)
  }

  if (!length(idx)) {
    missing <- c(missing, entry$id)
    next
  }
  if (length(idx) > 1) {
    stop("figure ", entry$id, " matches more than one line (",
         paste(idx, collapse = ", "),
         "). Add a unique `match` string in the R script.", call. = FALSE)
  }

  if (!identical(lines[idx], markdown)) {
    lines[idx] <- markdown
    replaced <- c(replaced, entry$id)
  }
}

if (length(replaced)) {
  writeLines(lines, chapter_file, useBytes = TRUE)
}

cat(sprintf("Chapter %02d: %d figure block(s) written, %d unchanged.\n",
            chapter, length(replaced),
            length(reg$figures) - length(replaced) - length(missing)))

if (length(missing)) {
  cat("No placeholder or existing image found for: ",
      paste(missing, collapse = ", "), "\n", sep = "")
}

leftover <- grep("\\[Insert (Figure|Graph)", lines)
if (length(leftover)) {
  cat("Unresolved placeholders remain on lines: ",
      paste(leftover, collapse = ", "), "\n", sep = "")
  for (i in leftover) {
    cat("  ", i, ": ", trimws(lines[i]), "\n", sep = "")
  }
}
