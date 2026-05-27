# **Statistical Methods in Research**

# **Unit I: Foundations of Data Analysis**

## **Chapter 1: Understanding Data through Measures and Visualizations**

- **Data Basics**: Categorical vs. Numerical variables.

- **Visualizing Single Variables**:

  - Categorical Data: Bar plots, Pareto charts.
  - Quantitative Data: Histograms.

- **Distribution Shapes and The Normal Curve**:

  - Skewness, symmetry, uni- and multi-modal shapes.
  - Normality as a "bell curve" and what it implies about the concentration of data.
  - Matching the Measure to the Shape - resistance and sensitivity, median vs mean.

- **Visualizing Relationships**:
  - Two numerical variables: Scatterplots.
  - Two categorical variables: Mosaic plots.
  - Mixed/Complex data: Box plots (categorical vs numerical), bubble plots (three numeric), and grouping variables (e.g., red triangles vs. blue dots on a scatterplot).

- **Describing Single Variables Numerically**:

  - **Measures of center:** Mean, median, mode, proportion.

  - **Measures of spread and position:** Standard deviation, quartiles, percentiles.

- **Populations and Samples**: The distinction between Parameters and Statistics.
- **Data Triage and Realities**:

  - Missing data and bias (e.g., non-random missing income data).
  - Censored or truncated data, ceiling and floor effects.

## **Chapter 2: From Research Questions to Formal Hypotheses**

- **The Scientific Process**: Formulating a clear research goal and research question.
- **Operationalization of Variables and Proxy Variables:** Turning abstract concepts into measurable survey questions or metrics
- **Measurement Quality**: Reliability and Validity of the chosen metrics.
- **Methods of Data Gathering**:
  - Observational Studies: Principles, brief notes on survey design, and bias.
  - Experimental Design: Randomization, replication, and control.
- **Translating Research into Statistics**: From a Research Question to a Statistical Question.
- **Identifying Parameters**: Using the variables of interest (categorical vs. numerical, skewed vs. symmetric) to determine the correct parameter.
- **Formalizing Hypotheses**:
  - Null and Alternative Hypotheses.
  - How to choose which is which (Null = no relationship/effect).
  - Using the identified parameters to correctly state the hypotheses.

## **Chapter 3: Hypothesis Testing and Effect Sizes**

- **The Core Concept**: What is Hypothesis Testing? Why do we care? (Signal vs. Noise).
- **The Framework of Evidence**:
  - Conceptual explanation of the p-value as a measure of evidence in favor of the alternative hypothesis.
  - Significance level ($\alpha$) as the required standard of evidence.
- **Errors in Decision Making**:
  - Type I errors: The primary thing to avoid and why that's important in research.
  - Type II errors and Statistical Power.
  - Power analysis and sample size determination (using GUI tools to plan a study).
- **Foundations of the *t* - Test**:
  - Visual intuition behind the Central Limit Theorem.
  - Requirements for a valid test (Normality checks as confirming the data fits the tool).
- **Choosing the Right Tool**: Revisiting Chapter 2's data gathering methods to choose the correct *t*-test (Single vs. Paired vs. Independent).
- **Post Hoc Analysis for t Tests:**
  - The difference between "statistically significant" and "practical significance." Low p-value means a large amount of evidence for an effect, not evidence of a large effect.
  - The difference between establishing an effect (hypothesis testing) and establishing the strength of the effect (CI or effect size).

- **Single Sample *t*-tests**:
  - Mechanics, confidence intervals for the mean.
  - The Directionality Debate: Why we prefer two-sided tests in scientific research, and how unjustified one-sided tests are common in p-hacking.
  - Reporting results in APA format (t-statistic, df, p-value, CI).
- **Matched Pair *t*-tests**:
  - Confidence intervals for the mean difference.
  - Reporting in APA.
