# =============================================================================
# Chapter 10 figures: Nonparametric Tests
#
# Run from the project root:
#   Rscript r_code/figures/chapter_10.R
#
# Figures 10.1-10.5 use textbook_prices.csv,
# college_teacher_salary_2023.csv, student_lifestyle_sleep.csv, cc_risk.csv,
# and college_backpacks.csv. The statistics behind the prose are recorded in
# figures/chapter_10/values.yml by r_code/figures/chapter_10_values.R.
# =============================================================================

source("r_code/figures/_book_figs.R")

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
  library(scales)
})

assert_book_font()

# ---- Data -------------------------------------------------------------------

textbooks <- read_csv("data/textbook_prices.csv", show_col_types = FALSE) %>%
  rename(Bookstore = 2)
salary <- read_csv(
  "data/college_teacher_salary_2023.csv", show_col_types = FALSE
)
lifestyle <- read_csv(
  "data/student_lifestyle_sleep.csv", show_col_types = FALSE
) %>%
  mutate(
    AlcoholUse = factor(
      AlcoholUse, levels = c("Abstain", "Light", "Moderate", "Heavy")
    )
  )
cc_risk <- read_csv("data/cc_risk.csv", show_col_types = FALSE)
backpacks <- read_csv("data/college_backpacks.csv", show_col_types = FALSE)

# ---- Figure 10.1: paired textbook price differences -------------------------

diff_df <- data.frame(
  difference = textbooks$Bookstore - textbooks$Amazon
)
tb_median <- median(diff_df$difference)

p101 <- ggplot(diff_df, aes(x = 1, y = difference)) +
  geom_hline(
    yintercept = 0, linetype = "dashed",
    colour = BOOK_MUTED, linewidth = 0.4
  ) +
  geom_boxplot(
    width = 0.34, fill = book_palette[["sky_blue"]],
    colour = BOOK_INK, linewidth = 0.35, outlier.shape = NA
  ) +
  geom_point(
    position = position_jitter(width = 0.03, height = 0, seed = 2026),
    shape = 21, fill = book_palette[["sky_blue"]],
    colour = BOOK_INK, size = 1.7, stroke = 0.3
  ) +
  annotate(
    "text", x = 1.28, y = 0, label = "Zero difference",
    hjust = 0, vjust = 1.4, size = 3.0, colour = BOOK_INK
  ) +
  annotate(
    "text", x = 1.28, y = tb_median,
    label = paste0("Median = ", dollar(tb_median, accuracy = 0.01)),
    hjust = 0, vjust = -0.6, size = 3.0, colour = BOOK_INK
  ) +
  scale_x_continuous(limits = c(0.55, 1.9), breaks = NULL) +
  scale_y_continuous(
    limits = c(-15, 135), breaks = seq(0, 120, 30)
  ) +
  labs(
    x = NULL,
    y = "Price difference (bookstore minus Amazon, dollars)"
  ) +
  book_theme() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()
  )

save_book_fig(
  p101,
  chapter = 10, id = "10.1", type = "box",
  slug = "textbook_price_differences",
  caption = paste(
    "Price differences in dollars for 16 required textbooks, calculated as",
    "bookstore minus Amazon. The median difference is 36.00, and most books",
    "cost more at the bookstore. The box shows the middle half of the",
    "differences; each circle is one textbook."
  ),
  alt = paste(
    "Boxplot of textbook price differences in dollars, with one point per",
    "book. The median is 36.00 and the middle half of the differences runs",
    "from about 4 to 61. Positive values mean the bookstore is more",
    "expensive; four books cost slightly less at the bookstore."
  ),
  direct_labels = TRUE
)

# ---- Figure 10.2: salary by sex --------------------------------------------

salary <- salary %>%
  mutate(Sex = factor(Sex, levels = c(0, 1), labels = c("Female", "Male")))

salary_medians <- salary %>%
  group_by(Sex) %>%
  summarise(median_salary = median(Salary), .groups = "drop") %>%
  mutate(
    label = paste0(
      "Median = ", dollar(median_salary * 1000, accuracy = 1)
    )
  )

p102 <- ggplot(salary, aes(x = Salary, fill = Sex)) +
  geom_histogram(
    binwidth = 20, boundary = 0,
    colour = BOOK_INK, linewidth = 0.25
  ) +
  geom_vline(
    data = salary_medians, aes(xintercept = median_salary),
    linetype = "dashed", colour = BOOK_INK, linewidth = 0.5
  ) +
  geom_text(
    data = salary_medians, inherit.aes = FALSE,
    aes(x = median_salary, y = Inf, label = label),
    vjust = 1.8, hjust = -0.05, size = 2.8, colour = BOOK_INK
  ) +
  facet_wrap(~Sex, ncol = 2, scales = "free_y") +
  scale_fill_manual(
    values = c(
      Female = book_palette[["sky_blue"]],
      Male = book_palette[["orange"]]
    ),
    guide = "none"
  ) +
  scale_x_continuous(breaks = seq(0, 500, 100)) +
  labs(
    x = "Annual salary (thousands of dollars)",
    y = "Number of professors"
  ) +
  book_theme()

save_book_fig(
  p102,
  chapter = 10, id = "10.2", type = "hist",
  slug = "salary_by_sex",
  caption = paste(
    "Annual teaching salaries for 97 female and 103 male professors. Both",
    "distributions are right-skewed, with most salaries below 120 thousand",
    "dollars and a long upper tail; the dashed line marks each median."
  ),
  alt = paste(
    "Side-by-side histograms of salary by sex with shared salary bins. Both",
    "distributions have their tallest bars below 40 thousand dollars and a",
    "long right tail. Female salaries reach about 170 thousand; male salaries",
    "extend to 536 thousand. Dashed lines mark the medians at 60 and 75",
    "thousand."
  ),
  direct_labels = TRUE
)

