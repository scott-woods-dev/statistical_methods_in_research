# ==================================================================
# R Companion, Chapter 2: Proportions and Reliability
# Statistical Methods in Research
#
# What this script makes:
#   1. A count and a proportion for one yes/no variable
#   2. Proportions for two groups, side by side
#   3. Cronbach's alpha for a set of survey items
#   4. A composite score that adds the items together
#
# Before you run it:
#   - Put this script, youth_risk_2007.csv, and
#     amas_math_anxiety.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - Install the psych package once, if you have not already:
#     install.packages("psych")
# ==================================================================


## ---- load-packages ----
# Load psych, the package that calculates Cronbach's alpha.
library(psych)


## ---- read-youth ----
# Read the youth survey and store it under the name "youth".
# CHANGE THIS: the file name of your dataset, inside the quotes.
youth <- read.csv("youth_risk_2007.csv")
names(youth)


## ---- count-one ----
# 1. COUNT AND PROPORTION FOR ONE VARIABLE.
#    table() counts how many rows have each value. Here 0 means
#    "no" and 1 means "yes, rode with a driver who had been
#    drinking".
# CHANGE THIS: your categorical variable after the $
ride_counts <- table(youth$ride.alc.driver)
ride_counts

# prop.table() turns the counts into proportions (each count
# divided by the total), so the proportions add up to 1.
# round(..., 3) rounds them to 3 decimal places.
round(prop.table(ride_counts), 3)


## ---- mean-of-01 ----
# Shortcut for a variable coded 0 and 1: its mean is the
# proportion of 1s.
mean(youth$ride.alc.driver)


## ---- count-two ----
# 2. PROPORTIONS FOR TWO GROUPS.
#    table(rows, columns) counts every combination of two
#    variables. The first variable becomes the rows and the second
#    becomes the columns. Here smoke is 0 = never tried smoking,
#    1 = has tried smoking.
# CHANGE THIS: your group variable first, then your outcome
ride_by_smoke <- table(youth$smoke, youth$ride.alc.driver)
ride_by_smoke

# margin = 1 divides each row by its own row total, so each row
# adds up to 1. That gives the proportion of "yes" answers within
# each group.
round(prop.table(ride_by_smoke, margin = 1), 3)


## ---- read-anxiety ----
# Read the math anxiety survey and store it under the name
# "anxiety".
# CHANGE THIS: the file name of your dataset, inside the quotes.
anxiety <- read.csv("amas_math_anxiety.csv")
names(anxiety)


## ---- choose-items ----
# 3. CRONBACH'S ALPHA.
#    First, pick out the survey items that belong to one scale.
#    Square brackets choose part of a dataset: [rows, columns].
#    Leaving the space before the comma empty means "all rows".
#    c() combines the column names into one list.
#    Here we use the five "learning anxiety" items.
# CHANGE THIS: the names of your items, each inside quotes
learning_items <- anxiety[, c("item_1", "item_3", "item_6",
                              "item_7", "item_9")]
head(learning_items)


## ---- alpha ----
# psych::alpha() means "the alpha() function from the psych
# package". Writing psych:: in front makes sure R uses the right
# alpha(), since another package (ggplot2) has a function with
# the same name.
psych::alpha(learning_items)


## ---- composite ----
# 4. COMPOSITE SCORE: add each person's answers across the items.
#    rowSums() adds across each row. The <- arrow stores the
#    result as a new column called learning_score in the dataset.
# CHANGE THIS: a name for your new score after the $, and the name
#              of your items inside rowSums()
anxiety$learning_score <- rowSums(learning_items)

# Check the new scores: the first six, then the mean.
head(anxiety$learning_score)
mean(anxiety$learning_score)
