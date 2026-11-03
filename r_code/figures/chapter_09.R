# =============================================================================
# Chapter 9 figures and values: Logistic Regression
#
# Run from the project root:
#   Rscript r_code/figures/chapter_09.R
#
# Figures 9.1-9.3 use icu_data.csv. The models, predicted probabilities, the
# confusion matrix, and the ROC/AUC values behind the prose are recorded in
# figures/chapter_09/values.yml by save_book_values(). Figures and the values
# registry are generated together; do not edit either by hand.
# =============================================================================

source("r_code/figures/_book_figs.R")

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
  library(scales)
})

assert_book_font()

# ---- Data -------------------------------------------------------------------

icu <- read_csv("data/icu_data.csv", show_col_types = FALSE)

# ---- Models -----------------------------------------------------------------
# The chapter's simple model (Table 9.1) uses Age. The reference script
# r_code/chapter_09.r instead fits Survive ~ Pulse as its baseline model; the
# discrepancy is recorded in the values registry below.

simple_age <- glm(Survive ~ Age, data = icu, family = binomial)
full_model <- glm(Survive ~ Emergency + Age, data = icu, family = binomial)

coef_table <- function(model) {
  s <- summary(model)$coefficients
  z <- qnorm(0.975)
  data.frame(
    term = rownames(s),
    estimate = s[, 1],
    se = s[, 2],
    z = s[, 3],
    p = s[, 4],
    ci_low = s[, 1] - z * s[, 2],
    ci_high = s[, 1] + z * s[, 2],
    odds_ratio = exp(s[, 1]),
    or_ci_low = exp(s[, 1] - z * s[, 2]),
    or_ci_high = exp(s[, 1] + z * s[, 2]),
    row.names = NULL
  )
}

simple_coefs <- coef_table(simple_age)
full_coefs <- coef_table(full_model)

# VIF from car::vif(), R's standard implementation for a GLM. It uses the
# covariance matrix of the coefficient estimates. The auxiliary-regression
# VIF that lm() models use gives 1.036 for these data; the GLM value is 1.010,
# which is what Minitab reports for this model as well.
vif_values <- car::vif(full_model)
vif_age <- unname(vif_values["Age"])
vif_emergency <- unname(vif_values["Emergency"])

# Predicted probabilities. The interval is Wald on the logit scale, then
# back-transformed; that reproduces the chapter's (0.713830, 0.835130).
prediction_row <- function(model, newdata, se_response = FALSE) {
  link <- predict(model, newdata = newdata, type = "link", se.fit = TRUE)
  z <- qnorm(0.975)
  fitted <- plogis(link$fit)
  if (se_response) {
    se <- predict(
      model, newdata = newdata, type = "response", se.fit = TRUE
    )$se.fit
  } else {
    se <- fitted * (1 - fitted) * link$se.fit
  }
  data.frame(
    age = newdata$Age,
    emergency = if (is.null(newdata$Emergency)) NA else newdata$Emergency,
    fitted = fitted,
    se_response = se,
    ci_low = plogis(link$fit - z * link$se.fit),
    ci_high = plogis(link$fit + z * link$se.fit),
    row.names = NULL
  )
}

pred_age65 <- prediction_row(
  simple_age, data.frame(Age = 65), se_response = TRUE
)
pred_profiles <- bind_rows(
  prediction_row(full_model, data.frame(Age = 65, Emergency = 0)),
  prediction_row(full_model, data.frame(Age = 65, Emergency = 1))
)

# ---- Classification at the 50% threshold ------------------------------------

icu$Predicted_Prob <- predict(full_model, type = "response")
icu$Predicted_Survive <- ifelse(icu$Predicted_Prob > 0.50, 1, 0)

conf_matrix <- table(
  Predicted = icu$Predicted_Survive, Actual = icu$Survive
)
tp <- conf_matrix["1", "1"]
fn <- conf_matrix["0", "1"]
tn <- conf_matrix["0", "0"]
fp <- conf_matrix["1", "0"]
sensitivity <- tp / (tp + fn)
specificity <- tn / (tn + fp)
accuracy <- (tp + tn) / sum(conf_matrix)

