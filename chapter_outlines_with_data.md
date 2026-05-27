# **Statistical Methods in Research: Curricular Outline** 

---

# **Unit I: Foundations of Data Analysis** 

## **Chapter 1: Understanding Data through Measures and Visualizations** 

* **Motivating Dataset:** `student_lifestyle_sleep.csv` 


* 
  **Data Basics**: Categorical vs. Numerical variables. 


* 
*Application:* Distinguishing between categorical variables like `DepressionStatus` or `AlcoholUse` and numerical variables like `GPA` or `WeekdaySleep`.


* **Visualizing Single Variables**: 


* Categorical Data: Bar plots, Pareto charts. 


* 
*Application:* Plotting frequency distributions of student academic standings (`ClassYear`).


* Quantitative Data: Histograms. 


* 
*Application:* Constructing histograms for cumulative semester grade point averages (`GPA`).


* **Distribution Shapes and The Normal Curve**: 


* Skewness, symmetry, uni- and multi-modal shapes. 


* Normality as a "bell curve" and what it implies about the concentration of data. 


* Matching the Measure to the Shape - resistance and sensitivity, median vs mean. 


* 
*Application:* Analyzing the shape of `ClassesMissed` (typically right-skewed) versus `WeekdaySleep` (more symmetric) to evaluate how outliers affect the mean relative to the median.


* **Visualizing Relationships**: 


* Two numerical variables: Scatterplots. 


* 
*Application:* Charting `GPA` against `WeekdaySleep`.


* Two categorical variables: Mosaic plots. 


* 
*Application:* Cross-tabulating `Stress` levels against `AlcoholUse` tiers.


* Mixed/Complex data: Box plots (categorical vs numerical), bubble plots (three numeric), and grouping variables (e.g., red triangles vs. blue dots on a scatterplot). 


* 
*Application:* Generating parallel box plots of `GPA` split across `AnxietyStatus` categories, or a grouped scatterplot of sleep vs. GPA color-coded by `Gender`.


* **Describing Single Variables Numerically**: 


* 
**Measures of center:** Mean, median, mode, proportion. 


* 
**Measures of spread and position:** Standard deviation, quartiles, percentiles. 


* Populations and Samples: The distinction between Parameters and Statistics. 


* 
*Application:* Calculating summary statistics for `Drinks` per week to define sample parameters.


* **Data Triage and Realities**: 


* Missing data and bias (e.g., non-random missing income data). 


* Censored or truncated data, ceiling and floor effects. 


* 
*Application:* Discussing potential self-reporting floor effects on zero-consumption variables like `ClassesMissed`.



## **Chapter 2: From Research Questions to Formal Hypotheses** 

* **Motivating Dataset:** `labor_market_discrimination.csv` 
* **Secondary Dataset:** `amas_math_anxiety.csv`


* 
  **The Scientific Process**: Formulating a clear research goal and research question. 


* 
*Application:* Investigating whether systemic racial discrimination manifests within corporate hiring pipelines.


* **Operationalization of Variables and Proxy Variables:** Turning abstract concepts into measurable survey questions or metrics 


* 
*Application:* Exploring how the original researchers operationalized perceived racial identity by randomly manipulating first names on resumes (e.g., "Greg" vs. "Jamal").


* **Measurement Quality**: Reliability and Validity of the chosen metrics. Introduce **internal consistency** as a core requirement for survey data.

  *Application:* Computing Cronbach's alpha across the nine item-level variables (`item_1` through `item_9`) in `amas_math_anxiety.csv`. We demonstrate how researchers validate a **summated scale** before collapsing individual questions into a single composite score.

* **Measurement Quality**: Reliability and Validity of the chosen metrics. 


* *Application:* Assessing callback status (`call`) as a valid measure of initial labor market interest.
* **Reliability in Measurement**: Cronbach's alpha. 


* *Application (Switch to `hsb.csv`):* Computing Cronbach's alpha across the 5 standardized educational test metrics (`read`, `write`, `math`, `science`, `socst`) to establish scale reliability before building predictive models.


* **Methods of Data Gathering**: 


* Observational Studies: Principles, brief notes on survey design, and bias. 


