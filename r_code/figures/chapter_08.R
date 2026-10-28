# =============================================================================
# Chapter 8 figures and values: Categorical Data Analysis
#
# Run from the project root:
#   Rscript r_code/figures/chapter_08.R
#
# Figures 8.1-8.5 use fatal_police_shootings.csv, speed_dating.csv, and
# icu_data.csv. The tests and model conventions are recorded in
# figures/chapter_08/values.yml by save_book_values(). Figures and the values
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

fps <- read_csv("data/fatal_police_shootings.csv", show_col_types = FALSE)
speed_dating <- read_csv("data/speed_dating.csv", show_col_types = FALSE)
icu <- read_csv("data/icu_data.csv", show_col_types = FALSE)

# ---- Goodness of fit: race versus 2020 Census -------------------------------

fps_clean_race <- fps %>%
  filter(race %in% c("A", "B", "H", "N", "W"))

observed_race <- table(fps_clean_race$race)
census_weights <- c(0.059, 0.121, 0.187, 0.007, 0.578)
gof_test <- chisq.test(
  observed_race, p = census_weights, rescale.p = TRUE
)

race_lookup <- c(
  A = "Asian", B = "Black", H = "Hispanic",
  N = "Native American", W = "White"
)
race_df <- data.frame(
  race_code = names(observed_race),
  Race = factor(
    race_lookup[names(observed_race)],
    levels = unname(race_lookup)
  ),
  Observed = as.numeric(observed_race),
  Expected = as.numeric(gof_test$expected),
  Residual = as.numeric(gof_test$residuals),
  row.names = NULL
)

# ---- Independence: mental illness and fleeing ------------------------------

fps_flee <- fps %>%
  filter(
    flee %in% c("Car", "Foot", "Not fleeing"),
    !is.na(signs_of_mental_illness)
  )

ind_table <- table(fps_flee$signs_of_mental_illness, fps_flee$flee)
ind_test <- chisq.test(ind_table)

mi_flee <- fps_flee %>%
  mutate(
    MentalIllness = factor(
      signs_of_mental_illness,
      levels = c(FALSE, TRUE),
      labels = c("No Documented Illness", "Documented Illness")
    ),
    Flee = factor(flee, levels = c("Not fleeing", "Foot", "Car"))
  ) %>%
  count(MentalIllness, Flee) %>%
  group_by(MentalIllness) %>%
  mutate(share = n / sum(n)) %>%
  ungroup()

# ---- Homogeneity: ICU age profiles -----------------------------------------

icu_clean <- icu %>%
  filter(!is.na(Emergency), !is.na(AgeGroup)) %>%
  mutate(
    Admission_Type = factor(
      Emergency, levels = c(0, 1),
      labels = c("Elective", "Emergency")
    ),
    Age_Category = factor(
      AgeGroup, levels = c(1, 2, 3),
      labels = c("Under 50", "50 to 69", "70 or older")
    )
  )

homog_table <- table(icu_clean$Admission_Type, icu_clean$Age_Category)
homog_test <- chisq.test(homog_table)

icu_props <- icu_clean %>%
  count(Admission_Type, Age_Category) %>%
  group_by(Admission_Type) %>%
  mutate(share = n / sum(n)) %>%
  ungroup()

# ---- McNemar: speed dating outcomes ----------------------------------------

speed_dating <- speed_dating %>%
  mutate(
    Interaction_Outcome = factor(
      case_when(
        DecisionM == 0 & DecisionF == 0 ~ "Both Said No",
        DecisionM == 1 & DecisionF == 1 ~ "Both Said Yes",
        DecisionM == 1 & DecisionF == 0 ~ "Only Male Said Yes",
        DecisionM == 0 & DecisionF == 1 ~ "Only Female Said Yes"
      ),
      levels = c(
        "Both Said No", "Only Male Said Yes",
        "Only Female Said Yes", "Both Said Yes"
      )
    )
  )

mcnemar_table <- table(
  Male_Decision = speed_dating$DecisionM,
  Female_Decision = speed_dating$DecisionF
)
mcnemar_test <- mcnemar.test(mcnemar_table)

outcome_counts <- speed_dating %>%
  count(Interaction_Outcome)

# ---- Association: Cramer's V for armed group and threat --------------------