# ---- ROC curve and AUC ------------------------------------------------------

thresholds <- sort(unique(c(1, icu$Predicted_Prob, 0)), decreasing = TRUE)
roc_df <- data.frame(
  threshold = thresholds,
  sensitivity = vapply(
    thresholds, function(t) mean(icu$Predicted_Prob[icu$Survive == 1] >= t),
    numeric(1)
  ),
  false_positive_rate = vapply(
    thresholds, function(t) mean(icu$Predicted_Prob[icu$Survive == 0] >= t),
    numeric(1)
  )
)
roc_df <- roc_df[order(roc_df$false_positive_rate, roc_df$sensitivity), ]

# AUC from the Mann-Whitney probability of correct ranking.
pred_survived <- icu$Predicted_Prob[icu$Survive == 1]
pred_died <- icu$Predicted_Prob[icu$Survive == 0]
auc <- mean(outer(pred_survived, pred_died, ">")) +
  0.5 * mean(outer(pred_survived, pred_died, "=="))

# ---- Deviance ---------------------------------------------------------------

null_deviance <- full_model$null.deviance
residual_deviance <- full_model$deviance
df_residual <- df.residual(full_model)
deviance_r2 <- 1 - residual_deviance / null_deviance

# Adjusted deviance R-squared uses p = all estimated parameters (the intercept
# plus the two predictors), the same convention as summary(lm)$adj.r.squared.
# Minitab applies a different penalty and reports 12.53% for this model; the
# R value used in the chapter is 12.65%.
n_parameters <- length(coef(full_model))
adjusted_deviance_r2 <- 1 - (1 - deviance_r2) * (nrow(icu) - 1) /
  (nrow(icu) - n_parameters)

# Hosmer-Lemeshow goodness-of-fit test (10 groups by predicted probability).
# The ungrouped deviance test, pchisq(deviance, df.residual), is not valid for
# individual 0/1 outcomes, so the chapter reports Hosmer-Lemeshow instead.
hl_test <- DescTools::HosmerLemeshowTest(full_model$fitted.values,
                                         full_model$y)$C
hl_chisq <- unname(hl_test$statistic)
hl_df <- unname(hl_test$parameter)
hl_p <- hl_test$p.value

# ---- Figure 9.1: survival outcome against pulse -----------------------------

lin_fit <- lm(Survive ~ Pulse, data = icu)
lin_grid <- data.frame(Pulse = seq(35, 200, length.out = 200))
lin_grid$fit <- predict(lin_fit, newdata = lin_grid)

p91 <- ggplot(icu, aes(x = Pulse)) +
  geom_hline(
    yintercept = c(0, 1), colour = BOOK_MUTED, linewidth = 0.35,
    linetype = "dotted"
  ) +
  geom_point(
    aes(y = Survive),
    position = position_jitter(width = 0, height = 0.045, seed = 2026),
    shape = 21, fill = book_palette[["sky_blue"]],
    colour = BOOK_INK, size = 1.6, stroke = 0.3, alpha = 0.9
  ) +
  geom_line(
    data = lin_grid, aes(y = fit),
    colour = book_palette[["vermillion"]], linewidth = 0.9
  ) +
  annotate(
    "text", x = 30, y = 1.075, label = "Survived (1)",
    hjust = 0, size = 3.1, colour = BOOK_INK
  ) +
  annotate(
    "text", x = 30, y = -0.075, label = "Died (0)",
    hjust = 0, size = 3.1, colour = BOOK_INK
  ) +
  annotate(
    "text", x = 196, y = 0.825, label = "Straight-line fit",
    hjust = 1, size = 3.1, colour = BOOK_INK
  ) +
  scale_x_continuous(
    limits = c(30, 200), breaks = seq(40, 200, 40),
    expand = expansion(mult = c(0.01, 0.02))
  ) +
  scale_y_continuous(
    limits = c(-0.12, 1.12), breaks = c(0, 0.5, 1),
    labels = percent_format(accuracy = 1)
  ) +
  labs(
    x = "Pulse (beats per minute)",
    y = "Predicted probability of survival"
  ) +
  book_theme()

