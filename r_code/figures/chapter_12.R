# =============================================================================
# Chapter 12 figures: Time Series Analysis
#
# Run from the project root:
#   Rscript r_code/figures/chapter_12.R
#
# Figures 12.1-12.3 use the weekly gym_membership_searches.csv file. The
# monthly sunscreen_searches.csv file is used only in the exercises; its values
# are recorded by r_code/figures/chapter_12_values.R.
# =============================================================================

source("r_code/figures/_book_figs.R")

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(readr)
  library(lubridate)
  library(forecast)
  library(tibble)
  library(scales)
})

assert_book_font()

# ---- Data -------------------------------------------------------------------

gym <- read_csv("data/gym_membership_searches.csv", show_col_types = FALSE) %>%
  mutate(Week = mdy(Week)) %>%
  rename(search_index = `gym membership`) %>%
  arrange(Week)

stopifnot(!any(is.na(gym$Week)), !any(is.na(gym$search_index)))

# ---- Figure 12.1: weekly time series ---------------------------------------

peak_row <- gym %>% slice_max(search_index, n = 1, with_ties = FALSE)

p121 <- ggplot(gym, aes(x = Week, y = search_index)) +
  geom_line(colour = BOOK_INK, linewidth = 0.5) +
  annotate(
    "point", x = peak_row$Week, y = peak_row$search_index,
    shape = 21, size = 2.6, stroke = 0.4,
    fill = book_palette[["orange"]], colour = BOOK_INK
  ) +
  annotate(
    "text", x = peak_row$Week, y = peak_row$search_index + 8,
    label = paste0("Peak = ", peak_row$search_index),
    hjust = 0.55, size = 3.0, colour = BOOK_INK
  ) +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  scale_y_continuous(
    limits = c(0, 108), breaks = seq(0, 100, 25)
  ) +
  labs(x = NULL, y = "Search index") +
  book_theme()

save_book_fig(
  p121,
  chapter = 12, id = "12.1", type = "line",
  slug = "gym_time_series",
  caption = paste(
    "Weekly gym membership search index from May 2021 through May 2026 (262",
    "weeks). The series trends upward and spikes every winter; the February",
    "2026 spike reaches the maximum index value of 100. The distance between",
    "the summer baseline and the winter peak grows over time."
  ),
  alt = paste(
    "Line chart of weekly gym search interest over five years. A gradual",
    "upward trend with sharp winter peaks. Winter peaks are about 37 in the",
    "season ending 2022, 48 in 2023, 54 in 2024, 64 in 2025, and 100 in",
    "February 2026."
  ),
  direct_labels = TRUE
)

# ---- Figure 12.2: lag-1 scatterplot ----------------------------------------

gym <- gym %>%
  mutate(lag_index = lag(search_index))

lag_pairs <- gym %>% filter(!is.na(lag_index))
lag_r <- cor(lag_pairs$search_index, lag_pairs$lag_index)
lag_slope <- unname(coef(lm(search_index ~ lag_index, data = lag_pairs))[2])

p122 <- ggplot(lag_pairs, aes(x = lag_index, y = search_index)) +
  geom_point(
    shape = 21, size = 1.7, stroke = 0.25,
    fill = book_palette[["sky_blue"]], colour = BOOK_INK, alpha = 0.65
  ) +
  geom_smooth(
    method = "lm", formula = y ~ x, se = FALSE,
    colour = book_palette[["vermillion"]],
    linetype = "dashed", linewidth = 0.7
  ) +
  annotate(
    "text", x = 18, y = 98,
    label = paste0(
      "r = ", sprintf("%.2f", lag_r), "\n",
      "slope = ", sprintf("%.2f", lag_slope)
    ),
    hjust = 0, vjust = 1, size = 3.2, colour = BOOK_INK
  ) +
  scale_x_continuous(
    limits = c(15, 105), breaks = seq(20, 100, 20)
  ) +
  scale_y_continuous(
    limits = c(15, 105), breaks = seq(20, 100, 20)
  ) +
  labs(
    x = "Search index, previous week (t-1)",
    y = "Search index, current week (t)"
  ) +
  book_theme()