# The raw armed field has 98 nonblank categories, many with only a handful of
# incidents. Collapse it to Gun, Unarmed, and Other weapon; cases coded
# missing, "undetermined", or "unknown weapon" are excluded because they do
# not identify a weapon. This keeps every expected count above 5.
fps_armed <- fps %>%
  filter(
    !is.na(armed),
    !(armed %in% c("undetermined", "unknown weapon"))
  ) %>%
  mutate(
    Armed_Group = factor(
      case_when(
        armed == "gun" ~ "Gun",
        armed == "unarmed" ~ "Unarmed",
        TRUE ~ "Other weapon"
      ),
      levels = c("Gun", "Unarmed", "Other weapon")
    ),
    Threat = factor(
      threat_level,
      levels = c("attack", "other", "undetermined"),
      labels = c("Attack", "Other", "Undetermined")
    )
  )

assoc_table <- table(fps_armed$Armed_Group, fps_armed$Threat)
assoc_test <- chisq.test(assoc_table)
assoc_expected <- assoc_test$expected
assoc_residuals <- assoc_test$residuals
cramers_v <- sqrt(
  as.numeric(assoc_test$statistic) /
    (sum(assoc_table) * (min(dim(assoc_table)) - 1))
)

# ---- Risk: infection and survival ------------------------------------------

risk_table <- table(
  Infection = icu$Infection, Survive = icu$Survive
)
risk_infected <- risk_table["1", "1"] / sum(risk_table["1", ])
risk_uninfected <- risk_table["0", "1"] / sum(risk_table["0", ])
relative_risk <- risk_infected / risk_uninfected
odds_ratio <- (risk_table["1", "1"] / risk_table["1", "0"]) /
  (risk_table["0", "1"] / risk_table["0", "0"])

# ---- Classification: pulse rule and emergency admission --------------------

icu$Predicted_Emergency <- ifelse(icu$Pulse > 100, 1, 0)
conf_matrix <- table(
  Predicted = icu$Predicted_Emergency, Actual = icu$Emergency
)
tp <- conf_matrix["1", "1"]
fn <- conf_matrix["0", "1"]
tn <- conf_matrix["0", "0"]
fp <- conf_matrix["1", "0"]
sensitivity <- tp / (tp + fn)
specificity <- tn / (tn + fp)

# ---- Reference tests in r_code/chapter_08.r --------------------------------

fps_body <- fps %>% filter(flee %in% c("Car", "Foot", "Not fleeing"))
body_table <- table(fps_body$flee, fps_body$body_camera)
body_test <- chisq.test(body_table)

mental_threat_table <- table(
  fps$signs_of_mental_illness, fps$threat_level
)
mental_threat_test <- chisq.test(mental_threat_table)

# ---- Figure 8.1: observed versus expected race counts ----------------------

race_long <- race_df %>%
  select(Race, Observed, Expected) %>%
  pivot_longer(
    cols = c(Observed, Expected), names_to = "Type", values_to = "Count"
  ) %>%
  mutate(Type = factor(Type, levels = c("Observed", "Expected")))

p81 <- ggplot(race_long, aes(x = Race, y = Count, fill = Type)) +
  geom_col(
    position = position_dodge(width = 0.78), width = 0.68,
    colour = BOOK_INK, linewidth = 0.35
  ) +
  geom_text(
    aes(label = comma(round(Count))),
    position = position_dodge(width = 0.78),
    vjust = -0.35, size = 2.8, colour = BOOK_INK
  ) +
  scale_fill_manual(
    values = c(
      Observed = book_palette[["sky_blue"]],
      Expected = book_palette[["orange"]]
    ),
    name = "Count type"
  ) +
  scale_y_continuous(
    labels = label_comma(), expand = expansion(mult = c(0, 0.14))
  ) +
  labs(x = "Racial category", y = "Number of incidents") +
  book_theme() +
  theme(axis.text.x = element_text(angle = 20, hjust = 1))

save_book_fig(
  p81,
  chapter = 8, id = "8.1", type = "bar",
  slug = "race_observed_expected",
  caption = paste(
    "Observed racial distribution of fatal police shootings compared with the",
    "expected 2020 U.S. Census distribution. The 5,708 incidents with a known",
    "race in the five Census categories are shown. The observed Black count is",
    "far above its expected count, while the White and Asian counts are below",
    "theirs."
  ),
  alt = paste(
    "Grouped bar chart of observed and expected counts for five racial",
    "categories. Black observed 1,528 versus expected 725; White 2,919 versus",
    "3,466; Asian 105 versus 354; Hispanic 1,066 versus 1,121; Native American",
    "90 versus 42. The Black bar is much taller than expected, and the White",
    "and Asian bars are shorter."
  ),
  direct_labels = TRUE,
  author_note = paste(
    "Expected counts use the 2020 Census weights c(5.9, 12.1, 18.7, 0.7,",
    "57.8)%, rescaled after excluding the 4.8% other/multiracial category.",
    "Exact expected counts: 353.75, 725.49, 1121.21, 41.97, 3465.57."
  )
)

