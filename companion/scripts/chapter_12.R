# ==================================================================
# R Companion, Chapter 12: Time Series Analysis
# Statistical Methods in Research
#
# What this script makes:
#   1. A time series line plot
#   2. A lag-1 variable, its autocorrelation, and a lag-1
#      scatterplot
#   3. An ARIMA model and a forecast with prediction intervals
#
# Before you run it:
#   - Put this script and gym_membership_searches.csv in the same
#     folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - Install ggplot2 and forecast once, if you have not already
#     (see Getting Set Up).
# ==================================================================


## ---- load-packages ----
# ggplot2 draws the graphs; forecast fits the ARIMA model and
# makes the forecast.
library(ggplot2)
library(forecast)


## ---- read-data ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
gym <- read.csv("gym_membership_searches.csv")
names(gym)
head(gym)


## ---- dates ----
# Turn the dates from text into real dates, so R puts them in
# time order on a graph.
#    format = "%m-%d-%y" describes how the dates are written:
#      month-day-year, with a two-digit year (05-16-21).
#      Use "%Y" for a four-digit year (05-16-2021), and change
#      the - to / if your dates use slashes (05/16/21).
# CHANGE THIS: your date column (in both places) and its format
gym$Week <- as.Date(gym$Week, format = "%m-%d-%y")
head(gym)


## ---- line-plot ----
# 1. TIME SERIES LINE PLOT: time along the bottom, the measurement
#    up the side. geom_line() joins the points in time order.
# CHANGE THIS: your date column, your measurement, and your labels
ggplot(gym, aes(x = Week, y = gym.membership)) +
  geom_line(color = "#0072B2", linewidth = 0.8) +
  labs(title = "Weekly Search Interest in Gym Memberships",
       x = "Week",
       y = "Search index (0 to 100)") +
  theme_minimal(base_size = 14)


## ---- lag ----
# 2. THE LAG-1 VARIABLE: each row gets the PREVIOUS row's value.
#    gym$gym.membership[-nrow(gym)] is every value except the
#      last one (nrow() counts the rows; the minus sign drops
#      that row).
#    c(NA, ...) puts an empty value at the start, since the first
#      week has no week before it.
# CHANGE THIS: your dataset (in all three places) and your
#              measurement
gym$lag_1 <- c(NA, gym$gym.membership[-nrow(gym)])
head(gym)


## ---- autocorrelation ----
# The lag-1 autocorrelation: the correlation between each week
# and the week before.
#    use = "complete.obs" skips the first row, which has no
#      previous week. Leave it as is.
# CHANGE THIS: your measurement and your lag column
cor(gym$gym.membership, gym$lag_1, use = "complete.obs")


## ---- lag-plot ----
# The lag-1 scatterplot: last week along the bottom, this week up
# the side, with a straight line, as in Chapter 4.
#    na.rm = TRUE in both layers skips the first row quietly.
# CHANGE THIS: your lag column, your measurement, and your labels
ggplot(gym, aes(x = lag_1, y = gym.membership)) +
  geom_point(color = "#0072B2", alpha = 0.6, na.rm = TRUE) +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE,
              color = "black", linetype = "dashed",
              na.rm = TRUE) +
  labs(title = "This Week Against Last Week",
       x = "Search index, previous week (t - 1)",
       y = "Search index, this week (t)") +
  theme_minimal(base_size = 14)


## ---- ts ----
# 3. ARIMA FORECAST.
#    ts() turns the measurement into a time series.
#    frequency = 52 is the number of measurements per year (52
#      for weekly data, 12 for monthly, 4 for quarterly).
#    start = c(2021, 20) is when the series starts: the year, then
#      which measurement of that year (here, the 20th week).
# CHANGE THIS: your measurement, frequency, and start
gym_ts <- ts(gym$gym.membership, frequency = 52,
             start = c(2021, 20))


## ---- arima ----
# auto.arima() tries many ARIMA models and keeps the best one.
# CHANGE THIS: your time series' name, and a name for the model
gym_model <- auto.arima(gym_ts)
gym_model


## ---- forecast ----
# forecast() projects the model forward.
#    h = 52 is how many measurements ahead to forecast (52 weeks,
#      or one year, here).
# CHANGE THIS: your model's name and how far ahead to forecast
gym_forecast <- forecast(gym_model, h = 52)

# The highest forecast value.
max(gym_forecast$mean)


## ---- forecast-plot ----
# The forecast plot: the data, then the forecast line with its
# 80% and 95% prediction intervals shaded around it.
# CHANGE THIS: your forecast's name and your labels
autoplot(gym_forecast) +
  labs(title = "ARIMA Forecast of Gym Membership Searches",
       x = "Year",
       y = "Search index (0 to 100)") +
  theme_minimal(base_size = 14)
