# ==================================================================
# R Companion, Chapter 8: Categorical Data Analysis
# Statistical Methods in Research
#
# What this script makes:
#   1. A chi-square goodness-of-fit test, with expected counts and
#      standardized residuals
#   2. A chi-square test for independence (the same code runs a
#      test for homogeneity), with Cramer's V
#   3. McNemar's test for paired yes/no answers
#   4. Relative risk and the odds ratio from a 2 x 2 table
#   5. Sensitivity and specificity of a yes/no rule
#
# Before you run it:
#   - Put this script, census_at_school.csv, acs_2023.csv, and
#     smoking_bmi_bp.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - Install effectsize once, if you have not already (see
#     Getting Set Up).
# ==================================================================


## ---- load-packages ----
# effectsize calculates Cramer's V. Everything else in this
# chapter is built into R.
library(effectsize)


## ---- read-students ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
students <- read.csv("census_at_school.csv")


## ---- gof ----
# 1. GOODNESS-OF-FIT: does one categorical variable match a set of
#    expected proportions?
#    table() counts each category, in alphabetical order.
# CHANGE THIS: your categorical variable
season_counts <- table(students$Season)
season_counts

#    p = c(...) lists the expected proportion for each category,
#      as decimals, in the SAME order as the table above. They
#      must add up to 1. Here every season is expected to be
#      equally popular (0.25 each).
# CHANGE THIS: the table name and your expected proportions
season_test <- chisq.test(season_counts,
                          p = c(0.25, 0.25, 0.25, 0.25))
season_test


## ---- gof-post-hoc ----
# The expected counts (check that each one is at least 5) and the
# standardized residuals, rounded to 2 decimal places.
# CHANGE THIS: your test's name, in both lines
season_test$expected
round(season_test$residuals, 2)


## ---- independence ----
# 2. test FOR INDEPENDENCE: are two categorical variables related?
#    table(rows, columns) builds the cross-tabulation.
#    prop.table(..., margin = 1) turns each row into proportions,
#      as in Chapter 2, so the rows can be compared.
# CHANGE THIS: your two categorical variables
power_table <- table(students$Gender, students$Superpower)
power_table
round(prop.table(power_table, margin = 1), 2)

# The test. With a cross-tabulation, chisq.test() needs nothing
# else: it calculates the expected counts itself.
# CHANGE THIS: your table's name, and a name for the test
power_test <- chisq.test(power_table)
power_test


## ---- independence-post-hoc ----
# Expected counts and standardized residuals for every cell.
# round(..., 1) rounds to 1 decimal place.
# CHANGE THIS: your test's name, in both lines
round(power_test$expected, 1)
round(power_test$residuals, 2)


## ---- cramers-v ----
# CRAMER'S V, from the effectsize package.
#    adjust = FALSE gives the standard Cramer's V that the textbook
#    uses. (Leaving it out gives a slightly smaller,
#    bias-adjusted version.)
# CHANGE THIS: your table's name
cramers_v(power_table, adjust = FALSE)


## ---- mcnemar ----
# 3. McNEMAR'S test: the same people answer two yes/no questions.
#    Here the two "questions" are whether each student sleeps at
#    least 8 hours on a school night and on a non-school night.
#    ifelse(test, "Yes", "No") gives "Yes" for each row where the
#      test is true, and "No" where it is false.
# CHANGE THIS: your variables, your cutoff, and new column names.
#              (If your data already hold two yes/no columns,
#              skip these two lines.)
students$Enough1 <- ifelse(students$Sleep1 >= 8, "Yes", "No")
students$Enough2 <- ifelse(students$Sleep2 >= 8, "Yes", "No")

#    Inside table(), Name = column gives each side a label.
# CHANGE THIS: your labels and your two yes/no columns
sleep_table <- table(SchoolNight = students$Enough1,
                     NonSchoolNight = students$Enough2)
sleep_table
mcnemar.test(sleep_table)


## ---- read-acs ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
acs <- read.csv("acs_2023.csv")


## ---- risk-table ----
# 4. RELATIVE RISK AND THE ODDS RATIO.
#    The groups you compare go in the rows; the outcome goes in
#    the columns. Both variables here are coded 0 and 1.
# CHANGE THIS: your group variable and your outcome variable
insurance_table <- table(Citizen = acs$USCitizen,
                         Insured = acs$HealthInsurance)
insurance_table

#    Each group's risk: the proportion in each row with each
#    outcome.
# CHANGE THIS: your table's name
risk <- prop.table(insurance_table, margin = 1)
risk


## ---- relative-risk ----
# RELATIVE RISK: one group's risk of the outcome divided by the
# baseline group's risk.
#    risk["0", "1"] means the row named 0 (noncitizens) and the
#      column named 1 (insured). The row comes first, then the
#      column, each in quotes.
# CHANGE THIS: the row of your group, the row of your baseline
#              group, and the column of your outcome
risk["0", "1"] / risk["1", "1"]


## ---- odds-ratio ----
# THE ODDS RATIO.
#    Each group's odds: its risk of the outcome divided by its
#      risk of not having it. risk[, "1"] (nothing before the
#      comma) means the whole column named 1, for every row.
# CHANGE THIS: the column of your outcome first, then the other
#              column
odds <- risk[, "1"] / risk[, "0"]
odds

#    The odds ratio: one group's odds divided by the baseline
#    group's odds.
# CHANGE THIS: your group first, then your baseline group
odds["0"] / odds["1"]


## ---- read-pressure ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
pressure <- read.csv("smoking_bmi_bp.csv")


## ---- rule ----
# 5. SENSITIVITY AND SPECIFICITY of a yes/no rule.
#    The rule: predict high blood pressure for everyone in the
#      Obese BMI group.
#    What actually happened: a systolic reading of 140 mmHg or
#      higher.
#    == means "is exactly equal to" (two equals signs).
# CHANGE THIS: your rule, your outcome, and new column names
pressure$Predicted <- ifelse(pressure$BMI == "Obese", "Yes", "No")
pressure$Actual <- ifelse(pressure$SystolicBP >= 140, "Yes", "No")

# The confusion matrix: predictions in the rows, what actually
# happened in the columns.
# CHANGE THIS: your dataset name, in both places
confusion <- table(Predicted = pressure$Predicted,
                   Actual = pressure$Actual)
confusion


## ---- sens-spec ----
# SENSITIVITY: of the people who actually had the outcome, the
# proportion the rule caught.
#    sum(confusion[, "Yes"]) adds up the whole "Yes" column.
# You do not need to change these lines if your labels are Yes
# and No.
confusion["Yes", "Yes"] / sum(confusion[, "Yes"])

# SPECIFICITY: of the people who did not have the outcome, the
# proportion the rule correctly left alone.
confusion["No", "No"] / sum(confusion[, "No"])
