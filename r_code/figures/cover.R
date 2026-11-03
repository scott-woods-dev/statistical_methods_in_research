# =============================================================================
# Book covers: "Statistical Methods in Research" and its R Companion
#
# Run from the project root:
#   Rscript r_code/figures/cover.R
#
# Writes three files for each book, the textbook in images/ and the companion
# in r_companion/images/:
#   cover.png              6 x 9 in at 300 dpi, for the web
#   cover.pdf              6 x 9 in vector, the cover artwork
#   cover_title_page.pdf   letter-size vector, the PDF title page
#
# Both covers share the layout and the motif. The companion uses the
# bluish-green family of the same Okabe-Ito palette so the two books are easy
# to tell apart; its title band keeps white text above 4.5:1 contrast.
#
# The letter version is the same design scaled to the book's PDF page size,
# with the motif widened to the page. The PDF format in _quarto.yml replaces
# \maketitle with this file.
#
# The motif is a fitted logistic regression on a simulated binary outcome,
# drawn with filled 95% confidence and prediction bands rather than dashed
# lines. The bands are defined in the "Interval definitions" section below.
# The simulated data use a fixed seed, so the cover is reproducible.
# =============================================================================

source("r_code/figures/_book_figs.R")

suppressPackageStartupMessages({
  library(ggplot2)
  library(grid)
})

assert_book_font()

# ---- Page profiles ----------------------------------------------------------

# Three horizontal fields: a strong top band for the title, white behind the
# motif, and a pale band for the author. The bands reuse the colors of the
# motif, so the page reads as one system.
COVER_BG <- "#FFFFFF"
TITLE_FAMILY <- "Inter SemiBold"
TITLE_COL <- "#FFFFFF"
SUBTITLE_COL <- "#FFFFFF"

# One entry per book: its colors, its title lines, its subtitle, and where its
# files go. Title lines are bottom aligned, so a two-line title sits just above
# the subtitle like the three-line one.
covers <- list(
  textbook = list(
    dir = "images",
    band_top = book_palette[["blue"]],          # #0072B2, white text 5.2:1
    band_bottom = "#E4F0F8",
    accent = book_palette[["sky_blue"]],
    ci_fill = book_palette[["blue"]],
    pi_fill = book_palette[["sky_blue"]],
    title = c("Statistical", "Methods in", "Research"),
    subtitle = "A CONCEPTUAL APPROACH"
  ),
  companion = list(
    dir = "r_companion/images",
    band_top = "#007A57",                       # dark bluish green, 5.4:1
    band_bottom = "#E2F3EC",
    accent = "#6FD3AE",
    ci_fill = book_palette[["bluish_green"]],   # #009E73
    pi_fill = "#3FBF8F",
    title = c("R", "Companion"),
    subtitle = "STATISTICAL METHODS IN RESEARCH"
  )
)

# The letter page is the book page scaled by 11 / 9 = 1.222. Every vertical
# measure and type size scales with it; the motif takes the extra width.
page_profile <- function(page = c("book", "letter")) {
  page <- match.arg(page)
  if (page == "book") {
    s <- 1
    list(page = page, w = 6, h = 9, scale = s, margin = 0.62,
         band_top_h = 2.72, band_bottom_h = 1.45,
         title_top = 8.42, title_size = 36, title_lead = 0.44,
         subtitle_y = 6.98, subtitle_size = 10,
         rule_y = 6.72, rule_w = 0.55, rule_h = 0.028,
         motif_y = 4.04, motif_w = 6.5, motif_h = 3.4,
         author_y = 0.74, author_size = 12.5)
  } else {
    s <- 11 / 9
    list(page = page, w = 8.5, h = 11, scale = s, margin = 0.62 * s,
         band_top_h = 2.72 * s, band_bottom_h = 1.45 * s,
         title_top = 8.42 * s, title_size = 36 * s, title_lead = 0.44 * s,
         subtitle_y = 6.98 * s, subtitle_size = 10 * s,
         rule_y = 6.72 * s, rule_w = 0.55 * s, rule_h = 0.028 * s,
         motif_y = 4.04 * s, motif_w = 9.0, motif_h = 3.4 * s,
         author_y = 0.74 * s, author_size = 12.5 * s)
  }
}

