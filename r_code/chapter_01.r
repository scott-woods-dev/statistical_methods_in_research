# ==============================================================================
# Chapter 1: Understanding Data through Measures and Visualizations
# Figure Generation Script
#
# Dataset: data/student_lifestyle_sleep.csv (253 college students)
#
# Run from the project root (the folder that contains data/ and r_code/).
# Plots appear in the RStudio viewer and are saved as PNGs in
# figures/chapter_01/.
#
# Figure numbering follows the [Insert Figure ...] callouts in the chapter.
# Note: the chapter text numbers the mosaic plot and the GPA box plot both as
# Figure 1.9 (a duplicate). The box plot below is saved as fig_1_09b_*.
# ==============================================================================

library(tidyverse)

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------
fig_dir <- file.path("figures", "chapter_01")
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

sl <- read_csv("data/student_lifestyle_sleep.csv", show_col_types = FALSE)

# Order the ordinal categories so bars, segments, and boxes appear in their
# natural progression (Normal -> Moderate -> Severe, Abstain -> Heavy)
sl <- sl %>%
  mutate(
    DepressionStatus = factor(DepressionStatus,
                              levels = c("normal", "moderate", "severe"),
                              labels = c("Normal", "Moderate", "Severe")),
    Stress = factor(Stress,
                    levels = c("normal", "high"),
                    labels = c("Normal", "High")),
    AlcoholUse = factor(AlcoholUse,
                        levels = c("Abstain", "Light", "Moderate", "Heavy"))
  )

# Shared palette for the AlcoholUse segments (Figures 1.8 and 1.9)
alcohol_colors <- c(Abstain = "#aec7e8",
                    Light   = "#ffbb78",
                    Moderate = "#98df8a",
                    Heavy   = "#ff9896")

# Save a ggplot object and show it in the viewer
save_fig <- function(plot, filename) {
  ggsave(file.path(fig_dir, filename), plot = plot,
         width = 7, height = 4.75, dpi = 150)
  print(plot)
  cat("Saved", filename, "\n")
}

# ------------------------------------------------------------------------------
# Figure 1.1 (Section 1.3): First 5 rows of the dataset
#
# This is a typeset table in the book (with the DepressionStatus and GPA
# columns highlighted), so it is printed here for reference rather than saved
# as a plot.
# ------------------------------------------------------------------------------
print("Figure 1.1: First 5 rows of student_lifestyle_sleep.csv")
print(head(sl, n = 5))

# ------------------------------------------------------------------------------
# Figure 1.2 (Section 1.3): Bar plot of DepressionStatus
#
# Categories on the x-axis in their natural ordinal order, frequencies on the
# y-axis, gaps between the bars.
# ------------------------------------------------------------------------------
depression_counts <- sl %>%
  count(DepressionStatus) %>%
  arrange(DepressionStatus)

p12 <- ggplot(depression_counts, aes(x = DepressionStatus, y = n)) +
  geom_col(width = 0.65, fill = "#4c72b0") +
  labs(x = "Depression Screening Status",
       y = "Number of Students") +
  theme_minimal()

save_fig(p12, "fig_1_02_barplot_depression.png")

# ------------------------------------------------------------------------------
# Figure 1.3 (Section 1.3): Pareto chart of tutoring/STEM center visit reasons
#
# The chapter presents this chart as a hypothetical example (a tutoring and
# STEM resource center), and no such variable exists in
# student_lifestyle_sleep.csv, so a small illustrative dataset is built here.
# The callout specifies: tallest bar "Math Help" on the far left, "Computer
# Use" second, and an "Other" bar on the far right combining the rare
# trailing categories.
# ------------------------------------------------------------------------------
tutoring_visits <- tribble(
  ~Reason,    ~Visits,
  "Math Help",       142,
  "Computer Use",     96,
  "Statistics Help",  61,
  "Writing Help",     48,
  "Career Services",  30,
  "Other",            26
) %>%
  mutate(Reason = factor(Reason, levels = Reason)) # descending, "Other" last

p13 <- ggplot(tutoring_visits, aes(x = Reason, y = Visits)) +
  geom_col(width = 0.7, fill = "#4c72b0") +
  labs(x = "Reason for Visit",
       y = "Number of Visits") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))

save_fig(p13, "fig_1_03_pareto_tutoring_visits.png")

# ------------------------------------------------------------------------------
# Figure 1.4 (Section 1.4): Histogram of WeekdaySleep with 1-hour bins
#
# Bars touch because the bins form a continuous number line.
# ------------------------------------------------------------------------------
p14 <- ggplot(sl, aes(x = WeekdaySleep)) +
  geom_histogram(binwidth = 1, boundary = 0, fill = "#4c72b0", color = "white") +
  labs(x = "Weekday Sleep (hours)",
       y = "Number of Students") +
  theme_minimal()

save_fig(p14, "fig_1_04_hist_weekdaysleep.png")

