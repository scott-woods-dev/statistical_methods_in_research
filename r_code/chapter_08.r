# ==============================================================================
# Chapter 8: Analyzing Relationships in Categorical Data
# ==============================================================================

# Install required packages if you don't already have them in your library
# install.packages(c("DescTools", "epitools"))

library(ggplot2)
library(tidyr)
library(dplyr)
library(DescTools)
library(epitools)

# ------------------------------------------------------------------------------
# 8.1 Single Variable Patterns: The Chi-Square Goodness-of-Fit Test
# Dataset: fatal_police_shootings.csv
# ------------------------------------------------------------------------------
fps <- read.csv("fatal_police_shootings.csv")

# Clean the race variable by isolating only the known categories 
# (Filtering out 'O' or missing values for a cleaner baseline comparison)
fps_clean_race <- subset(fps, race %in% c("A", "B", "H", "N", "W"))
observed_race <- table(fps_clean_race$race)

# Define the exact 2020 U.S. Census baseline weights 
# (Ensure alphabetical order to match R's default table output: A, B, H, N, W)
census_weights <- c(0.059,  # Asian (5.9%)
                    0.121,  # Black (12.1%)
                    0.187,  # Hispanic (18.7%)
                    0.007,  # Native American (0.7%)
                    0.578)  # White (57.8%)

# Run the Goodness-of-Fit test
# The rescale.p = TRUE argument automatically re-weights these proportions 
# to sum to 1.0 since the Multiracial/Other category (4.8%) is excluded.
gof_test <- chisq.test(x = observed_race, p = census_weights, rescale.p = TRUE)

print("--- 8.1 Goodness of Fit (2020 Census Baselines) ---")
print(gof_test)
print(observed_race)
print(gof_test$expected)

# 1. Calculate the standardized residuals
# gof_test is the chisq.test object from your previous chunk
residuals <- gof_test$residuals
print("--- Standardized Residuals ---")
print(round(residuals, 2))

# 2. Prepare data for the grouped bar chart
# Create a data frame of observed vs expected counts
plot_data <- data.frame(
  Race = c("Asian", "Black", "Hispanic", "Native American", "White"),
  Observed = as.numeric(observed_race),
  Expected = as.numeric(gof_test$expected)
)

# Reshape the data from wide to long format for ggplot2
plot_data_long <- pivot_longer(plot_data, 
                               cols = c("Observed", "Expected"), 
                               names_to = "Type", 
                               values_to = "Count")

# 3. Build the grouped bar chart
ggplot(plot_data_long, aes(x = Race, y = Count, fill = Type)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), 
           color = "black", width = 0.7) +
  scale_fill_manual(values = c("Observed" = "#56B4E9", "Expected" = "#E69F00")) +
  labs(title = "Fatal Police Shootings: Observed vs. Expected Census Counts",
       x = "Racial Identity",
       y = "Number of Incidents",
       fill = "Count Type") +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.text.x = element_text(size = 11),
    legend.position = "top"
  )

# ------------------------------------------------------------------------------
# 8.2 Two Variable Relationships: The Chi-Square Test for Independence
# Dataset: fatal_police_shootings.csv
# ------------------------------------------------------------------------------
# Cross-tabulate fleeing behavior against body camera deployment
fps_clean_flee <- subset(fps, flee %in% c("Car", "Foot", "Not fleeing"))
ind_table <- table(fps_clean_flee$flee, fps_clean_flee$body_camera)

ind_test <- chisq.test(ind_table)
print("--- 8.2 Test for Independence ---")
print(ind_test)


# ------------------------------------------------------------------------------
# 8.3 Comparing Populations: The Chi-Square Test for Homogeneity
# Dataset: fatal_police_shootings.csv
# ------------------------------------------------------------------------------
# Cross-tabulate mental illness signs (populations) against threat level
homog_table <- table(fps$signs_of_mental_illness, fps$threat_level)

homog_test <- chisq.test(homog_table)
print("--- 8.3 Test for Homogeneity ---")
print(homog_test)
# Proportions across populations to illustrate the concept in text:
# prop.table(homog_table, margin = 1) 