save_book_fig(
  p91,
  chapter = 9, id = "9.1", type = "scatter",
  slug = "survive_vs_pulse",
  caption = paste(
    "Survival status by pulse rate for 200 ICU patients. Each circle is a",
    "patient at 0 (died) or 1 (survived), jittered vertically to show",
    "overlap. The straight-line fit stays inside the probability range here",
    "because pulse is only weakly related to survival, but nothing in a",
    "straight line keeps it there."
  ),
  alt = paste(
    "Scatterplot of survival status against pulse for 200 ICU patients, with",
    "points jittered into two bands at 0 (died) and 1 (survived). A straight",
    "regression line runs from 83% predicted survival at pulse 39 down to 76%",
    "at pulse 192, staying inside the 0 to 100% range. The line has no floor",
    "or ceiling."
  ),
  direct_labels = TRUE
)

# ---- Figure 9.2: probability to odds to log-odds ----------------------------

pi_seq <- seq(0.005, 0.995, length.out = 500)

logit_long <- bind_rows(
  data.frame(panel = "A. Probability", x = pi_seq, y = pi_seq),
  data.frame(panel = "B. Odds", x = pi_seq, y = pi_seq / (1 - pi_seq)),
  data.frame(panel = "C. Log-odds (logit)", x = pi_seq, y = qlogis(pi_seq))
) %>%
  mutate(
    panel = factor(
      panel,
      levels = c("A. Probability", "B. Odds", "C. Log-odds (logit)")
    )
  )

reference_lines <- data.frame(
  panel = factor(
    c("B. Odds", "C. Log-odds (logit)"),
    levels = levels(logit_long$panel)
  ),
  yintercept = c(1, 0)
)

panel_labels <- data.frame(
  panel = factor(
    c("A. Probability", "B. Odds", "C. Log-odds (logit)"),
    levels = levels(logit_long$panel)
  ),
  x = c(0.5, 0.03, 0.03),
  y = c(0.10, 2.5, 0.45),
  label = c(
    "bounded between 0 and 1",
    "even odds",
    "centered on 0"
  ),
  hjust = c(0.5, 0, 0)
)

p92 <- ggplot(logit_long, aes(x = x, y = y)) +
  geom_hline(
    data = reference_lines, aes(yintercept = yintercept),
    colour = BOOK_MUTED, linewidth = 0.4, linetype = "dashed"
  ) +
  geom_line(colour = book_palette[["blue"]], linewidth = 1.0) +
  geom_text(
    data = panel_labels,
    aes(x = x, y = y, label = label, hjust = hjust),
    size = 3.0, colour = BOOK_INK, vjust = -0.4
  ) +
  facet_wrap(~panel, ncol = 1, scales = "free_y") +
  scale_x_continuous(
    labels = percent_format(accuracy = 1),
    breaks = c(0, 0.25, 0.5, 0.75, 1)
  ) +
  labs(x = "Probability of survival", y = "Transformed value") +
  book_theme() +
  theme(
    panel.spacing = unit(0.9, "lines"),
    strip.text = element_text(hjust = 0)
  )

save_book_fig(
  p92,
  chapter = 9, id = "9.2", type = "diagram",
  slug = "logit_progression",
  caption = paste(
    "Building the logit in three steps, all plotted against the same",
    "probability of survival. Panel A shows probability, bounded between 0",
    "and 1. Panel B shows odds, compressed between 0 and 1 and stretching",
    "toward infinity above 1. Panel C shows the log-odds (logit), centered on",
    "0 and extending in both directions."
  ),
  alt = paste(
    "Three stacked line charts share a probability axis from 0 to 1. Panel A",
    "is the straight line from 0 to 1. Panel B stays near 0, passes even odds",
    "at 1, then climbs steeply toward infinity. Panel C is an S-shaped curve",
    "through 0, dropping near 0 and rising near 1."
  ),
  width = 6.5, height = 6.2,
  direct_labels = TRUE
)

