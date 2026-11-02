#!/usr/bin/env Rscript
# Generates chapters/appendix-index.md from the glossary terms and the chapter
# sources. Never edit the index by hand.
#
#   Rscript tools/index/build_index.R           write the index
#   Rscript tools/index/build_index.R --report  also list terms with no entry
#
# An entry points students to sections that discuss a topic, not to every mention.
# A section counts as a discussion of a term when the term is in its heading or a
# subheading,
# is bolded there (the defining section, printed in bold), or appears at least
# MIN_MENTIONS times in its prose. An entry lists the defining section plus the
# most-mentioned others, MAX_LOCATIONS in all, in book order. Terms with no such
# section are left out unless they are in tools/index/keep.txt.
# Inputs: appendix-glossary.md, exclude.txt, aliases.txt, keep.txt.

MIN_MENTIONS  <- 4
MAX_LOCATIONS <- 9
SKIP_SECTIONS <- "^(Key Concepts|(Chapter )?Exercises|New Notation|Common Mistakes)"

args <- commandArgs(trailingOnly = TRUE)
root <- normalizePath(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "..", ".."))
setwd(root)

read_list <- function(f) {
  x <- trimws(readLines(f, warn = FALSE))
  x[nzchar(x) & !startsWith(x, "#")]
}

# ---- Glossary terms ----
gl <- readLines("chapters/appendix-glossary.md", warn = FALSE)
rows <- grep("^\\| ", gl, value = TRUE)
rows <- rows[!grepl("^\\| (Term|-)", rows)]
terms <- trimws(sub("^\\| (.*?) \\| .*$", "\\1", rows, perl = TRUE))
exclude <- read_list("tools/index/exclude.txt")
keep <- read_list("tools/index/keep.txt")
bad <- setdiff(c(exclude, keep), terms)
if (length(bad)) stop("not in the glossary: ", paste(bad, collapse = "; "))
terms <- setdiff(terms, exclude)

alias_lines <- read_list("tools/index/aliases.txt")
aliases <- list()
for (l in alias_lines) {
  p <- trimws(strsplit(l, "|", fixed = TRUE)[[1]])
  aliases[[p[1]]] <- trimws(strsplit(p[2], ";", fixed = TRUE)[[1]])
}

# Search patterns for one phrase: spaces and hyphens interchangeable, plural ok.
phrase_rx <- function(ph, cs) {
  esc <- gsub("([.^$*+?()\\[\\]{}|\\\\])", "\\\\\\1", ph, perl = TRUE)
  esc <- gsub("[ -]", "[ -]", esc)
  if (!cs) esc <- sub("y$", "(y|ies)", esc) else esc <- esc
  tail <- if (cs) "s?" else if (grepl("\\(y\\|ies\\)$", esc)) "" else "(s|es)?"
  list(rx = paste0("(?<![A-Za-z0-9])", esc, tail, "(?![A-Za-z0-9])"), cs = cs)
}
patterns <- lapply(terms, function(t) {
  base <- trimws(sub("\\s*\\([^)]*\\)\\s*$", "", t))
  ac <- regmatches(t, regexec("\\(([A-Z]{2,}s?)\\)\\s*$", t))[[1]][2]
  ph <- list()
  if (!grepl("\\$", base)) ph <- c(ph, list(phrase_rx(base, FALSE)))
  if (!is.na(ac)) ph <- c(ph, list(phrase_rx(sub("s$", "", ac), TRUE)))
  for (a in aliases[[t]]) ph <- c(ph, list(phrase_rx(a, grepl("^[A-Z]{2,}s?$", a))))
  ph
})
names(patterns) <- terms
unsearchable <- terms[lengths(patterns) == 0]
if (length(unsearchable))
  stop("add an alias for: ", paste(unsearchable, collapse = "; "))

