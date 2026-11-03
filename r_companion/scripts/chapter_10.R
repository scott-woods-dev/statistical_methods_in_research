# ==================================================================
# R Companion, Chapter 10: Nonparametric Tests
# Statistical Methods in Research
#
# What this script makes:
#   1. The Wilcoxon signed-rank test (two paired measurements)
#   2. The Mann-Whitney U test (two independent groups)
#   3. The Kruskal-Wallis test (three or more groups)
#   4. Spearman's rho, with its 95% confidence interval
#   5. Fisher's exact test
#
# Before you run it:
#   - Put this script, weight_loss_incentive.csv, and
#     census_at_school.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - This chapter uses only functions built into R, so there are
#     no packages to load.
# ==================================================================


## ---- read-weight ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
weight <- read.csv("weight_loss_incentive.csv")


## ---- complete-pairs ----
# 1. WILCOXON SIGNED-RANK test.
#    Keep only the people with BOTH measurements, using subset()
#    from Chapter 3. !is.na() means "is not missing", and & means
#    "and".
# CHANGE THIS: your dataset and your two paired measurements
pairs <- subset(weight, !is.na(WeightLoss) & !is.na(Month7Loss))
nrow(pairs)


## ---- wilcoxon-medians ----
# The descriptive statistics: each measurement's median and the
# median of the differences (first minus second).
# CHANGE THIS: your two paired measurements
median(pairs$WeightLoss)
median(pairs$Month7Loss)
median(pairs$WeightLoss - pairs$Month7Loss)


## ---- wilcoxon ----
# The test.
#    paired = TRUE pairs the two measurements row by row.
#    conf.int = TRUE adds a 95% confidence interval.
#    exact = FALSE and correct = FALSE make R calculate the
#      p-value and interval the same way as the textbook's
#      software. Leave them as they are.
# CHANGE THIS: your two paired measurements, in the same order as
#              above
wilcox.test(pairs$WeightLoss, pairs$Month7Loss, paired = TRUE,
            conf.int = TRUE, exact = FALSE, correct = FALSE)


## ---- read-students ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
students <- read.csv("census_at_school.csv")


## ---- mann-whitney ----
# 2. MANN-WHITNEY U test.
#    Each group's median, with tapply() from Chapter 3.
# CHANGE THIS: your numerical variable and your group variable
tapply(students$TextsSent, students$Gender, median)

#    The test is written like t.test(): the numerical variable
#    before the ~, the group variable after it. The other
#    settings work as in the Wilcoxon test above.
# CHANGE THIS: your numerical variable, your group variable, and
#              your dataset
wilcox.test(TextsSent ~ Gender, data = students, conf.int = TRUE,
            exact = FALSE, correct = FALSE)


## ---- order-pressure ----
# 3. KRUSKAL-WALLIS test.
#    Put the groups in order, as in Chapter 6.
# CHANGE THIS: your group variable (in both places) and your
#              groups, in order
students$SchoolPressure <- factor(students$SchoolPressure,
  levels = c("None", "Very little", "Some", "A lot"))

#    Each group's size and median.
# CHANGE THIS: your numerical variable and your group variable
table(students$SchoolPressure)
tapply(students$HWHours, students$SchoolPressure, median)


## ---- kruskal ----
# The test, written like aov() in Chapter 6.
# CHANGE THIS: your numerical variable, your group variable, and
#              your dataset
kruskal.test(HWHours ~ SchoolPressure, data = students)


## ---- spearman ----
# 4. SPEARMAN'S RHO.
#    For an ordered categorical variable, first turn its groups
#    into ranks: as.integer() gives each group its place in the
#    order set above (None = 1, Very little = 2, Some = 3,
#    A lot = 4). Skip this line if both variables are numerical.
# CHANGE THIS: your ordered variable and a name for its ranks
students$PressureRank <- as.integer(students$SchoolPressure)

#    method = "spearman" makes cor.test() from Chapter 4 calculate
#      Spearman's rho instead of Pearson's r.
#    exact = FALSE is needed when values are tied, as they almost
#      always are. Leave it as is.
# CHANGE THIS: your two variables, and a name for the result
pressure_rho <- cor.test(students$HWHours, students$PressureRank,
                         method = "spearman", exact = FALSE)
pressure_rho


## ---- spearman-ci ----
# The 95% confidence interval for rho (R does not print one).
# Copy these lines as they are; change only the result's name and
# n, the number of people with both values (with no missing
# values, the number of rows in your dataset).
rho <- pressure_rho$estimate
n <- 500
tanh(atanh(rho) + c(-1.96, 1.96) / sqrt(n - 3))


## ---- fisher ----
# 5. FISHER'S EXACT test, for a cross-tabulation with expected
#    counts below 5 (see Chapter 8).
#    Row proportions first, as in Chapter 2, to see the pattern.
# CHANGE THIS: your two categorical variables
travel_table <- table(students$Gender, students$GetToSchool)
travel_table
round(prop.table(travel_table, margin = 1), 3)

# The test needs only the table.
# CHANGE THIS: your table's name
fisher.test(travel_table)
