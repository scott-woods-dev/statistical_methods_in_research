# ==================================================================
# R Companion, Chapter 1: Graphs and Summaries
# Statistical Methods in Research
#
# What this script makes:
#   1. A bar chart
#   2. A histogram
#   3. A mean and a median
#   4. Side-by-side box plots
#   5. A scatterplot
#   6. A scatterplot with groups
#
# Before you run it:
#   - Put this script and census_at_school.csv in the same folder.
#   - In RStudio, choose
#     Session > Set Working Directory > To Source File Location.
#
# Lines that start with # are comments. R skips them; they are
# notes for you.
#
# Colors: the graphs use colors from the Okabe-Ito palette, the
# same one the textbook uses, chosen so that people with color
# blindness can tell them apart. Each color is written as a code:
#   "#0072B2" blue        "#D55E00" vermillion (red-orange)
#   "#009E73" green       "#CC79A7" pink
# You can also type a plain color name instead, such as "darkgreen".
# ==================================================================


## ---- load-packages ----
# Load ggplot2, the package that draws our graphs. You install it
# once (see Getting Set Up), but you load it every time you open
# RStudio.
library(ggplot2)


## ---- read-data ----
# Read the CSV file and store it under the name "students".
# CHANGE THIS: the file name of your dataset, inside the quotes.
students <- read.csv("census_at_school.csv")

# List the variable names, so you can check that the data loaded
# and see exactly how each name is spelled.
names(students)


## ---- dollar-sign ----
# The $ sign picks one variable (column) out of a dataset:
# students$TravelTime means "the TravelTime column of students".
# head() shows only the first six values, so the screen does not
# fill up with all 500.
head(students$TravelTime)


## ---- bar-chart ----
# 1. BAR CHART: one bar per category. The height of each bar is
#    the number of students in that category.
#    ggplot(students, ...) names the dataset to use.
#    aes() says which variable goes where; x = puts it on the
#      horizontal axis. (aes is short for "aesthetics".)
#    geom_bar() draws the bars. fill = sets the color inside the
#      bars, and color = sets the color of their outlines.
#    labs() writes the title and the axis labels. Anything inside
#      quotes is printed exactly as you type it.
#    theme_minimal() gives the graph a plain background.
#      base_size = 14 sets the text size, in points. You can leave
#      it as is.
# CHANGE THIS: your categorical variable after x =
ggplot(students, aes(x = GetToSchool)) +
  geom_bar(fill = "#0072B2", color = "black") +
  # CHANGE THIS: your title and x-axis label, inside the quotes
  labs(title = "How Students Get to School",
       x = "Way of getting to school",
       y = "Number of students") +
  theme_minimal(base_size = 14)


## ---- histogram ----
# 2. HISTOGRAM: shows the shape of one numerical variable.
#    binwidth = 1 makes each bar 1 unit wide, in the units of your
#      variable (here, 1 hour of sleep).
#    fill = and color = work the same way as in the bar chart.
# CHANGE THIS: your numerical variable after x =
ggplot(students, aes(x = Sleep1)) +
  # CHANGE THIS: a binwidth that suits your variable
  geom_histogram(binwidth = 1, fill = "#0072B2", color = "black") +
  # CHANGE THIS: your title and x-axis label, inside the quotes
  labs(title = "Hours of Sleep on a School Night",
       x = "Hours of sleep",
       y = "Number of students") +
  theme_minimal(base_size = 14)


## ---- mean-median ----
# 3. MEAN AND MEDIAN of one numerical variable. Each one takes a
#    single variable, picked out with the $ sign.
# CHANGE THIS: your variable after the $, in both lines
mean(students$TravelTime)
median(students$TravelTime)


## ---- mean-missing ----
# Armspan has some empty cells, so mean() gives NA.
mean(students$Armspan)


## ---- mean-missing-fix ----
# na.rm = TRUE removes the empty cells before R calculates.
# (na.rm is short for "NA remove"; TRUE means yes.)
mean(students$Armspan, na.rm = TRUE)
median(students$Armspan, na.rm = TRUE)


## ---- box-plot ----
# 4. SIDE-BY-SIDE BOX PLOTS: one box per group.
#    Year is stored as a number (2023 or 2024). factor() tells R
#    to treat it as group names, which gives one box per year.
#    y = puts the numerical variable on the vertical axis.
#    fill = sets the color inside the boxes.
# CHANGE THIS: your group variable inside factor(), and your
#              numerical variable after y =
ggplot(students, aes(x = factor(Year), y = Sleep1)) +
  geom_boxplot(fill = "#0072B2") +
  # CHANGE THIS: your title and axis labels, inside the quotes
  labs(title = "School-Night Sleep by Survey Year",
       x = "Survey year",
       y = "Hours of sleep") +
  theme_minimal(base_size = 14)


## ---- scatterplot ----
# 5. SCATTERPLOT: one dot per student, showing how two numerical
#    variables move together. The variable after x = goes on the
#    horizontal axis; the variable after y = goes on the vertical
#    axis.
#    geom_point() draws the dots. color = sets their color.
# CHANGE THIS: your x variable and your y variable
ggplot(students, aes(x = Height, y = Armspan)) +
  geom_point(color = "#0072B2") +
  # CHANGE THIS: your title and axis labels, inside the quotes
  labs(title = "Height and Armspan",
       x = "Height (cm)",
       y = "Armspan (cm)") +
  theme_minimal(base_size = 14)


## ---- scatterplot-groups ----
# 6. SCATTERPLOT WITH GROUPS: the same graph, with each group in
#    its own color AND its own shape. The shapes let a reader tell
#    the groups apart even in black and white.
#    color = and shape = inside aes() name the group variable.
#    scale_color_manual(values = ...) picks the colors, one per
#      group, in alphabetical order of the group names (here,
#      Female gets blue and Male gets vermillion). c() combines
#      the colors into one list. With more groups, add more colors
#      from the list at the top of this script.
# CHANGE THIS: your group variable, after color = and shape =
ggplot(students, aes(x = Height, y = Armspan,
                     color = Gender, shape = Gender)) +
  geom_point() +
  scale_color_manual(values = c("#0072B2", "#D55E00")) +
  # CHANGE THIS: your labels; give color = and shape = the same
  #              legend title
  labs(title = "Height and Armspan by Gender",
       x = "Height (cm)",
       y = "Armspan (cm)",
       color = "Gender",
       shape = "Gender") +
  theme_minimal(base_size = 14)


## ---- save-graph ----
# SAVING A GRAPH: ggsave() saves the most recent graph as a picture
# in your working directory.
#   width = 7 and height = 4.5 set the size of the picture, in
#   inches (7 inches is about the width of a printed page). Change
#   them only if you want a bigger or smaller picture.
# CHANGE THIS: a file name for your graph, ending in .png
ggsave("my_graph.png", width = 7, height = 4.5)
