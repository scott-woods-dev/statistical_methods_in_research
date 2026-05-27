# Chapter 5 Summary: Multiple Regression for Complex Systems

## 5.1 Introduction

- **Dataset**: `births_2014.csv` — sample of 1,000 live birth events from the 2014 US national natality public-use file
  - `weight`: numerical, infant birth weight in pounds (response variable)
  - `weeks`: numerical, gestational length in weeks
  - `mage`: numerical, mother's age in years
  - `visits`: numerical, count of prenatal medical visits
  - `habit`: categorical, mother's tobacco smoking status during pregnancy
  - `mature`: categorical, mother's clinical age maturity status

## 5.2 What is Multiple Regression?

- **Multiple regression**: predicts a single continuous response variable using two or more predictors simultaneously
- **Confounding factor**: an underlying third variable that influences both the predictor and the response variable
- **Omitted variable bias**: inaccurate/misleading slope caused by failing to account for confounding factors; occurs when a model is "blind" to overlapping variables
- Example: predicting `weight` from only `mage` yields a positive slope, but this is confounded by `visits` and `weeks`; adding them as predictors corrects the bias

## 5.3 What "Controlling For" a Variable Means

- **To control for** a variable: mathematically hold it constant to isolate the true effect of the primary predictor; neutralizes confounding factors
- Example: simple regression of `weight` on `mage` shows positive slope (older mothers → heavier babies)
- Adding `weeks` as second predictor alongside `mage`: slope for `mage` shrinks dramatically, may become statistically insignificant
- Interpretation after controlling: "If we only compare mothers whose pregnancies lasted the exact same number of weeks, does mother's age still affect birth weight?" — answer is often no; original positive slope was an illusion from confounding

## 5.4 Evaluating the Model

- **Overall model significance**: F-value with overall p-value; for the birth weight model, p = $0.000$ (< $0.05$, model is effective)
- **Regular $R^2$**: always increases when adding a new variable, even if that variable is nonsense — mathematical flaw
- **Adjusted $R^2$** ($R^2_{\text{adj}}$): penalizes the model for adding useless variables; goes up only with strong predictors, goes down with random noise; should always be reported for multiple regression
- Birth weight model: regular $R^2$ = $30.51\%$, Adjusted $R^2$ = $30.37\%$ (slightly lower due to penalty for two predictors)
- Remaining unexplained variation: $69.63\%$ driven by other biological/environmental factors not included
- **Regression equation**: $\text{Predicted Weight} = -4.056 + 0.01558(\text{mage}) + 0.2796(\text{weeks})$
  - Slope for `mage`: $0.01558$ — each additional year of maternal age increases birth weight by $0.01558$ pounds, holding pregnancy length constant
  - Slope for `weeks`: $0.2796$ — each additional week of pregnancy increases birth weight by $0.2796$ pounds, holding mother's age constant
  - Intercept: $-4.056$; biologically impossible (zero-year-old mother, zero weeks pregnant); no meaningful real-world interpretation

## 5.5 Evaluating Predictors

- Cannot compare raw slopes across predictors because they are tied to different units of measurement
- **Standard error**: expected background noise/uncertainty for a specific slope estimate
- **T-Value**: slope divided by its standard error; proxy for variable's signal strength
- `mage`: T-Value = $2.60$, p-value = $0.009$ (< $0.05$, statistically significant)
- `weeks`: T-Value = $20.79$, p-value = $0.000$ (highly significant)
- Both are significant, but comparing T-Values reveals gestational length provides a massively stronger signal than maternal age

## 5.6 Binary Predictors

- **Indicator variable** (dummy variable): translates categorical values into numbers ($1$ and $0$) for regression equations
- Example: `habit` variable — smoking status coded as $1 = \text{smoker}$, $0 = \text{nonsmoker}$
- Regression equation with indicator: $\text{Predicted Weight} = -3.812 + 0.01457(\text{mage}) + 0.2752(\text{weeks}) - 0.369(\text{smoker})$
- Slope for indicator variable acts as an on-and-off switch: represents the average difference in response between the two categories
- Interpretation of $-0.369$: babies born to mothers who smoke weigh an average of $0.369$ pounds less than those born to nonsmokers, holding `mage` and `weeks` constant

## 5.7 Categorical Predictors

