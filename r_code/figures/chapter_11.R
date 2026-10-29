# =============================================================================
# Chapter 11 figures: Factor Analysis
#
# Run from the project root:
#   Rscript r_code/figures/chapter_11.R
#
# Figures 11.1 and 11.2 use speed_dating.csv. Figure 11.1 plots the initial
# eigenvalues of the female rating correlation matrix. Figure 11.2 compares the
# female and male correlation matrices. The statistics behind the prose are
# recorded in figures/chapter_11/values.yml by
# r_code/figures/chapter_11_values.R.
# =============================================================================

source("r_code/figures/_book_figs.R")

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(readr)
  library(scales)
})

assert_book_font()

# ---- Data -------------------------------------------------------------------

df <- read_csv("data/speed_dating.csv", show_col_types = FALSE)

vars_f <- c(
  "AttractiveF", "SincereF", "IntelligentF",
  "FunF", "AmbitiousF", "SharedInterestsF"
)
vars_m <- c(
  "AttractiveM", "SincereM", "IntelligentM",
  "FunM", "AmbitiousM", "SharedInterestsM"
)

data_f <- df %>%
  select(all_of(vars_f)) %>%
  filter(if_all(everything(), ~ !is.na(.x)))
data_m <- df %>%
  select(all_of(vars_m)) %>%
  filter(if_all(everything(), ~ !is.na(.x)))

cor_f <- cor(data_f)
cor_m <- cor(data_m)

# Order the matrix by the female factor clusters: character and intellect
# first, then social appeal. The male panel uses the same order.
vars_order <- c(
  "Intelligent", "Ambitious", "Sincere",
  "Attractive", "Fun", "Shared interests"
)

order_matrix <- function(m, suffix) {
  short <- sub(paste0(suffix, "$"), "", colnames(m))
  short <- ifelse(short == "SharedInterests", "Shared interests", short)
  idx <- match(vars_order, short)
  out <- m[idx, idx]
  dimnames(out) <- list(vars_order, vars_order)
  out
}

cor_f_ord <- order_matrix(cor_f, "F")
cor_m_ord <- order_matrix(cor_m, "M")

# ---- Figure 11.1: scree chart ----------------------------------------------

scree <- data.frame(
  factor = seq_len(ncol(cor_f)),
  eigenvalue = as.numeric(eigen(cor_f)$values)
)

p111 <- ggplot(scree, aes(x = factor, y = eigenvalue)) +
  geom_line(colour = BOOK_INK, linewidth = 0.5) +
  geom_point(
    shape = 21, size = 2.6, stroke = 0.4,
    fill = book_palette[["sky_blue"]], colour = BOOK_INK
  ) +
  geom_text(
    aes(
      label = sprintf("%.2f", eigenvalue),
      hjust = ifelse(factor == 2, -0.2, 0.5)
    ),
    vjust = -1.0, size = 3.0, colour = BOOK_INK
  ) +
  geom_vline(
    xintercept = 2.5, linetype = "dashed",
    colour = BOOK_MUTED, linewidth = 0.45
  ) +
  annotate(
    "text", x = 2.55, y = 2.45, label = "Elbow at Factor 3",
    hjust = 0, size = 3.0, colour = BOOK_INK
  ) +
  scale_x_continuous(breaks = seq_len(ncol(cor_f))) +
  scale_y_continuous(
    limits = c(0, 3.25), breaks = seq(0, 3, 1)
  ) +
  labs(
    x = "Factor number",
    y = "Variance explained (eigenvalue)"
  ) +
  book_theme()

save_book_fig(
  p111,
  chapter = 11, id = "11.1", type = "line",
  slug = "scree_female_ratings",
  caption = paste(
    "Scree chart for the six female partner ratings (n = 238). The first",
    "eigenvalue is 2.86 and the second is 1.22; the line then falls to 0.61",
    "at Factor 3 and flattens across Factors 4 through 6. The elbow falls at",
    "Factor 3, so the first two factors are retained."
  ),
  alt = paste(
    "Line chart of eigenvalues for six factors from the female ratings.",
    "Values are 2.86, 1.22, 0.61, 0.54, 0.42, and 0.35. The line drops",
    "steeply through Factor 2 and flattens after Factor 3."
  ),
  direct_labels = TRUE
)

# ---- Figure 11.2: female and male correlation heatmaps ---------------------

heat_long <- function(m, panel) {
  out <- as.data.frame(as.table(m))
  names(out) <- c("row_var", "col_var", "r")
  out$panel <- panel
  out
}

heat_df <- bind_rows(
  heat_long(cor_f_ord, "Female ratings"),
  heat_long(cor_m_ord, "Male ratings")
) %>%
  mutate(
    row_var = factor(row_var, levels = rev(vars_order)),
    col_var = factor(col_var, levels = vars_order),
    panel = factor(panel, levels = c("Female ratings", "Male ratings")),
    label = sprintf("%.2f", r),
    # White text only on the dark diagonal cells; ink elsewhere.
    text_colour = ifelse(r >= 0.85, "#FFFFFF", BOOK_INK)
  )

p112 <- ggplot(
  heat_df, aes(x = col_var, y = row_var, fill = r)
) +
  geom_tile(colour = BOOK_INK, linewidth = 0.3) +
  geom_text(
    aes(label = label, colour = text_colour),
    size = 2.7
  ) +
  facet_wrap(~panel, ncol = 2) +
  scale_fill_gradient(
    low = "#F4F8FB", high = book_palette[["blue"]],
    limits = c(0, 1), guide = "none"
  ) +
  scale_colour_identity() +
  scale_x_discrete(position = "bottom") +
  coord_fixed() +
  labs(x = NULL, y = NULL) +
  book_theme() +
  theme(
    panel.grid = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank(),
    axis.ticks.x.bottom = element_blank(),
    axis.ticks.y.left = element_blank(),
    axis.minor.ticks.x.bottom = element_blank(),
    axis.minor.ticks.y.left = element_blank(),
    axis.ticks.length = unit(0, "pt"),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
    axis.text.y = element_text(size = 8),
    panel.spacing = unit(0.7, "lines"),
    legend.position = "none",
    strip.text = element_text(face = "bold", size = 9)
  )

save_book_fig(
  p112,
  chapter = 11, id = "11.2", type = "heatmap",
  slug = "correlation_heatmaps",
  caption = paste(
    "Correlation heatmaps for the six female and six male partner ratings",
    "(female n = 238, male n = 236). Rows and columns are ordered by the",
    "female factor clusters: character and intellect first, then social",
    "appeal. The female panel forms two blocks of stronger correlations; the",
    "male panel has no block structure. Every cell prints its correlation."
  ),
  alt = paste(
    "Two 6 by 6 correlation heatmaps with values printed in each cell. The",
    "female panel shows two blocks of correlations near 0.50 to 0.56. The",
    "male panel runs from 0.31 to 0.60 with no block pattern."
  ),
  direct_labels = TRUE
)