# ---- Figure 9.3: ROC curve --------------------------------------------------

operating_point <- data.frame(
  false_positive_rate = fp / (fp + tn),
  sensitivity = tp / (tp + fn)
)

p93 <- ggplot(roc_df, aes(x = false_positive_rate, y = sensitivity)) +
  geom_abline(
    intercept = 0, slope = 1,
    colour = BOOK_MUTED, linewidth = 0.6, linetype = "dashed"
  ) +
  geom_path(colour = book_palette[["blue"]], linewidth = 1.0) +
  geom_point(
    data = operating_point, shape = 24, size = 3.2,
    fill = book_palette[["vermillion"]], colour = BOOK_INK, stroke = 0.35
  ) +
  annotate(
    "segment",
    x = 0.90, y = 0.88, xend = 0.94, yend = 0.98,
    colour = BOOK_INK, linewidth = 0.4,
    arrow = arrow(length = unit(0.12, "cm"), type = "closed")
  ) +
  annotate(
    "text", x = 0.88, y = 0.86, label = "50% threshold",
    hjust = 1, size = 3.0, colour = BOOK_INK
  ) +
  annotate(
    "text", x = 0.80, y = 0.40, label = "Coin flip (AUC = 0.50)",
    hjust = 1, size = 2.9, colour = BOOK_INK
  ) +
  annotate(
    "text", x = 0.36, y = 0.22, label = "AUC = 0.749",
    size = 3.4, fontface = "bold", colour = BOOK_INK
  ) +
  scale_x_continuous(
    labels = percent_format(accuracy = 1), breaks = seq(0, 1, 0.25),
    limits = c(0, 1), expand = expansion(mult = c(0.01, 0.02))
  ) +
  scale_y_continuous(
    labels = percent_format(accuracy = 1), breaks = seq(0, 1, 0.25),
    limits = c(0, 1), expand = expansion(mult = c(0.01, 0.02))
  ) +
  coord_equal() +
  labs(
    x = "False positive rate (1 - specificity)",
    y = "Sensitivity (true positive rate)"
  ) +
  book_theme()

save_book_fig(
  p93,
  chapter = 9, id = "9.3", type = "roc",
  slug = "roc_auc",
  caption = paste(
    "ROC curve for the logistic regression of survival on age and emergency",
    "admission for 200 ICU patients. The curve plots sensitivity against the",
    "false positive rate at every decision threshold. The dashed diagonal is",
    "a coin-flip model; the triangle marks the 50% threshold, where the",
    "model's specificity is only 5.0%."
  ),
  alt = paste(
    "ROC curve for the age and emergency model. The curve climbs above the",
    "dashed diagonal, reaching 40% sensitivity at a 10% false positive rate,",
    "63% at 25%, and 98% at 95%. The area under the curve is 0.749. A",
    "triangle at a 95% false positive rate and 99% sensitivity marks the 50%",
    "threshold."
  ),
  width = 5.6, height = 5.2,
  direct_labels = TRUE
)

# ---- Values registry --------------------------------------------------------

conf_df <- as.data.frame(conf_matrix)
names(conf_df) <- c("predicted", "actual", "count")

roc_key_points <- roc_df %>%
  filter(
    false_positive_rate %in% c(0, 0.05, 0.10, 0.25, 0.50, 0.95, 1)
  ) %>%
  distinct(false_positive_rate, .keep_all = TRUE)