# ------------------------------------------------------------------------------
# Figure 1.5 (Section 1.5): Normal curve overlaid on a symmetric histogram
#
# WeekdaySleep is the chapter's example of a roughly bell-shaped variable.
# The overlaid curve uses the sample mean and standard deviation, scaled to
# the histogram's count scale (density * n).
# ------------------------------------------------------------------------------
ws_mean <- mean(sl$WeekdaySleep)
ws_sd   <- sd(sl$WeekdaySleep)

p15 <- ggplot(sl, aes(x = WeekdaySleep)) +
  geom_histogram(binwidth = 1, boundary = 0, fill = "#cdd8ea", color = "white") +
  stat_function(fun = function(x) dnorm(x, mean = ws_mean, sd = ws_sd) * nrow(sl),
                color = "#c44e52") +
  labs(x = "Weekday Sleep (hours)",
       y = "Number of Students") +
  theme_minimal()

save_fig(p15, "fig_1_05_hist_weekdaysleep_normal_overlay.png")

# ------------------------------------------------------------------------------
# Figure 1.6 (Section 1.5): Histogram of ClassesMissed (right-skewed)
#
# 1-unit bins aligned on the whole numbers, so the floor effect at zero is
# visible.
# ------------------------------------------------------------------------------
p16 <- ggplot(sl, aes(x = ClassesMissed)) +
  geom_histogram(binwidth = 1, boundary = -0.5, fill = "#4c72b0", color = "white") +
  labs(x = "Classes Missed",
       y = "Number of Students") +
  theme_minimal()

save_fig(p16, "fig_1_06_hist_classesmissed.png")

# ------------------------------------------------------------------------------
# Figure 1.7 (Section 1.6): Scatterplot of ClassesMissed (x) vs. GPA (y)
# ------------------------------------------------------------------------------
p17 <- ggplot(sl, aes(x = ClassesMissed, y = GPA)) +
  geom_point(color = "#4c72b0", alpha = 0.7) +
  labs(x = "Classes Missed",
       y = "GPA") +
  theme_minimal()

save_fig(p17, "fig_1_07_scatter_classesmissed_gpa.png")

# ------------------------------------------------------------------------------
# Figure 1.8 (Section 1.7): Segmented (100% stacked) bar chart
#
# AlcoholUse within Stress levels. Both bars are stretched to 100%, hiding
# the difference in group size (which is the point the chapter makes).
# ------------------------------------------------------------------------------
p18 <- ggplot(sl, aes(x = Stress, fill = AlcoholUse)) +
  geom_bar(position = "fill", width = 0.6) +
  scale_fill_manual(values = alcohol_colors, name = "Alcohol Use") +
  labs(x = "Stress Level",
       y = "Proportion of Students") +
  theme_minimal()

save_fig(p18, "fig_1_08_segmented_alcohol_by_stress.png")

# ------------------------------------------------------------------------------
# Figure 1.9 (Section 1.7): Mosaic plot of Stress (columns) x AlcoholUse
#
# Base R's barplot() applied to a two-way table produces a mosaic plot: the
# width of each column is proportional to the group total (the Normal column
# is noticeably wider than High), and the height of each block is the
# within-group proportion of that drinking category.
# ------------------------------------------------------------------------------
stress_alcohol_table <- t(table(sl$Stress, sl$AlcoholUse))
# transposed so that Stress levels are the side-by-side columns and
# AlcoholUse categories stack within them

png(file.path(fig_dir, "fig_1_09_mosaic_stress_alcohol.png"),
    width = 1050, height = 800, res = 150)
par(mar = c(8, 4, 3, 2))
barplot(stress_alcohol_table,
        beside = TRUE,
        names.arg = colnames(stress_alcohol_table),
        col = alcohol_colors[levels(sl$AlcoholUse)],
        xlab = "Stress Level (column width = group size)",
        ylab = "Proportion within group")
legend(x = 0.35, y = -0.42,
       legend = levels(sl$AlcoholUse),
       fill = alcohol_colors[levels(sl$AlcoholUse)],
       title = "Alcohol Use",
       horiz = TRUE, xpd = TRUE, bty = "n")
dev.off()
cat("Saved fig_1_09_mosaic_stress_alcohol.png\n")

# ------------------------------------------------------------------------------
# Figure 1.9b (Section 1.8): Side-by-side box plots of GPA by DepressionStatus
#
# (Numbered Figure 1.9 in the chapter text, which duplicates the mosaic
# plot's number.)
# ------------------------------------------------------------------------------
p19b <- ggplot(sl, aes(x = DepressionStatus, y = GPA)) +
  geom_boxplot(width = 0.5, fill = "#cdd8ea", color = "#4c72b0") +
  labs(x = "Depression Screening Status",
       y = "GPA") +
  theme_minimal()

save_fig(p19b, "fig_1_09b_boxplot_gpa_by_depression.png")

