# ==================================================================
# R Companion, Chapter 3: t-Tests, Effect Sizes, and Power
# Statistical Methods in Research
#
# What this script makes:
#   1. A single sample t-test
#   2. A matched pair t-test
#   3. Group means and standard deviations
#   4. A Welch's independent sample t-test
#   5. Cohen's d
#   6. A t-test for one group only
#   7. The sample size needed for 80% power
#
# Before you run it:
#   - Put this script, census_at_school.csv, and
#     weight_loss_incentive.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - Install the effectsize package once, if you have not already:
#     install.packages("effectsize")
# ==================================================================


## ---- load-packages ----
# Load effectsize, the package that calculates Cohen's d. The
# t-tests themselves are built into R and need no package.
library(effectsize)


## ---- read-students ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
students <- read.csv("census_at_school.csv")


## ---- one-sample ----
# 1. SINGLE SAMPLE t-test: compares the mean of one variable to a
#    fixed number (a benchmark).
#    The first argument is the variable to test.
#    mu = 8 is the benchmark: here, 8 hours of sleep. (mu is the
#      Greek letter for a population mean.)
# CHANGE THIS: your variable after the $, and your benchmark
#              after mu =
t.test(students$Sleep1, mu = 8)


## ---- paired ----
# 2. MATCHED PAIR t-test: compares two measurements taken on the
#    same people. Here each student reported sleep on a
#    non-school night (Sleep2) and on a school night (Sleep1).
#    paired = TRUE tells R the two columns belong to the same
#      people, row by row.
#    R subtracts the second variable from the first, so the
#      difference here is Sleep2 minus Sleep1.
# CHANGE THIS: your two variables, in the order you want them
#              subtracted
t.test(students$Sleep2, students$Sleep1, paired = TRUE)


## ---- read-weight ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
weight <- read.csv("weight_loss_incentive.csv")


## ---- group-stats ----
# 3. GROUP MEANS AND STANDARD DEVIATIONS, for reporting.
#    tapply(variable, groups, function) splits the variable by
#      group and applies the function (mean or sd) to each part.
#    na.rm = TRUE skips the blank cells, as in Chapter 1.
# CHANGE THIS: your numerical variable and your group variable
#              in both lines
tapply(weight$WeightLoss, weight$Group, mean, na.rm = TRUE)
tapply(weight$WeightLoss, weight$Group, sd, na.rm = TRUE)


## ---- welch ----
# 4. WELCH'S INDEPENDENT SAMPLE t-test: compares the means of two
#    separate groups. R uses Welch's version unless you tell it
#    otherwise.
#    WeightLoss ~ Group reads "WeightLoss, split by Group". The ~
#      sign (called a tilde) is on the top-left key of most
#      keyboards.
#    data = weight names the dataset, so you do not need $.
# CHANGE THIS: your numerical variable before the ~, your group
#              variable after it, and your dataset after data =
t.test(WeightLoss ~ Group, data = weight)


## ---- cohens-d ----
# 5. COHEN'S d for the difference between the two groups. It is
#    written the same way as the t-test.
# CHANGE THIS: the same variables and dataset as your t-test
cohens_d(WeightLoss ~ Group, data = weight)


## ---- subset ----
# 6. A t-test FOR ONE GROUP ONLY.
#    subset() keeps only the rows that match a condition.
#    Group == "Incentive" means "Group is exactly Incentive". Use
#      two equals signs, and spell the group exactly as it appears
#      in the data, inside quotes.
#    The result is stored as a new, smaller dataset.
# CHANGE THIS: your dataset, your group variable, and the group
#              you want to keep
incentive <- subset(weight, Group == "Incentive")
nrow(incentive)

# Then test that group's Month7Loss against 0 (no change).
# CHANGE THIS: your variable after the $, and your benchmark
t.test(incentive$Month7Loss, mu = 0)


## ---- power ----
# 7. SAMPLE SIZE FOR 80% POWER (independent sample t-test).
#    delta = 0.5 is the effect size you expect, as a Cohen's d.
#    sd = 1 lets delta be read as a Cohen's d. Leave it at 1.
#    sig.level = 0.05 is the significance level (alpha).
#    power = 0.80 is the power you want.
#    R fills in the one value you leave out: here, n.
# CHANGE THIS: the effect size you expect, after delta =
power.t.test(delta = 0.5, sd = 1, sig.level = 0.05, power = 0.80)
