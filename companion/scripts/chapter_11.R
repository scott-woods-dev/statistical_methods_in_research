# ==================================================================
# R Companion, Chapter 11: Factor Analysis
# Statistical Methods in Research
#
# What this script makes:
#   1. A correlation matrix for a set of survey items
#   2. A scree chart
#   3. An exploratory factor analysis (principal axis factoring
#      with varimax rotation), with communalities and uniquenesses
#   4. The same analysis with maximum likelihood, for comparison
#   5. Cronbach's alpha for the items in each factor
#
# Before you run it:
#   - Put this script and amas_math_anxiety.csv in the same
#     folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#   - Install ggplot2 and psych once, if you have not already (see
#     Getting Set Up).
# ==================================================================


## ---- load-packages ----
# ggplot2 draws the scree chart; psych runs the factor analysis
# and Cronbach's alpha.
library(ggplot2)
library(psych)


## ---- read-data ----
# CHANGE THIS: the file name of your dataset, inside the quotes.
amas <- read.csv("amas_math_anxiety.csv")

# Keep only the survey items, as in Chapter 2.
#    amas[, c(...)] keeps every row (nothing before the comma)
#    and only the columns named inside c().
# CHANGE THIS: your dataset and the names of your items
items <- amas[, c("item_1", "item_2", "item_3", "item_4",
                  "item_5", "item_6", "item_7", "item_8",
                  "item_9")]


## ---- correlations ----
# 1. CORRELATION MATRIX: the correlation between every pair of
#    items, rounded to 2 decimal places.
# You do not need to change this line.
round(cor(items), 2)


## ---- scree ----
# 2. SCREE CHART.
#    eigen(cor(items))$values gives the amount of variation each
#      potential factor explains (its eigenvalue), largest first.
#    1:9 means the whole numbers from 1 to 9, one per item.
# CHANGE THIS: the 9 in 1:9, to your number of items
eigenvalues <- eigen(cor(items))$values
scree <- data.frame(Factor = 1:9, Eigenvalue = eigenvalues)
round(scree, 2)

#    geom_line() joins the points; geom_point() marks them.
#    scale_x_continuous(breaks = 1:9) labels every factor number.
# CHANGE THIS: the 9 in 1:9 again, and your title
ggplot(scree, aes(x = Factor, y = Eigenvalue)) +
  geom_line(color = "#0072B2", linewidth = 1) +
  geom_point(color = "#0072B2", size = 3) +
  scale_x_continuous(breaks = 1:9) +
  labs(title = "Scree Chart for the Nine AMAS Items",
       x = "Factor number",
       y = "Variance explained (eigenvalue)") +
  theme_minimal(base_size = 14)


## ---- paf ----
# 3. FACTOR ANALYSIS with fa() from psych.
#    nfactors = 2 is the number of factors to extract (from the
#      scree chart).
#    fm = "pa" means principal axis factoring.
#    rotate = "varimax" means varimax rotation.
# CHANGE THIS: the number of factors, and a name for the result
paf <- fa(items, nfactors = 2, fm = "pa", rotate = "varimax")

# The rotated factor matrix.
#    cutoff = 0 prints every loading (by default, R hides small
#      ones).
#    sort = TRUE lists the items grouped by the factor they load
#      on most.
# CHANGE THIS: your result's name
print(paf$loadings, cutoff = 0, sort = TRUE)


## ---- communality ----
# Communalities (h2) and uniquenesses (u2), rounded to 3 places.
# CHANGE THIS: your result's name, in both lines
round(paf$communality, 3)
round(paf$uniquenesses, 3)


## ---- ml ----
# 4. MAXIMUM LIKELIHOOD: the same analysis, with fm = "ml".
# CHANGE THIS: the number of factors, and a name for the result
ml <- fa(items, nfactors = 2, fm = "ml", rotate = "varimax")
print(ml$loadings, cutoff = 0, sort = TRUE)


## ---- alpha ----
# 5. CRONBACH'S ALPHA for the items in each factor, as in
#    Chapter 2.
#    psych::alpha() makes sure R uses the alpha() from psych (see
#      Chapter 2).
#    $total$raw_alpha keeps just Cronbach's alpha from the results.
# CHANGE THIS: the items that loaded on each factor
psych::alpha(items[, c("item_1", "item_3", "item_6", "item_7",
                       "item_9")])$total$raw_alpha
psych::alpha(items[, c("item_2", "item_4", "item_5",
                       "item_8")])$total$raw_alpha