# ------------------------------------------------------------------------------
# Figure 1.10 (Section 1.8): Scatterplot of ClassesMissed vs. GPA with Stress
# as the grouping variable
#
# Per the callout: Normal stress = blue circles, High stress = red triangles.
# Varying both color and shape keeps the groups distinguishable without
# relying on color alone.
# ------------------------------------------------------------------------------
p110 <- ggplot(sl, aes(x = ClassesMissed, y = GPA,
                       color = Stress, shape = Stress)) +
  geom_point(alpha = 0.8, size = 1.8) +
  scale_color_manual(values = c(Normal = "blue", High = "red"),
                     name = "Stress Level") +
  scale_shape_manual(values = c(Normal = 16, High = 17),
                     name = "Stress Level") +
  labs(x = "Classes Missed",
       y = "GPA") +
  theme_minimal()

save_fig(p110, "fig_1_10_scatter_gpa_missed_by_stress.png")

# ------------------------------------------------------------------------------
# Figure 1.11 (Section 1.8): Bubble plot
#
# WeekdaySleep (x), GPA (y), bubble size scaled to weekly Drinks. The minimum
# mapped size stays visible so abstainers appear as tiny specks rather than
# disappearing.
# ------------------------------------------------------------------------------
p111 <- ggplot(sl, aes(x = WeekdaySleep, y = GPA, size = Drinks)) +
  geom_point(color = "#4c72b0", alpha = 0.55) +
  scale_size(range = c(1, 12), name = "Drinks per Week") +
  labs(x = "Weekday Sleep (hours)",
       y = "GPA") +
  theme_minimal()

save_fig(p111, "fig_1_11_bubble_sleep_gpa_drinks.png")

# ------------------------------------------------------------------------------
# Figure 1.13 (Section 1.10): Diagram mapping the quartiles and the IQR onto
# a box plot
#
# A single horizontal box plot of WeekdaySleep, annotated with Q1, the
# Median, and Q3, plus a bracket above the box showing that the physical
# length of the box is the IQR. (Figures 1.12 and 1.14 are typeset tables in
# the text and require no code.)
# ------------------------------------------------------------------------------
q25 <- as.numeric(quantile(sl$WeekdaySleep, 0.25))
q50 <- as.numeric(quantile(sl$WeekdaySleep, 0.50))
q75 <- as.numeric(quantile(sl$WeekdaySleep, 0.75))
iqr <- q75 - q25

png(file.path(fig_dir, "fig_1_13_iqr_boxplot_diagram.png"),
    width = 1050, height = 600, res = 150)
par(mar = c(5, 4, 2, 2))
boxplot(sl$WeekdaySleep,
        horizontal = TRUE,
        axes = TRUE,
        staple = FALSE,
        xlab = "Weekday Sleep (hours)",
        ylab = NULL,
        ylim = c(0, 2.6))
# Bracket above the box: from Q1 to Q3
segments(q25, 1.6, q25, 2.0)
segments(q75, 1.6, q75, 2.0)
segments(q25, 2.0, q75, 2.0, lwd = 2)
text((q25 + q75) / 2, 2.25,
     sprintf("IQR = Q3 - Q1 = %.2f - %.2f = %.2f hours", q75, q25, iqr),
     cex = 0.95)
# Labels below the box, pointing up at each edge and the median line
arrows(q25, 0.30, q25, 0.55, length = 0.02)
text(q25, 0.10, "Q1 (25th %ile)", cex = 0.9)
arrows(q50, 0.30, q50, 0.90, length = 0.02)
text(q50, 0.10, "Median (50th %ile)", cex = 0.9)
arrows(q75, 0.30, q75, 0.55, length = 0.02)
text(q75, 0.10, "Q3 (75th %ile)", cex = 0.9)
dev.off()
cat("Saved fig_1_13_iqr_boxplot_diagram.png\n")

# ------------------------------------------------------------------------------
# Figure 1.15 (Section 1.16): Side-by-side box plots of ClassesMissed
# grouped by DepressionStatus
# ------------------------------------------------------------------------------
p115 <- ggplot(sl, aes(x = DepressionStatus, y = ClassesMissed)) +
  geom_boxplot(width = 0.5, fill = "#cdd8ea", color = "#4c72b0") +
  labs(x = "Depression Screening Status",
       y = "Classes Missed") +
  theme_minimal()

save_fig(p115, "fig_1_15_boxplot_classesmissed_by_depression.png")

# ------------------------------------------------------------------------------
# Section 1.16 reference values
#
# Median and IQR of ClassesMissed within each DepressionStatus group, for
# checking the "Numerical Summaries" table in the Guided Analysis
# (Normal: Mdn 1.0, IQR 2.0; Moderate: Mdn 2.0, IQR 3.0; Severe: Mdn 4.0,
# IQR 5.0).
# ------------------------------------------------------------------------------
print("Section 1.16: Median / IQR of ClassesMissed by DepressionStatus")
print(aggregate(ClassesMissed ~ DepressionStatus, data = sl,
                FUN = function(x) c(Median = median(x), IQR = IQR(x))))
