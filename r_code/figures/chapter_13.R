# =============================================================================
# Chapter 13 figures: Ethics in Statistics and Data Integrity
#
# Run from the project root:
#   Rscript r_code/figures/chapter_13.R
#
# Chapter 13 uses no dataset. Figure 13.1 is a workflow diagram. Figure 13.2
# plots the probability of at least one false positive under independent tests
# and a true null. The calculated values are recorded in
# figures/chapter_13/values.yml by r_code/figures/chapter_13_values.R.
# =============================================================================

source("r_code/figures/_book_figs.R")

suppressPackageStartupMessages({
  library(ggplot2)
  library(scales)
})

assert_book_font()

# ---- Figure 13.1: secure data workflow -------------------------------------

workflow <- data.frame(
  xmin = rep(1.0, 4),
  xmax = rep(5.3, 4),
  ymin = c(8.1, 6.2, 4.3, 2.4),
  ymax = c(9.4, 7.5, 5.6, 3.7),
  label = c(
    "1. Gather\nSigned consent forms\nand audio recordings",
    paste(
      "2. Transfer\nScan forms and upload audio to",
      "a secure cloud folder;\ndelete the raw audio",
      sep = "\n"
    ),
    paste(
      "3. De-identify\nAssign a code such as",
      "Participant 04; create\nthe master key",
      sep = "\n"
    ),
    paste(
      "4. Store\nTranscripts in one restricted folder;",
      "paper forms locked or shredded",
      sep = "\n"
    )
  ),
  stringsAsFactors = FALSE
)

p131 <- ggplot() +
  geom_rect(
    data = workflow,
    aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
    fill = "#EAF3F9", colour = BOOK_INK, linewidth = 0.45
  ) +
  geom_text(
    data = workflow,
    aes(x = (xmin + xmax) / 2, y = (ymin + ymax) / 2, label = label),
    size = 2.7, colour = BOOK_INK, lineheight = 0.95
  ) +
  geom_segment(
    aes(x = 3.15, xend = 3.15, y = 8.1, yend = 7.5),
    arrow = grid::arrow(length = grid::unit(0.08, "in")),
    colour = BOOK_MUTED, linewidth = 0.5
  ) +
  geom_segment(
    aes(x = 3.15, xend = 3.15, y = 6.2, yend = 5.6),
    arrow = grid::arrow(length = grid::unit(0.08, "in")),
    colour = BOOK_MUTED, linewidth = 0.5
  ) +
  geom_segment(
    aes(x = 3.15, xend = 3.15, y = 4.3, yend = 3.7),
    arrow = grid::arrow(length = grid::unit(0.08, "in")),
    colour = BOOK_MUTED, linewidth = 0.5
  ) +
  annotate(
    "rect", xmin = 6.4, xmax = 9.8, ymin = 4.3, ymax = 5.6,
    fill = "#FDF0E6", colour = book_palette[["vermillion"]],
    linewidth = 0.5, linetype = "dashed"
  ) +
  annotate(
    "text", x = 8.1, y = 4.95,
    label = paste0(
      "Master key\nParticipant 04 → name",
      "\nSeparate restricted folder"
    ),
    size = 2.7, colour = BOOK_INK, lineheight = 0.95
  ) +
  geom_segment(
    aes(x = 5.3, xend = 6.4, y = 4.95, yend = 4.95),
    arrow = grid::arrow(length = grid::unit(0.08, "in")),
    colour = book_palette[["vermillion"]], linetype = "dashed",
    linewidth = 0.5
  ) +
  annotate(
    "text", x = 3.15, y = 1.7,
    label = "The master key never sits in the same folder as the transcripts.",
    size = 2.6, colour = BOOK_INK
  ) +
  scale_x_continuous(limits = c(0.4, 10.2), expand = c(0, 0)) +
  scale_y_continuous(limits = c(1.3, 9.8), expand = c(0, 0)) +
  book_theme() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.line = element_blank(),
    panel.grid = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = BOOK_BG, colour = NA),
    plot.margin = margin(6, 6, 6, 6)
  )

save_book_fig(
  p131,
  chapter = 13, id = "13.1", type = "diagram",
  slug = "secure_data_workflow",
  height = 4.5,
  caption = paste(
    "A secure workflow for confidential interview data. Consent forms and",
    "audio are gathered, then transferred to an institutional cloud folder.",
    "The raw audio is deleted, transcripts are de-identified with a code such",
    "as Participant 04, and the master key that links the code to the",
    "participant's name is stored in a separate restricted folder. Paper forms",
    "are locked or shredded."
  ),
  alt = paste(
    "Flow chart of four steps: gather consent forms and audio, transfer them",
    "to a secure cloud folder, de-identify transcripts and create a master",
    "key, then store transcripts and forms. A dashed branch shows the master",
    "key in a separate restricted folder."
  ),
  direct_labels = TRUE
)

# ---- Figure 13.2: false-positive probability -------------------------------

alpha <- 0.05
tests <- c(1, 5, 10, 20, 50)
fp <- data.frame(
  tests = factor(tests, levels = tests),
  probability = 1 - (1 - alpha)^tests
)

p132 <- ggplot(fp, aes(x = tests, y = probability)) +
  geom_col(
    fill = book_palette[["sky_blue"]],
    colour = BOOK_INK, linewidth = 0.35, width = 0.62
  ) +
  geom_text(
    aes(label = percent(probability, accuracy = 1)),
    vjust = -0.5, size = 3.2, colour = BOOK_INK
  ) +
  geom_hline(
    yintercept = 0.5, linetype = "dashed",
    colour = BOOK_MUTED, linewidth = 0.45
  ) +
  scale_y_continuous(
    labels = percent, limits = c(0, 1), breaks = seq(0, 1, 0.25),
    expand = expansion(mult = c(0, 0.02))
  ) +
  labs(
    x = "Number of independent tests",
    y = "Probability of at least one false positive"
  ) +
  book_theme()

save_book_fig(
  p132,
  chapter = 13, id = "13.2", type = "bar",
  slug = "false_positive_probability",
  caption = paste(
    "Probability of at least one false positive when testing independent",
    "hypotheses with no real effect, at an alpha level of 0.05. The",
    "probability rises from 5% with one test to 23% with five, 40% with ten,",
    "64% with twenty, and 92% with fifty. The dashed line marks 50%."
  ),
  alt = paste(
    "Bar chart of false-positive probability by number of independent tests.",
    "Bars rise from 5% for 1 test to 23% for 5, 40% for 10, 64% for 20, and",
    "92% for 50. The 20-test bar passes the 50% line."
  ),
  direct_labels = TRUE
)