- **Independent Sample *t*-tests**:
  - Confidence Intervals for Differences in Means.
  - Handling unequal variances (Welch's test as the default).
  - Reporting in APA.
- **Beyond the p-value: Effect Sizes**:
  - Effect Sizes as Post Hoc Analysis: Cohen's *d*, Hedges' *g*, Glass' Delta.
  - How to choose between reporting Confidence Intervals and Effect Sizes.


------

# **Unit II: Linear Regression and Transformations**

## **Chapter 4: Simple Linear Regression and Correlation**

- **First Things First**: Linear correlation ($r$) and the coefficient of determination ($R^2$).
- **Reliability in Measurement**: Cronbach's alpha.
- **Foundations of Modeling**: The Four-Step Modeling Process (Choose a form, fit to data, assess accuracy, and use for inference).
- **Fitting the Model**: Interpreting the regression slope and intercept, connecting coefficients to real-world economic and psychological outcomes.
- **Model Diagnostics**: Assessing linearity, independence, and homoscedasticity through visual residual analysis.
- **The Anomalies**: Handling outliers and influential points.
- **Transformations**:
  - Understanding logarithms as a visual "scaling" tool for skewed social science data.
  - Re-expressing variables (response $y$ or predictor $x$) to meet model conditions.

## **Chapter 5: Multiple Regression for Complex Systems**

- **Adding Predictors**: Using multiple variables to account for confounding factors in social research.
- **The Core Concept**: What "controlling for" a variable actually means in practice.
  - **Omitted Variable Bias**: why we must add predictors to get accurate slopes.
- **Evaluating Predictors**: Comparing the strength of effects (using slope divided by standard error as a rough proxy).
- **Categorical Predictors**: Integrating binary variables (like treatment vs. control) into regression models using indicator/dummy variables.
- **Model Complexities**:
  - **Interactions**: Understanding how social variables influence one another.
  - **Multicollinearity**: What happens when predictors overlap, and how to spot it with VIF.


------

# **Unit III: Design of Experiments (ANOVA)**

## **Chapter 6: The One-Way ANOVA**

- **The Core Concept**: Partitioning variation (Within-groups vs. Between-groups).
- **Fitting the One-Way Model**: Assessing differences between multiple categorical treatment groups.
- **Model Diagnostics**: Validating the underlying assumptions of ANOVA (independence, mutually exclusive factor levels, normality of residuals, equal variances).
- **Post Hoc Analysis**: Multiple comparisons.
  - Tukey's HSD, Hsu's MCB, and Dunnett's test.

## **Chapter 7: Advanced Experimental Designs**

- **Reducing Variation**: The concept of Blocking (grouping subjects with similar characteristics).
- **Two-Way ANOVA**: Analyzing two categorical factors and their interactions.
  - **Visualizing Interactions:** interaction plots.
- **ANCOVA (Analysis of Covariance)**:
- **Correlated Data**: Repeated Measures ANOVA (handling pre-test/post-test designs).
- **Advanced Structural Concepts**:
  - Fixed vs. Random Effects (when levels are fixed choices vs. a random sample).
  - Nesting and Hierarchy (when levels of one factor are unique to a level of another).


------

# **Unit IV: Categorical Data Analysis**

## **Chapter 8: Analyzing Relationships in Categorical Data**

- **Single Variable Patterns**: Goodness-of-Fit tests for checking distribution patterns against expected frequencies.  
- **Two Variable Relationships**: Chi-Square Tests for association and independence.
- **The Small Sample Exception**: Fisher's Exact Test for small sample sizes.  
- **Quantifying the Relationship**: Measuring Dependence to understand the strength of the relationship between discrete social variables.  

## **Chapter 9: Logistic Regression**

- **The Core Concept**: Introduction to Binary Outcomes and modeling yes/no results.

- **The Math (Conceptually)**: The Logit Link, explaining how we use logs to connect categorical outcomes to quantitative predictors.  

- **Interpretation**: Odds Ratios, and how to interpret the likelihood of an event occurring in social science contexts.  

- **Model Diagnostics**: Assessing Fit to evaluate the accuracy of logistic models for decision-making.  

  

  

------

# **Unit V: Advanced Tools and Ethical Considerations** 

## **Chapter 10: Nonparametric Tests**

- **The Core Concept**: When to use nonparametrics (handling non-normality, small sample sizes, ordinal data, and situations where the median is of primary importance).
- **Measuring Correlation**: Spearman's Rho.
- **Alternatives to the \*t\*-test**: Mann-Whitney U, Wilcoxon Signed-rank, and the Sign test.
- **Alternatives to ANOVA**: The Kruskal-Wallis test.

## **Chapter 11: Factor Analysis**

- **The Purpose**: Identifying unspecified, latent groups/factors within survey data.
- **The Great Debate**: Why Principal Components Analysis (PCA) is not ideal in comparison to true Factor Analysis.
  - PCA is notoriously the default extraction method in many drop-down software menus, so this ends up being a "software trap" for new students. PCA is strictly a data reduction technique that ignores underlying commonalities, whereas Factor Analysis reveals latent factors.
- **Extraction Methods**: Maximum Likelihood and Principal Axis Factoring.
- **Implementation**: Exploratory vs. Confirmatory analysis.
- **Visualizing Factors**: Using Scree Charts to identify a reasonable number of factors.
- **Revisiting Cronbach's Alpha**: Researchers often run a Factor Analysis to ensure a survey is measuring one construct, and then use Cronbach's Alpha to measure its reliability.

## **Chapter 12: Time Series Analysis**

- **The Purpose**: Identifying trends, cyclical patterns, and irregular movements.  
- **Visualizing Time**: Time Series Plots.
- **The Independence Violation**: Understanding Autocorrelation.
- **Forecasting**: A conceptual introduction to ARIMA models.

## **Chapter 13: Ethics in Statistics and Data Integrity**

- **The Infrastructure of Ethics**: Data governance and data stewardship.

- **The Institutional Review Board**: A behind-the-curtain look at why we have it, what protocols are, and how they are actually evaluated. Defining "minimal risk," "human subjects," and "vulnerable populations."

- **Data Security**: Privacy concerns in human subjects research, and clearly distinguishing between anonymity and confidentiality.  

- **Algorithmic Accountability**: Bias in algorithms and the promotion of transparency.  

- **The Ethics of Omission**: Data triage, listwise deletion, handling missing responses, and a conceptual nod to imputation.  

- **Analytic Integrity**: The mechanics of p-hacking. Exploring unjustified one-sided tests, selective group analysis, failing to adjust significance levels for multiple comparisons, and using massive sample sizes to "find" non-existent practical effects.  

  

  