# ---- Simulated data ---------------------------------------------------------

set.seed(20261029)

n <- 220
x <- stats::runif(n, 0, 100)          # a score from 0 to 100
eta <- -4.6 + 0.092 * x               # true log-odds
y <- stats::rbinom(n, 1, stats::plogis(eta))

fit <- stats::glm(y ~ x, family = stats::binomial())

grid_x <- data.frame(x = seq(0, 100, length.out = 500))
pred <- stats::predict(fit, newdata = grid_x, type = "link", se.fit = TRUE)
z <- stats::qnorm(0.975)

# ---- Interval definitions ---------------------------------------------------
# Confidence band: the fitted probability of a positive outcome,
#   inverse-logit(eta_hat +/- 1.96 * se(eta_hat)).
# Prediction band: the latent propensity of a new observation, which adds the
#   logistic error variance pi^2 / 3 to the squared standard error before
#   transforming back. A prediction interval for the binary outcome itself
#   would be the whole 0 to 1 range, so the latent version is the one that
#   carries information.

se <- pred$se.fit
grid_x$fit <- stats::plogis(pred$fit)
grid_x$ci_lo <- stats::plogis(pred$fit - z * se)
grid_x$ci_hi <- stats::plogis(pred$fit + z * se)
pred_se <- sqrt(se^2 + pi^2 / 3)
grid_x$pi_lo <- stats::plogis(pred$fit - z * pred_se)
grid_x$pi_hi <- stats::plogis(pred$fit + z * pred_se)

# ---- The motif --------------------------------------------------------------

set.seed(7)
pts <- data.frame(
  x = x,
  y = y + stats::runif(n, -0.030, 0.030)
)

make_motif <- function(cv) ggplot() +
  geom_ribbon(
    data = grid_x, aes(x = x, ymin = pi_lo, ymax = pi_hi),
    fill = cv$pi_fill, alpha = 0.16
  ) +
  geom_ribbon(
    data = grid_x, aes(x = x, ymin = ci_lo, ymax = ci_hi),
    fill = cv$ci_fill, alpha = 0.24
  ) +
  geom_point(
    data = pts, aes(x = x, y = y),
    shape = 16, size = 1.2, colour = BOOK_INK, alpha = 0.32
  ) +
  geom_line(
    data = grid_x, aes(x = x, y = fit),
    colour = BOOK_INK, linewidth = 0.85
  ) +
  scale_x_continuous(limits = c(-1, 101), expand = c(0, 0)) +
  scale_y_continuous(limits = c(-0.13, 1.13), expand = c(0, 0)) +
  theme_void() +
  theme(
    plot.margin = margin(0, 0, 0, 0),
    plot.background = element_rect(fill = NA, colour = NA),
    panel.background = element_rect(fill = NA, colour = NA),
    legend.position = "none"
  )

# ---- Letter tracking for the subtitle ---------------------------------------

tracked <- function(x, gap = " ") {
  paste(strsplit(x, "")[[1]], collapse = gap)
}

# ---- Page composition -------------------------------------------------------