* Experimental Design: Randomization, replication, and control. 


* 
*Application:* Contrasting standard observational employment surveys against this randomized field experiment framework.


* **Translating Research into Statistics**: From a Research Question to a Statistical Question. 


* 
**Identifying Parameters**: Using the variables of interest (categorical vs. numerical, skewed vs. symmetric) to determine the correct parameter. 


* 
*Application:* Realizing the outcome of interest is categorical (`call`), pointing toward population proportions ($p$) as the target parameter.


* **Formalizing Hypotheses**: 


* Null and Alternative Hypotheses. 


* How to choose which is which (Null = no relationship/effect). 


* Using the identified parameters to correctly state the hypotheses. 


* *Application:* Writing formal statements comparing the true callback rates of White-sounding names ($\pi_W$) and Black-sounding names ($\pi_B$), setting $H_0: \pi_W = \pi_B$.




* ## **Chapter 3: Hypothesis Testing and Effect Sizes** * **Motivating Dataset:** `depression_diet_treatment.csv`

  ### **3.1 The Core Concept & The Framework of Evidence**

  - **The Core Concept**: What is Hypothesis Testing? Why do we care? (Signal vs. Noise).
  - Conceptual explanation of the $p$-value as a measure of evidence in favor of the alternative hypothesis.
  - Significance level ($\alpha$) as the required standard of evidence.

  ### **3.2 Errors in Decision Making**

  - Type I errors: The primary thing to avoid and why that's important in research.
  - Type II errors: Conceptual definition and the stakes of missing a true effect.
  - *Application:* Discussing the ethical stakes of Type I and Type II errors when evaluating clinical depression protocols using the $n = 75$ student cohort.

  ### **3.3 Foundations of the $t$-Test**

  - Visual intuition behind the Central Limit Theorem.
  - Requirements for a valid test (Normality checks as confirming the data fits the tool).

  ### **3.4 Choosing the Right Tool**

  - Revisiting Chapter 2's data gathering methods (observational vs. experimental) to choose the correct $t$-test (Single vs. Paired vs. Independent).

  ### **3.5 Single Sample $t$-tests**

  - Mechanics, confidence intervals for the mean.
  - Reporting results in APA format ($t$-statistic, $df$, $p$-value, CI).
  - *Application:* Testing whether the baseline student sample's mean `CESD1` score differs significantly from a known clinical severity benchmark.

  ### **3.6 Matched Pair $t$-tests**

  - Confidence intervals for the mean difference.
  - Reporting in APA format.
  - *Application:* Analyzing within-subject improvements over time by running a paired test on baseline versus post-intervention depression metrics (`CESD1` vs. `CESD21`), using the pre-calculated `CESDDiff` variable.

  ### **3.7 Independent Sample $t$-tests**

  - Confidence Intervals for Differences in Means.
  - Handling unequal variances (Welch's test as the default).
  - Reporting in APA format.
  - *Application:* Comparing `CESDDiff` scores across the independent `Group` factor levels (Diet vs. Control) to see if the intervention outpaced normal lifestyle shifts.

  ### **3.8 Beyond the $p$-value: Practical Significance and Effect Sizes**

  - The difference between "statistically significant" and "practical significance." Low $p$-value means a large amount of evidence for an effect, not evidence of a large effect.
  - The difference between establishing an effect (hypothesis testing) and establishing the strength of the effect (CI or effect size).
  - Effect Sizes as Post Hoc Analysis: Cohen's $d$, Hedges' $g$, Glass' Delta.
  - *Application:* Calculating Cohen's $d$ for the diet intervention's impact to weigh practical behavioral significance against statistical significance.

  ### **3.9 Power Analysis**

  - Statistical Power and sample size determination.
  - Using GUI tools to plan a study.

  ### **3.10 Guided Analysis**

  - **The Research Interest:** Exploring the broader context of young adult mental health, poor dietary habits, and whether accessible lifestyle shifts can move the needle on clinical depression markers.
  - **The Research Question:** Does a 21-day healthy diet intervention significantly improve depression symptoms compared to typical dietary habits? (Variables: `Group` and `CESDDiff`).
  - **Data Triage and Exploratory Analysis:** Checking the `CESDDiff` distribution for extreme outliers or severe skewness that might violate the $t$-test assumptions. Using comparative box plots to visually assess the initial difference between the Diet and Control groups.
  - **Formal Analysis:** Executing the independent samples $t$-test (Welch's) and calculating Cohen's $d$. Presenting the summary statistics (Means, Standard Deviations) alongside the test statistics ($t$, $df$, $p$, 95% CI).
  - **Conclusion:** Translating the statistical output into a formal APA-formatted conclusion that directly answers the research question in plain English.









---

# **Unit II: Linear Regression and Transformations** 

## **Chapter 4: Simple Linear Regression and Correlation** 

* **Primary Motivating Dataset:** `happy_planet_index_2024.csv` 


* 
  **First Things First**: Linear correlation ($r$) and the coefficient of determination ($R^2$). 


* *Application:* Mapping the raw correlation between a country's economic baseline (`GDPperCapita`) and its health outcomes (`LifeExpectancy`).


* **Foundations of Modeling**: The Four-Step Modeling Process (Choose a form, fit to data, assess accuracy, and use for inference). 

  * A conceptual warning regarding ordinal variables. We explain that while a composite scale score can serve as a continuous response variable ($y$), a single, isolated Likert question cannot.



* 
**Fitting the Model**: Interpreting the regression slope and intercept, connecting coefficients to real-world economic and psychological outcomes. 


* 
*Application:* Modeling the Ladder of Life (`LOL`) subjective well-being score using per capita ecological foot printing metrics (`Footprint`).


* **Model Diagnostics**: Assessing linearity, independence, and homoscedasticity through visual residual analysis. 


* 
*Application:* Evaluating global model diagnostics to look for structural changes across geographic boundaries (`Region`).


* **The Anomalies**: Handling outliers and influential points. 


* *Application:* Pinpointing country-level outliers (e.g., micro-states or extreme economic anomalies) that pull heavily on the regression line.


* 
**Transformations**: 


* Understanding logarithms as a visual "scaling" tool for skewed social science data. 


* Re-expressing variables (response $y$ or predictor $x$) to meet model conditions. 


* *Application:* Applying a natural log transformation to the heavily right-skewed `GDPperCapita` variable to satisfy model assumptions.

## **Chapter 5: Multiple Regression for Complex Systems** 

* **Motivating Dataset:** `births_2014.csv` 


* 
  **Adding Predictors**: Using multiple variables to account for confounding factors in social research. 


* 
*Application:* Modeling neonatal birth weight (`weight`) by checking maternal age (`mage`), total prenatal hospital visits (`visits`), and gestational duration (`weeks`).




* 
**The Core Concept**: What "controlling for" a variable actually means in practice. 


* 
**Omitted Variable Bias**: why we must add predictors to get accurate slopes. 


* *Application:* Observing the structural shift in demographic predictors when the crucial confounding variable `weeks` is left out of the model.




* 
**Evaluating Predictors**: Comparing the strength of effects (using slope divided by standard error as a rough proxy). 


* 
**Categorical Predictors**: Integrating binary variables (like treatment vs. control) into regression models using indicator/dummy variables. 


* 
*Application:* Introducing maternal tobacco habits (`habit`) as an indicator variable ($1 = \text{smoker}$, $0 = \text{nonsmoker}$) to assess its impact on birth weight while controlling for medical covariates.




* 
**Model Complexities**: 


* 
**Interactions**: Understanding how social variables influence one another. 


* 
*Application:* Evaluating whether the negative impact of maternal smoking (`habit`) varies based on clinical age maturity categories (`mature`).




* 
**Multicollinearity**: What happens when predictors overlap, and how to spot it with VIF. 


* 
*Application:* Spotting variance inflation when simultaneously including parental demographic metrics like biological father's age (`fage`) and mother's age (`mage`).









---

# **Unit III: Design of Experiments (ANOVA)** 

## **Chapter 6: The One-Way ANOVA** 

* **Motivating Dataset:** `hsb.csv` 
* **What Do We Mean by Experimental Design?**
  * Preliminary vocabulary - response variable, factor or treatment variable, factor or treatment levels, treatment groups.
* What is an ANOVA? Why call it analysis of "variance"? (Note SD has been defined already, but not variance. Maybe just leave it as a measure of variability.)
  * What designs lead to ANOVA?
  * Statisticians think of this as comparing means across different subgroups or treatments. Is the mean writing score the same in each program track?  Researchers often think of this as looking for a relationship between a categorical variable and a numerical variable. Does the choice of program track have an effect on writing scores?



* **Partitioning variation** (Within-groups vs. Between-groups). Keep it intuitive - no math definitions of partitioning and variances.
* **Why not Independent Sample t Tests?**

  * Compare and Contrast to Welch's t test from Chapter 3



* **Fitting the One-Way Model**: Assessing differences between multiple categorical treatment groups. 


* *Application:* Assessing structural variation in standardized writing performance scores (`write`) across three student tracking programs (`prog`: general, academic, or vocational).


* **Model Diagnostics**: Validating the underlying assumptions of ANOVA:

  * independent samples - why does it matter?
  * mutually exclusive factor levels - we need observations to fall into one and only one group
  * normality of residuals (clarify that despite what intro textbooks say, we do not need normality of data in each group - that is sufficient but not necessary)

    * Histograms - number of bars changes shape so tread carefully
    * Anderson-Darling or Shapiro-Wilk - binary result. Very low p-values suggest non-normality, but high p-values do not mean normally distributed.
    * Probability plot - probably best diagnostic, but takes some time to build intuition.
    * Rule of thumb for all of these: instead of assuming it's non-normal unless you're convinced it is normal, assume it is normal unless you're convinced it's not. ANOVA is mildly robust with mild skew or deviations from classic bell shape, so this way of thinking will allow us to conduct our research while still avoiding egregious issues.

  * equal variances 

    * Suggestion - use jitter plot to visually check instead of a hypothesis test. Using a test to see if you can run a test is problematic. Stick to intuition on that about inability to control Type I or Type II errors like we are claiming.
    * ANOVA is mildly robust - if the largest SD is no more than double the smallest SD, there is likely no cause for concern. (Actually it's 7X for variance, but this is an easier rule of thumb.)

  * What to do when these checks fail: longitudinal data (not independent) - repeated measures, mutually exclusive - probably a redesign of the data gathering method is thebest choice, normality - Kruskall-Wallis, equal variances - Mood's test



* *Application:* Evaluating variance equality and residual patterns across the three program tracks using box plots and diagnostic checks.
* Circling back - assuming model is valid, what conclusion can we make?  At least one pair of factor levels shows a significant difference in means. Pretty vague - so we need post hoc




* **Post Hoc Analysis**: Multiple comparisons and controlling for Type I errors. 


  * Tukey's HSD, Hsu's MCB, and Dunnett's test. 
  * Post hoc to the post hoc - these will identify which pairs of factor levels show a difference.


  * *Applications:* Implementing Tukey's HSD to pinpoint which program tracks differ, and using Dunnett's test treating the "general" track as the baseline comparison control group.




## **Chapter 7: Advanced Experimental Designs** 

* **Primary Motivating Dataset:** `maid_mindset.csv` 


* **Two-Way ANOVA**: Analyzing two categorical factors and their interactions. 
* **Reducing Variation**: The concept of Blocking (grouping subjects with similar characteristics). 


* 
**Visualizing Interactions:** interaction plots. 


* 
*Application:* Evaluating the shift in post-intervention systolic blood pressure (`Syst2`) across experimental categories (`Cond`) and an engineered categorical factor representing subject age blocks.




* 
  **ANCOVA (Analysis of Covariance)**: 

* *Application:* Modeling post-intervention blood pressure (`Syst2`) across experimental conditions (`Cond`) while explicitly including baseline systolic blood pressure (`Syst`) as a continuous covariate.

  


* **Repeated Measures ANOVA** (handling pre-test/post-test designs). 

* **Longitudinal Data**

* *Application:* Tracing within-subject shifts from baseline body mass index (`BMI`) to post-intervention index levels (`BMI2`) across the 4-week timeline.

  


* 
**Advanced Structural Concepts**: 


* Fixed vs. Random Effects (when levels are fixed choices vs. a random sample). 


* Nesting and Hierarchy (when levels of one factor are unique to a level of another). 


* 
*Application:* Discussing why hotel location would be treated as a random hierarchical effect if maids were sampled across different hotel chains.







---

# **Unit IV: Categorical Data Analysis** 

## **Chapter 8: Analyzing Relationships in Categorical Data** 

* **Primary Motivating Dataset:** `fatal_police_shootings.csv` 


* **Secondary Low-Cell Dataset:** `college_backpacks.csv` 


* 
  **Single Variable Patterns**: Goodness-of-Fit tests for checking distribution patterns against expected frequencies. 


* 
*Application:* Comparing the observed racial distribution (`race`) within the tracking database against general U.S. Census Bureau baseline population weights.




* 
**Two Variable Relationships**: Chi-Square Tests for association and independence. 


* 
*Application:* Evaluating whether a systematic relationship exists between subjects' flight behaviors (`flee`) and the active deployment of officer body cameras (`body_camera`).




* 
**The Small Sample Exception**: Fisher's Exact Test for small sample sizes. 


* 
*Application (Switch to `college_backpacks.csv`):* Attempting to cross-tabulate self-reported back discomfort status (`BackProblems`) against enrollment levels (`Status`: Graduate vs. Undergraduate). Because graduate students make up a tiny segment of the sample, cells drop below 5, forcing the transition to Fisher's Exact Test.




* 
**Quantifying the Relationship**: Measuring Dependence to understand the strength of the relationship between discrete social variables. 


* 
*Application:* Calculating tracking metrics (like Phi or Cramér's $V$) to evaluate the strength of connection between weapon categories (`armed`) and overall threat indicators (`threat_level`).



## **Chapter 9: Logistic Regression** 

* **Motivating Dataset:** `icu_data.csv` 


* 
  **The Core Concept**: Introduction to Binary Outcomes and modeling yes/no results. 


* 
**The Math (Conceptually)**: The Logit Link, explaining how we use logs to connect categorical outcomes to quantitative predictors. 


* 
*Application:* Building a model to predict the log-odds of binary patient survival to hospital discharge (`Survive`).




* 
**Interpretation**: Odds Ratios, and how to interpret the likelihood of an event occurring in social science contexts. 


* 
*Application:* Transforming logistic coefficients into Odds Ratios to gauge the survival odds of elective versus emergency admissions (`Emergency`), or for changes in physiological metrics like heart rate (`Pulse`).




* 
**Model Diagnostics**: Assessing Fit to evaluate the accuracy of logistic models for decision-making. 


* 
*Application:* Constructing confusion matrices, assessing sensitivity/specificity trade-offs, and calculating classification accuracy metrics for patient outcomes.







---

# **Unit V: Advanced Tools and Ethical Considerations** 

## **Chapter 10: Nonparametric Tests** 

* **Primary Non-Normal Datasets:** `cc_risk.csv` & `weight_loss_incentive.csv` 


* **Secondary Sizing Dataset:** `student_lifestyle_sleep.csv` 


* **The Core Concept**: When to use nonparametrics. We focus on handling non-normality, small sample sizes,  situations where medians are the preferred measure over means due to outliers or extreme skew, and individual ordinal items where calculating a standard mean is mathematically invalid.


* 
**Measuring Correlation**: Spearman's Rho. 


* *Application (Using `cc_risk.csv`):* Evaluating the connection between `Age` and alcohol use tracking indices (`DaysDrink`), which exhibit severe right-skewness and zero-inflation.




* 
**Alternatives to the $t$-test**: Mann-Whitney U, Wilcoxon Signed-rank, and the Sign test. 


* 
*Application (Using `cc_risk.csv`):* Running a Mann-Whitney U test to compare the distributions of `DaysDrink` across biological sexes (`Sex`).


* 
*Application (Using `weight_loss_incentive.csv`):* Utilizing the small sample size ($n = 38$) to run a Wilcoxon Signed-Rank test tracking variations between active intervention weight loss metrics and unmonitored follow-up metrics (`WeightLoss` vs. `Month7Loss`).




* **Alternatives to ANOVA**: The Kruskal-Wallis test and Mood's Test. 

  * Similarities and differences



* *Application (Kruskal-Wallis):* Utilizing `student_lifestyle_sleep.csv` to compare continuous grade point averages (`GPA`) across the ordered categories of `AlcoholUse` (Abstain, Light, Moderate, Heavy). This highlights how to analyze an ordinal variable without forcing it into a parametric tool.



## **Chapter 11: Factor Analysis** 

* **Motivating Dataset:** `speed_dating.csv` 


* 
  **The Purpose**: Identifying unspecified, latent groups/factors within survey data. 


* 
*Application:* Discovering hidden evaluative concepts underlying partner rating metrics.




* 
**The Great Debate**: Why Principal Components Analysis (PCA) is not ideal in comparison to true Factor Analysis. 


* PCA is notoriously the default extraction method in many drop-down software menus, so this ends up being a "software trap" for new students. 


* PCA is strictly a data reduction technique that ignores underlying commonalities, whereas Factor Analysis reveals latent factors. 


* 
*Application:* Having students run a parallel drop-down analysis using both options on the six partner rating variables (`Attractive`, `Sincere`, `Intelligent`, `Fun`, `Ambitious`, `SharedInterests`) to show how true Factor Analysis isolates latent constructs like "Social Appeal" versus "Socioeconomic Status," whereas PCA simply compresses variance.




* 
**Extraction Methods**: Maximum Likelihood and Principal Axis Factoring. 


* 
**Implementation**: Exploratory vs. Confirmatory analysis. 


* 
**Visualizing Factors**: Using Scree Charts to identify a reasonable number of factors. 


* **Revisiting Cronbach's Alpha**: Connect factor extraction directly to scale validation. Researchers use factor analysis to isolate hidden concepts, and then use alpha to confirm each tracking cluster is reliable.


* *Application:* Extracting factors via a visual Scree analysis, then computing Cronbach's Alpha on the variables loading onto those factors to verify item cluster reliability. Clarify how the data is Likert scale and how that affects our analysis.





## **Chapter 12: Time Series Analysis** 

* **Motivating Dataset:** `gym_membership_searches.csv`
* 
**The Purpose**: Identifying trends, cyclical patterns, and irregular movements. 


* *Application:* Tracing how public interest in fitness shifts over a five-year window, isolating long-term trends from recurring seasonal behavior.


* 
**Visualizing Time**: Time Series Plots. 


* *Application:* Transitioning students from standard histograms to continuous line charts to track the popularity index of the search term `gym membership` across weekly dates (`Week`).


* 
**The Independence Violation**: Understanding Autocorrelation. 


* *Application:* Proving why regular linear regression assumptions fail by demonstrating how a high search volume in week $t$ directly relates to the search volume in week $t+1$.


* 
**Forecasting**: A conceptual introduction to ARIMA models. 


* *Application:* Introducing structural models to predict search baseline variations heading into the next winter peak.





## **Chapter 13: Ethics in Statistics and Data Integrity** 

* **Motivating Dataset:** None Required (Conceptual & Structural Framework Focus).
* 
**The Infrastructure of Ethics**: Data governance and data stewardship. 


* 
**The Institutional Review Board**: A behind-the-curtain look at why we have it, what protocols are, and how they are actually evaluated. 


* Defining "minimal risk," "human subjects," and "vulnerable populations." 


* 
**Data Security**: Privacy concerns in human subjects research, and clearly distinguishing between anonymity and confidentiality. 


* 
**Algorithmic Accountability**: Bias in algorithms and the promotion of transparency. 


* 
**The Ethics of Omission**: Data triage, listwise deletion, handling missing responses, and a conceptual nod to imputation. 


* **Analytic Integrity**: The mechanics of p-hacking. Exploring unjustified one-sided tests, selective group analysis, failing to adjust significance levels for multiple comparisons, and using massive sample sizes to "find" non-existent practical effects.