# ---- Figure 8.2: fleeing behavior by mental illness ------------------------

flee_fill <- c(
  "Not fleeing" = book_palette[["blue"]],
  "Foot" = book_palette[["orange"]],
  "Car" = book_palette[["bluish_green"]]
)
flee_text <- contrast_text(flee_fill)

p82 <- ggplot(mi_flee, aes(x = MentalIllness, y = share, fill = Flee)) +
  geom_col(width = 0.62, colour = BOOK_INK, linewidth = 0.35) +
  geom_text(
    aes(label = percent(share, accuracy = 1), colour = Flee),
    position = position_stack(vjust = 0.5), size = 2.7, show.legend = FALSE
  ) +
  scale_fill_manual(values = flee_fill, name = "Fleeing behavior") +
  scale_colour_manual(values = flee_text, guide = "none") +
  scale_y_continuous(
    labels = percent_format(accuracy = 1), expand = expansion(mult = c(0, 0))
  ) +
  labs(x = "Documented mental illness", y = "Share within group") +
  book_theme()

save_book_fig(
  p82,
  chapter = 8, id = "8.2", type = "segmented",
  slug = "flee_by_mental_illness",
  caption = paste(
    "Fleeing behavior by documented mental illness status. Each bar is scaled",
    "to 100% within its group. People with documented illness were more likely",
    "to not flee and less likely to flee by car or on foot."
  ),
  alt = paste(
    "100% stacked bar chart of fleeing behavior for two groups. No documented",
    "illness: not fleeing 62%, on foot 17%, by car 22%. Documented illness:",
    "not fleeing 86%, on foot 8%, by car 7%. The documented-illness bar has a",
    "larger not-fleeing segment and smaller fleeing segments."
  ),
  direct_labels = TRUE,
  author_note = paste(
    "Counts: no documented illness 2,700 not fleeing, 727 on foot, 941 by car;",
    "documented illness 1,183 not fleeing, 105 on foot, 94 by car. N = 5,750."
  )
)

# ---- Figure 8.3: ICU age profile by admission type -------------------------

p83 <- ggplot(
  icu_props, aes(x = Admission_Type, y = share, fill = Age_Category)
) +
  geom_col(
    position = position_dodge(width = 0.8), width = 0.7,
    colour = BOOK_INK, linewidth = 0.35
  ) +
  geom_text(
    aes(label = percent(share, accuracy = 1)),
    position = position_dodge(width = 0.8),
    vjust = -0.35, size = 2.8, colour = BOOK_INK
  ) +
  scale_fill_manual(
    values = c(
      "Under 50" = book_palette[["blue"]],
      "50 to 69" = book_palette[["orange"]],
      "70 or older" = book_palette[["bluish_green"]]
    ),
    name = "Age category"
  ) +
  scale_x_discrete(
    labels = c(
      Elective = "Elective Admissions",
      Emergency = "Emergency Admissions"
    )
  ) +
  scale_y_continuous(
    labels = percent_format(accuracy = 1), expand = expansion(mult = c(0, 0.14))
  ) +
  labs(x = "Admission type", y = "Within-group proportion") +
  book_theme()

save_book_fig(
  p83,
  chapter = 8, id = "8.3", type = "bar",
  slug = "icu_age_by_admission",
  caption = paste(
    "Age group distribution within elective and emergency ICU admissions.",
    "Bars show the percentage of each admission group in each age category.",
    "Elective admissions have a much smaller share of patients under 50."
  ),
  alt = paste(
    "Grouped bar chart of age groups within two ICU admission types.",
    "Elective: under 50 13%, 50 to 69 45%, 70 or older 42%. Emergency: under",
    "50 35%, 50 to 69 36%, 70 or older 29%. The elective under-50 bar is much",
    "shorter."
  ),
  direct_labels = TRUE,
  author_note = paste(
    "Counts: elective 7 under 50, 24 aged 50 to 69, 22 aged 70 or older;",
    "emergency 52, 53, and 42. N = 200."
  )
)

# ---- Figure 8.4: speed dating outcomes -------------------------------------

