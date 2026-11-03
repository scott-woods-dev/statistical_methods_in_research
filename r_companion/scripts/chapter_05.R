# ==================================================================
# R Companion, Chapter 5: Multiple Regression
# Statistical Methods in Research
#
# What this script makes:
#   1. A multiple regression with two numerical predictors
#   2. A model with a binary (two-group) predictor added
#   3. A model with a categorical predictor (three or more groups)
#   4. Variance inflation factors (VIF)
#   5. A model with an interaction
#
# Before you run it:
#   - Put this script and acs_2023.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - Install the car package once, if you have not already:
#     install.packages("car")
# ==================================================================


## ---- load-packages ----
# Load car, the package that calculates VIF.
library(car)


## ---- read-data ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
census <- read.csv("acs_2023.csv")

# Keep only the people who worked at least one hour a week, using
# subset() from Chapter 3.
workers <- subset(census, HoursWk > 0)
nrow(workers)


## ---- two-predictors ----
# 1. MULTIPLE REGRESSION: list the predictors after the ~,
#    joined with + signs.
#    Income ~ HoursWk + Age reads "Income, predicted by HoursWk and
#    Age".
# CHANGE THIS: your response, your predictors, your dataset, and a
#              name for your model
hours_model <- lm(Income ~ HoursWk + Age, data = workers)
summary(hours_model)


## ---- binary ----
# 2. BINARY PREDICTOR: a variable with two groups goes in the
#    model like any other predictor. Here Sex is coded 1 = male,
#    0 = female, so female is the baseline group.
# CHANGE THIS: add your binary predictor after another + sign
sex_model <- lm(Income ~ HoursWk + Age + Sex, data = workers)
summary(sex_model)


## ---- categorical ----
# 3. CATEGORICAL PREDICTOR with three or more groups.
#    Race is stored as words (Asian, Black, Other, White), so R
#    makes the indicator variables itself. It uses the first group
#    in alphabetical order (Asian) as the baseline.
# CHANGE THIS: add your categorical predictor after a + sign
race_model <- lm(Income ~ HoursWk + Age + Sex + Race,
                 data = workers)
summary(race_model)


## ---- baseline ----
# To choose a different baseline group, turn the variable into a
# factor and name the baseline with relevel().
#    ref = "White" makes White the baseline group.
# CHANGE THIS: your categorical variable (in both places) and the
#              group you want as the baseline
workers$Race <- relevel(factor(workers$Race), ref = "White")
race_model <- lm(Income ~ HoursWk + Age + Sex + Race,
                 data = workers)
summary(race_model)


## ---- vif ----
# 4. VARIANCE INFLATION FACTORS: one VIF for each predictor.
#    vif() comes from the car package.
# CHANGE THIS: your model name
vif(sex_model)


## ---- interaction ----
# 5. INTERACTION: a * between two predictors includes both of them
#    AND their interaction. Here the question is whether the
#    income difference for married people is the same for men and
#    women. Married is coded 1 = married, 0 = not married.
# CHANGE THIS: your two predictors, joined with *
interaction_model <- lm(Income ~ HoursWk + Age + Sex * Married,
                        data = workers)
summary(interaction_model)
