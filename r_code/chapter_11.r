# Load required package (install if needed: install.packages("psych"))
library(psych)

# Load the dataset (adjust path if needed)
df <- read.csv("data/speed_dating.csv")

# Select the 6 Female rating variables and 6 Male rating variables
vars_F <- c("AttractiveF", "SincereF", "IntelligentF", "FunF", "AmbitiousF", "SharedInterestsF")
vars_M <- c("AttractiveM", "SincereM", "IntelligentM", "FunM", "AmbitiousM", "SharedInterestsM")

data_F <- na.omit(df[, vars_F])
data_M <- na.omit(df[, vars_M])

cat("=== SAMPLE SIZES AFTER NA OMISSION ===\n")
cat("Female ratings n =", nrow(data_F), "\n")
cat("Male ratings n =", nrow(data_M), "\n\n")

cat("=== 1. CORRELATION MATRICES ===\n")
cat("--- Female Ratings Correlation Matrix ---\n")
print(round(cor(data_F), 3))

cat("\n--- Male Ratings Correlation Matrix ---\n")
print(round(cor(data_M), 3))

cat("\n=== 2. FEMALE RATINGS: PAF WITH VARIMAX (SPSS Classic Emulation) ===\n")
fa_F_pa_var <- fa(data_F, nfactors = 2, fm = "pa", rotate = "varimax")
print(fa_F_pa_var$loadings, cutoff = 0.0)
cat("Communalities (h2):\n")
print(round(fa_F_pa_var$communality, 3))
cat("Uniquenesses (u2):\n")
print(round(fa_F_pa_var$uniquenesses, 3))

cat("\n=== 3. FEMALE RATINGS: ML WITH VARIMAX ===\n")
fa_F_ml_var <- fa(data_F, nfactors = 2, fm = "ml", rotate = "varimax")
print(fa_F_ml_var$loadings, cutoff = 0.0)
cat("Communalities (h2):\n")
print(round(fa_F_ml_var$communality, 3))

cat("\n=== 4. MALE RATINGS: PAF WITH VARIMAX ===\n")
fa_M_pa_var <- fa(data_M, nfactors = 2, fm = "pa", rotate = "varimax")
print(fa_M_pa_var$loadings, cutoff = 0.0)
cat("Communalities (h2):\n")
print(round(fa_M_pa_var$communality, 3))

cat("\n=== 5. PCA COMPARISON (For Section 11.3) ===\n")
pca_F_var <- principal(data_F, nfactors = 2, rotate = "varimax")
print(pca_F_var$loadings, cutoff = 0.0)
cat("PCA Communalities (h2):\n")
print(round(pca_F_var$communality, 3))
