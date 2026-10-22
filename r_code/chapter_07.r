# ==============================================================================
# Chapter 7 Reference Script: Advanced Experimental Designs
# Textbook: Statistical Methods in Research
# Dataset: maid_mindset.csv
# ==============================================================================

# Load required libraries
library(tidyverse)
library(car)       # For Type III Anova, Levene's test, and Repeated Measures
library(emmeans)   # For Estimated Marginal Means (Adjusted Means)

# ------------------------------------------------------------------------------
# 0. Data Ingestion & Setup
# ------------------------------------------------------------------------------
# Set global contrast options to match SPSS/Minitab Type III SS calculation
options(contrasts = c("contr.sum", "contr.poly"))

# Read and prepare dataset
df_maids <- read_csv("maid_mindset.csv") %>%
  mutate(
    # Explicitly factor and label the primary treatment
    Cond = factor(Cond, levels = c(0, 1), labels = c("Control", "Informed")),
    # Section 7.3: Engineer the categorical Age Block (Split at Age 40)
    Age_Group = factor(if_else(Age < 40, "Under 40", "40+")),
    # Create a unique identifier for the Repeated Measures analysis
    Subject_ID = factor(row_number())
  )

# ==============================================================================
# SECTIONS 7.3 - 7.5: Two-Way ANOVA & Interactions
# ==============================================================================

# 1. Fit the Factorial Model (Response: Post-Intervention Systolic BP)
twoway_fit <- lm(Syst2 ~ Cond * Age_Group, data = df_maids)

# 2. Extract Type III ANOVA Table 
# This provides the F-tests and p-values for Main Effects and the Interaction
cat("--- Two-Way ANOVA Table (Type III SS) ---\n")
print(car::Anova(twoway_fit, type = "III"))

# 3. Generate the Interaction Plot (Section 7.4)
# Compute cell means first to build a clean ggplot line chart
cell_means <- df_maids %>%
  group_by(Cond, Age_Group) %>%
  summarise(mean_Syst2 = mean(Syst2, na.rm = TRUE), .groups = 'drop')

interaction_plot <- ggplot(cell_means, aes(x = Cond, y = mean_Syst2, color = Age_Group, group = Age_Group)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 4) +
  labs(
    title = "Interaction Plot: Post-Intervention Systolic Blood Pressure",
    x = "Experimental Condition",
    y = "Mean Systolic BP (mmHg)",
    color = "Age Block"
  ) +
  theme_minimal() +
  theme(text = element_text(size = 12))

# Display plot
print(interaction_plot)

# 4. Cell-Level Diagnostics (Section 7.5)
cat("\n--- Two-Way ANOVA Diagnostics ---\n")
# Levene's Test across all 4 structural cells
print(car::leveneTest(Syst2 ~ Cond * Age_Group, data = df_maids))
# Shapiro-Wilk test on the pooled residuals
print(shapiro.test(residuals(twoway_fit)))


# ==============================================================================
# SECTIONS 7.6 - 7.8: ANCOVA (Analysis of Covariance)
# ==============================================================================

# 1. Step 1: Test the Homogeneity of Regression Slopes Assumption (Section 7.7)
# We look specifically at the interaction between the Covariate (Syst) and Predictor (Cond)
slope_test_fit <- lm(Syst2 ~ Syst * Cond, data = df_maids)
cat("\n--- ANCOVA Assumption: Homogeneity of Regression Slopes ---\n")
print(car::Anova(slope_test_fit, type = "III"))

# 2. Step 2: Fit the Standard ANCOVA Model (Assuming the interaction above is non-significant)
ancova_fit <- lm(Syst2 ~ Syst + Cond, data = df_maids)
cat("\n--- Main ANCOVA Table (Type III SS) ---\n")
print(car::Anova(ancova_fit, type = "III"))

# 3. Step 3: Extract Estimated Marginal Means / Adjusted Means (Section 7.8)
# This calculates the group means holding the baseline 'Syst' constant at its sample mean
cat("\n--- Adjusted Means (Estimated Marginal Means) for Conditions ---\n")
print(emmeans::emmeans(ancova_fit, specs = "Cond"))

# 4. ANCOVA Diagnostics
cat("\n--- ANCOVA Residual Diagnostics ---\n")
print(shapiro.test(residuals(ancova_fit)))


# ==============================================================================
# SECTIONS 7.9 - 7.11: Repeated Measures ANOVA
# ==============================================================================

# --- Method A: Wide Format via car::Anova (Best for mimicking Sphericity/Mauchly's output) ---
# Because R's base aov() doesn't calculate Mauchly's test, fitting a multivariate 
# linear model allows car to compute Sphericity corrections directly.
rm_multivariate_fit <- lm(cbind(BMI, BMI2) ~ Cond, data = df_maids)
time_factor <- data.frame(Time = factor(c("Baseline", "Post_4_Weeks")))

cat("\n--- Repeated Measures ANOVA (With Sphericity & Corrections) ---\n")
rm_output <- car::Anova(rm_multivariate_fit, idata = time_factor, idesign = ~Time, type = "III")
# This prints Mauchly's Test, Greenhouse-Geisser, and Huynh-Feldt epsilon values
print(summary(rm_output, multivariate = FALSE))


# --- Method B: Long Format via Base R (Good for simple Within-Subjects tables) ---
# Pivot data to long format for tracking changes
df_maids_long <- df_maids %>%
  pivot_longer(cols = c(BMI, BMI2), names_to = "Timepoint", values_to = "BMI_Value") %>%
  mutate(
    Timepoint = factor(Timepoint, levels = c("BMI", "BMI2"), labels = c("Baseline", "Post-Intervention"))
  )

# Traditional error-term specification for RM ANOVA
rm_aov_fit <- aov(BMI_Value ~ Timepoint * Cond + Error(Subject_ID / Timepoint), data = df_maids_long)
cat("\n--- Traditional Long-Format Repeated Measures Table ---\n")
print(summary(rm_aov_fit))