save_book_fig(
  p122,
  chapter = 12, id = "12.2", type = "scatter",
  slug = "gym_lag_scatter",
  caption = paste(
    "Gym membership search index in week t against the same index in week",
    "t-1 (261 weekly pairs). The points form a tight positive band:",
    "r = 0.92 and the fitted slope is 0.93. The dashed line is the",
    "least-squares fit."
  ),
  alt = paste(
    "Scatterplot of this week's gym search index against last week's.",
    "Points cluster tightly along a positive line from about 20 to 100;",
    "r = 0.92 and the fitted slope is 0.93."
  ),
  direct_labels = TRUE
)

# ---- Figure 12.3: ARIMA forecast -------------------------------------------

ts_gym <- ts(gym$search_index, frequency = 52, start = c(2021, 20))
arima_model <- auto.arima(ts_gym)
gym_forecast <- forecast(arima_model, h = 52)

last_week <- max(gym$Week)
last_value <- tail(gym$search_index, 1)

forecast_df <- bind_rows(
  tibble(
    date = last_week,
    mean = last_value,
    lower = last_value,
    upper = last_value
  ),
  tibble(
    date = last_week + 7 * seq_len(52),
    mean = as.numeric(gym_forecast$mean),
    lower = as.numeric(gym_forecast$lower[, 2]),
    upper = as.numeric(gym_forecast$upper[, 2])
  )
)

fc_peak <- forecast_df %>%
  filter(date > last_week) %>%
  slice_max(mean, n = 1, with_ties = FALSE)

p123 <- ggplot() +
  geom_ribbon(
    data = forecast_df,
    aes(x = date, ymin = lower, ymax = upper),
    fill = book_palette[["sky_blue"]], alpha = 0.30
  ) +
  geom_line(
    data = gym, aes(x = Week, y = search_index),
    colour = BOOK_INK, linewidth = 0.5
  ) +
  geom_line(
    data = forecast_df, aes(x = date, y = mean),
    colour = book_palette[["blue"]],
    linetype = "dashed", linewidth = 0.7
  ) +
  geom_vline(
    xintercept = last_week, linetype = "dotted",
    colour = BOOK_MUTED, linewidth = 0.4
  ) +
  annotate(
    "point", x = fc_peak$date, y = fc_peak$mean,
    shape = 21, size = 2.5, stroke = 0.4,
    fill = book_palette[["orange"]], colour = BOOK_INK
  ) +
  annotate(
    "text", x = fc_peak$date, y = fc_peak$mean + 12,
    label = paste0(
      "Peak ", sprintf("%.1f", fc_peak$mean), "\n",
      format(fc_peak$date, "%b %Y")
    ),
    hjust = 1.05, size = 3.0, colour = BOOK_INK
  ) +
  annotate(
    "text", x = last_week + 14, y = 108,
    label = "Forecast begins", hjust = 0, size = 3.0, colour = BOOK_INK
  ) +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  scale_y_continuous(
    limits = c(0, 118), breaks = seq(0, 100, 25)
  ) +
  labs(x = NULL, y = "Search index") +
  book_theme()

save_book_fig(
  p123,
  chapter = 12, id = "12.3", type = "line",
  slug = "gym_arima_forecast",
  caption = paste(
    "Weekly gym membership search index from May 2021 through May 2026 with",
    "a 52-week ARIMA forecast. The selected model is ARIMA(1,1,1) with a",
    "seasonal moving-average term at 52 weeks. The forecast repeats a winter",
    "peak of 70.3 in mid-February 2027, below",
    "the 2026 record of 100, and the 95% prediction interval widens from",
    "about 19 points to about 45 points."
  ),
  alt = paste(
    "Time series line plot from 2021 through 2027. Observed weekly searches",
    "rise with winter peaks; the dashed forecast starts in May 2026 and peaks",
    "at 70.3 in February 2027, inside a shaded band that widens through 2027."
  ),
  direct_labels = TRUE
)
