# Chapter 1 Summary: Understanding Data through Measures and Visualizations

## Running Example / Dataset
- **Dataset**: `student_lifestyle_sleep.csv` — data from 253 college students over one semester
- **Variables used throughout the chapter**:
  - `WeekdaySleep`: numerical, average weekday sleep hours
  - `WeekendSleep`: numerical, average weekend sleep hours
  - `GPA`: numerical, cumulative GPA (capped at 4.0)
  - `ClassesMissed`: numerical, total lectures missed during the semester
  - `ClassYear`: categorical ordinal (1=First Year, 2=Sophomore, 3=Junior, 4=Senior)
  - `DepressionStatus`: categorical ordinal (Normal, Moderate, Severe)
  - `AnxietyStatus`: categorical ordinal (Normal, Moderate, Severe)
  - Additional variables referenced: `Stress` (Normal/High), `AlcoholUse` (Abstain/Light/Moderate/Heavy), `Drinks` (weekly alcoholic drinks count)

## Topics Covered

### 1.2 Categorical vs. Numerical Variables
- **Categorical variables**: place individuals into groups; subdivided into:
  - **Nominal**: no natural order (e.g., college major, favorite color)
  - **Ordinal**: categories with a natural logical order (e.g., `ClassYear`, `AlcoholUse`)
- **Numerical variables**: measurable quantities where math is meaningful (e.g., `GPA`, `WeekdaySleep`)
- Variable type dictates which statistical tools and visualizations are appropriate

### 1.3 Visualizing Single Categorical Variables
- **Bar plot**: rectangular bars for each category; height = frequency; gaps between bars signal distinct categories; ordinal variables should keep natural order (not sorted by height)
  - Example: bar plot of `DepressionStatus` (Normal, Moderate, Severe)
- **Pareto chart**: bar plot for nominal data with many categories; bars sorted descending left-to-right; rare trailing categories combined into "Other"
  - Example: reasons for visiting a tutoring/STEM resource center

### 1.4 Visualizing Single Numerical Variables
- **Histogram**: groups numerical data into continuous bins (ranges); bars touch (no gaps) to represent continuity on the number line
  - Example: histogram of `WeekdaySleep` with 1-hour bin widths, peaking around 7–8 hours

### 1.5 Distribution Shapes and The Normal Curve
- **Unimodal**: single peak; **bimodal**: two peaks
- **Symmetric distribution**: left and right sides mirror each other
- **Normal curve** (bell curve): symmetric, data concentrated at center, tails fade evenly in both directions; many natural human traits follow this shape
- **Skewness**:
  - **Right-skewed** (positively skewed): tail extends to the right; associated with a **floor effect** (data piles up at a hard lower limit)
    - Example: `ClassesMissed` — peak at zero/one, long right tail for students who missed 10–15 classes
  - **Left-skewed** (negatively skewed): tail extends to the left; associated with a **ceiling effect** (data piles up at an upper limit)
    - Example: exam scores capped at 100%
- Shape concepts also apply intuitively to ordinal variables (e.g., grade distributions in different class sections)

### 1.6 Visualizing Relationships: Two Numerical Variables
- **Scatterplot**: each observation is a dot; x-axis and y-axis represent two numerical variables; used to detect trends (upward, downward, or no pattern)
  - Example: `ClassesMissed` (x-axis) vs. `GPA` (y-axis); shows negative trend — more missed classes associated with lower GPA

### 1.7 Visualizing Relationships: Two Categorical Variables
- **Segmented bar chart** (100% stacked bar chart): each group gets an equal-height bar divided into colored segments by a second variable; used to compare proportions across groups
  - Example: `AlcoholUse` within `Stress` levels (Normal vs. High)
  - Drawback: hides actual group sizes
- **Mosaic plot**: segmented bar chart adjusted so column widths reflect true group sizes; width = group size, height = rate within group, area = proportion of total sample
  - Example: `Stress` and `AlcoholUse`; "Normal" stress column wider than "High"

