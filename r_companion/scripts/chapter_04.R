# ==================================================================
# R Companion, Chapter 4: Correlation and Simple Linear Regression
# Statistical Methods in Research
#
# What this script makes:
#   1. A correlation (r) with its test
#   2. A regression model: intercept, slope, and R-squared
#   3. A scatterplot with the regression line
#   4. A residual plot and a histogram of the residuals
#   5. Cook's distance, to look for influential points
#   6. A confidence interval for the slope
#   7. A prediction, with a confidence and a prediction interval
#   8. A log transformation for a curved relationship
#
# Before you run it:
#   - Put this script, census_at_school.csv, and
#     happy_planet_index_2024.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
# ==================================================================


## ---- load-packages ----
library(ggplot2)


## ---- read-students ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
students <- read.csv("census_at_school.csv")


## ---- correlation ----
# 1. CORRELATION: cor.test() calculates r for two numerical
#    variables and tests whether the population correlation (rho)
#    is different from 0. The order of the two variables does not
#    matter.
# CHANGE THIS: your two numerical variables
cor.test(students$Height, students$Foot)


## ---- fit-model ----
# 2. REGRESSION MODEL: lm() stands for "linear model".
#    Foot ~ Height reads "Foot, predicted by Height". The response
#      (y) goes before the ~ and the predictor (x) after it.
#    The model is stored under the name foot_model, so you can
#      use it in the steps below.
#    summary() prints the results.
# CHANGE THIS: your response variable, your predictor, your
#              dataset, and a name for your model
foot_model <- lm(Foot ~ Height, data = students)
summary(foot_model)


## ---- scatter-line ----
# 3. SCATTERPLOT WITH THE REGRESSION LINE.
#    geom_smooth(method = "lm") adds the regression line.
#    se = FALSE leaves out the gray band around the line.
# CHANGE THIS: your predictor after x =, your response after y =,
#              and your labels
ggplot(students, aes(x = Height, y = Foot)) +
  geom_point(color = "#0072B2") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = "Foot Length and Height",
       x = "Height (cm)",
       y = "Foot length (cm)") +
  theme_minimal(base_size = 14)


## ---- residuals ----
# 4. RESIDUALS: store each student's predicted value and residual
#    (actual minus predicted) as two new columns in the dataset.
#    fitted() gives the predicted values; resid() gives the
#      residuals.
# CHANGE THIS: your dataset name before each $, and your model
#              name inside fitted() and resid()
students$predicted <- fitted(foot_model)
students$residual <- resid(foot_model)


## ---- residual-plot ----
# RESIDUAL PLOT: predicted values across, residuals up and down.
#    geom_hline(yintercept = 0) draws a horizontal line at 0
#      (no error). linetype = "dashed" makes it a dashed line.
ggplot(students, aes(x = predicted, y = residual)) +
  geom_point(color = "#0072B2") +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "Residual Plot",
       x = "Predicted foot length (cm)",
       y = "Residual (cm)") +
  theme_minimal(base_size = 14)


## ---- residual-histogram ----
# HISTOGRAM OF THE RESIDUALS, to check that they form a rough
# bell curve. This is the histogram from Chapter 1.
ggplot(students, aes(x = residual)) +
  geom_histogram(binwidth = 1, fill = "#0072B2", color = "black") +
  labs(title = "Histogram of the Residuals",
       x = "Residual (cm)",
       y = "Number of students") +
  theme_minimal(base_size = 14)


## ---- cooks ----
# 5. COOK'S DISTANCE: one value for each row.
#    max() shows the largest one.
#    which(... > 1) lists the rows above 1, the textbook's cutoff.
# CHANGE THIS: your model name inside cooks.distance()
cooks <- cooks.distance(foot_model)
max(cooks)
which(cooks > 1)


## ---- confint ----
# 6. 95% CONFIDENCE INTERVAL for the intercept and the slope.
# CHANGE THIS: your model name
confint(foot_model)


## ---- predict ----
# 7. PREDICTION for a new predictor value.
#    data.frame(Height = 170) sets up the value to predict from.
#      The name (Height) must match the predictor in the model.
#    interval = "confidence" gives the interval for the MEAN of
#      everyone with that height.
#    interval = "prediction" gives the interval for ONE person.
# CHANGE THIS: your predictor's name and the value you want, and
#              your model name
new_student <- data.frame(Height = 170)
predict(foot_model, new_student, interval = "confidence")
predict(foot_model, new_student, interval = "prediction")


## ---- read-planet ----
# 8. LOG TRANSFORMATION, with a second dataset.
# CHANGE THIS: the file name of your dataset, inside the quotes.
planet <- read.csv("happy_planet_index_2024.csv")


## ---- curve ----
# First, the scatterplot on the original scale.
ggplot(planet, aes(x = Footprint, y = LifeExpectancy)) +
  geom_point(color = "#0072B2") +
  labs(title = "Life Expectancy and Ecological Footprint",
       x = "Ecological footprint",
       y = "Life expectancy (years)") +
  theme_minimal(base_size = 14)


## ---- log-scatter ----
# log10() takes the base-10 logarithm of each value. Putting it
# inside aes() plots the transformed values; the data stay as
# they are.
# CHANGE THIS: your predictor inside log10(), and your response
ggplot(planet, aes(x = log10(Footprint), y = LifeExpectancy)) +
  geom_point(color = "#0072B2") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = "Life Expectancy and Log of Footprint",
       x = "Ecological footprint (log base 10)",
       y = "Life expectancy (years)") +
  theme_minimal(base_size = 14)


## ---- log-model ----
# The model works the same way, with log10() around the predictor.
# CHANGE THIS: your response, your predictor inside log10(), and
#              your dataset
log_model <- lm(LifeExpectancy ~ log10(Footprint), data = planet)
summary(log_model)
