# Glossary

This glossary contains definitions for key terms used throughout the textbook.

| Term | Definition |
|------|------------|
| adjusted $R^2$ | A version of $R^2$ that penalizes a model for adding predictors that do not improve fit, so it can decrease when useless variables are added; preferred for comparing multiple regression models. |
| adjusted deviance $R^2$ | A version of deviance $R^2$ that penalizes the model for adding predictors, so it can decrease when useless variables are added. |
| adjusted means | Group averages recalculated by an ANCOVA as if every participant had started at the same covariate value; also called estimated marginal means. |
| algorithmic accountability | The obligation to hold algorithms and their creators responsible for the outcomes the algorithms produce, including biased or harmful decisions. |
| algorithmic bias | Systematic unfairness produced when an algorithm learns from biased historical data and applies that pattern at scale. |
| alternative hypothesis | The claim that an effect, a difference, or a relationship exists in the population, written $H_1$; this is the position the researcher is actually trying to prove, and it is accepted only when the data provide strong enough evidence. |
| analytic integrity | The obligation to analyze data honestly, deciding what to test before looking at the data and reporting all results, including null findings. |
| ANCOVA | Analysis of Covariance: a hybrid of ANOVA and regression that compares group means while adjusting for one or more continuous covariates. |
| anonymity | A privacy condition in which no one, not even the researcher, can link data back to the individual. |
| ANOVA | Analysis of Variance: a statistical test that compares the means of three or more independent groups to determine whether at least one pair differs significantly; the natural extension of the independent sample t-test. |
| area under the curve (AUC) | A summary of a model's classification performance, equal to the probability that the model ranks a randomly chosen positive case above a randomly chosen negative case; 0.5 is chance and 1.0 is perfect. |
| ARIMA | AutoRegressive Integrated Moving Average: a forecasting model that combines recent momentum, removal of trend, and correction for past shocks to project future values. |
| association | A systematic connection between two categorical variables, meaning knowing the category of one gives information about the other; the opposite of independence. |
| association metric | A standardized measure of the strength of a relationship between categorical variables, the categorical equivalent of an effect size; Phi and Cramér's V are the two primary examples. |
| autocorrelation | The correlation of a variable with its own past values, meaning observations that are close in time tend to be related. |
| automated model selection | A software procedure that adds or removes predictors automatically based on statistical criteria; useful for screening, but it can override theoretical judgment and should not be used on autopilot. |
| autoregressive (AR) | The ARIMA component that uses a series' own recent values, or momentum, to help predict the next value. |
| bar plot | A graph that displays the frequency or proportion of observations in each category using rectangular bars, with gaps between bars to signal categorical data. |
| base-10 logarithm | A logarithm using base 10, written log10; it compresses large values and is often used to linearize exponential growth. |
| baseline group | The category of a categorical predictor that is left out of the indicator variables and absorbed into the intercept; every other category is interpreted relative to it (also called the reference group). |
| between-groups variation | The part of total variation that measures how far the group averages are from one another; in ANOVA it represents the signal, or the effect of the factor. |
| between-subjects design | A design in which different participants are assigned to different groups, so comparisons are made between separate people. |
| bias | A systematic error that pushes results away from the truth in a particular direction; unlike random variability, bias does not disappear with larger sample sizes. |
| bimodal | A distribution with two distinct peaks, often signaling that two different groups are mixed together in the data. |
| bin | An interval used in a histogram to group values of a numerical variable; each bar represents one bin and its height shows how many observations fall within that range. |
| binary outcome | An outcome with exactly two possible categories, such as survived or died. |
| blocking | Converting a known nuisance variable into categorical groups (blocks) so its variation is removed from the error term, improving the comparison. |
| Bonferroni correction | A conservative post hoc method that lowers the threshold for each comparison to control the family-wise error rate; it strongly protects against Type I errors but raises the risk of Type II errors. |
| box plot | A graph that summarizes the distribution of a numerical variable using five key values (minimum, first quartile, median, third quartile, maximum), with individual points flagging potential outliers; useful for comparing distributions across categories. |
| bubble plot | A scatterplot extended to three numerical variables: two define point positions on the axes, and a third determines the size of each bubble. |
| case-control study | An observational design that selects people who already have an outcome (cases) and people who do not (controls), then looks back at past exposures; also called a retrospective design. |
| categorical variable | A variable that places each observation into a group or category; values are labels rather than quantities and do not support arithmetic operations. |
| ceiling effect | Occurs when many observations pile up at the maximum possible value, preventing detection of further differences among high performers. |
| cell | A specific subgroup created by crossing the levels of two or more factors in a factorial design. |
| censored data | Data in which you know a value exists beyond a certain threshold but do not know its exact amount (e.g., recorded as "40+"). |
| central limit theorem | The theorem that the distribution of sample means approaches a predictable bell curve as sample size grows, regardless of the shape of the original data; this is what allows t-tests to work with skewed data when the sample is large enough. |
| chi-square goodness-of-fit test | A test that compares the distribution of one categorical variable in a sample against an external baseline distribution, such as a census profile. |
| chi-square statistic | The test statistic for chi-square tests, formed by summing the squared gaps between observed and expected counts, each divided by the expected count; larger values mean the data deviate more from the null expectation. |
| chi-square test for homogeneity | A test that compares the distribution of one categorical variable across two or more separate populations to see whether the proportions are the same. |
| chi-square test for independence | A test that asks whether two categorical variables measured in a single sample are associated, using a cross-tabulation of their counts. |
| coefficient of determination | The proportion of variability in one variable that is explained by another, written $R^2$ and calculated by squaring the correlation $r$; often reported as a percentage. |
| cohen's $d$ | A standardized effect size that divides the difference between two means by the standard deviation, expressing the gap in standard-deviation units so results can be compared across studies. |
| communality | The proportion of a variable's variation that is shared with other variables because they measure the same underlying factor; also called communality. |
| component | A summary variable produced by PCA, which compresses all variance, including unique variance and measurement error, into a smaller set of dimensions. |
| confidence interval | A range of plausible values for a true population mean or difference, built from sample data; a 95% confidence interval (CI) comes from a procedure that captures the true value in about 95% of repeated samples. |
| confidentiality | A privacy condition in which the researcher can link data to participants but promises to keep their identities secret. |
| confirmatory factor analysis (CFA) | A factor analysis used when the researcher already has a theory and specifies in advance how many factors exist and which variables belong to each, then tests how well that model fits. |
| confounding factor | A third variable that influences both the predictor and the response variable, distorting the apparent relationship; also called a confounding variable. |
| confounding variable | A hidden or unmeasured factor that is linked to both the groups you are comparing and the outcome, so it can make two variables appear connected even when one does not cause the other. |
| confusion matrix | A 2 by 2 table that compares a prediction rule's yes/no calls with the actual outcomes, showing true positives, false positives, true negatives, and false negatives. |
| continuous variable | A numerical variable that can take any value within a range, limited only by measurement precision (e.g., height, weight, time). |
| control | The practice of holding outside variables constant in an experiment so they do not interfere with the results. |
| control for | To mathematically hold a variable constant in a model so that the unique effect of another predictor can be isolated. |
| control group | The group in an experiment that does not receive the treatment being tested, used as a baseline for comparison with the treatment group. |
| Cook's Distance | A measure of how much a regression model changes when one data point is removed (also called Cook's D); values above 1.0 are generally treated as highly influential. |
| correlation matrix | A table showing the correlation coefficient between every pair of variables in a set. |
| covariate | A continuous background variable included in a model to adjust for its effect, such as a baseline score. |
| Cramér's V | An association metric for categorical variables used when the cross-tabulation is larger than 2 by 2, ranging from 0 (no association) to 1 (perfect association). |
| cronbach's alpha | A statistic (written $\alpha$) that measures the internal consistency of a survey, ranging from 0 to 1; values of 0.70 or higher are generally considered acceptable in social science research. |
| cross-tabulation | A table that counts observations in each combination of categories for two categorical variables; also called a contingency table. |
| cyclical patterns | Predictable, repeating fluctuations in a time series that occur at regular intervals; in social science this is often called seasonality. |
| data governance | The overarching rules, policies, and standards that determine how data are collected, stored, and used. |
| data reduction | The goal of summarizing many observed variables with a smaller number of components or factors, without necessarily uncovering hidden constructs. |
| data stewardship | The day-to-day ethical responsibility of the individual researcher to protect and handle data properly. |
| data transformation | A mathematical change to a variable, such as a log transformation, applied to make its distribution better meet a model's assumptions. |
| data triage | The initial pass through a dataset to decide what to keep, drop, or treat as missing before formal analysis. |
| degrees of freedom | A number tied to sample size that the t-distribution uses when producing a p-value; for a single sample t-test it equals $n - 1$ and is reported in parentheses after $t$ in APA style. |
| de-identification | Removing or masking identifying details from a dataset while keeping a separate key that can link records back to individuals; not the same as anonymity. |
| descriptive statistics | Numerical summaries that describe a dataset, such as the mean, median, standard deviation, and proportion. |
| deviance | A measure of badness of fit in logistic regression, analogous to residual error; lower values mean predictions are closer to the observed outcomes. |
| deviance $R^2$ | A pseudo-$R^2$ for logistic regression that measures how much the model reduces deviance compared with a model with no predictors. |
| deviance goodness-of-fit test | A test of whether a logistic model's predicted probabilities fit the observed outcomes; unlike most tests, a large p-value is the desired result because the null hypothesis says the model fits well. |
| discrete variable | A numerical variable that takes on distinct, separate values, typically counts (e.g., number of siblings). |
| distribution | The pattern of how values of a variable are spread across its range; described by center, spread, shape, and unusual observations. |
| Dunnett's test | A post hoc test that compares several groups against one designated baseline group, saving power by skipping comparisons among the other groups. |
| effect size | A standardized number describing how large a difference or relationship is, independent of sample size, used to judge whether a statistically significant result is large enough to matter. |
| equal variance (homoscedasticity) | The assumption that the vertical spread of residuals stays roughly constant across the range of the predictor variable; a fan or cone shape signals heteroscedasticity. |
| ethics of omission | The ethical responsibility attached to decisions about which data to keep, drop, or treat as missing, because those choices determine whose experiences count. |
| expected count | The count a chi-square test would expect in a cell if the null hypothesis were true; every expected count should be at least 5 for the standard test to be trustworthy. |
| experiment | A study in which researchers deliberately manipulate one or more variables to observe the direct effect on an outcome, using control and randomization to support a cause-and-effect conclusion. |
| exploratory factor analysis (EFA) | A factor analysis used when the researcher does not know the underlying structure and lets the correlations reveal how many factors exist and which variables belong together. |
| extrapolation | Using a regression model to predict outside the range of predictor values observed in the data, which is risky because the relationship may change. |
| factor | The categorical variable that divides a sample into the groups being compared; also called the treatment variable. |
| factor analysis | A statistical method that explains correlations among observed variables by positing one or more hidden factors, separating shared communality from unique variance. |
| factorial design | A study design that crosses two or more categorical factors so that every combination of levels is represented, allowing main effects and interactions to be estimated. |
| factor level | One of the specific categories that make up a factor; also called a treatment level. |
| factor loading | A weight between -1 and 1 that measures the strength and direction of the relationship between an observed variable and a factor; loadings of about 0.40 or higher are usually treated as meaningful. |
| factor matrix | A table showing each observed variable's loadings on each extracted factor, often after rotation, along with communality and uniqueness. |
| false negative | A missed case: the prediction rule says no when the event happened. |
| false positive | A false alarm: the prediction rule says yes when the event did not happen. |
| family-wise error rate | The overall probability of making at least one Type I error across a family of comparisons; post hoc tests are designed to control it. |
| Fisher's Exact Test | A test for categorical associations designed for small samples, used when an expected count falls below 5. |
| floor effect | Occurs when many observations cluster at the minimum possible value, compressing the range of observable variation. |
| forecasting | Predicting future values of a time series from its historical patterns. |
| f-statistic | The ANOVA test statistic, calculated as the ratio of between-groups variation (signal) to within-groups variation (noise); its meaning depends on the degrees of freedom, so it is interpreted through its p-value. |
| glass's delta | An effect size that divides the difference between two group means by the control group's standard deviation, used when the two groups have different spreads. |
| global ANOVA | The overall ANOVA F-test that asks whether any group means differ, before post hoc tests identify which specific pairs differ. |
| grouping variable | A categorical variable used to divide observations into groups within a plot, often shown through different colors or shapes, so patterns can be compared across categories. |
| halo effect | A cognitive bias in which a strong positive impression in one area leads a person to rate a target favorably across unrelated categories, producing a uniform blur of correlations. |
| hedges' $g$ | A version of Cohen's $d$ with a small-sample correction, typically used when the total sample is under about 20 people and interpreted the same way as $d$. |
| histogram | A graph for a single numerical variable that groups values into adjacent bins with no gaps between bars; bar heights show how many observations fall in each bin. |
| homogeneity of regression slopes | The ANCOVA assumption that the relationship between the covariate and the response is parallel across groups, checked by testing the covariate-by-group interaction. |
| human subjects | People who participate in research and whose data or biological material are collected and analyzed. |
| hypothesis testing | A formal procedure for deciding whether an observed effect is real or could plausibly be explained by random variation, by weighing the data against a null hypothesis. |
| imputation | Replacing a missing value with a statistically estimated value so that the observation can be kept in the analysis. |
| independence | In study design, the assumption that observations do not influence one another; in categorical data, the property that knowing one variable's category gives no information about another (the opposite of association). |
| independent sample t-test | A t-test that compares the means of two separate, unrelated groups to see whether their difference is statistically significant. |
| indicator variable | A numerical variable coded 1 or 0 to represent whether an observation belongs to a category, allowing categorical predictors to enter a regression equation; also called a dummy variable. |
| influential point | A data point whose removal would noticeably change a model's slope or intercept, usually because it combines high leverage with a large residual. |
| institutional review board (IRB) | An independent committee that evaluates research protocols before a study begins to protect human subjects, keep risk minimal, and safeguard vulnerable populations. |
| integrated (I) | The ARIMA component that temporarily removes the long-term trend, usually by differencing, so cyclical patterns can be analyzed on a stable baseline. |
| interaction | A situation in which the effect of one predictor on the response variable changes depending on the value of another predictor. |
| interaction effect | The result of an interaction: the effect of one factor depends on the level of another, so its size or direction changes across groups. |
| interaction plot | A graph of group means with one line per level of a second factor; parallel lines suggest no interaction, while converging, diverging, or crossing lines suggest one. |
| internal consistency | How well the different items on a survey hang together, which a researcher must establish before adding the items into a single overall score. |
| interquartile range (IQR) | The spread of the middle 50 percent of data, calculated as Q3 minus Q1; resistant to outliers and paired naturally with the median for skewed distributions. |
| irregular movements | Random noise, sudden shocks, or anomalies in a time series that do not repeat. |
| jitter plot | A graph that randomly nudges points sideways so overlapping observations stay visible; used to compare the vertical spread of groups when checking equal variances. |
| Kruskal-Wallis Test | A nonparametric test that compares three or more independent groups by ranking all observations; the rank-based alternative to a one-way ANOVA. |
| lag | The number of time periods by which a series is shifted to compare a value with an earlier value; a lag-1 comparison pairs each week with the week before. |
| latent construct | A hidden concept, such as social appeal or socioeconomic status, that is not measured directly but is inferred from several observed variables. |
| law of diminishing returns | The pattern in which each additional unit of a predictor produces a smaller improvement in the outcome, creating a curve that rises sharply and then flattens. |
| left-skewed | A distribution whose longer tail extends toward lower values; also called negatively skewed. |
| Levene's test | A formal hypothesis test for equal group variances; the chapter recommends visual checks and the 2X rule instead, because using a test to gatekeep another test compounds error. |
| leverage | The potential a data point has to pull a regression line toward itself, which is greatest when its predictor value sits at the extreme edge of the observed range. |
| Likert scale | An ordinal survey scale, such as disagree, neutral, agree, whose categories have a clear order but unknown distances between them. |
| linear correlation | A number $r$ between -1 and 1 that measures the direction and strength of a straight-line relationship between two numerical variables; the sign gives the direction and the distance from zero gives the strength. |
| linearity | The assumption that the true relationship between two numerical variables is a straight line, checked by looking for curves in a residual plot. |
| linearize | To transform data mathematically so that a curved relationship becomes approximately straight, allowing a linear regression model to be used. |
| linear trend | The straight-line relationship between calendar time and a variable, describing its long-term trajectory rather than short-term momentum. |
| listwise deletion | Dropping every observation that has a missing value on any variable in the analysis. |
| logarithmic transformation | A transformation that takes the logarithm of a variable, compressing large values and stretching small ones; often used to linearize an exponential or diminishing-returns relationship. |
| logistic regression | A regression model for a binary outcome that estimates how predictors affect the odds of the outcome; the odds ratio is its basic building block. |
| logit | Another name for the log-odds, and the quantity a logistic regression model estimates directly. |
| log-odds | The natural logarithm of the odds of an outcome; a scale centered at zero that can be modeled with a straight line. |
| longitudinal data | Data collected from the same participants at multiple time points; the repeated observations are dependent, so a standard one-way ANOVA does not apply. |
| main effects | The individual predictors that make up an interaction term; when an interaction is included in a model, the main effects must also be included. |
| Mann-Whitney U Test | A nonparametric test that compares two independent groups by pooling and ranking all observations; requires the two distributions to have roughly the same shape. |
| margin of error | The width of a confidence interval around an estimate; a smaller margin of error means a more precise estimate, and increasing the sample size shrinks it. |
| matched pair t-test | A t-test for data in which each observation in one group is linked to a specific observation in another, such as the same person measured before and after an intervention; it tests whether the average within-pair difference is zero. |
| maximum likelihood (ML) | A factor extraction method that assumes multivariate normality and allows formal fit tests and confidence intervals; it can distort loadings when that assumption fails. |
| McNemar's test | A test for paired categorical data that compares two dependent proportions by focusing on the pairs where the two responses disagree. |
| mean | The average: add all values together and divide by the number of observations; uses every value, making it informative but sensitive to extreme values. |
| measurement error | Random noise in a measurement caused by imperfect measurement conditions, not by the construct being measured; it is part of unique variance. |
| measures of center | Numerical summaries that describe a typical or central value in a distribution, such as the mean, median, and mode; the type of data determines which measure is appropriate. |
| measures of spread | Numerical summaries that describe how spread out or variable the observations are, such as the range, interquartile range, and standard deviation. |
| median | The middle value when all observations are ordered from smallest to largest; half the data fall above it and half below, and it is resistant to outliers and skew. |
| median difference | The median of the within-pair differences in paired data, used as the center that the Wilcoxon Signed-Rank Test evaluates. |
| meta-analysis | A technique that mathematically combines the results of many independent studies on the same topic, pooling their data to build a stronger argument than any single study can. |
| minimal risk | The standard that the probability and magnitude of harm in a study are no greater than those encountered in ordinary daily life or routine tests. |
| missing at random (MAR) | Missingness that depends on other observed variables in the dataset, rather than being purely random or systematically tied to the missing value itself. |
| missing completely at random (MCAR) | Missingness that occurs with equal probability for all observations, unrelated to any variable, observed or unobserved. |
| missing not at random (MNAR) | Missingness that is systematically related to the missing value itself (e.g., low-income students less likely to report income), introducing bias that is difficult to correct. |
| modal | Refers to the number of prominent peaks in a distribution: unimodal (one peak), bimodal (two peaks), or multimodal (three or more peaks). |
| mode | The most frequently occurring value in a dataset; the only measure of center appropriate for nominal data. |
| model diagnostics | The checks researchers run to verify a model's assumptions, such as independence, mutually exclusive factor levels, normal residuals, and equal variances. |
| monotonic | A relationship that consistently moves in one direction, either upward or downward, though it may curve; it cannot reverse direction. |
| Mood's Median test | A non-parametric alternative to ANOVA used when group variances are unequal. |
| mosaic plot | A graph that displays the relationship between two categorical variables using rectangles whose areas correspond to the proportions of observations in each combination of categories. |
| moving average (MA) | The ARIMA component that adjusts forecasts for recent random shocks or irregular movements. |
| multicollinearity | Heavy overlap among predictors that makes it hard for a model to tell which variable is driving the change, producing unstable and unreliable slopes. |
| multimodal | A distribution with three or more distinct peaks. |
| multiple comparisons | Testing several hypotheses on the same data without adjusting the significance level, which inflates the family-wise error rate. |
| multiple logistic regression | A logistic regression model that predicts a binary outcome using two or more predictors at once. |
| multiple regression | A statistical method that predicts a single continuous response variable using two or more predictors at the same time. |
| mutually exclusive | A requirement that each observation belongs to exactly one level of a factor, with no overlap between groups. |
| noise | Random variation among individuals that is unrelated to the factor being studied; in ANOVA it is the within-groups variation. |
| nominal variable | A categorical variable whose categories have no natural order (e.g., eye color, country of birth). |
| nonparametric tests | Tests that do not require a normal distribution, typically by analyzing ranks instead of raw values; used for small samples, skewed data, or ordinal outcomes. |
| non-resistant measure | A statistical measure that shifts noticeably when extreme values or outliers are present; the mean is an example. |
| non-response bias | A type of bias that occurs when the people who choose not to complete a survey are fundamentally different from those who do, so the collected data do not represent the full group. |
| normal curve | The symmetric, bell-shaped curve that describes a normal distribution, with most observations clustered near the center and becoming rarer toward the tails; also called the bell curve. |
| normal distribution | A specific symmetric, unimodal "bell curve" shape common in nature and measurement data; about 68% of observations fall within one standard deviation of the mean, 95% within two, and 99.7% within three. |
| normality | In regression, the assumption that the residuals form a roughly bell-shaped distribution; the raw predictor and response variables do not need to be normal. |
| normality test | A formal hypothesis test, such as Anderson-Darling or Shapiro-Wilk, that checks whether residuals are normally distributed; a low p-value suggests non-normality, but the chapter treats these tests as a tiebreaker rather than a gatekeeper. |
| nuisance variable | A background variable that affects the outcome but is not the main focus of the study; left uncontrolled, it adds noise to the comparison. |
| null hypothesis | The default assumption of no effect, no difference, or no relationship, written $H_0$; it always uses exact equality ($=$) and stands unless the data provide strong evidence against it. |
| numerical variable | A variable that takes on values representing quantities and supports arithmetic operations (e.g., GPA, age, hours studied). |
| observational study | A study in which researchers observe individuals and measure variables of interest without manipulating the environment, recording the world as it naturally exists. |
| observed variable | A variable that is directly measured, such as a survey item, and used as an indicator of a latent construct. |
| odds | The probability of an event divided by the probability of the event not happening; odds of 4 mean four events for every one non-event. |
| odds ratio | The odds of an outcome in one group divided by the odds of the same outcome in a baseline group; the standard measure of risk in case-control studies. |
| omitted variable bias | Bias that occurs when a confounding variable is left out of a model, so the included predictor's slope absorbs the missing variable's effect and becomes inaccurate. |
| one-sided test | A hypothesis test that looks for an effect in only one direction; choosing it after seeing the data or without justification halves the p-value and is a form of p-hacking. |
| operationalization | The process of defining exactly how you will measure an abstract concept in your study, bridging a theoretical idea and the concrete data you will eventually analyze. |
| ordinal | A categorical variable whose categories have a meaningful order but unknown distances between adjacent categories. |
| ordinal logistic regression | A regression model for an ordinal outcome with three or more ranked categories. |
| ordinal variable | A categorical variable whose categories follow a meaningful ranking (e.g., education level, satisfaction rating), though distances between adjacent categories are not necessarily equal. |
| outlier | A data point that strays far from the pattern set by the rest of the data, often producing a large residual in a regression model. |
| overfitting | A modeling failure in which a model becomes so complex that it memorizes random noise in the sample instead of the true underlying pattern. |
| paired data | Observations that come in linked pairs, such as two people in the same interaction or the same person measured twice; standard chi-square tests assume independent observations, so paired categorical data require McNemar's test. |
| parameter | A numerical summary that describes an entire population; usually fixed but unknown, estimated from sample statistics. |
| Pareto chart | A bar plot for categorical data with bars sorted from most to least frequent, often combining rare categories into a single "Other" bar so the largest categories stand out. |
| parsimony | The principle that the simplest model that explains the data well is preferred, avoiding unnecessary complexity. |
| partitioning variation | The ANOVA process of splitting total variation into between-groups variation (signal) and within-groups variation (noise). |
| percentile | The percentage of observations that fall below a given value; for example, scoring at the 90th percentile means you scored higher than 90% of the comparison group. |
| p-hacking | Running many tests or model variations on the same data until a p-value below .05 appears, which inflates the Type I error rate and is an ethical violation. |
| Phi ($\phi$) | An association metric for a 2 by 2 cross-tabulation, ranging from 0 (no association) to 1 (perfect association). |
| point estimate | A single predicted value produced by plugging a specific predictor value into a regression equation; in regression it estimates the mean response for all observations with that predictor value. |
| population | The entire group of individuals or observations you want to draw conclusions about. |
| post hoc test | A follow-up comparison run after a significant ANOVA to identify which specific groups differ while controlling the family-wise error rate; also called post hoc analysis. |
| power analysis | The process of calculating, before a study begins, the sample size needed to detect an effect of a given size with a chosen level of statistical power. |
| power curves | A graph showing how statistical power rises as sample size increases, with separate curves for different effect sizes. |
| practical significance | Whether an effect is large enough to matter in practice, judged from an effect size or confidence interval rather than from a p-value alone. |
| predicted probability | The model's estimated probability that a specific observation has the outcome, produced by converting the logit back to a 0-to-1 scale. |
| prediction interval | A range that is likely to contain the response value for a single new observation at a given predictor value; it is wider than a confidence interval for the mean because individuals vary more than averages. |
| predictor variable | A variable used to predict or explain the response variable in a regression model; also called an independent variable. |
| principal axis factoring (PAF) | A factor extraction method that makes few distributional assumptions and is the usual choice for ordinal survey data in exploratory factor analysis. |
| principal components analysis (PCA) | A data reduction method that compresses all variance, including unique variance and measurement error, into components; it does not separate shared communality from noise. |
| proportion | The fraction of observations falling into a given category; commonly reported for two-category categorical variables (e.g., 80 out of 200 = 0.40 or 40%). |
| proportion of variance | The share of total variance explained by a factor or component, used to judge how much each one contributes. |
| protocol | A detailed plan submitted to an Institutional Review Board that describes the research question, participants, consent process, and data protection; approval is required before data collection begins. |
| proxy variable | A measurable characteristic that stands in for an unobservable or difficult-to-measure concept. |
| p-value | The probability of seeing data at least as surprising as yours if the null hypothesis were true; a small p-value means the data would be unusual under $H_0$ and counts as evidence against it. |
| Q-Q plot | A plot that compares observed residuals with the values expected under a normal distribution; points that hug the diagonal line support normality, and it is treated as equivalent to a normal probability plot. |
| quartile | Values that divide a dataset into four equal parts: Q1 (25th percentile), Q2 (the median, 50th percentile), and Q3 (75th percentile). |
| randomization | The random assignment of subjects or treatments in an experiment so that unavoidable natural differences are spread evenly across groups, keeping hidden biases from skewing the results. |
| rare events rule | The guideline that a logistic regression needs roughly 10 to 15 occurrences of the least common outcome for each predictor, so rare outcomes require larger samples. |
| receiver operating characteristic (ROC) curve | A plot of sensitivity against the false positive rate across all possible decision thresholds, used to compare classification models. |
| relative risk | The probability of an outcome in one group divided by the probability of the same outcome in a baseline group; intuitive for cohort studies but not valid for case-control designs. |
| reliability | The consistency of a measurement: a reliable tool gives you the same result every time you measure the same phenomenon under the same conditions. |
| reliable estimator | An estimator whose values cluster close to the true parameter across repeated samples. |
| repeated measures ANOVA | An ANOVA for a within-subjects design in which the same participants are measured at multiple time points or conditions, so each person serves as their own baseline. |
| replication | Conducting an experiment on a large enough number of subjects so that the results are not just a statistical fluke. |
| research goal | A general statement about the phenomenon you want to understand; broad and directional, but usually too abstract to test directly. |
| research question | A specific, measurable relationship between defined variables that you can observe and record, narrowed down from a broad research goal. |
| residual | The difference between an observed value and the value predicted by a model, so a positive residual means the model underpredicted and a negative residual means it overpredicted. |
| residual plot | A graph with the predictor variable on the horizontal axis and the residuals on the vertical axis, used to check for curves, unequal spread, and structural patterns that a straight-line model would miss. |
| resistant measure | A statistical measure not strongly influenced by extreme values or outliers; the median is an example. |
| response variable | The variable a regression model is trying to predict, traditionally plotted on the vertical axis; it must be a true numerical measurement. |
| right-skewed | A distribution whose longer tail extends toward higher values; also called positively skewed. |
| rotation | A mathematical adjustment of factor axes that maximizes high loadings and minimizes low ones, producing a clearer simple structure without changing the underlying communality. |
| sample | A subset of a population, the portion from which you collect data. |
| sample size | The number of observations in a sample, usually written $n$; larger samples reduce random error and increase statistical power. |
| scatterplot | A graph that displays the relationship between two numerical variables by placing each observation as a point; used to assess direction, form, and strength of the relationship. |
| scree chart | A line graph of the variance explained by each successive factor, used to choose how many factors to keep by locating the elbow where the curve flattens. |
| segmented bar chart | A chart that compares two categorical variables by giving each group a bar of equal height (100%) divided into segments showing the proportion in each category of the second variable; also called a 100% stacked bar chart. |
| selective group analysis | Testing many subgroups and reporting only the significant ones, a form of p-hacking that hides the failed tests. |
| sensitivity | The true positive rate: the percentage of actual events that a prediction rule correctly catches. |
| signal | The portion of variation that reflects the real effect being studied, such as differences between group means; in ANOVA it is the between-groups variation. |
| significance level | The threshold of evidence, written $\alpha$ and usually set at .05, that a researcher requires before rejecting the null hypothesis. |
| significance stars | Symbols such as `*`, `**`, and `***` placed next to coefficients in journal tables to mark p-values below common thresholds (.05, .01, and .001). |
| Sign Test | A flexible nonparametric test for paired data that compares the direction of within-pair differences; used when the Wilcoxon symmetry assumption fails. |
| simple structure | A clean factor pattern in which each observed variable loads strongly on one factor and weakly on the others. |
| single sample t-test | A t-test that compares the mean of one sample against a known, fixed benchmark, such as a national average or a clinical cutoff. |
| skewness | The extent to which a distribution is asymmetric, with a longer tail extending toward one side; right-skewed distributions trail toward high values and left-skewed distributions toward low values. |
| slope | The rate of change in a regression model: the predicted change in the response variable for each one-unit increase in the predictor variable. |
| Spearman's Rho | A nonparametric correlation that ranks both variables before correlating them, measuring the strength of a monotonic relationship; also used for ordinal data. |
| specificity | The true negative rate: the percentage of actual non-events that a prediction rule correctly ignores. |
| specific variance | Variation that is real and systematic but unique to a single observed variable, not shared with other variables; part of unique variance. |
| standard deviation | A measure of how much individual values typically deviate from the mean; small values indicate tight clustering, large values indicate wide scattering. |
| standard error | The typical amount by which a sample statistic is expected to vary from sample to sample because of random chance; it is the denominator of the t-statistic. |
| standardized residual | A cell's contribution to a chi-square test, scaled so that values beyond about plus or minus 2 indicate a significant over- or under-representation. |
| statistic | A numerical summary calculated from sample data; varies from sample to sample because different samples contain different individuals. |
| statistically significant | A result is statistically significant when its p-value is below the chosen significance level, meaning the data provide enough evidence to reject the null hypothesis. |
| statistical power | The probability that a study will detect a true effect if one exists; it is the complement of a Type II error, and researchers generally aim for at least 80%. |
| statistical question | A formal question that (1) requires gathering data, (2) accounts for natural variability from sample to sample, and (3) names the specific statistical measure you will use to compare groups. |
| summated scale | A measurement tool that asks several different, targeted questions about the same concept and then combines the responses into a single overall score. |
| symmetric | A distribution whose left half mirrors its right half; if folded at the center, both sides would line up closely. |
| three-way ANOVA | An ANOVA that tests three categorical factors at once, producing three main effects, three two-way interactions, and one three-way interaction; powerful but hard to interpret. |
| time series analysis | The analysis of data collected in chronological order, breaking it into trend, cyclical patterns, and irregular movements so the series can be understood and forecast. |
| time series plot | A line chart with time on the horizontal axis and the measured variable on the vertical axis, preserving the chronological order of the data. |
| total variation | The overall spread among all observations in a dataset before it is split into between-groups and within-groups parts. |
| transparency | The practice of openly publishing methods, models, and analytical steps so outside experts can audit and reproduce the work. |
| treatment | The specific condition or category that distinguishes the groups being compared, whether researchers assign it or it occurs naturally. |
| treatment group | The subset of participants who fall into one particular level of a factor. |
| trend | The long-term, overarching direction of a time series, meaning whether its baseline is generally rising, falling, or stable. |
| true negative | A correct rejection: the prediction rule says no and the event did not happen. |
| true positive | A hit: the prediction rule says yes and the event happened. |
| truncated data | Data in which observations beyond a certain threshold are excluded entirely and never appear in the dataset (e.g., only enrolling students who scored above 70). |
| t-statistic | A signal-to-noise ratio calculated by dividing the gap between a sample result and the hypothesized value by the standard error; software converts it into a p-value. |
| t-test | A family of hypothesis tests for comparing means, including the single sample, matched pair, and independent sample versions. |
| Tukey's HSD | A post hoc test that compares every pair of group means while controlling the family-wise error rate; the standard choice when all pairwise comparisons matter. |
| t-value | A predictor's slope divided by its standard error, used as a rough measure of signal strength; another name for the t-statistic. |
| two-way ANOVA | An ANOVA that tests the effects of two categorical factors at once, including their main effects and interaction. |
| type I error | A false alarm (a false positive): rejecting the null hypothesis when it is actually true; the significance level sets the rate at which this error occurs. |
| type II error | A missed signal (a false negative): failing to reject the null hypothesis when a real effect exists, often because the study lacked enough evidence or statistical power to detect it. |
| unimodal | A distribution with one clear peak; the most common shape encountered in practice. |
| unique variance | The proportion of a variable's variation that is not shared with other variables, made up of specific variance and measurement error; also called uniqueness. |
| validity | Whether a measurement actually captures what you claim it is measuring; a measure can be reliable (consistent) yet still invalid if it is not measuring the intended concept. |
| variance | A measure of spread equal to the average squared deviation from the mean; ANOVA partitions this variability into between-groups and within-groups parts. |
| variance inflation factor (VIF) | A diagnostic for multicollinearity that measures how much a predictor's variance is inflated by its overlap with other predictors; values above 5 signal dangerous overlap. |
| vulnerable populations | Groups whose ability to give free and informed consent may be compromised, such as prisoners, children, or students under institutional pressure. |
| welch's t-test | A version of the independent sample t-test that adjusts the degrees of freedom when the two groups have unequal variances, producing a more trustworthy p-value. |
| Wilcoxon Signed-Rank Test | A nonparametric test for paired data that compares the median difference by ranking the within-pair differences; requires the differences to be roughly symmetric. |
| within-groups variation | The part of total variation that measures the random differences among individuals inside the same group; in ANOVA it represents the noise. |
| within-subjects design | A design in which the same participants are measured under multiple conditions or time points, so comparisons are made within each person. |
| y-intercept | The predicted value of the response variable when the predictor variable equals zero; it anchors the regression line as a baseline. |
| zero-inflated | A distribution with a large pile of zeros and a small number of high values, so the mean is pulled away from the typical observation. |

: Definitions of key terms used throughout the book.