p84 <- ggplot(outcome_counts, aes(x = Interaction_Outcome, y = n)) +
  geom_col(
    width = 0.62, fill = book_palette[["sky_blue"]],
    colour = BOOK_INK, linewidth = 0.35
  ) +
  geom_text(aes(label = n), vjust = -0.4, size = 3.2, colour = BOOK_INK) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.14))) +
  labs(x = "Decision outcome", y = "Number of interactions") +
  book_theme() +
  theme(axis.text.x = element_text(angle = 20, hjust = 1))

save_book_fig(
  p84,
  chapter = 8, id = "8.4", type = "bar",
  slug = "speed_dating_outcomes",
  caption = paste(
    "Outcomes of 276 speed-dating interactions. The two disagreement bars are",
    "the ones McNemar's test compares: 83 interactions where only the man said",
    "yes and 64 where only the woman said yes."
  ),
  alt = paste(
    "Bar chart of four paired dating outcomes. Both said no 66; only male said",
    "yes 83; only female said yes 64; both said yes 63. The only-male-yes bar",
    "is the tallest. The only-female-yes bar is taller than both-said-yes and",
    "slightly shorter than both-said-no."
  ),
  direct_labels = TRUE,
  author_note = paste(
    "McNemar's test uses the two disagreement cells: 83 male-only yes versus",
    "64 female-only yes. The agreement cells are 66 both no and 63 both yes."
  )
)

# ---- Figure 8.5: confusion matrix diagram ----------------------------------

conf_df <- data.frame(
  xmin = c(0, 1, 0, 1),
  xmax = c(1, 2, 1, 2),
  ymin = c(1, 1, 0, 0),
  ymax = c(2, 2, 1, 1),
  label = c(
    "True Positive\n(TP)", "False Positive\n(FP)",
    "False Negative\n(FN)", "True Negative\n(TN)"
  ),
  fill = c(
    book_palette[["bluish_green"]], book_palette[["orange"]],
    book_palette[["orange"]], book_palette[["bluish_green"]]
  )
)

p85 <- ggplot(conf_df) +
  geom_rect(
    aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = fill),
    colour = BOOK_INK, linewidth = 0.5
  ) +
  geom_text(
    aes(
      x = (xmin + xmax) / 2, y = (ymin + ymax) / 2, label = label
    ),
    size = 3.8, lineheight = 1.0, colour = BOOK_INK
  ) +
  annotate(
    "text", x = c(0.5, 1.5), y = 2.16,
    label = c("Actual Positive", "Actual Negative"),
    size = 3.3, fontface = "bold", colour = BOOK_INK
  ) +
  annotate(
    "text", x = -0.12, y = c(1.5, 0.5),
    label = c("Predicted Positive", "Predicted Negative"),
    angle = 90, size = 3.3, fontface = "bold", colour = BOOK_INK
  ) +
  scale_fill_identity() +
  coord_cartesian(xlim = c(-0.4, 2.05), ylim = c(-0.1, 2.35), clip = "off") +
  theme_void(base_family = BOOK_FONT) +
  theme(
    plot.background = element_rect(fill = BOOK_BG, colour = NA),
    plot.margin = margin(10, 14, 10, 14)
  )

save_book_fig(
  p85,
  chapter = 8, id = "8.5", type = "diagram",
  slug = "confusion_matrix",
  caption = paste(
    "A confusion matrix. Rows show the rule's prediction and columns show the",
    "actual outcome. The diagonal cells are correct classifications (true",
    "positive and true negative); the off-diagonal cells are errors (false",
    "positive and false negative)."
  ),
  alt = paste(
    "Two-by-two confusion matrix. The top-left cell is true positive,",
    "predicted positive and actual positive. The top-right is false positive,",
    "predicted positive and actual negative. The bottom-left is false",
    "negative, predicted negative and actual positive. The bottom-right is",
    "true negative, predicted negative and actual negative."
  ),
  width = 6.5, height = 4.5,
  direct_labels = TRUE,
  author_note = paste(
    "The diagram is generic. The ICU pulse rule in Table 8.6 has 65 true",
    "positives, 15 false positives, 82 false negatives, and 38 true negatives."
  )
)

# ---- Values registry -------------------------------------------------------

ind_df <- as.data.frame(ind_table)
names(ind_df) <- c("mental_illness", "flee", "count")
ind_res <- as.data.frame(ind_test$residuals)
names(ind_res) <- c("mental_illness", "flee", "residual")