# ------------------------------------------------------------------------------
# 8.4 Graph: 100% Stacked Bar Chart for Independence
# ------------------------------------------------------------------------------
# Filter out any missing/unwanted categories for a clean visual
fps_clean_flee <- fps %>% 
  filter(flee %in% c("Car", "Foot", "Not fleeing"),
         !is.na(signs_of_mental_illness))

# Build the 100% stacked bar chart
ggplot(fps_clean_flee, aes(x = as.factor(signs_of_mental_illness), fill = flee)) +
  geom_bar(position = "fill", color = "black", width = 0.6) +
  scale_y_continuous(labels = scales::percent_format()) +
  scale_x_discrete(labels = c("0" = "No Documented Illness", "1" = "Documented Illness")) +
  scale_fill_brewer(palette = "Blues") +
  labs(title = "Fleeing Behavior vs. Documented Mental Illness",
       x = "Mental Illness Status",
       y = "Proportion of Encounters",
       fill = "Fleeing Behavior") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 14))

# ------------------------------------------------------------------------------
# 8.5 Analysis: Chi-Square Test & Standardized Residuals
# ------------------------------------------------------------------------------
# Create the cross-tabulation table
ind_table_mi <- table(fps_clean_flee$signs_of_mental_illness, fps_clean_flee$flee)

# Run the Chi-Square Test for Independence
ind_test_mi <- chisq.test(ind_table_mi)

print("--- Test for Independence ---")
print(ind_test_mi)

print("--- Standardized Residuals ---")
print(round(ind_test_mi$residuals, 2))

# ------------------------------------------------------------------------------
# 8.4 Dependent Categorical Data: McNemar's Test
# Dataset: speed_dating.csv
# ------------------------------------------------------------------------------
sd <- read.csv("speed_dating.csv")

# 1. Prepare data for the interaction outcomes plot
# Create a new column classifying the outcome of each pair
sd <- sd %>%
  mutate(Interaction_Outcome = case_when(
    DecisionM == 0 & DecisionF == 0 ~ "Both Said No",
    DecisionM == 1 & DecisionF == 1 ~ "Both Said Yes",
    DecisionM == 1 & DecisionF == 0 ~ "Only Male Said Yes",
    DecisionM == 0 & DecisionF == 1 ~ "Only Female Said Yes"
  ))

# Order the factor levels for a logical visual flow
sd$Interaction_Outcome <- factor(sd$Interaction_Outcome, 
                                 levels = c("Both Said No", "Only Male Said Yes", 
                                            "Only Female Said Yes", "Both Said Yes"))

# 2. Build the bar chart
ggplot(sd, aes(x = Interaction_Outcome)) +
  geom_bar(fill = "#56B4E9", color = "black", width = 0.6) +
  geom_text(stat='count', aes(label=..count..), vjust=-0.5, size=4) +
  labs(title = "Speed Dating: Outcomes of Paired Interactions",
       x = "Decision Outcome",
       y = "Number of Interactions") +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.text.x = element_text(size = 11)
  )

# 3. Run McNemar's Test
mcnemar_table <- table(Male_Decision = sd$DecisionM, Female_Decision = sd$DecisionF)
mcnemar_test <- mcnemar.test(mcnemar_table)

print("--- McNemar's Test Results ---")
print(mcnemar_test)
# ------------------------------------------------------------------------------
# 8.5 Quantifying the Relationship: Association Metrics
# Dataset: fatal_police_shootings.csv
# ------------------------------------------------------------------------------
# We use Cramer's V for a table larger than 2x2 (armed vs threat_level)
assoc_table <- table(fps$armed, fps$threat_level)

cramers_v <- CramerV(assoc_table)
print("--- 8.5 Cramer's V ---")
print(paste("Cramer's V:", round(cramers_v, 3)))


# ------------------------------------------------------------------------------
# 8.6 Quantifying Risk: Relative Risk and Odds Ratios
# Dataset: icu_data.csv
# ------------------------------------------------------------------------------
icu <- read.csv("icu_data.csv")

