# ==================================================================
# R Companion, Chapter 7: Two-Way ANOVA, ANCOVA, and Repeated
# Measures
# Statistical Methods in Research
#
# What this script makes:
#   1. A two-way ANOVA, with cell standard deviations and an
#      interaction plot
#   2. An ANCOVA, with its slopes check and adjusted means
#   3. A repeated measures ANOVA with one between-subjects factor
#
# Before you run it:
#   - Put this script, smoking_bmi_bp.csv, and
#     census_at_school.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - Install ggplot2, car, and emmeans once, if you have not
#     already (see Getting Set Up).
# ==================================================================


## ---- load-packages ----
# ggplot2 draws the interaction plot, car makes the ANOVA tables,
# and emmeans calculates adjusted means.
library(ggplot2)
library(car)
library(emmeans)

# This setting makes R calculate the main effects the way the
# textbook does (Type III sums of squares need it). Run it once,
# before fitting any model. You do not need to change it.
options(contrasts = c("contr.sum", "contr.poly"))


## ---- read-pressure ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
pressure <- read.csv("smoking_bmi_bp.csv")

# Put the BMI groups in order, as in Chapter 6.
pressure$BMI <- factor(pressure$BMI,
                       levels = c("Normal", "Overweight", "Obese"))


## ---- cell-stats ----
# 1. TWO-WAY ANOVA.
#    Cell means and standard deviations. Inside tapply(),
#    list(first, second) splits the data by BOTH factors at once,
#    giving one value per cell.
# CHANGE THIS: your numerical variable and your two factors
tapply(pressure$SystolicBP,
       list(pressure$BMI, pressure$Smoker), mean)
cell_sds <- tapply(pressure$SystolicBP,
                   list(pressure$BMI, pressure$Smoker), sd)
cell_sds

# The 2X rule, across all the cells.
max(cell_sds) / min(cell_sds)


## ---- interaction-plot ----
# INTERACTION PLOT: one line per Smoker group, joining the group
# means across the BMI categories.
#    color =, linetype =, and shape = all show the Smoker group,
#      so the lines can be told apart without color.
#    stat_summary(fun = mean, ...) plots the mean, drawn as a line
#      and as points.
# CHANGE THIS: your first factor after x =, your numerical
#              variable after y =, and your second factor in the
#              four places it appears
ggplot(pressure, aes(x = BMI, y = SystolicBP, color = Smoker,
                     linetype = Smoker, shape = Smoker,
                     group = Smoker)) +
  stat_summary(fun = mean, geom = "line", linewidth = 1) +
  stat_summary(fun = mean, geom = "point", size = 3) +
  scale_color_manual(values = c("#0072B2", "#D55E00")) +
  labs(title = "Mean Systolic Blood Pressure",
       x = "BMI category",
       y = "Mean systolic blood pressure (mmHg)",
       color = "Smoker", linetype = "Smoker", shape = "Smoker") +
  theme_minimal(base_size = 14)


## ---- two-way ----
# THE TWO-WAY ANOVA.
#    BMI * Smoker includes both factors and their interaction,
#      as in Chapter 5.
#    Anova(..., type = 3) from the car package prints the table
#      the textbook uses (Type III).
# CHANGE THIS: your numerical variable, your two factors, your
#              dataset, and a name for your model
pressure_model <- lm(SystolicBP ~ BMI * Smoker, data = pressure)
Anova(pressure_model, type = 3)


## ---- read-students ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
students <- read.csv("census_at_school.csv")


## ---- slopes-check ----
# 2. ANCOVA.
#    First, the assumption check: does the covariate (Height)
#    relate to the response (Foot) the same way in each group?
#    Height * Gender tests the covariate-by-group interaction.
# CHANGE THIS: your response, your covariate, your group
#              variable, and your dataset
slopes_check <- lm(Foot ~ Height * Gender, data = students)
Anova(slopes_check, type = 3)


## ---- ancova ----
# THE ANCOVA: the covariate and the group, joined with + (no
# interaction).
# CHANGE THIS: the same variables, joined with +
foot_model <- lm(Foot ~ Height + Gender, data = students)
Anova(foot_model, type = 3)


## ---- adjusted-means ----
# ADJUSTED MEANS: each group's mean foot length for students of
# the same (average) height. The name in quotes is your group
# variable.
# CHANGE THIS: your model name and your group variable
emmeans(foot_model, "Gender")

# For comparison, the raw (unadjusted) group means.
tapply(students$Foot, students$Gender, mean)


## ---- repeated ----
# 3. REPEATED MEASURES ANOVA, with the data in "wide" form: one
#    row per person, one column per time point.
#    cbind(Sleep1, Sleep2) joins the two measurements of the same
#      people, in time order. Gender is the between-subjects
#      factor.
# CHANGE THIS: your repeated measurements inside cbind(), your
#              between-subjects factor, and your dataset
sleep_model <- lm(cbind(Sleep1, Sleep2) ~ Gender, data = students)

#    nights names the measurements, in the same order as in
#      cbind(): a factor called Night with two levels.
# CHANGE THIS: a name for your time factor and a label for each
#              measurement, in order
nights <- data.frame(Night = factor(c("School", "Weekend")))

#    idata = nights and idesign = ~ Night tell Anova() which
#      columns are the repeated measurements.
#    multivariate = FALSE prints the standard ANOVA table.
# CHANGE THIS: your time factor's name after the ~
sleep_anova <- Anova(sleep_model, idata = nights,
                     idesign = ~ Night, type = 3)
summary(sleep_anova, multivariate = FALSE)