homog_df <- as.data.frame(homog_table)
names(homog_df) <- c("admission_type", "age_category", "count")
homog_res <- as.data.frame(homog_test$residuals)
names(homog_res) <- c("admission_type", "age_category", "residual")

mcnemar_df <- as.data.frame(mcnemar_table)
names(mcnemar_df) <- c("male_decision", "female_decision", "count")
outcome_df <- as.data.frame(outcome_counts)
names(outcome_df) <- c("outcome", "count")

assoc_df <- as.data.frame(assoc_table)
names(assoc_df) <- c("armed_group", "threat_level", "count")
assoc_exp_df <- as.data.frame(as.table(assoc_expected))
names(assoc_exp_df) <- c("armed_group", "threat_level", "expected")
assoc_res_df <- as.data.frame(as.table(assoc_residuals))
names(assoc_res_df) <- c("armed_group", "threat_level", "residual")

risk_df <- as.data.frame(risk_table)
names(risk_df) <- c("infection", "survive", "count")

conf_df_values <- as.data.frame(conf_matrix)
names(conf_df_values) <- c("predicted", "actual", "count")

body_df <- as.data.frame(body_table)
names(body_df) <- c("flee", "body_camera", "count")

mental_threat_df <- as.data.frame(mental_threat_table)
names(mental_threat_df) <- c("mental_illness", "threat_level", "count")

values <- list(
  data = list(
    fatal_police_shootings_rows = nrow(fps),
    speed_dating_rows = nrow(speed_dating),
    icu_rows = nrow(icu),
    race_clean_n = sum(observed_race),
    flee_clean_n = sum(ind_table),
    armed_clean_n = sum(assoc_table),
    icu_clean_n = sum(homog_table)
  ),
  goodness_of_fit_race = list(
    test = "chisq.test(observed_race, p = census_weights, rescale.p = TRUE)",
    n = sum(observed_race),
    chi_square = as.numeric(gof_test$statistic),
    df = as.numeric(gof_test$parameter),
    p = gof_test$p.value,
    census_weights = census_weights,
    race_table = race_df
  ),
  independence_mental_illness_flee = list(
    test = "chisq.test(table(signs_of_mental_illness, flee))",
    n = sum(ind_table),
    chi_square = as.numeric(ind_test$statistic),
    df = as.numeric(ind_test$parameter),
    p = ind_test$p.value,
    table = ind_df,
    residuals = ind_res
  ),
  homogeneity_icu_age = list(
    test = "chisq.test(table(Admission_Type, Age_Category))",
    n = sum(homog_table),
    chi_square = as.numeric(homog_test$statistic),
    df = as.numeric(homog_test$parameter),
    p = homog_test$p.value,
    table = homog_df,
    residuals = homog_res
  ),
  mcnemar_speed_dating = list(
    test = "mcnemar.test(table(DecisionM, DecisionF))",
    n = nrow(speed_dating),
    chi_square = as.numeric(mcnemar_test$statistic),
    df = as.numeric(mcnemar_test$parameter),
    p = mcnemar_test$p.value,
    table = mcnemar_df,
    outcome_counts = outcome_df
  ),
  cramers_v_armed_threat = list(
    test = paste(
      "chisq.test(table(Armed_Group, Threat));",
      "Cramer's V = sqrt(chi-square/(N*(min(r,c)-1)))"
    ),
    n = sum(assoc_table),
    armed_categories = nrow(assoc_table),
    threat_categories = ncol(assoc_table),
    chi_square = as.numeric(assoc_test$statistic),
    df = as.numeric(assoc_test$parameter),
    p = assoc_test$p.value,
    cramers_v = cramers_v,
    min_expected = min(assoc_expected),
    table = assoc_df,
    expected = assoc_exp_df,
    residuals = assoc_res_df,
    note = paste(
      "The raw armed field is collapsed to Gun, Unarmed, and Other weapon:",
      "Gun is armed == 'gun', Unarmed is armed == 'unarmed', and every other",
      "retained entry is Other weapon. Cases coded missing, 'undetermined', or",
      "'unknown weapon' are excluded, leaving N = 5963. Every expected count is",
      "at least 5 (minimum 6.72). This replaces the earlier 99 x 3 table, where",
      "247 of 297 expected counts were below 5 and blank armed values were",
      "treated as a category."
    )
  ),
  risk_icu_infection_survival = list(
    table = risk_df,
    risk_infected = risk_infected,
    risk_uninfected = risk_uninfected,
    relative_risk = relative_risk,
    odds_ratio = odds_ratio,
    note = paste(
      "Rows are Infection (0/1), columns are Survive (0/1); RR and OR compare",
      "infected patients with uninfected patients."
    )
  ),
  classification_pulse_emergency = list(
    rule = "Pulse > 100 predicts emergency admission",
    n = sum(conf_matrix),
    table = conf_df_values,
    true_positive = tp,
    false_negative = fn,
    true_negative = tn,
    false_positive = fp,
    sensitivity = sensitivity,
    specificity = specificity
  ),
  reference_body_camera_flee = list(
    test = "chisq.test(table(flee, body_camera))",
    note = "Reference script section 8.2; not the main chapter example.",
    n = sum(body_table),
    chi_square = as.numeric(body_test$statistic),
    df = as.numeric(body_test$parameter),
    p = body_test$p.value,
    table = body_df
  ),
  reference_mental_illness_threat = list(
    test = "chisq.test(table(signs_of_mental_illness, threat_level))",
    note = "Reference script section 8.3; not the main chapter example.",
    n = sum(mental_threat_table),
    chi_square = as.numeric(mental_threat_test$statistic),
    df = as.numeric(mental_threat_test$parameter),
    p = mental_threat_test$p.value,
    table = mental_threat_df
  ),
  figures = list(
    figure_8_1 = list(
      note = paste(
        "Observed and expected race counts; exact expected counts are in",
        "goodness_of_fit_race. The figure labels the expected counts rounded",
        "to whole incidents."
      )
    ),
    figure_8_2 = list(
      note = "100% stacked bar of fleeing behavior within mental illness groups."
    ),
    figure_8_3 = list(
      note = "Age profile within ICU admission types."
    ),
    figure_8_4 = list(
      note = "Speed dating outcome counts; the two disagreement cells drive McNemar's test."
    ),
    figure_8_5 = list(
      note = paste(
        "Generic confusion matrix diagram. The ICU pulse-rule counts are in",
        "classification_pulse_emergency and Table 8.6."
      )
    )
  ),
  table_8_1 = list(
    note = "Cross-tabulation of fleeing behavior by mental illness; counts are in independence_mental_illness_flee."
  ),
  table_8_2 = list(
    note = "Cross-tabulation of age group by ICU admission type; counts are in homogeneity_icu_age."
  ),
  table_8_3 = list(
    note = "Static Cramer's V cutoffs by the number of categories in the smaller variable; no calculated values."
  ),
  table_8_4 = list(
    note = paste(
      "Armed group by threat level cross-tabulation; counts, expected counts,",
      "and residuals are in cramers_v_armed_threat."
    )
  ),
  table_8_5 = list(
    note = "Static effect-size guidelines for odds ratios; no calculated values."
  ),
  table_8_6 = list(
    note = "Confusion matrix; values are in classification_pulse_emergency."
  )
)