### 1.8 Visualizing Relationships: Mixed and Complex Data
- **Box plot** (box-and-whisker): compares a numerical variable across categorical groups; box = middle 50%, line inside = median, whiskers extend to extremes
  - Example: side-by-side box plots of `GPA` by `DepressionStatus` (Normal, Moderate, Severe)
- **Grouped scatterplot**: adds a third categorical variable via color/shape encoding
  - Example: `ClassesMissed` vs. `GPA` with dots colored/shaped by `Stress` level
- **Bubble plot**: scatterplot where dot size encodes a third numerical variable
  - Example: `WeekdaySleep` (x) vs. `GPA` (y), bubble size = weekly `Drinks`

### 1.9 Measures of Center
- **Proportion** (categorical): fraction/percentage in a specific category; always between 0 and 1
  - Example: 38 out of 253 students with severe depression → proportion = 0.15 (15%)
- **Mode** (categorical): most frequent category
- **Median** (numerical): exact middle value when sorted; resistant to outliers/skew
  - Example context: `Drinks` variable — extreme values (20+ drinks/week) do not affect the median
- **Mean** (numerical): sum of all values divided by count; sensitive to outliers but uses all data
  - Example calculation: mean of weekday sleep hours [7, 6, 8, 7, 7] = 35/5 = 7 hours
  - Mean is superior for calculating totals/aggregates (e.g., forecasting tax revenue from per-person average)
- Summary table (Figure 1.12): which measure of center to use by data type

### 1.10 Measures of Spread and Position
- **Standard deviation**: paired with the mean; measures typical distance of data points from the mean; small = tightly clustered, large = widely scattered
- **Percentiles**: position of a value relative to the group (e.g., 90th percentile = scored higher than 90%)
- **Quartiles**: Q1 = 25th percentile, Q2 = 50th percentile (= median), Q3 = 75th percentile
- **Interquartile Range (IQR)**: Q3 − Q1; measures spread of the middle 50%; resistant to outliers/skew; paired with the median
- Box plot visual mapping: box edges = Q1 and Q3, line inside = median, box length = IQR

### 1.11 Matching Measures to Shape (The Golden Rule)
- **Symmetric distribution** → report mean + standard deviation
- **Skewed or has outliers** → report median + IQR
- Mean is a more reliable estimator than the median because it uses all data points; sample means cluster more tightly around the true population value across repeated samples

### 1.12 Populations and Samples
- **Population**: entire group of interest (e.g., "all undergraduate college students in the United States")
- **Sample**: smaller subset actually studied (n = 253)
- **Parameter**: numerical summary describing the entire population; almost always unknown
- **Statistic**: numerical summary calculated from the sample; known exactly
- Mnemonic: S**a**mples → S**t**atistics, P**o**pulations → P**a**rameters
- Notation (Figure 1.13):
  - N = population size, n = sample size
  - μ = population mean, x̄ = sample mean
  - σ = population standard deviation, s = sample standard deviation
  - π = population proportion, p = sample proportion

### 1.13 Complications of Real-Life Data
- **Missing data and bias**: missing values may be random (safe to delete) or systematic (introduces bias); example: students with failing GPAs intentionally skipping the GPA question → artificially high mean
- **Floor effect**: data piles up at a hard minimum; creates right-skew (e.g., `ClassesMissed` cannot go below zero)
- **Ceiling effect**: data piles up at a hard maximum; creates left-skew (e.g., `GPA` capped at 4.0)
- **Censored data**: exact values hidden above/below a threshold (e.g., survey checkbox "10 or more" drinks — know the minimum but not the exact count)
- **Truncated data**: certain values excluded entirely by study design (e.g., sleep-in students missing an early-morning consent form are cut from the sample)

### 1.14 Common Mistakes and Misconceptions
- Averaging numerical labels that are actually category codes (e.g., averaging major codes 1–4 produces nonsense)
- Confusing bar plots (categorical, gaps between bars) with histograms (numerical, touching bars)
- Blindly using mean/standard deviation on skewed data without checking distribution shape first
