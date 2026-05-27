# Chapter 3: Hypothesis Testing and Effect Sizes — Outline

## Running Example / Dataset
- **Dataset:** `depression_diet_treatment.csv`
- **Scenario:** A randomized controlled experiment testing whether a short-term healthy diet intervention reduces clinical depression symptoms in young adults.
- **Participants:** 75 college students with elevated depression symptoms and poor dietary habits, randomly assigned to two groups:
  - **Diet group** (n=37): received healthy food packages + dietary guidance
  - **Control group**: maintained usual eating habits
- **Duration:** 21 days
- **Variables:**
  - `Group`: categorical — "Control" or "Diet"
  - `CESD1`: numerical — baseline CESD depression score (Day 1); higher = more severe
  - `CESD21`: numerical — post-intervention CESD score (Day 21)
  - `CESDDiff`: numerical — change in CESD score (Day 21 minus Day 1); negative = improvement

## Section 3.1: Introduction
- Recap of Chapter 1 (data visualization, numerical summaries like means) and Chapter 2 (formulating null/alternative hypotheses).
- Core question addressed: how to make a definitive decision from sample statistics — is an observed difference real signal or random noise?
- Chapter goals: formal hypothesis testing, separating signal from noise, avoiding critical errors, assessing practical significance.

## Section 3.2: The Core Concept & Framework of Evidence
### Signal vs. Noise
- Hypothesis testing as the procedure for distinguishing true intervention effects (signal) from natural random variation (noise).

### p-value
- Defined as the probability of observing results as extreme as those collected, assuming the null hypothesis is true.
- Large p-value → results are unsurprising under H₀; insufficient evidence to claim an effect.
- Small p-value → results are highly unlikely under H₀; strong evidence for H₁.

### Significance Level (α)
- Predetermined threshold set before analysis; standard convention α = .05 in social sciences.
- Decision rule: if p < α, reject H₀; if p ≥ α, fail to reject H₀.
- "Fail to reject" ≠ "accept" — analogous to a jury verdict of "not guilty" rather than "innocent."

## Section 3.3: Foundations of the t-test
### Central Limit Theorem (CLT)
- With sufficiently large samples, the distribution of sample means forms a predictable bell curve (normal distribution).
- CLT is the mathematical foundation enabling t-tests to calculate how surprising a specific result is.
- Figure 3.1 referenced: histogram of simulated sampling distribution of mean CESDDiff scores forming a bell curve.

### Assumptions / Conditions for t-test
- **Independence:** data points must be independent; randomized experimental design ensures this.
- **Normality:** sample averages should form a bell curve; checked via visual plot of raw data.
- **Sample size exception (n ≥ 30):** CLT allows the t-test to work even with skewed/messy data if n is large enough, though severe skew or extreme outliers may require a much larger n.

## Section 3.4: Choosing the Right Tool — Three Types of t-tests
- Choice depends on how data was gathered and what research question is being asked.

### Single Sample t-test
- Compares one group's average against a known, fixed benchmark (e.g., national average, clinical threshold).
- Research question example: Were baseline CESD1 scores significantly different from the clinical benchmark of 16?

### Matched Pair t-test
- Used for pre-test/post-test designs where the same participants are measured twice; data points are linked.
- Research question example: Did the Diet group's students see a significant improvement in depression scores over three weeks (CESD1 vs. CESD21)?
- Software calculates difference score (`CESDDiff`) per participant and tests whether the average difference differs from zero.

### Independent Sample t-test
- Compares two completely separate, unrelated groups; no overlap between groups.
- Research question example: Did the Diet group improve significantly more than the Control group (comparing CESDDiff across both groups)?

## Section 3.5: Single Sample t-tests
### Hypotheses
- H₀: μ = 16 (population mean equals clinical benchmark)
- H₁: μ ≠ 16 (two-sided; true average is not equal to 16)
- Notation introduced: μ (mu) for the true population mean.

