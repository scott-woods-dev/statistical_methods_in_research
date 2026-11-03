# ==================================================================
# R Companion, Chapter 6: The One-Way ANOVA
# Statistical Methods in Research
#
# What this script makes:
#   1. Group means and standard deviations, with the 2X rule
#   2. A jitter plot with the group means
#   3. The global one-way ANOVA
#   4. A normal Q-Q plot of the residuals
#   5. Tukey's HSD post hoc test
#   6. Dunnett's test, comparing each group to a control
#   7. Cohen's d for one pair of groups
#
# Before you run it:
#   - Put this script and smoking_bmi_bp.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - Install ggplot2, emmeans, and effectsize once, if you have
#     not already (see Getting Set Up).
# ==================================================================


## ---- load-packages ----
# ggplot2 draws the graphs, emmeans runs Dunnett's test, and
# effectsize calculates Cohen's d.
library(ggplot2)
library(emmeans)
library(effectsize)


## ---- read-data ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
pressure <- read.csv("smoking_bmi_bp.csv")
names(pressure)


## ---- order-groups ----
# Put the groups in a sensible order. Without this, R uses
# alphabetical order (Normal, Obese, Overweight).
#    factor(..., levels = c(...)) lists the groups in the order
#    you want, spelled exactly as in the data.
# CHANGE THIS: your group variable (in both places) and your
#              groups, in order
pressure$BMI <- factor(pressure$BMI,
                       levels = c("Normal", "Overweight", "Obese"))


## ---- group-stats ----
# 1. GROUP MEANS AND STANDARD DEVIATIONS, with tapply() from
#    Chapter 3. The standard deviations are stored as group_sds
#    so the next line can use them.
# CHANGE THIS: your numerical variable and your group variable
tapply(pressure$SystolicBP, pressure$BMI, mean)
group_sds <- tapply(pressure$SystolicBP, pressure$BMI, sd)
group_sds

# THE 2X RULE: the largest standard deviation divided by the
# smallest. A result of 2 or less passes the check.
max(group_sds) / min(group_sds)


## ---- jitter ----
# 2. JITTER PLOT: one dot per person, nudged sideways so the dots
#    do not pile up.
#    geom_jitter(width = 0.2) spreads the dots 0.2 of a group's
#      width to each side. height = 0 keeps their values exact.
#    alpha = 0.5 makes the dots see-through, so overlaps show.
#    stat_summary(fun = mean, ...) adds each group's mean.
#      shape = 18 is a diamond; size = 5 makes it large.
# set.seed() fixes the random sideways nudges, so the plot looks
# the same every time you run it. Any whole number works.
set.seed(2026)

# CHANGE THIS: your group variable after x =, your numerical
#              variable after y =, and your labels
ggplot(pressure, aes(x = BMI, y = SystolicBP)) +
  geom_jitter(width = 0.2, height = 0, alpha = 0.5,
              color = "#0072B2") +
  stat_summary(fun = mean, geom = "point", shape = 18, size = 5,
               color = "black") +
  labs(title = "Systolic Blood Pressure by BMI Category",
       x = "BMI category",
       y = "Systolic blood pressure (mmHg)") +
  theme_minimal(base_size = 14)


## ---- anova ----
# 3. ONE-WAY ANOVA: aov() is written like lm(), with the
#    numerical variable before the ~ and the group variable after.
# CHANGE THIS: your numerical variable, your group variable, your
#              dataset, and a name for your model
bp_model <- aov(SystolicBP ~ BMI, data = pressure)
summary(bp_model)


## ---- qq ----
# 4. NORMAL Q-Q PLOT of the residuals.
#    Store the residuals as a new column, as in Chapter 4.
#    aes(sample = residual) tells ggplot which values to check.
#    stat_qq() draws the dots; stat_qq_line() draws the
#      reference line.
# CHANGE THIS: your dataset name and your model name
pressure$residual <- resid(bp_model)

ggplot(pressure, aes(sample = residual)) +
  stat_qq(color = "#0072B2") +
  stat_qq_line() +
  labs(title = "Normal Q-Q Plot of the Residuals",
       x = "Expected if normal (theoretical quantiles)",
       y = "Residuals (sample quantiles)") +
  theme_minimal(base_size = 14)


## ---- tukey ----
# 5. TUKEY'S HSD: compares every pair of groups.
# CHANGE THIS: your model name
TukeyHSD(bp_model)


## ---- dunnett ----
# 6. DUNNETT'S TEST: compares each group only to the control.
#    emmeans(model, "BMI") calculates each group's mean from the
#      model. The name in quotes is your group variable.
#    method = "trt.vs.ctrl" means "each treatment versus the
#      control".
#    ref = 1 makes the first group in your order (here, Normal)
#      the control.
# CHANGE THIS: your model name and your group variable; set the
#              order of your groups so the control comes first
group_means <- emmeans(bp_model, "BMI")
dunnett <- contrast(group_means, method = "trt.vs.ctrl", ref = 1)
dunnett
confint(dunnett)


## ---- cohens-d ----
# 7. COHEN'S d for one pair of groups, as in Chapter 3.
#    %in% c(...) keeps the rows whose group is one of the two
#      named, so the test sees only that pair.
# CHANGE THIS: your variables, your dataset, and the two groups
cohens_d(SystolicBP ~ BMI,
         data = subset(pressure, BMI %in% c("Normal", "Obese")))