- For a categorical variable with $k$ possible values: model creates $k-1$ separate indicator variables
- **Baseline group** (reference group): one category is selected and hidden inside the intercept; all other slopes are comparisons against this baseline
- Example: education level with 3 categories (High School, Bachelor's Degree, Graduate Degree) → 2 indicator variables created
- Hypothetical equation (High School as baseline): $\text{Predicted Weight} = -4.05 + 0.28(\text{weeks}) + 0.15(\text{Bachelor}) + 0.22(\text{Graduate})$
  - Bachelor's slope $0.15$: infants of mothers with a Bachelor's weigh $0.15$ pounds more than those of High School-educated mothers, holding `weeks` constant
  - Graduate slope $0.22$: infants of mothers with a Graduate Degree weigh $0.22$ pounds more than the High School baseline, holding `weeks` constant
- Baseline group (High School) has no direct slope; relies on formula $-4.05 + 0.28(\text{weeks})$

## 5.8 Interactions

- **Interaction**: when the effect of one variable changes depending on the value of another variable
- Interaction term created by multiplying two variables together (e.g., `mature` $\times$ `smoker`)
- Example equation: $\text{Predicted Weight} = -3.714 + 0.01035(\text{mage}) + 0.2753(\text{weeks}) - 0.353(\text{smoker}) + 0.118(\text{mature}) - 0.125(\text{mature} \times \text{smoker})$

### The Hierarchy Rule for Main Effects

- **Hierarchy rule**: if an interaction term is included, the individual variables (**main effects**) that compose it must also be included in the model
- Cannot have `mature` $\times$ `smoker` without keeping separate `mature` and `smoker` terms; interaction loses its anchor otherwise

### Interpreting the Math

- Interaction term activates only when both conditions are met (both indicators = $1$)
- For mature smoker: receives $-0.353$ penalty for smoking, $+0.118$ adjustment for being mature, and additional $-0.125$ interaction penalty

### The Rule for p-values

- When an interaction term is present, p-values for individual main effects no longer test the overall effect; they only test the effect when the other variable equals zero
- **Rule**: if model contains an interaction term, ignore p-values for individual main effects; look only at the p-value for the interaction itself
- Example: `mature` $\times$ `smoker` interaction p-value = $0.700$ (> $0.05$, not significant) → delete interaction from model and rerun with only main effects

## 5.9 Multicollinearity

- **Multicollinearity**: disruptive overlap when two predictors bring nearly the same information; slopes become unstable and unreliable
- **Variance Inflation Factor (VIF)**: diagnostic metric for each predictor measuring overlap with other predictors
  - VIF = $1$: zero overlap
  - VIF between $1$ and $5$: mild, harmless overlap
  - VIF above $5$ (especially above $10$): severe multicollinearity; must remove one overlapping variable
- Example: predicting `weight` from both `mage` and `fage` (father's age)
  - Equation: $\text{Predicted Weight} = 6.822 - 0.00863(\text{fage}) + 0.0242(\text{mage})$
  - VIF = $1.93$: well below danger zone of $5$; model can safely distinguish between the two variables

## 5.10 Common Mistakes and Misconceptions

### The "Low $R^2$ is a Failure" Trap

- In social science/epidemiology, explaining ~$30\%$ of variation with a few survey questions is a success; remaining variation reflects natural human diversity
- Do not discard a good model because $R^2$ is low

### The Kitchen Sink Trap and Overfitting

- **Overfitting**: model becomes too complex, memorizing random noise in the specific sample rather than finding true underlying pattern; fails on new data
- **Underfitting**: model with too few predictors misses the real story (e.g., omitted variable bias)
- Goal: "Goldilocks" model — just complex enough to capture signal, simple enough to ignore noise
- Use Adjusted $R^2$ to verify whether a new variable actually improves true accuracy

### The Causation Illusion

- Cross-reference: Chapter 2 lesson on observational data
- Even with multiple predictors controlling for confounders, observational data can only prove association, not causation; unmeasured confounding factors may remain (e.g., maternal genetics, environmental pollution)

### The Autopilot Trap

- **Automated model selection**: software algorithms that add/remove predictors based solely on p-values — must be avoided
- Algorithms are blind to domain knowledge and produce nonsensical overfitted equations
- Keep predictors with strong **theoretical justification** even if their p-value is not significant; high p-value means insufficient evidence in this sample, not proof of uselessness

### The "Bigger Slope Means Bigger Impact" Fallacy

- Cannot compare raw slopes across different units; use T-Values to evaluate variable strength

### Forgetting the Baseline Group

- Categorical slopes only represent comparison against the hidden baseline group, not absolute population averages

## 5.11 Guided Analysis: The Wage Gap

- **Dataset**: `college_teacher_salary_2023.csv` — random sample of 200 postsecondary educators in the US
  - `Salary`: numerical response variable, annual pay in thousands of dollars
  - `Sex`: categorical predictor, $1 = \text{male}$, $0 = \text{female}$
  - `Age`: numerical predictor, educator's age in years
  - `PhD`: categorical predictor, $1 = \text{holds a PhD}$, $0 = \text{does not hold a PhD}$

### Step 1: The Raw Gap

- Simple regression of `Salary` on `Sex` only: slope for `Sex` = $31.43$ (males earn ~$31,427 more on average); p-value = $0.002$ (statistically significant)

### Step 2: Adding Confounders

- Multiple regression predicting `Salary` from `Sex`, `Age`, and `PhD` simultaneously to address omitted variable bias

### Step 3: Controlling for Variables in Action

- Slope for `Age`: $0.73$ (extra ~$734 per year of age)
- Slope for `PhD`: $48.55$ (extra ~$48,554 for holding a doctorate)
- Slope for `Sex` after controlling: shifted to $27.64$, p-value = $0.003$ (< $0.05$, still statistically significant)
- Interpretation: wage gap persists even when comparing educators of the exact same age and degree status

### Step 4: APA Reporting

- APA-formatted report example: "A multiple regression was conducted to predict annual teaching salary from biological sex, age, and doctoral degree status. The overall model was statistically significant, *F*(3, 196) = $18.49$, *p* < $.001$, with an Adjusted $R^2$ of $.21$. While age (*p* = $.017$) and holding a PhD (*p* < $.001$) were significant positive predictors of salary, biological sex was also a significant predictor (*p* = $.003$) when controlling for these factors."