### Mechanics — t-statistic formula
- General formula: Test Statistic = (Sample Outcome − Hypothesized Outcome) / Standard Error
- Numerator = raw effect (gap between sample average and benchmark).
- Denominator = Standard Error (expected random variability of a typical sample average).
- Result = t-statistic, interpreted as a signal-to-noise ratio.

### Applied to example data
- Sample mean CESD1 = 20.47; benchmark = 16; gap = 4.47 points.
- Calculated t-statistic = 2.81.

### Confidence Interval (CI)
- Range of plausible values for the true population mean.
- 95% CI interpretation: if study repeated thousands of times, ~95% of resulting intervals would capture the true population average.
- Resulting 95% CI = [17.30, 23.63]; entire interval above benchmark of 16 → consistent with significant p-value.

### APA Reporting Format (for t-tests)
Required elements:
1. Plain English summary of finding.
2. Descriptive statistics: sample mean (*M*) and standard deviation (*SD*).
3. Test statistic: *t* with degrees of freedom (*df*) in parentheses; for single sample, df = n − 1.
4. Exact p-value (or p < .001 if very small).
5. 95% Confidence Interval.

- Example report: "At the beginning of the study, the sample of students exhibited depression scores (*M* = 20.47, *SD* = 13.76) that were significantly higher than the clinical baseline of 16, *t*(74) = 2.81, *p* = .006, 95% CI [17.30, 23.63]."

### Nuances in Conclusion Wording
- **"Significant"** in statistics means p < α only; does not imply the effect is large or practically important.
- **Direction:** The t-test/p-value confirms a difference exists but is blind to direction; descriptive statistics (sample mean, CI) must be consulted to determine whether scores were higher or lower.

## Section 3.6: Matched Pair t-tests
### Hypotheses
- H₀: μ_diff = 0 (true average change is zero — diet had no effect)
- H₁: μ_diff ≠ 0 (true average change is not zero)
- Notation introduced: μ_diff for the true population mean of difference scores.

### Difference Score Calculation Convention
- Rule: Post-Treatment − Pre-Treatment (Day 21 minus Day 1).
- Positive value = increase in score; negative value = decrease/improvement.
- For this study, a negative CESDDiff indicates symptom reduction.

### Applied to example data
- Diet group average change = -6.03 points (SD = 10.53); n = 37.
- Calculated p-value = .001; t(36) = -3.48.
- 95% CI for mean difference = [-9.54, -2.52]; entire interval below zero → real reduction in symptoms.

### APA Report
- "Over the 21-day intervention, students in the healthy diet group experienced a significant reduction in depression symptoms (*M* = -6.03, *SD* = 10.53), *t*(36) = -3.48, *p* = .001, 95% CI [-9.54, -2.52]."

### Need for a Control Group
- Matched pair test shows the Diet group improved, but cannot establish causation — improvement could be due to external factors (e.g., end of midterms). Must compare against control group.

## Section 3.7: Independent Sample t-tests
### Hypotheses
- Human-readable format: H₀: μ_Diet = μ_Control; H₁: μ_Diet ≠ μ_Control
- Software format: H₀: μ_Diet − μ_Control = 0 (equivalent, but allows testing against non-zero values).

### Mechanics — Unequal Variances & Welch's t-test
- Traditional assumption of equal variances between groups is rarely met in practice.
- Modern software defaults to **Welch's t-test**, which adjusts degrees of freedom to account for unequal variances, producing a more reliable p-value.

### Applied to example data
- Diet group mean CESDDiff = -6.03 (SD = 10.53); Control group mean CESDDiff = 0.32 (SD = 12.35).
- Raw gap ≈ -6.35 points.
- Welch's test result: t(71.86) = -2.40, p = .019.
- 95% CI for difference between groups = [-11.63, -1.07]; entirely negative → Diet group improved significantly more than Control.