# For risk and odds ratios, the orientation of the 2x2 table matters.
# Rows = Predictor (Infection: 0, 1), Columns = Outcome (Survive: 0, 1)
# Note: epitools defaults to comparing row 2 vs row 1, and col 2 vs col 1.
risk_table <- table(Infection = icu$Infection, Survive = icu$Survive)

# Calculate Relative Risk
rr_result <- riskratio(risk_table)

# Calculate Odds Ratio
or_result <- oddsratio(risk_table)

print("--- 8.6 Relative Risk and Odds Ratios ---")
print("Relative Risk:")
print(rr_result$measure)
print("Odds Ratio:")
print(or_result$measure)


# ------------------------------------------------------------------------------
# 8.7 Evaluating a Classification: Sensitivity and Specificity
# Dataset: icu_data.csv
# ------------------------------------------------------------------------------
# Create a hypothetical triage rule: If pulse > 100, predict an emergency admission
icu$Predicted_Emergency <- ifelse(icu$Pulse > 100, 1, 0)

# Build the Confusion Matrix
# Rows = Predicted Status, Columns = Actual Status (Emergency: 1 = yes, 0 = no)
conf_matrix <- table(Predicted = icu$Predicted_Emergency, Actual = icu$Emergency)

# Calculate Sensitivity (True Positive Rate) and Specificity (True Negative Rate)
# True Positives = Predicted 1, Actual 1
# False Negatives = Predicted 0, Actual 1
# True Negatives = Predicted 0, Actual 0
# False Positives = Predicted 1, Actual 0

tp <- conf_matrix["1", "1"]
fn <- conf_matrix["0", "1"]
tn <- conf_matrix["0", "0"]
fp <- conf_matrix["1", "0"]

sensitivity <- tp / (tp + fn)
specificity <- tn / (tn + fp)

print("--- 8.7 Sensitivity and Specificity ---")
print("Confusion Matrix:")
print(conf_matrix)
print(paste("Sensitivity:", round(sensitivity, 3)))
print(paste("Specificity:", round(specificity, 3)))


# NEW Test for Homogeneity

# 1. Load the data
icu <- read.csv("icu_data.csv")

# 2. Prep the data: Convert numeric codes to descriptive labels
icu_clean <- icu %>%
  filter(!is.na(Emergency) & !is.na(AgeGroup)) %>%
  mutate(
    Admission_Type = factor(Emergency, levels = c(0, 1), 
                            labels = c("Elective", "Emergency")),
    Age_Category = factor(AgeGroup, levels = c(1, 2, 3), 
                          labels = c("Under 50", "50 to 69", "70 or older"))
  )

# 3. Create the cross-tabulation table
# Rows = Populations (Admission Type), Columns = Categorical Profile (Age Category)
homog_table <- table(icu_clean$Admission_Type, icu_clean$Age_Category)

print("--- Cross-Tabulation ---")
print(homog_table)

# 4. Run the Chi-Square Test for Homogeneity
homog_test <- chisq.test(homog_table)

print("--- Chi-Square Test for Homogeneity ---")
print(homog_test)

print("--- Standardized Residuals ---")
print(round(homog_test$residuals, 2))

# 5. Build the Grouped Bar Chart (Proportions within Populations)
# Calculate proportions within each Admission Type to allow fair visual comparison
plot_data <- icu_clean %>%
  group_by(Admission_Type, Age_Category) %>%
  summarise(Count = n(), .groups = 'drop') %>%
  group_by(Admission_Type) %>%
  mutate(Proportion = Count / sum(Count))

# Generate the plot
ggplot(plot_data, aes(x = Admission_Type, y = Proportion, fill = Age_Category)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), color = "black", width = 0.7) +
  scale_y_continuous(labels = scales::percent_format()) +
  scale_fill_brewer(palette = "YlGnBu") +
  labs(title = "Age Profile by ICU Admission Type",
       x = "Admission Type",
       y = "Within-Group Proportion",
       fill = "Age Category") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 14))