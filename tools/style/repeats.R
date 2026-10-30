# Report overused phrases and sentence openers across the chapters.
# Report only: it never edits and has no pass/fail. Run from the repo root:
#   Rscript tools/style/repeats.R [min_count]
# Phrases that recur in several chapters are the ones readers notice.

args <- commandArgs(trailingOnly = TRUE)
min_count <- if (length(args)) as.integer(args[1]) else 4L

files <- sort(Sys.glob("chapters/chapter-*.md"))
chapter_of <- function(f) sub("^chapter-(\\d+)\\.md$", "\\1", basename(f))

read_prose <- function(f) {
  x <- readLines(f, warn = FALSE)
  fence <- cumsum(grepl("^```", x))
  x <- x[fence %% 2 == 0 & !grepl("^```", x)]
  x <- x[!grepl("^\\s*(\\||!\\[|:::|#)", x)]          # tables, images, divs, headings
  x <- gsub("\\$\\$.*?\\$\\$|\\$[^$]*\\$", " ", x)    # math
  x <- gsub("`[^`]*`", " ", x)                        # inline code
  x <- gsub("\\[([^]]*)\\]\\([^)]*\\)", "\\1", x)     # links
  x <- gsub("[*_]", "", x)
  x[nzchar(trimws(x))]
}

prose <- lapply(files, read_prose)
names(prose) <- vapply(files, chapter_of, "")

tokens <- function(lines) {
  w <- unlist(strsplit(tolower(paste(lines, collapse = " ")), "[^a-z']+"))
  w[nzchar(w)]
}

ngram_counts <- function(n) {
  rows <- lapply(names(prose), function(ch) {
    w <- tokens(prose[[ch]])
    if (length(w) < n) return(NULL)
    g <- vapply(seq_len(length(w) - n + 1), function(i) paste(w[i:(i + n - 1)], collapse = " "), "")
    data.frame(gram = g, ch = ch)
  })
  d <- do.call(rbind, rows)
  tab <- aggregate(ch ~ gram, d, function(z) c(n = length(z), chapters = length(unique(z))))
  out <- data.frame(gram = tab$gram, n = tab$ch[, "n"], chapters = tab$ch[, "chapters"])
  out[out$n >= min_count & out$chapters >= 2, ]
}

# Keep the longest phrases; drop shorter ones fully contained in a kept longer one.
res <- do.call(rbind, lapply(c(6, 5, 4), function(n) cbind(ngram_counts(n), len = n)))
res <- res[order(-res$len, -res$n), ]
keep <- logical(nrow(res))
for (i in seq_len(nrow(res))) {
  longer <- res$gram[keep & res$len > res$len[i]]
  keep[i] <- !any(grepl(res$gram[i], longer, fixed = TRUE))
}
res <- res[keep, ]
res <- res[order(-res$n, -res$len), ]

cat(sprintf("== Repeated phrases (4-6 words; at least %d times, in 2+ chapters) ==\n", min_count))
print(head(res[, c("n", "chapters", "gram")], 60), row.names = FALSE)

# Sentence openers: first two words of each sentence.
sents <- unlist(lapply(prose, function(l) unlist(strsplit(paste(l, collapse = " "), "(?<=[.?!])\\s+", perl = TRUE))))
open2 <- vapply(strsplit(tolower(sents), "[^a-z']+"), function(w) {
  w <- w[nzchar(w)]; if (length(w) >= 2) paste(w[1:2], collapse = " ") else NA_character_
}, "")
ot <- sort(table(open2[!is.na(open2)]), decreasing = TRUE)
cat("\n== Most common two-word sentence openers ==\n")
print(head(ot[ot >= max(min_count, 8)], 30))