# ---- Figure 10.3: GPA by alcohol use ---------------------------------------

p103 <- ggplot(lifestyle, aes(x = AlcoholUse, y = GPA)) +
  geom_boxplot(
    width = 0.5, fill = book_palette[["sky_blue"]],
    colour = BOOK_INK, linewidth = 0.35,
    outlier.shape = 21, outlier.colour = BOOK_INK,
    outlier.fill = "white", outlier.size = 1.5
  ) +
  scale_y_continuous(
    limits = c(1.8, 4.05), breaks = seq(2, 4, 0.5)
  ) +
  labs(x = "Alcohol use", y = "Grade point average") +
  book_theme()

save_book_fig(
  p103,
  chapter = 10, id = "10.3", type = "box",
  slug = "gpa_by_alcohol",
  caption = paste(
    "Grade point averages for 253 students by self-reported alcohol use. The",
    "medians fall from 3.40 for students who abstain to 3.10 for heavy",
    "drinkers, but the groups overlap heavily and the Kruskal-Wallis test is",
    "not significant (p = .141)."
  ),
  alt = paste(
    "Boxplots of GPA for four alcohol-use groups. Medians are 3.40 for",
    "abstain, 3.30 for light, 3.25 for moderate, and 3.10 for heavy. The",
    "boxes overlap and each spans roughly 3.0 to 3.6."
  ),
  direct_labels = TRUE
)

# ---- Figure 10.4: days drinking --------------------------------------------

days_df <- data.frame(DaysDrink = cc_risk$DaysDrink)
mean_days <- mean(days_df$DaysDrink)
median_days <- median(days_df$DaysDrink)
max_days_count <- max(table(days_df$DaysDrink))

p104 <- ggplot(days_df, aes(x = DaysDrink)) +
  geom_histogram(
    binwidth = 1, boundary = 0,
    fill = book_palette[["sky_blue"]], colour = BOOK_INK,
    linewidth = 0.25
  ) +
  geom_vline(
    xintercept = median_days, linetype = "solid",
    colour = book_palette[["vermillion"]], linewidth = 0.8
  ) +
  geom_vline(
    xintercept = mean_days, linetype = "dashed",
    colour = BOOK_MUTED, linewidth = 0.7
  ) +
  annotate(
    "text", x = median_days + 0.8, y = max_days_count * 0.96,
    label = paste0("Median = ", median_days, " days"),
    hjust = 0, size = 3.0, colour = BOOK_INK
  ) +
  annotate(
    "text", x = mean_days + 0.8, y = max_days_count * 0.84,
    label = paste0("Mean = ", round(mean_days, 1), " days"),
    hjust = 0, size = 3.0, colour = BOOK_INK
  ) +
  scale_x_continuous(breaks = seq(0, 30, 5)) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.08))
  ) +
  labs(
    x = "Days drinking in the past month",
    y = "Number of students"
  ) +
  book_theme()

save_book_fig(
  p104,
  chapter = 10, id = "10.4", type = "hist",
  slug = "days_drinking",
  caption = paste(
    "Distribution of drinking days in the past month for 437 students. Zero",
    "days is the tallest bar at 123 students, and the mean (6.5 days) sits",
    "well above the median (3 days) because a small group drinks frequently."
  ),
  alt = paste(
    "Histogram of drinking days in the past month for 437 students. The",
    "0-day bar is tallest at 123 students, counts drop after the first few",
    "days, a secondary bump appears at 10 days, and a thin tail reaches 30",
    "days. The mean of 6.5 days is marked to the right of the median of 3",
    "days."
  ),
  direct_labels = TRUE
)

# ---- Figure 10.5: back problems by enrollment status -----------------------

bp_df <- backpacks %>%
  mutate(
    Status = factor(
      Status, levels = c("G", "U"),
      labels = c("Graduate", "Undergraduate")
    ),
    BackProblems = factor(
      BackProblems, levels = c(0, 1),
      labels = c("No back problems", "Back problems")
    )
  ) %>%
  count(Status, BackProblems, .drop = FALSE)

p105 <- ggplot(
  bp_df, aes(x = Status, y = n, fill = BackProblems)
) +
  geom_col(
    position = position_dodge(width = 0.75), width = 0.65,
    colour = BOOK_INK, linewidth = 0.35
  ) +
  geom_text(
    aes(label = n, y = pmax(n, 1.2)),
    position = position_dodge(width = 0.75),
    vjust = -0.4, size = 3.2, colour = BOOK_INK
  ) +
  annotate(
    "text", x = "Graduate", y = 38, label = "Only 3 graduate students",
    size = 3.0, colour = BOOK_INK
  ) +
  scale_fill_manual(
    values = c(
      "No back problems" = book_palette[["sky_blue"]],
      "Back problems" = book_palette[["orange"]]
    ),
    name = NULL
  ) +
  scale_y_continuous(
    limits = c(0, 75), expand = expansion(mult = c(0, 0.05))
  ) +
  labs(x = "Enrollment status", y = "Number of students") +
  book_theme()

save_book_fig(
  p105,
  chapter = 10, id = "10.5", type = "bar",
  slug = "back_problems_by_status",
  caption = paste(
    "Back problems by enrollment status for 100 students. Only 3 students",
    "are graduate students, and none reported back problems; 32 of 97",
    "undergraduates did. The tiny graduate group is why expected counts fall",
    "below five and Fisher's exact test is used."
  ),
  alt = paste(
    "Grouped bar chart of back problems by enrollment status. Graduate: 3",
    "without problems and 0 with. Undergraduate: 65 without and 32 with. The",
    "graduate bars are tiny because the sample has only 3 graduate students."
  ),
  direct_labels = TRUE
)