### APA Report
- "A Welch's independent sample t-test was conducted to determine if a healthy diet intervention improved depression symptoms compared to a control group. The diet group experienced a significantly greater reduction in depression scores (*M* = -6.03, *SD* = 10.53) than the control group (*M* = 0.32, *SD* = 12.35), *t*(71.86) = -2.40, *p* = .019, 95% CI [-11.63, -1.07]."

### Statistical Language Notes
- **Never say "prove":** Statistics deals in probability; α = .05 means a 5% risk of Type I error is always accepted. Use "established" or "provided evidence."
- **"Cause" is permissible here:** Because this was a randomized controlled experiment (not an observational survey), random assignment distributed confounding variables equally across groups, justifying causal language.

## Section 3.8: Beyond the p-value — Practical Significance and Effect Sizes
### Limitation of the p-value
- A p-value only measures evidence against H₀; it does not measure effect magnitude.
- Large sample sizes reduce noise, making even trivially small effects statistically significant (e.g., a 0.1-point drop with n = 10,000).

### Effect Sizes — Cohen's d
- Standardized measure of how large the difference between groups is, independent of sample size.
- Formula: d = (Difference between Means) / Standard Deviation
- Uses standard deviations as universal unit of measurement for cross-study comparability.

### Interpreting Cohen's d (rules of thumb)
- d ≈ 0.2 → small effect
- d ≈ 0.5 → medium effect
- d ≈ 0.8 → large effect

### Applied to example data
- Raw gap = ~6.35 points; combined standard deviation ≈ 11.49.
- Cohen's d = 0.55 (medium, practically significant effect).

### Other Effect Size Variations
- **Hedges' g:** Cohen's d with a correction for small sample sizes (n < 20); interpreted identically.
- **Glass's Delta:** Used when group standard deviations differ greatly; divides by control group SD only.

### Best Practices — CI vs. Effect Size Emphasis
- **Focus on Confidence Interval** when variable uses concrete, interpretable units (e.g., pounds, dollars) — the range is intuitively meaningful.
- **Focus on Cohen's d** when variable uses abstract units (e.g., survey points like CESD scores) — translates results into a universal scale.

### Complete APA Conclusion (with effect size)
- "A Welch's independent sample t-test was conducted to determine if a healthy diet intervention improved depression symptoms compared to a control group. The diet group experienced a significantly greater reduction in depression scores (*M* = -6.03, *SD* = 10.53) than the control group (*M* = 0.32, *SD* = 12.35), *t*(71.86) = -2.40, *p* = .019, 95% CI [-11.63, -1.07], *d* = 0.55."

## Section 3.9: Power Analysis
### Statistical Power
- Defined as the probability that a study will successfully detect a true effect if one genuinely exists (opposite of Type II error).
- Standard target: minimum 80% power in social sciences.

### Four Interlocking Elements
1. Significance Level (α) — typically fixed at .05.
2. Sample Size (n).
3. Effect Size — the expected practical magnitude of difference.
4. Power — probability of detecting a true effect.
- Knowing any three allows calculation of the fourth; with α and power fixed, planning becomes a balance between n and effect size.

### Power Curves
- Figure 3.2 referenced: graph showing sample size (x-axis), statistical power (y-axis), with curves for different effect sizes.
- Larger samples → higher power.
- Larger effects → easier to detect; reach 80% power at smaller n.

### Finding Minimum Sample Size — Two Approaches
1. **Relying on past research:** Use effect sizes from previous similar studies as input.
2. **Defining minimal practical outcome:** Determine the smallest difference that would matter in practice (e.g., a 4-point CESD drop), then calculate n needed to detect that threshold.

### Planning for Precision — Margin of Error
- Researchers can plan sample size around desired confidence interval width rather than p-value.
- Larger samples → narrower margin of error → greater precision.
- Example: specifying "95% confidence with margin of error no wider than 2 points" to calculate required n.