save_book_values(
  chapter = 8,
  values = values,
  conventions = list(
    chi_square = paste(
      "Pearson chi-square tests. The goodness-of-fit expected counts use the",
      "2020 Census weights c(5.9, 12.1, 18.7, 0.7, 57.8)%, rescaled to sum to",
      "1 after excluding the 4.8% other/multiracial category."
    ),
    mcnemar = "mcnemar.test with continuity correction (R default).",
    cramers_v = paste(
      "Cramer's V = sqrt(chi-square/(N*(min(r,c)-1))). The example collapses",
      "the raw armed field to Gun, Unarmed, and Other weapon: Gun is armed ==",
      "'gun', Unarmed is armed == 'unarmed', and every other retained entry is",
      "Other weapon. Cases coded missing, 'undetermined', or 'unknown weapon'",
      "are excluded. The resulting 3 x 3 table has N = 5963 and df = 4."
    ),
    risk = paste(
      "RR = risk of survival with infection / risk of survival without",
      "infection; OR from the same 2 x 2 table."
    ),
    classification = paste(
      "The pulse rule predicts emergency when Pulse > 100; rows are predicted",
      "and columns are actual."
    ),
    software = paste(
      "r_code/chapter_08.r calls DescTools::CramerV() and epitools for the risk",
      "measures. Those packages are not installed here, so this script reproduces",
      "the same quantities with base R table(), chisq.test(), and mcnemar.test()."
    ),
    note = paste(
      "The chapter's Cramer's V example was replaced with a 3 x 3 grouping",
      "that meets the expected-count assumption. The earlier 99 x 3 table had",
      "247 of 297 expected counts below 5."
    )
  ),
  source = "r_code/chapter_08.r"
)
