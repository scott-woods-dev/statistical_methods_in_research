# ==================================================================
# R Companion, Chapter 9: Logistic Regression
# Statistical Methods in Research
#
# What this script makes:
#   1. A simple logistic regression, with its odds ratio
#   2. A multiple logistic regression, with odds ratios, their 95%
#      confidence intervals, and VIF
#   3. Predicted probabilities for specific profiles
#   4. Deviance R-squared and adjusted deviance R-squared
#   5. The Hosmer-Lemeshow goodness-of-fit test
#   6. A confusion matrix, with sensitivity and specificity
#   7. An ROC curve and its AUC
#
# Before you run it:
#   - Put this script and youth_risk_2007.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - Install ggplot2, car, pROC, and DescTools once, if you have
#     not already (see Getting Set Up).
# ==================================================================


## ---- load-packages ----
# ggplot2 styles the ROC curve, car calculates VIF, and pROC
# makes the ROC curve and its AUC.
library(ggplot2)
library(car)
library(pROC)


## ---- read-data ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
youth <- read.csv("youth_risk_2007.csv")

# The outcome must be coded 0 and 1, with 1 for the event you are
# predicting. useNA = "ifany" also counts any missing values.
# CHANGE THIS: your outcome variable
table(youth$smoke, useNA = "ifany")


## ---- simple ----
# 1. SIMPLE LOGISTIC REGRESSION.
#    glm() is written like lm(): the outcome before the ~, the
#      predictor after it.
#    family = binomial makes it a logistic regression (for a 0/1
#      outcome). Leave it as is.
#    na.action = na.exclude skips rows with missing values but
#      keeps their places, so the predictions line up with the
#      dataset later. Leave it as is.
# CHANGE THIS: your outcome, your predictor, your dataset, and a
#              name for your model
age_model <- glm(smoke ~ age4, data = youth, family = binomial,
                 na.action = na.exclude)
summary(age_model)

# The odds ratios: exp() turns each slope into an odds ratio.
# CHANGE THIS: your model's name
exp(coef(age_model))


## ---- multiple ----
# 2. MULTIPLE LOGISTIC REGRESSION: list the predictors after the
#    ~, joined with + signs, as in Chapter 5.
# CHANGE THIS: your outcome, your predictors, and your dataset
youth_model <- glm(smoke ~ ride.alc.driver + age4, data = youth,
                   family = binomial, na.action = na.exclude)
summary(youth_model)


## ---- odds-ratios ----
# Odds ratios with their 95% confidence intervals, side by side.
#    confint.default() gives the confidence intervals for the
#      slopes; exp() turns everything into odds ratios.
#    cbind() puts the columns side by side; OR = names the first.
#    round(..., 4) rounds to 4 decimal places.
# CHANGE THIS: your model's name, in both places
round(exp(cbind(OR = coef(youth_model),
                confint.default(youth_model))), 4)


## ---- vif ----
# VIF, as in Chapter 5.
# CHANGE THIS: your model's name
vif(youth_model)


## ---- predict ----
# 3. PREDICTED PROBABILITIES for specific profiles.
#    data.frame() builds a small table of profiles: one column per
#      predictor, spelled exactly as in the model, one row per
#      profile. Here: two 16-year-olds, one who did not ride with
#      a drinking driver (0) and one who did (1).
# CHANGE THIS: your predictors and the values for each profile
profiles <- data.frame(ride.alc.driver = c(0, 1),
                       age4 = c(16, 16))

#    type = "response" gives probabilities (0 to 1) instead of
#    log-odds. Leave it as is.
# CHANGE THIS: your model's name
predict(youth_model, newdata = profiles, type = "response")


## ---- deviance-r2 ----
# 4. DEVIANCE R-SQUARED: how much the model reduced the deviance,
#    compared with a model with no predictors.
#    $deviance is the model's deviance; $null.deviance is the
#      deviance with no predictors.
#    $df.residual and $df.null are their degrees of freedom,
#      which the adjusted version uses.
# CHANGE THIS: your model's name (in every place on both lines)
1 - youth_model$deviance / youth_model$null.deviance

1 - (youth_model$deviance / youth_model$df.residual) /
  (youth_model$null.deviance / youth_model$df.null)


## ---- hosmer-lemeshow ----
# 5. HOSMER-LEMESHOW TEST, from the DescTools package.
#    DescTools:: tells R which package the function comes from,
#      so you do not need a library() line for it.
#    fit = the predicted probabilities, and obs = the actual 0/1
#      outcomes, for the people the model used. The model stores
#      both: $fitted.values and $y.
#    $C keeps the standard version of the test (the function also
#      calculates a second version, $H).
# CHANGE THIS: your model's name (in both places), and a name for
#              the result
hl <- DescTools::HosmerLemeshowTest(fit = youth_model$fitted.values,
                                    obs = youth_model$y)$C
hl


## ---- hosmer-lemeshow-groups ----
# The share of 1s in each group: what actually happened, then what
# the model predicted.
#    prop.table(..., margin = 1) turns each row into proportions,
#      as in Chapter 2; [, 2] keeps the column for the 1s.
# CHANGE THIS: your result's name, in both lines
round(prop.table(hl$observed, margin = 1)[, 2], 2)
round(prop.table(hl$expected, margin = 1)[, 2], 2)


## ---- confusion ----
# 6. CONFUSION MATRIX.
#    fitted() gives each person's predicted probability; store it
#      as a new column.
#    ifelse(... > 0.5, 1, 0) predicts 1 when the probability is
#      over 50% (the threshold), and 0 otherwise.
# CHANGE THIS: your dataset, your model, and (if you want a
#              different threshold) the 0.5
youth$prob <- fitted(youth_model)
youth$predicted <- ifelse(youth$prob > 0.5, 1, 0)

# Predictions in the rows, what actually happened in the columns.
# CHANGE THIS: your dataset and your outcome
confusion <- table(Predicted = youth$predicted,
                   Actual = youth$smoke)
confusion

# Sensitivity and specificity, as in Chapter 8. You do not need
# to change these lines if your outcome is coded 0 and 1.
confusion["1", "1"] / sum(confusion[, "1"])
confusion["0", "0"] / sum(confusion[, "0"])


## ---- roc ----
# 7. ROC CURVE AND AUC.
#    roc(actual, predicted) compares what happened with the
#      predicted probabilities, at every possible threshold.
# CHANGE THIS: your outcome and your predicted probabilities
youth_roc <- roc(youth$smoke, youth$prob)
auc(youth_roc)


## ---- roc-plot ----
# The ROC curve.
#    ggroc() draws it as a ggplot, so the usual + layers work.
#    legacy.axes = TRUE puts the false positive rate (1 minus
#      specificity) along the bottom, as in the textbook. Leave
#      it as is.
#    geom_abline() adds the diagonal "coin flip" line: intercept
#      = 0 and slope = 1 start it at the corner and run it at 45
#      degrees. linetype = "dashed" makes it dashed.
# CHANGE THIS: your ROC object's name and your title
ggroc(youth_roc, legacy.axes = TRUE, color = "#0072B2",
      linewidth = 1) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  labs(title = "ROC Curve: Predicting Ever Smoking",
       x = "False positive rate (1 - specificity)",
       y = "Sensitivity") +
  theme_minimal(base_size = 14)