values <- list(
  data = list(
    icu_rows = nrow(icu),
    survived = sum(icu$Survive == 1),
    died = sum(icu$Survive == 0)
  ),
  simple_model_age = list(
    model = "glm(Survive ~ Age, family = binomial)",
    n = nrow(icu),
    coefficients = simple_coefs,
    null_deviance = simple_age$null.deviance,
    residual_deviance = simple_age$deviance,
    deviance_r2 = 1 - simple_age$deviance / simple_age$null.deviance
  ),
  prediction_age65_simple = pred_age65,
  multiple_model = list(
    model = "glm(Survive ~ Emergency + Age, family = binomial)",
    n = nrow(icu),
    coefficients = full_coefs,
    vif_age = vif_age,
    vif_emergency = vif_emergency,
    null_deviance = null_deviance,
    residual_deviance = residual_deviance,
    df_residual = df_residual,
    n_parameters = n_parameters,
    deviance_r2 = deviance_r2,
    adjusted_deviance_r2 = adjusted_deviance_r2,
    hosmer_lemeshow_chisq = hl_chisq,
    hosmer_lemeshow_df = hl_df,
    hosmer_lemeshow_p = hl_p
  ),
  prediction_profiles_age65 = pred_profiles,
  classification_threshold_50 = list(
    threshold = 0.5,
    rule = "Predicted survival when fitted probability > 0.50",
    table = conf_df,
    true_positive = tp,
    false_negative = fn,
    true_negative = tn,
    false_positive = fp,
    sensitivity = sensitivity,
    specificity = specificity,
    accuracy = accuracy
  ),
  roc_auc = list(
    auc = auc,
    note = "AUC is the Mann-Whitney probability that a survivor has a higher fitted probability than a non-survivor.",
    key_points = roc_key_points,
    operating_point = operating_point
  ),
  figures = list(
    figure_9_1 = list(
      note = paste(
        "Linear fit Survive ~ Pulse: intercept 0.84696, slope -0.0004747.",
        "Predicted survival runs from 0.828 at Pulse 39 to 0.756 at Pulse",
        "192. The line reaches 0 only at Pulse 1,784."
      )
    ),
    figure_9_2 = list(
      note = paste(
        "Conceptual diagram: probability, odds = pi/(1-pi), and logit =",
        "log(pi/(1-pi)) plotted against the same probability axis."
      )
    ),
    figure_9_3 = list(
      note = paste(
        "ROC computed from the full model's fitted probabilities without a",
        "package. The triangle is the 50% classification threshold from the",
        "confusion matrix (sensitivity 0.994, false positive rate 0.95)."
      )
    )
  ),
  table_9_1 = list(
    note = "Simple logistic regression of survival on Age; coefficients are in simple_model_age."
  ),
  table_9_2 = list(
    note = "Predicted probability for a 65-year-old from the simple Age model; values are in prediction_age65_simple."
  ),
  table_9_3 = list(
    note = "Multiple logistic regression coefficients, standard errors, Wald 95% CIs, z, p, and VIF are in multiple_model."
  ),
  table_9_4 = list(
    note = "Odds ratios and 95% CIs are the odds_ratio, or_ci_low, and or_ci_high columns in multiple_model$coefficients."
  ),
  table_9_5 = list(
    note = "65-year-old elective admission; first row of prediction_profiles_age65."
  ),
  table_9_6 = list(
    note = "65-year-old emergency admission; second row of prediction_profiles_age65."
  ),
  table_9_7 = list(
    note = "Confusion matrix at the 50% threshold; values are in classification_threshold_50."
  )
)

