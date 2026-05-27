# Chapter 4 Summary: Correlation and Simple Linear Regression

## Dataset Used Throughout the Chapter
- **Happy Planet Index** dataset (147 countries)
- Variables: `Country` (categorical), `Region` (categorical, 8 areas), `LifeExpectancy` (numerical, years), `Footprint` (numerical, ecological footprint per capita), `LOL` (numerical, Ladder of Life score 0–10), `GDPperCapita` (numerical, GDP per person adjusted for purchasing power)

## Section 4.1: Introduction
- Chapter goals: measure relationship strength via linear correlation; build simple linear regression models using a four-step process; check models for errors and outliers; transform skewed data

## Section 4.2: Linear Correlation and Coefficient of Determination
- **Linear Correlation ($r$)**: measures direction (sign) and strength (magnitude, range -1 to 1) of straight-line relationship between two numerical variables
- Must visually verify linearity via scatterplot before calculating $r$; curved relationships require non-parametric tools (Spearman's rho, covered in Chapter 10)
- **Cohen's rules of thumb** for interpreting |$r$|: ~0.10 = small, ~0.30 = medium, ≥0.50 = large (social science context; physical sciences expect values near 1.0)
- Example application: GDPperCapita vs. Footprint shows strong positive $r$
- **Hypothesis test for correlation**: $H_0: \rho = 0$, $H_1: \rho \neq 0$; must establish non-zero population correlation before building a model
- **Coefficient of Determination ($R^2$)**: equals $r^2$; represents percentage of variability in one variable explained by the other (no causality implied)
- Example: $R^2 = 65.12\%$ for GDPperCapita vs. Footprint — 65.12% of global footprint variation explained by GDP per capita
- Notation note: uppercase $R^2$ used to be consistent with future multi-variable models (Chapter 5)
- Context matters for "good" $R^2$: physical sciences expect >90%; social sciences consider 25% a valuable finding

## Section 4.3: Foundations of Modeling — Four-Step Process
1. **Choose a form**: inspect scatterplot to determine if straight line is appropriate
2. **Fit to data**: software calculates best-fit line
3. **Assess accuracy**: diagnostic checks on residuals
4. **Use for inference**: make predictions and draw population-level conclusions

### Warning on Ordinal Variables
- Response variable ($y$) must be a true numerical measurement, not an isolated ordinal category (e.g., "Low/Medium/High")
- Composite scores spanning many levels (e.g., LOL 0–10 scale) can be treated as continuous if reliability and validity are established (per Chapter 2)

## Section 4.4: Fitting the Model — The Regression Line
- Example model: predictor $x$ = GDPperCapita, response $y$ = Footprint
- Equation form: Predicted Footprint = Intercept + (Slope × GDPperCapita)
- **Intercept**: predicted $y$ when $x = 0$; example value 1.672 (may not be meaningful in context if $x=0$ is unrealistic)
- **Slope**: rate of change — how much $y$ changes per one-unit increase in $x$; example value 0.000247
- Slope magnitude does NOT indicate relationship strength; use $r$ for strength and $R^2$ for prediction reliability
- Scale slope by meaningful units (e.g., multiply by 10,000 to interpret per $10,000 GDP increase → footprint increases by 2.47)

## Section 4.5: Model Diagnostics — Checking Work
- **Residuals**: difference between actual value and predicted value; positive = model underestimated, negative = overestimated, zero = perfect prediction
- **Residual plot**: predictor ($x$) on horizontal axis, residuals on vertical axis with zero line

### Four Diagnostic Checks (L.I.N.E. Checklist)
1. **Linearity**: no curves/U-shapes in residual plot; curved pattern means straight-line model is inappropriate
2. **Equal Variance (Homoscedasticity)**: vertical spread of residuals should be constant across $x$; megaphone/cone shape = heteroscedasticity violation
3. **Independence**: no structural patterns or groupings in residuals; example: color-coding by Region reveals systematic bias if Western Europe clusters above zero and Sub-Saharan Africa below
4. **Normality**: residuals (not raw variables) must be roughly normally distributed for valid confidence intervals and predictions

- Failed diagnostics signal need for more complex multi-variable models (Chapter 5)

## Section 4.6: Outliers and Influential Points
- **Outlier** in regression context: data point far from the regression line (large residual), not necessarily extreme raw value
- **Influential points**: outliers with high leverage that pull the regression line toward themselves
- **Leverage**: determined by position on x-axis; points at extreme edges of $x$ have more influence than points near the mean
- Example: wealthy micro-states (Qatar, Luxembourg) have extreme GDP values and can distort global regression line

### Cook's Distance
- Measures how much the regression line shifts when a point is removed vs. included
- Rule of thumb: Cook's D > 1.0 = highly influential point in social sciences

### Ethics of Removing Influential Points
- Do not delete data simply to improve model appearance; extreme points may contain valuable insights
- If removal justified by high Cook's Distance, run model both with and without the point; report both results transparently with justification

## Section 4.7: Logarithmic Transformations for Curved Relationships
- Two common curved patterns in social science data:
  1. **Exponential growth/decay** (e.g., population compounding upward, memory retention decaying)
  2. **Law of diminishing returns**: rapid initial increase that plateaus; example = GDPperCapita vs. LifeExpectancy

### Log Transformation
- "Squishes" the scale: compresses large values inward, stretches small values outward to linearize curved data
- Example: applying log10(GDPperCapita) as predictor against LifeExpectancy straightens the curve; $R^2$ improves to 77.22%

### Interpreting Transformed Models
- Equation example: Predicted LifeExpectancy = 16.28 + 13.54 × log10(GDPperCapita)
- Slope interpretation changes: with base-10 log, slope represents expected change in $y$ each time $x$ multiplies by 10
- Example interpretations:
  - GDP from $1,000 to $10,000 (×10): predicted life expectancy increase = 13.54 years
  - GDP from $10,000 to $100,000 (×10): same predicted increase of 13.54 years, despite $90,000 vs. $9,000 absolute difference

## Section 4.8: Inference and Predictions
- **Confidence Interval for the Slope**: interval estimate for true population slope; example 95% CI = (0.000217, 0.000277) — entirely positive, confirming real-world positive relationship
- Scaled interpretation: per $10,000 GDP increase, footprint increases between 2.17 and 2.77 units

### Point Estimates
- Plugging an $x$ value into the regression equation yields $\hat{y}$, which predicts the **mean** response for all observations at that $x$, not a single individual

### Confidence Interval vs. Prediction Interval
- Example at GDP = $70,000:
  - **95% CI for the mean**: (17.38, 20.52) — where the average footprint of all countries at this GDP level falls
  - **95% PI for an individual**: (10.59, 27.31) — where a single new country's footprint would fall
- Prediction Interval is much wider than Confidence Interval; groups are more predictable than individuals

## Section 4.9: Common Mistakes and Misconceptions
- **"$r = 0$" trap**: $r = 0$ only means no *linear* relationship; variables may still be strongly connected in a curved way — always check scatterplot
- **Assuming causation from correlation**: use "predicts" or "is associated with," not "causes," unless running controlled randomized experiment
- **"Bigger slope is better" fallacy**: slope magnitude depends on units of measurement; use $r$ to judge relationship strength
- **Extrapolation**: regression line only valid within observed data range; predicting far outside the range is unreliable
