# ==============================================================================
# Chapter 9: Logistic Regression
# Value Generation Script
# ==============================================================================

# ------------------------------------------------------------------------------
# 9.1 & 9.2 The Core Concept & The Logit Link
# Dataset: icu_data.csv
# ------------------------------------------------------------------------------
icu <- read.csv("icu_data.csv")

# Baseline model: Predicting survival based on a continuous metric (Pulse)
# family = binomial automatically applies the logit link function
baseline_model <- glm(Survive ~ Pulse, data = icu, family = binomial)

print("--- 9.2 Baseline Model (Log-Odds) ---")
summary(baseline_model)

# ------------------------------------------------------------------------------
# 9.3 Interpreting the Output: Slopes and Odds Ratios
# Dataset: icu_data.csv
# ------------------------------------------------------------------------------
# Multivariate model: Predicting survival controlling for Age and Admission Type
full_model <- glm(Survive ~ Emergency + Age, data = icu, family = binomial)

print("--- 9.3 Multivariate Model Slopes (Log-Odds) ---")
summary(full_model)

print("--- 9.3 Odds Ratios ---")
# Exponentiate the raw slope coefficients to get the interpretable Odds Ratios
odds_ratios <- exp(coef(full_model))
print(odds_ratios)

# ------------------------------------------------------------------------------
# 9.4 From Odds to Probabilities
# Dataset: icu_data.csv
# ------------------------------------------------------------------------------
# Generate predicted probabilities for a 65-year-old patient:
# 1. Admitted as an elective procedure (Emergency = 0)
# 2. Admitted as an emergency procedure (Emergency = 1)
patient_scenarios <- data.frame(
  Age = c(65, 65),
  Emergency = c(0, 1) 
)

# type = "response" forces R to reverse-transform log-odds into a final probability
predicted_probs <- predict(full_model, newdata = patient_scenarios, type = "response")

print("--- 9.4 Predicted Probabilities ---")
print("Probability of survival for a 65-year-old (Elective vs. Emergency):")
# Outputting as a clean data frame for easy reading
print(data.frame(patient_scenarios, Survival_Probability = round(predicted_probs, 4)))

# ------------------------------------------------------------------------------
# 9.5 Model Diagnostics and Accuracy
# Dataset: icu_data.csv
# ------------------------------------------------------------------------------
# Generate predicted survival probabilities for every patient in the dataset
icu$Predicted_Prob <- predict(full_model, type = "response")

# Apply the classification threshold at 50% (0.50)
icu$Predicted_Survive <- ifelse(icu$Predicted_Prob > 0.50, 1, 0)

# Build the Confusion Matrix
# Rows = Predicted Status, Columns = Actual Status
conf_matrix_logistic <- table(Predicted = icu$Predicted_Survive, Actual = icu$Survive)

print("--- 9.5 Logistic Model Confusion Matrix ---")
print(conf_matrix_logistic)

# Calculate Sensitivity and Specificity
# Context note: In this dataset, the positive event (1) is Survival.
# Sensitivity = True Positive Rate (The model correctly predicted the patient would survive)
# Specificity = True Negative Rate (The model correctly predicted the patient would die)

# Extract values from the table (handling potential row/col naming safely)
tp_log <- conf_matrix_logistic["1", "1"]
fn_log <- conf_matrix_logistic["0", "1"]
tn_log <- conf_matrix_logistic["0", "0"]
fp_log <- conf_matrix_logistic["1", "0"]

sensitivity_log <- tp_log / (tp_log + fn_log)
specificity_log <- tn_log / (tn_log + fp_log)

print(paste("Sensitivity (Correctly predicted survival):", round(sensitivity_log, 3)))
print(paste("Specificity (Correctly predicted death):", round(specificity_log, 3)))