# ---- Sections of each chapter ----
slugify <- function(h) {
  s <- gsub("`|\\$", "", h)
  s <- tolower(gsub("\\[([^]]*)\\]\\([^)]*\\)", "\\1", s))
  s <- gsub("[^a-z0-9 _.-]", "", s)
  s <- gsub(" +", "-", trimws(s))
  s <- sub("^[^a-z]+", "", s)
  if (!nzchar(s)) "section" else s
}
secs <- list()   # each: id (N.M), chapter file, heading, slug, text (prose lines)
for (f in sort(list.files("chapters", "^chapter-[0-9]+\\.md$", full.names = TRUE))) {
  n <- as.integer(sub("^.*chapter-([0-9]+)\\.md$", "\\1", f))
  lines <- readLines(f, warn = FALSE)
  in_code <- FALSE; in_math <- FALSE; m <- 0L; cur <- NULL; used <- character()
  flush <- function() if (!is.null(cur)) secs[[length(secs) + 1L]] <<- cur
  for (ln in lines) {
    if (grepl("^\\s*(```|~~~)", ln)) { in_code <- !in_code; next }
    if (in_code) next
    if (grepl("^## ", ln)) {
      flush()
      m <- m + 1L
      h <- sub("^## +", "", sub("\\s*\\{[^}]*\\}\\s*$", "", ln))
      sl <- slugify(h); base <- sl; k <- 0L
      while (sl %in% used) { k <- k + 1L; sl <- paste0(base, "-", k) }
      used <- c(used, sl)
      cur <- list(id = paste0(n, ".", m), file = basename(f), heading = h,
                  slug = sl, text = character())
      next
    }
    if (is.null(cur)) next
    if (grepl("^\\s*\\$\\$", ln)) {
      if (!grepl("\\$\\$.*\\$\\$", ln)) in_math <- !in_math
      next
    }
    if (in_math || grepl("^(!\\[|: |<!--)", ln)) next
    cur$text <- c(cur$text, ln)
  }
  flush()
}
clean <- function(x) {
  x <- gsub("[\u2018\u2019]", "'", x)
  x <- gsub("`[^`]*`", " ", x)
  x <- gsub("\\$([A-Za-z0-9^_]{1,6})\\$", "\\1", x)   # simple math such as $d$ stays searchable
  x <- gsub("\\$[^$]*\\$", " ", x)
  x <- gsub("\\]\\([^)]*\\)", "]", x)
  x
}

count_in <- function(pats, txt) {
  sum(vapply(pats, function(p)
    sum(lengths(regmatches(txt, gregexpr(p$rx, txt, perl = TRUE, ignore.case = !p$cs)))),
    numeric(1)))
}
bolded_in <- function(pats, txt) {
  b <- unlist(regmatches(txt, gregexpr("\\*\\*[^*]+\\*\\*", txt)))
  if (!length(b)) return(FALSE)
  any(vapply(pats, function(p) any(grepl(p$rx, b, perl = TRUE, ignore.case = !p$cs)), logical(1)))
}

counted <- !vapply(secs, function(s) grepl(SKIP_SECTIONS, s$heading), logical(1))
entries <- list(); dropped <- character()
for (t in terms) {
  pats <- patterns[[t]]
  cnt <- hd <- df <- integer(length(secs))
  for (i in seq_along(secs)) {
    if (!counted[i]) next
    txt <- clean(secs[[i]]$text)
    cnt[i] <- count_in(pats, txt)
    hl <- c(secs[[i]]$heading, sub("^#+ +", "", grep("^#{3,} ", secs[[i]]$text, value = TRUE)))
    hd[i] <- count_in(pats, clean(hl)) > 0
    df[i] <- bolded_in(pats, txt)
  }
  subst <- which(cnt >= MIN_MENTIONS | hd == 1 | df == 1)
  defining <- if (any(df == 1)) which(df == 1)[1] else NA_integer_
  if (!length(subst)) {
    if (!(t %in% keep)) { dropped <- c(dropped, t); next }
    subst <- order(-cnt, seq_along(cnt))[seq_len(min(3, sum(cnt > 0)))]
    if (!length(subst)) { dropped <- c(dropped, t); next }
  }
  rest <- setdiff(subst, defining)
  rest <- rest[order(-cnt[rest], rest)]
  pick <- c(if (!is.na(defining)) defining, rest)
  pick <- sort(head(pick, MAX_LOCATIONS))
  entries[[t]] <- list(idx = pick, def = defining)
}

# ---- Write ----
sort_key <- function(t) tolower(gsub("[^A-Za-z0-9 ]", "", t))
ord <- order(sort_key(names(entries)), names(entries))
out <- c("# Index {.unnumbered}", "",
  "<!-- Generated by tools/index/build_index.R from the chapter sources. Do not edit by hand. -->",
  "",
  paste("This index points you to the sections that discuss each topic. The section",
        "where the book defines a term is in bold. For short definitions, use the glossary."),
  "")
last <- ""
for (t in names(entries)[ord]) {
  L <- toupper(substr(sort_key(t), 1, 1))
  if (L != last) { out <- c(out, "", paste0("## ", L, " {.unnumbered}"), ""); last <- L }
  e <- entries[[t]]
  locs <- vapply(e$idx, function(i) {
    s <- secs[[i]]
    lab <- sprintf("[%s](%s#%s)", s$id, s$file, s$slug)
    if (!is.na(e$def) && i == e$def) paste0("**", lab, "**") else lab
  }, character(1))
  out <- c(out, paste0("- ", t, ": ", paste(locs, collapse = ", ")))
}
writeLines(out, "chapters/appendix-index.md")
cat(sprintf("Index: %d entries from %d glossary terms (%d excluded, %d with no discussed section)\n",
            length(entries), length(terms) + length(exclude), length(exclude), length(dropped)))
if ("--report" %in% args) {
  cat("\nTerms with no entry:\n"); cat(paste0("  ", dropped), sep = "\n")
}