draw_cover <- function(p, cv) {
  grid.newpage()
  grid.rect(gp = gpar(fill = COVER_BG, col = NA))

  # Top band behind the title block
  grid.rect(
    x = unit(0, "npc"), y = unit(p$h - p$band_top_h, "in"),
    width = unit(1, "npc"), height = unit(p$band_top_h, "in"),
    just = c("left", "bottom"),
    gp = gpar(fill = cv$band_top, col = NA)
  )

  # Bottom band behind the author
  grid.rect(
    x = unit(0, "npc"), y = unit(0, "in"),
    width = unit(1, "npc"), height = unit(p$band_bottom_h, "in"),
    just = c("left", "bottom"),
    gp = gpar(fill = cv$band_bottom, col = NA)
  )

  # Title, up to three lines, bottom aligned to the three-line layout
  title_lines <- cv$title
  shift <- (3 - length(title_lines)) * p$title_lead
  for (i in seq_along(title_lines)) {
    grid.text(
      title_lines[i],
      x = unit(p$margin, "in"),
      y = unit(p$title_top - shift - (i - 1) * p$title_lead, "in"),
      just = c("left", "top"),
      gp = gpar(fontfamily = TITLE_FAMILY, fontsize = p$title_size,
                col = TITLE_COL, lineheight = 0.95)
    )
  }

  # Subtitle and accent rule
  grid.text(
    tracked(cv$subtitle),
    x = unit(p$margin, "in"), y = unit(p$subtitle_y, "in"),
    just = c("left", "center"),
    gp = gpar(fontfamily = BOOK_FONT, fontsize = p$subtitle_size,
              col = SUBTITLE_COL)
  )
  grid.rect(
    x = unit(p$margin, "in"), y = unit(p$rule_y, "in"),
    width = unit(p$rule_w, "in"), height = unit(p$rule_h, "in"),
    just = c("left", "center"),
    gp = gpar(fill = cv$accent, col = NA)
  )

  # Motif, bled slightly left and right, centered in the white field
  pushViewport(viewport(
    x = unit(p$w / 2, "in"), y = unit(p$motif_y, "in"),
    width = unit(p$motif_w, "in"), height = unit(p$motif_h, "in")
  ))
  grid.draw(ggplotGrob(make_motif(cv)))
  popViewport()

  # Author
  grid.text(
    "Scott Woods",
    x = unit(p$margin, "in"), y = unit(p$author_y, "in"),
    just = c("left", "center"),
    gp = gpar(fontfamily = "Inter Medium", fontsize = p$author_size,
              col = BOOK_INK)
  )
}

# ---- Write the files --------------------------------------------------------

book <- page_profile("book")
letter <- page_profile("letter")

for (cv in covers) {
  dir.create(cv$dir, showWarnings = FALSE, recursive = TRUE)

  ragg::agg_png(
    file.path(cv$dir, "cover.png"), width = book$w, height = book$h,
    units = "in", res = BOOK_DPI, background = COVER_BG
  )
  draw_cover(book, cv)
  invisible(grDevices::dev.off())

  grDevices::cairo_pdf(file.path(cv$dir, "cover.pdf"), width = book$w,
                       height = book$h, family = BOOK_FONT, onefile = FALSE)
  draw_cover(book, cv)
  invisible(grDevices::dev.off())

  grDevices::cairo_pdf(file.path(cv$dir, "cover_title_page.pdf"),
                       width = letter$w, height = letter$h,
                       family = BOOK_FONT, onefile = FALSE)
  draw_cover(letter, cv)
  invisible(grDevices::dev.off())

  message(
    "Wrote ", cv$dir, "/cover.png (", book$w * BOOK_DPI, " x ",
    book$h * BOOK_DPI, " px), cover.pdf, and cover_title_page.pdf"
  )
}

# ---- Console summary --------------------------------------------------------

cat("\n--- Cover motif ---\n")
cat("n =", n, " simulated observations\n")
print(stats::coef(fit))
b <- stats::coef(fit)
cat("Fitted probability at x = 0:   ", round(stats::plogis(b[[1]]), 3), "\n")
cat("Fitted probability at x = 100: ",
    round(stats::plogis(b[[1]] + 100 * b[[2]]), 3), "\n")
cat("Confidence band width at x = 50:",
    round(grid_x$ci_hi[250] - grid_x$ci_lo[250], 3), "\n")
cat("Prediction band width at x = 50:",
    round(grid_x$pi_hi[250] - grid_x$pi_lo[250], 3), "\n")