save_book_values(
  chapter = 9,
  values = values,
  conventions = list(
    outcome = "Survive = 1 means survived to discharge; Survive = 0 means died in the hospital.",
    models = paste(
      "The simple model in Table 9.1 is glm(Survive ~ Age); the multiple",
      "model is glm(Survive ~ Emergency + Age); both use the binomial family",
      "with the logit link."
    ),
    confidence_intervals = paste(
      "Coefficient CIs are Wald intervals (estimate +/- 1.96 SE). Predicted",
      "probability CIs are Wald intervals on the logit scale, back-transformed",
      "with plogis; this reproduces the chapter's (0.713830, 0.835130)."
    ),
    vif = paste(
      "VIF from car::vif(full_model), R's standard GLM method, which uses the",
      "covariance matrix of the coefficient estimates. Both predictors give",
      "1.010. The auxiliary-regression VIF used for lm models gives 1.036.",
      "Minitab reports the same 1.01 for this model; other software can differ",
      "slightly."
    ),
    deviance = paste(
      "Deviance R-squared = 1 - residual deviance/null deviance. Adjusted",
      "deviance R-squared uses the same adjustment as summary(lm)",
      "$adj.r.squared: 1 - (1 - R-squared)(n - 1)/(n - p) with p = 3, the",
      "intercept plus the two predictors. The result is 0.1265. The",
      "Hosmer-Lemeshow test is DescTools::HosmerLemeshowTest(fitted, y)$C,",
      "with 10 groups."
    ),
    software_differences = paste(
      "Minitab's adjusted deviance R-squared uses a different penalty and",
      "reports 12.53% for this model; its VIF is 1.01, matching car::vif.",
      "The chapter uses the R values: VIF 1.01 and adjusted deviance",
      "R-squared 12.65%."
    ),
    classification = paste(
      "At the 50% threshold a patient is classified as predicted survival",
      "when the fitted probability is greater than 0.50."
    ),
    roc = paste(
      "The ROC curve sweeps every unique fitted probability. The AUC is the",
      "Mann-Whitney statistic, equivalent to the area under the step curve."
    ),
    prose_checks = paste(
      "Reproduced from the CSV: Age coefficient -0.0275 and OR 0.973; full",
      "model Age OR 0.9666 and Emergency OR 0.0860; VIF 1.01 from car::vif;",
      "65-year-old fitted 0.780442 with CI (0.713830, 0.835130); 65-year-old",
      "elective 0.964350 and emergency 0.699344; confusion matrix 159/38/2/1;",
      "sensitivity 99.4%; specificity 5.0%; AUC 0.7491; deviance R-squared",
      "13.53%; Hosmer-Lemeshow chi-square 4.00 on 8 df, p = 0.857. The",
      "text uses VIF 1.01 and adjusted deviance R-squared 12.65%, R's values",
      "with p = all parameters. Minitab reports 12.53% for the adjusted value."
    ),
    reference_script = paste(
      "r_code/chapter_09.r fits Survive ~ Pulse as its baseline model and",
      "does not fit Survive ~ Age, so it does not reproduce Table 9.1 or the",
      "65-year-old prediction. This script fits the Age model the prose uses."
    )
  ),
  source = "r_code/chapter_09.r"
)

# ---- Console summary --------------------------------------------------------

cat("\n--- Chapter 9 summary ---\n")
cat("Survived:", sum(icu$Survive == 1), " Died:", sum(icu$Survive == 0), "\n")
cat("Simple Age coefficient:", round(simple_coefs$estimate[2], 5),
    " OR:", round(simple_coefs$odds_ratio[2], 4), "\n")
cat("Age OR (full):",
    round(full_coefs$odds_ratio[full_coefs$term == "Age"], 4),
    " Emergency OR:",
    round(full_coefs$odds_ratio[full_coefs$term == "Emergency"], 4), "\n")
cat("VIF Age:", round(vif_age, 4), " Emergency:", round(vif_emergency, 4), "\n")
cat("Deviance R2:", round(deviance_r2, 5),
    " Adjusted:", round(adjusted_deviance_r2, 5),
    " Hosmer-Lemeshow:", round(hl_chisq, 2), "on", hl_df, "df, p =",
    round(hl_p, 4), "\n")
cat("65-year-old simple fit:", round(pred_age65$fitted, 6),
    " CI:", round(pred_age65$ci_low, 6), round(pred_age65$ci_high, 6), "\n")
cat("65-year-old elective:", round(pred_profiles$fitted[1], 6),
    " emergency:", round(pred_profiles$fitted[2], 6), "\n")
cat("Sensitivity:", round(sensitivity, 5),
    " Specificity:", round(specificity, 5),
    " AUC:", round(auc, 5), "\n")
