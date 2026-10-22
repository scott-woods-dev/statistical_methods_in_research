# Load required libraries
library(tidyverse)
library(lubridate)
library(forecast)

# 1. Load and prepare the data
df <- read_csv("data/gym_membership_searches.csv") |>
  mutate(Week = mdy(Week),
         time_index = row_number(),
         lag_1 = lag(`gym membership`, 1))

# 2. Identify the peak date
peak_week <- df |> 
  filter(`gym membership` == 100) |> 
  select(Week)
print("--- Peak Search Week ---")
print(peak_week)

# 3. The Flawed Linear Model
linear_model <- lm(`gym membership` ~ time_index, data = df)
print("--- Flawed Linear Regression Summary ---")
summary(linear_model)

# 4. The Autocorrelation Coefficient (Lag-1)
lag1_cor <- cor(df$`gym membership`, df$lag_1, use = "complete.obs")
print("--- Lag-1 Autocorrelation ---")
print(lag1_cor)

# 5. Generate Visualizations
# Plot A: The Flawed Histogram (for 12.2 comparison)
p_hist <- ggplot(df, aes(x = `gym membership`)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "white") +
  theme_minimal() +
  labs(title = "Histogram of Gym Membership Searches")

# Plot B: Time Series Line Plot
p_line <- ggplot(df, aes(x = Week, y = `gym membership`)) +
  geom_line(color = "darkblue", linewidth = 0.8) +
  theme_minimal() +
  labs(title = "Time Series: Gym Membership Searches", x = "Date", y = "Search Index")

# Plot C: Lag-1 Autocorrelation Scatterplot
p_lag <- ggplot(df, aes(x = lag_1, y = `gym membership`)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  theme_minimal() +
  labs(title = "Autocorrelation: Week vs. Previous Week", 
       x = "Search Interest (Week t-1)", 
       y = "Search Interest (Week t)")

# 6. Basic ARIMA Forecast (for 12.4)
# Assuming roughly 52 weeks per year, starting mid-May 2021
ts_data <- ts(df$`gym membership`, frequency = 52, start = c(2021, 20)) 
arima_model <- auto.arima(ts_data)
p_forecast <- autoplot(forecast(arima_model, h = 52)) +
  theme_minimal() +
  labs(title = "ARIMA Forecast: Next 6 Months", x = "Year", y = "Search Index")

# Display plots (run these one by one in your console to view them)
print(p_hist)
print(p_line)
print(p_lag)
print(p_forecast)