# 1. Load the data
# Make sure salary.csv is in your current working directory
data <- read.csv("college_teacher_salary_2023.csv")

# 2. Step 1: The Raw Gap (Simple Linear Regression)
model_raw <- lm(Salary ~ Sex, data = data)

cat("\n======================================================\n")
cat("STEP 1: THE RAW GAP (Salary ~ Sex)\n")
cat("======================================================\n")
summary(model_raw)

# 3. Steps 2 & 3: Adding Confounders (Multiple Regression)
model_controlled <- lm(Salary ~ Sex + Age + PhD, data = data)

cat("\n======================================================\n")
cat("STEPS 2 & 3: CONTROLLED MODEL (Salary ~ Sex + Age + PhD)\n")
cat("======================================================\n")
summary(model_controlled)

# 4. Extract specific Adjusted R-squared and F-statistic for APA reporting
cat("\n======================================================\n")
cat("STEP 4: EXTRA METRICS FOR APA REPORTING\n")
cat("======================================================\n")
controlled_summary <- summary(model_controlled)
adj_r_squared <- controlled_summary$adj.r.squared
f_stat <- controlled_summary$fstatistic

cat("Adjusted R-squared:", round(adj_r_squared, 3), "\n")
cat("F-statistic:", round(f_stat[1], 2), "\n")
cat("Degrees of Freedom (numerator):", f_stat[2], "\n")
cat("Degrees of Freedom (denominator):", f_stat[3], "\n")
# Calculate exact p-value for the F-statistic
p_value_f <- pf(f_stat[1], f_stat[2], f_stat[3], lower.tail = FALSE)
cat("F-statistic p-value:", format.pval(p_value_f, digits = 3), "\n")