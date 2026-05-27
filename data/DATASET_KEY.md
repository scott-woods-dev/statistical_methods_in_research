# Statistical Methods in Research Dataset Documentation

# Dataset: `acs_2023.csv`

## Description
This dataset contains demographic, economic, and lifestyle information from a sample of individuals living in the United States, drawn from the 2023 American Community Survey.

## Format
A comma-separated values (`.csv`) file containing **10,000 observations** (rows) and **9 variables** (columns).

### Variable Dictionary

| Variable Name     | Data Type   | Description and Coding Keys                                  |
| :---------------- | :---------- | :----------------------------------------------------------- |
| `Sex`             | Categorical | The individual's sex ($1 = \text{male}$, $0 = \text{female}$). |
| `Age`             | Numerical   | The individual's age in years.                               |
| `Married`         | Categorical | Marital status ($1 = \text{married}$, $0 = \text{not married}$). |
| `Income`          | Numerical   | Total wages and salary earned over the past 12 months, recorded in thousands of dollars (e.g., a value of $50$ means $\$50,000$). |
| `HoursWk`         | Numerical   | The average number of hours the individual works per week.   |
| `Race`            | Categorical | The individual's racial identity (**Asian**, **Black**, **White**, or **Other**). |
| `USCitizen`       | Categorical | Citizenship status ($1 = \text{citizen}$, $0 = \text{noncitizen}$). |
| `HealthInsurance` | Categorical | Health insurance coverage status ($1 = \text{have health insurance}$, $0 = \text{no health insurance}$). |
| `Language`        | Categorical | Primary language spoken at home ($1 = \text{English spoken at home}$, $0 = \text{other}$). |

---

## Details
The American Community Survey (ACS) is an ongoing demographics survey administered by the United States Census Bureau. It is distributed annually to a random sample of approximately 3.5 million households, representing about 3% of all U.S. households. The Census Bureau eventually makes a heavily anonymized 1% random sample of all U.S. residents available to the public. To create this specific dataset, a random sub-sample of $n = 10,000$ individuals was drawn directly from the publicly available 2023 ACS data.

---

## Source
United States Census Bureau. (2023). *American Community Survey*. https://www.census.gov/programs-surveys/acs





# Dataset: `amas_math_anxiety.csv`

## Description

This dataset contains individual item-level responses measuring mathematics anxiety using the 9-item Abbreviated Mathematics Anxiety Scale (AMAS). The subjects are a large sample of adult workers evaluating their subjective tension and anxiety across various academic and testing scenarios.

## Format

A comma-separated values (`.csv`) file containing **2,200 observations** (rows) and **9 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `item_1`          | Numerical     | Subjective anxiety rating when having to use the tables in the back of a math book, recorded on a $1 \text{ to } 5$ scale where a value of $1$ indicates low anxiety and $5$ indicates high anxiety. |
| `item_2`          | Numerical     | Subjective anxiety rating when thinking about an upcoming math test one day before, recorded on a $1 \text{ to } 5$ scale where a value of $1$ indicates low anxiety and $5$ indicates high anxiety. |
| `item_3`          | Numerical     | Subjective anxiety rating when watching a teacher work an algebraic equation on the blackboard, recorded on a $1 \text{ to } 5$ scale where a value of $1$ indicates low anxiety and $5$ indicates high anxiety. |
| `item_4`          | Numerical     | Subjective anxiety rating when taking an examination in a math course, recorded on a $1 \text{ to } 5$ scale where a value of $1$ indicates low anxiety and $5$ indicates high anxiety. |
| `item_5`          | Numerical     | Subjective anxiety rating when being given a homework assignment of many difficult problems due the next class meeting, recorded on a $1 \text{ to } 5$ scale where a value of $1$ indicates low anxiety and $5$ indicates high anxiety. |
| `item_6`          | Numerical     | Subjective anxiety rating when listening to a lecture in a math class, recorded on a $1 \text{ to } 5$ scale where a value of $1$ indicates low anxiety and $5$ indicates high anxiety. |
| `item_7`          | Numerical     | Subjective anxiety rating when listening to another student explain a math formula, recorded on a $1 \text{ to } 5$ scale where a value of $1$ indicates low anxiety and $5$ indicates high anxiety. |
| `item_8`          | Numerical     | Subjective anxiety rating when being given a "pop" quiz in a math class, recorded on a $1 \text{ to } 5$ scale where a value of $1$ indicates low anxiety and $5$ indicates high anxiety. |
| `item_9`          | Numerical     | Subjective anxiety rating when starting a new chapter in a math book, recorded on a $1 \text{ to } 5$ scale where a value of $1$ indicates low anxiety and $5$ indicates high anxiety. |

## Details

This dataset represents baseline psychological profiling measurements collected as part of a major within-study comparison research project conducted by academic researchers in 2022. A sample of $n = 2,200$ participants was recruited via the Amazon Mechanical Turk crowdsourcing platform. The primary purpose of the original study was to create a high-quality empirical benchmark database to evaluate how well non-experimental causal effect estimation methods replicate the findings of randomized controlled trials within educational training settings. Before participating in any educational intervention exercises, respondents completed the full 9-item Abbreviated Mathematics Anxiety Scale (AMAS) to capture variations in baseline quantitative anxiety. The AMAS is widely implemented in psychometric literature because it efficiently captures two distinct but correlated dimensions of quantitative stress: math evaluation anxiety (items 2, 4, 5, and 8) and math learning anxiety (items 1, 3, 6, 7, and 9).

## Source

Hopko, D. R., Mahadevan, R., Bare, R. L., & Hunt, M. K. (2003). The Abbreviated Math Anxiety Scale (AMAS): Construction, validity, and reliability. *Assessment*, 10(2), 178–182. [https://doi.org/10.1177/1073191103010002008](https://www.google.com/search?q=https://doi.org/10.1177/1073191103010002008&authuser=1)

Keller, B., Park, S., & Zhang, J. (2022). *A new four-arm within-study comparison: Design, implementation, and data*. Working paper/dataset documentation.

# Dataset: `births_2014.csv`

## Description

This dataset contains physical, demographic, and behavioral health metrics for a sample of infants and their expectant mothers, extracted from national birth registry records compiled across the United States in 2014.

## Format

A comma-separated values (`.csv`) file containing **1,000 observations** (rows) and **13 variables** (columns). Each row tracks a single live birth event.

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `fage`            | Numerical     | The biological father's age in years.                        |
| `mage`            | Numerical     | The biological mother's age in years.                        |
| `mature`          | Categorical   | Clinical maturity status classification of the mother (e.g., **younger mom** or **mature mom**). |
| `weeks`           | Numerical     | Total gestational length of the pregnancy recorded in weeks. |
| `premie`          | Categorical   | Gestational maturity classification of the infant at birth (**full-term** or **premie**). |
| `visits`          | Numerical     | The total number of prenatal medical or hospital visits made by the mother during the pregnancy. |
| `gained`          | Numerical     | Total physical weight gained by the mother during the pregnancy, measured in pounds. |
| `weight`          | Numerical     | The final birth weight of the infant, measured in pounds.    |
| `lowbirthweight`  | Categorical   | Clinical birth weight classification ($1 = \text{low birthweight}$, $0 = \text{not low birthweight}$). |
| `sex`             | Categorical   | The biological sex assigned to the infant at birth (**female** or **male**). |
| `habit`           | Categorical   | Tobacco smoking status of the mother during pregnancy (**nonsmoker** or **smoker**). |
| `marital`         | Categorical   | Marital status of the mother at the time of delivery (**married** or **not married**). |
| `whitemom`        | Categorical   | Racial identity classification of the mother (**white** or **not white**). |

------

## Details

Every year, the United States government compiles and releases an extensive administrative database detailing every recorded birth nationwide. This repository serves as a foundational resource for epidemiological and medical researchers studying how parental demographics, maternal healthcare utilization, and behavioral choices (such as tobacco use) correlate with neonatal outcomes like gestational duration and infant birth weight.

This dataset represents a random sample of $n = 1,000$ cases extracted from the massive 2014 national natality public-use file.

------

## Source

United States Department of Health and Human Services, Centers for Disease Control and Prevention, National Center for Health Statistics. (2016). *Natality Detail File, 2014 United States* (ICPSR 36461-v1). Inter-university Consortium for Political and Social Research. [https://doi.org/10.3886/ICPSR36461.v1](https://www.google.com/search?q=https://doi.org/10.3886/ICPSR36461.v1&authuser=1)

# Dataset: `cc_risk.csv`

## Description

This dataset contains academic survey data from a sample of undergraduate students, focusing on the intersection of risky behavioral habits and problematic personal financial decisions.

## Format

A comma-separated values (`.csv`) file containing **437 observations** (rows) and **4 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Age`             | Numerical     | The student's age in years.                                  |
| `Sex`             | Categorical   | The student's biological sex ($1 = \text{female}$, $0 = \text{male}$). |
| `DaysDrink`       | Numerical     | The number of days the student consumed alcohol within the past 30 days. |
| `Overdrawn`       | Categorical   | Financial risk marker indicating whether the student overdrew their checking account within the past year ($1 = \text{yes}$, $0 = \text{no}$). |

------

## Details

The data was collected via a comprehensive, 150-question survey distributed to 437 undergraduate students enrolled in large introductory courses at either Mississippi State University or the University of Mississippi.

The primary objective of the original study was to examine the relationships between psychological sensation-seeking traits, behavioral risk-taking (such as alcohol consumption habits), and problematic financial management behaviors among young adults (such as credit card misuse and bank account mismanagement). 

------

## Source

Worthy, S. L., Jonkman, J. N., & Blinn-Pike, L. (2010). Sensation-seeking, risk-taking, and problematic financial behaviors of college students. *Journal of Family and Economic Issues*, 31(2), 161–170. [https://doi.org/10.1007/s10834-010-9183-2](https://www.google.com/search?q=https://doi.org/10.1007/s10834-010-9183-2&authuser=1)

# Dataset: `census_at_school.csv`

## Description

This dataset contains a wide range of physical, behavioral, and demographic measurements from a sample of high school seniors in the state of Pennsylvania, collected during the 2023 and 2024 academic years.

## Format

A comma-separated values (`.csv`) file containing **500 observations** (rows) and **35 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Year`            | Categorical   | The year the student submitted their data (**2023** or **2024**). |
| `Gender`          | Categorical   | The individual's gender (**Female** or **Male**).            |
| `Age`             | Numerical     | The student's age in years.                                  |
| `Hand`            | Categorical   | The student's dominant hand (**Left**, **Right**, or **Both**). |
| `Height`          | Numerical     | The student's height measured in centimeters.                |
| `Foot`            | Numerical     | The student's foot length measured in centimeters.           |
| `Armspan`         | Numerical     | The student's armspan measured in centimeters.               |
| `Languages`       | Numerical     | The number of languages the student speaks fluently.         |
| `GetToSchool`     | Categorical   | Main mode of transportation used to get to school (**Bus**, **Car**, or **Walk**—where Walk includes bicycles and skateboards). |
| `TravelTime`      | Numerical     | The time it takes the student to travel to school, recorded in minutes. |
| `ReactionTime`    | Numerical     | The time, in seconds, it takes the student to click a button when a visual color changes during an online test. |
| `MemoryScore`     | Numerical     | The score achieved by the student in a standard online memory card-matching game. |
| `Activity`        | Categorical   | The student's self-reported favorite physical activity or sport. |
| `Music`           | Categorical   | The student's favorite genre of music.                       |
| `BirthMonth`      | Categorical   | The month the student was born.                              |
| `Season`          | Categorical   | The student's favorite season (**Autumn**, **Spring**, **Summer**, or **Winter**). |
| `Allergies`       | Categorical   | Whether the student has known allergies (**Yes** or **No**). |
| `Vegetarian`      | Categorical   | Whether the student follows a vegetarian diet (**Yes** or **No**). |
| `FavFood`         | Categorical   | The student's favorite food category.                        |
| `FavDrink`        | Categorical   | The beverage the student consumes most often during the day. |
| `FavSubject`      | Categorical   | The student's favorite academic subject in school.           |
| `Sleep1`          | Numerical     | The typical number of hours of sleep the student gets on a school night. |
| `Sleep2`          | Numerical     | The typical number of hours of sleep the student gets on a non-school night (weekends/holidays). |
| `Occupants`       | Numerical     | The total number of people living in the student's primary home. |
| `Communicate`     | Categorical   | The method the student uses most often to communicate with friends (e.g., Text, FaceTime, In-Person). |
| `TextsSent`       | Numerical     | The estimated number of text messages the student sent during the previous day. |
| `HangHours`       | Numerical     | The total number of hours the student spent hanging out with friends over the last week. |
| `HWHours`         | Numerical     | The total number of hours the student spent doing homework over the last week. |
| `VideoGameHours`  | Numerical     | The total number of hours the student spent playing video/computer games over the last week. |
| `ComputerHours`   | Numerical     | The total number of hours the student spent using a computer for non-gaming purposes over the last week. |
| `TVHours`         | Numerical     | The total number of hours the student spent watching TV/streaming services over the last week. |
| `WorkHours`       | Numerical     | The total number of hours the student spent working at a paid job over the last week. |
| `SchoolPressure`  | Categorical   | The student's subjective assessment of the amount of pressure they feel due to schoolwork (e.g., None, Very Little, Some, A Lot). |
| `Superpower`      | Categorical   | The superpower the student desires most (**Fly**, **Freeze time**, **Invisibility**, **Super strength**, or **Telepathy**). |
| `Preference`      | Categorical   | The life outcome the student would prefer most if they could only choose one (**Famous**, **Happy**, **Healthy**, or **Rich**). |

------

## Details

Census at School is an ongoing, international classroom project hosted in the United States by the American Statistical Association (ASA). The initiative is designed to engage students in grades 4 through 12 in statistical problem-solving by having them securely submit their own anonymous data to a national database, which can then be sampled for educational use.

This specific dataset represents a random sample of $n = 500$ high school seniors from the state of Pennsylvania who participated in the program across the 2023 and 2024 collection periods. It provides an excellent real-world playground for analyzing multivariate data, exploring outliers, and comparing categorical preferences against numerical lifestyle choices.

------

## Source

American Statistical Association. (2024). *U.S. Census at School Program*. Retrieved from https://ww2.amstat.org/censusatschool/





# Dataset: `college_backpacks.csv`

## Description

This dataset contains physical and academic measurements from a sample of college students, collected to investigate the relationship between backpack weights, student body weights, and the prevalence of self-reported back problems.

## Format

A comma-separated values (`.csv`) file containing **100 observations** (rows) and **9 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `BackpackWeight`  | Numerical     | The weight of the student's backpack, measured in pounds.    |
| `BodyWeight`      | Numerical     | The body weight of the student, measured in pounds.          |
| `Ratio`           | Numerical     | The weight of the backpack divided by the student's body weight (e.g., a value of $0.10$ means the backpack weighs exactly 10% of the student's body weight). |
| `BackProblems`    | Categorical   | Self-reported history of back issues or discomfort ($1 = \text{experiences back problems}$, $0 = \text{no back problems}$). |
| `Major`           | Categorical   | The student's academic major field of study.                 |
| `Year`            | Numerical     | The number of years of college the student has completed.    |
| `Sex`             | Categorical   | The biological sex of the student (**Female** or **Male**).  |
| `Status`          | Categorical   | The academic enrollment level of the student (**G** = Graduate student, **U** = Undergraduate student). |
| `Units`           | Numerical     | The total number of academic credits/units the student is currently enrolled in for the semester. |

------

## Details

Are heavy text books, laptops, and binders physically harming college students? To explore this question, a team of researchers conducted a campus-wide survey at California Polytechnic State University (San Luis Obispo) in 2002. They sampled 100 students, recording both the physical strain variables (backpack weight, body weight, and back health status) and relevant academic covariates (units taken, major, and class standing).

The data was originally published to provide statistics students with a realistic, multivariate playground for studying proportions, analyzing correlation between continuous physical traits, and evaluating whether a higher backpack-to-bodyweight ratio is significantly associated with health complaints like chronic back pain.

------

## Source

Mintz, J., Mintz, J., Moore, K., & Schuh, K. (2002). Oh, my aching back! A statistical analysis of backpack weights. *Stats: The Magazine for Students of Statistics*, 32, 17–19.

# Dataset: `college_teacher_salary_2023.csv`

## Description

This dataset contains annual salary, demographic, and educational data for a sample of postsecondary educators in the United States, extracted from the 2023 American Community Survey.

## Format

A comma-separated values (`.csv`) file containing **200 observations** (rows) and **4 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Salary`          | Numerical     | The individual's annual salary from teaching, recorded in thousands of dollars (e.g., a value of $85$ means $\$85,000$). |
| `Sex`             | Categorical   | The individual's biological sex ($1 = \text{male}$, $0 = \text{female}$). |
| `Age`             | Numerical     | The individual's age in years.                               |
| `PhD`             | Categorical   | Doctoral degree attainment status ($1 = \text{holds a PhD or equivalent terminal degree}$, $0 = \text{does not hold a PhD}$). |

------

## Details

This dataset is a random sample of $n = 200$ postsecondary teachers subsetted from the 2023 American Community Survey (ACS) 1-year Public Use Microdata Sample (PUMS), which is compiled and managed by the United States Census Bureau.

------

## Source

United States Census Bureau. (2023). *American Community Survey 1-Year Public Use Microdata Sample (PUMS)*. Retrieved from https://www.census.gov/programs-surveys/acs/data/pums.html

# Dataset: `depression_diet_treatment.csv`

## Description

This dataset contains results from a randomized controlled experiment tracking the impact of a short-term, three-week healthy diet intervention on depression symptoms and body mass index (BMI) among young adults.

## Format

A comma-separated values (`.csv`) file containing **75 observations** (rows) and **10 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Group`           | Categorical   | The experimental group assignment for the student (**Control** or **Diet**). |
| `CESD1`           | Numerical     | Centre for Epidemiological Studies Depression (CESD) score measured at baseline on Day 1. High scores indicate greater depression severity. |
| `CESD21`          | Numerical     | Centre for Epidemiological Studies Depression (CESD) score measured at the conclusion of the study on Day 21. |
| `CESDDiff`        | Numerical     | The change in the CESD depression score over the 21 days ($\text{Day 21} - \text{Day 1}$). A negative value indicates an improvement in symptoms. |
| `DASS1`           | Numerical     | Depression, Anxiety, and Stress Scale (DASS) depression subscale score measured at baseline on Day 1. High scores indicate greater self-reported depression severity. |
| `DASS21`          | Numerical     | Depression, Anxiety, and Stress Scale (DASS) depression subscale score measured at the conclusion of the study on Day 21. |
| `DASSDiff`        | Numerical     | The change in the DASS depression score over the 21 days ($\text{Day 21} - \text{Day 1}$). A negative value indicates an improvement in symptoms. |
| `BMI1`            | Numerical     | The participant's Body Mass Index (BMI) measured at baseline on Day 1. |
| `BMI21`           | Numerical     | The participant's Body Mass Index (BMI) measured at the conclusion of the study on Day 21. |
| `BMIDiff`         | Numerical     | The change in the participant's Body Mass Index (BMI) over the 21 days ($\text{Day 21} - \text{Day 1}$). |

------

## Details

A group of researchers in Australia conducted a short, three-week dietary intervention using a randomized controlled experimental design. The study sample consisted of 75 college-age students who initially exhibited both elevated depression symptoms and relatively poor dietary habits. Participants were randomly assigned to either a healthy diet intervention group (which received healthy food hampers and dietary guidance) or a control group (which maintained their normal eating habits).

To track changes in mental health, the researchers recorded scores across two distinct numerical depression metrics at the start and end of the 21-day period: the CESD scale, which leans more heavily toward clinical observations of depression, and the DASS depression subscale, which relies primarily on subjective, self-reported symptom frequency. Physical changes were also monitored by calculating each participant's Body Mass Index (BMI) on Day 1 and Day 21.

------

## Source

Francis, H. M., Stevenson, R. J., Chambers, J. R., Joint, D., Dickie, E. W., & Burger, C. (2019). A brief diet intervention can reduce symptoms of depression in young adults: A randomised controlled trial. *PLoS ONE*, 14(10), e0222768. [https://doi.org/10.1371/journal.pone.0222768](https://www.google.com/search?q=https://doi.org/10.1371/journal.pone.0222768&authuser=1)





# Dataset: `fatal_police_shootings.csv`

## Description

This dataset contains a subset of records documenting fatal shootings by on-duty law enforcement officers across the United States, compiled to track demographics, threat levels, and incident characteristics.

## Format

A comma-separated values (`.csv`) file containing **6,421 observations** (rows) and **12 variables** (columns).

### Variable Dictionary

| **Variable Name**         | **Data Type** | **Description and Coding Keys**                              |
| ------------------------- | ------------- | ------------------------------------------------------------ |
| `date`                    | Categorical   | The exact calendar date when the fatal shooting occurred ($YYYY-MM-DD$). |
| `manner_of_death`         | Categorical   | Clinical manner of death specification (**shot** or **shot and Tasered**). |
| `armed`                   | Categorical   | Indicates the type of weapon or implement the individual possessed that responding officers believed could inflict physical harm (e.g., gun, knife, unarmed, undetermined). |
| `age`                     | Numerical     | The age of the individual in years.                          |
| `gender`                  | Categorical   | The gender identity of the individual (**M** = Male, **F** = Female, or non-binary/transgender tracking matching public records). |
| `race`                    | Categorical   | The racial or ethnic background of the individual, coded as: **W** = White, non-Hispanic **B** = Black, non-Hispanic **H** = Hispanic **A** = Asian **N** = Native American **O** = Other / Unknown |
| `city`                    | Categorical   | The municipality or county where the fatal shooting took place. |
| `state`                   | Categorical   | The two-letter postal abbreviation for the U.S. state where the incident occurred. |
| `signs_of_mental_illness` | Categorical   | Indicator of acute mental distress or psychiatric history ($1 = \text{documented signs or history of mental illness}$, $0 = \text{no documented signs}$). |
| `threat_level`            | Categorical   | Classification of the immediate threat posed by the individual: **attack** = Highest threat level (e.g., firing a weapon, direct physical assault) **other** = Significant threat but not a direct assault **undetermined** = Insufficient data to evaluate threat |
| `flee`                    | Categorical   | The individual's movement behavior during the encounter (**Car**, **Foot**, or **Not fleeing**). |
| `body_camera`             | Categorical   | Indicates whether a responding officer was equipped with an active body-worn camera during the incident ($1 = \text{yes}$, $0 = \text{no}$). |

------

## Details

This dataset is derived directly from an ongoing investigative database maintained by *The Washington Post*, which tracks every fatal shooting by an on-duty police officer in the United States. Launched to address a lack of comprehensive, centralized tracking at the federal level, the database relies on local news reports, public records, social media, and independent verification platforms to log incidents.

The dataset includes structural variables designed to classify the circumstances surrounding each fatal encounter, including demographic markers, geographic locations, whether body cameras were deployed, and behavioral risk profiles (such as active flight attempts or visible indicators of psychological crisis). 

------

## Source

The Washington Post. (2024). *Fatal Force: National archive of police-involved shootings*. Retrieved from https://github.com/washingtonpost/data-police-shootings



# Dataset: `gym_membership_searches.csv`

## Description

This dataset contains weekly Google search popularity data for the term "gym membership" in the United States over a five-year period, capturing real-world consumer behavior, cyclical interest, and health-related seasonality.

## Format

A comma-separated values (`.csv`) file containing **262 observations** (rows) and **2 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Week`            | Categorical   | The starting date for the week of data collection, recorded in MM/DD/YYYY format (ranging from 05/16/2021 to 05/17/2026). |
| `gym membership`  | Numerical     | The normalized search interest index for the phrase "gym membership." Google scales these values from 0 to 100, where 100 represents the absolute peak search volume during the five-year window, and other values represent a percentage of that peak. |

## Details

Google Trends isolates a random sample of search traffic to calculate how frequently a specific term is searched relative to the total number of searches conducted during that exact time window. This relative frequency approach prevents raw population growth or shifting internet access rates from artificially inflating the data over time.

Spanning from mid-May 2021 to mid-May 2026, this dataset provides an excellent foundation for introductory statistics students to transition from traditional histograms to basic time-series analysis using line graphs. The data displays highly predictable, recurring seasonal trends.

## Source

Google LLC. (2026). *Google Trends Search Interest for "gym membership"*. Retrieved May 19, 2026, from [https://trends.google.com](https://trends.google.com?authuser=1)

# Dataset: `happy_planet_index_2024.csv`

## Description

This dataset contains country-level measurements from the Happy Planet Index (HPI) project, tracking indicators of sustainable well-being, ecological impact, and demographic metrics across 147 nations.

## Format

A comma-separated values (`.csv`) file containing **147 observations** (rows) and **9 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Country`         | Categorical   | The name of the country.                                     |
| `Region`          | Categorical   | The geographic region of the country, coded as: $1 = \text{Latin America}$ $2 = \text{North America and Oceania}$ $3 = \text{Western Europe}$ $4 = \text{Middle East and North Africa}$ $5 = \text{Sub-Saharan Africa}$ $6 = \text{South Asia}$ $7 = \text{Eastern Europe and Central Asia}$ $8 = \text{East Asia}$ |
| `HPI`             | Numerical     | Happy Planet Index score, measured on a $0 \text{ to } 100$ scale. Higher scores represent higher efficiency at delivering long, happy lives with a sustainable ecological footprint. |
| `HPIRank`         | Numerical     | The global ranking of the country based on its HPI score.    |
| `LifeExpectancy`  | Numerical     | The average life expectancy of a resident in years.          |
| `Footprint`       | Numerical     | Ecological footprint per capita. This measures the biological surface area required to support a country’s consumption and absorb its waste. |
| `LOL`             | Numerical     | Ladder of Life score, measured on a $0 \text{ to } 10$ scale. This is a subjective metric where residents rate their own overall well-being and life satisfaction. |
| `GDPperCapita`    | Numerical     | Gross Domestic Product per person, adjusted for purchasing power. |
| `Population`      | Numerical     | The total population of the country, recorded in millions.   |

------

## Details

The Happy Planet Index is an ongoing global project designed to measure how efficiently nations use their ecological resources to support long, high-quality lives for their residents. Unlike traditional economic metrics like GDP, the HPI places ecological limits and human well-being at the center of its calculation.

The index combines three primary pillars: subjective well-being (measured by the "Ladder of Life" survey metric), objective health outcomes (measured by life expectancy), and ecological sustainability (measured by the ecological footprint). This specific dataset represents a global snapshot of 147 countries compiled during the 2024 index report cycle.

------

## Source

Abdallah, S., & Hoffman, A. (2024). *The Happy Planet Index 2024 Data File*. Happy Planet Index Project. Retrieved from http://www.happyplanetindex.org





# Dataset: `hsb.csv`

## Description

This dataset contains demographic records, school characteristics, and standardized test scores for a sample of high school seniors, originally collected as part of a major national longitudinal study on education.

## Format

A comma-separated values (`.csv`) file containing **200 observations** (rows) and **11 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `id`              | Categorical   | A unique identification number assigned to each student.     |
| `gender`          | Categorical   | The student's gender identity (**female** or **male**).      |
| `race`            | Categorical   | The student's racial identity (**african american**, **asian**, **hispanic**, or **white**). |
| `ses`             | Categorical   | The socioeconomic status of the student's family, classified as **low**, **middle**, or **high**. |
| `schtyp`          | Categorical   | The type of school the student attends (**public** or **private**). |
| `prog`            | Categorical   | The academic program track the student is enrolled in (**general**, **academic**, or **vocational**). |
| `read`            | Numerical     | The student's standardized reading score.                    |
| `write`           | Numerical     | The student's standardized writing score.                    |
| `math`            | Numerical     | The student's standardized mathematics score.                |
| `science`         | Numerical     | The student's standardized science score.                    |
| `socst`           | Numerical     | The student's standardized social studies score.             |

------

## Details

The High School and Beyond (HS&B) survey is a foundational national longitudinal study managed by the National Center for Education Statistics (NCES). The study was launched to track the educational, vocational, and personal development of American high school students as they transition into higher education and the workforce.

This specific dataset is a random sample of $n = 200$ seniors taken from the broader baseline cohort. All five subject-area test variables (`read`, `write`, `math`, `science`, and `socst`) are scaled to a standardized metric (typically with a mean around 50 and a standard deviation of 10).

------

## Source

UCLA Institute for Digital Research & Education. (n.d.). *High School and Beyond (HS&B) Dataset*. Statistical Consulting Archive. Retrieved from [https://stats.oas.ucla.edu/](https://www.google.com/search?q=https://stats.oas.ucla.edu/&authuser=1)

# Dataset: `icu_data.csv`

## Description

This dataset contains clinical, demographic, and admission records for a sample of patients admitted to a hospital's Intensive Care Unit (ICU), with a primary focus on tracking patient survival and critical health indicators.

## Format

A comma-separated values (`.csv`) file containing **200 observations** (rows) and **9 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `ID`              | Categorical   | A unique identification number assigned to each patient.     |
| `Survive`         | Categorical   | The patient's survival status at hospital discharge ($1 = \text{the patient survived to be discharged}$, $0 = \text{the patient died in the hospital}$). |
| `Age`             | Numerical     | The age of the patient in years.                             |
| `AgeGroup`        | Categorical   | The patient's age category, coded as: $1 = \text{Under 50 years old}$ $2 = 50 \text{ to } 69 \text{ years old}$ $3 = \text{70 years or older}$ |
| `Sex`             | Categorical   | The biological sex of the patient ($1 = \text{female}$, $0 = \text{male}$). |
| `Infection`       | Categorical   | Infection status at the time of admission ($1 = \text{an infection is suspected}$, $0 = \text{no infection is suspected}$). |
| `SysBP`           | Numerical     | The patient's systolic blood pressure measured in millimeters of mercury (mmHg). |
| `Pulse`           | Numerical     | The patient's heart rate measured in beats per minute (bpm). |
| `Emergency`       | Categorical   | The type of ICU admission ($1 = \text{emergency admission}$, $0 = \text{elective admission}$). |

------

## Details

An Intensive Care Unit (ICU) handles the most severe, life-threatening cases in a hospital system, demanding continuous monitoring and rapid clinical intervention. Because critical care environments are high-risk, modeling patient survival alongside admission types and physiological baselines is crucial for improving triage and hospital resource management.

This dataset consists of a random sample of $n = 200$ patients extracted from a larger, comprehensive clinical study conducted within an ICU.

------

## Source

The Data and Story Library (DASL). (n.d.). *ICU Datafile*. Carnegie Mellon University. Retrieved from http://lib.stat.cmu.edu/DASL/Datafiles/ICU.html





# Dataset: `labor_market_discrimination.csv`

## Description

This dataset contains a subset of records from a landmark 2004 field experiment investigating racial discrimination in the United States labor market by measuring callback rates for fictitious resumes assigned distinctly African-American or White-sounding names.

## Format

A comma-separated values (`.csv`) file containing **4,870 observations** (rows) and **63 variables** (columns). A selection of 7 foundational variables frequently utilized in introductory analyses is outlined below.

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `education`       | Categorical   | The highest level of education reported on the resume, coded as: $0 = \text{not reported}$ $1 = \text{high school diploma}$ $2 = \text{high school graduate}$ $3 = \text{some college}$ $4 = \text{college or more}$ |
| `n_jobs`          | Numerical     | The total number of prior jobs listed on the applicant's resume. |
| `years_exp`       | Numerical     | The total number of years of professional work experience listed on the resume. |
| `first_name`      | Categorical   | The first name assigned to the fictitious resume (used to manipulate perceived race and gender). |
| `sex`             | Categorical   | Perceived biological sex based on the resume's first name ($\text{'f'} = \text{female}$, $\text{'m'} = \text{male}$). |
| `race`            | Categorical   | Perceived racial identity based on the resume's first name ($\text{'b'} = \text{Black}$, $\text{'w'} = \text{White}$). |
| `call`            | Categorical   | Interview callback indicator ($1 = \text{the applicant received a callback for an interview}$, $0 = \text{no callback received}$). |

------

## Details

To rigorously study racial bias in employment practices, researchers Marianne Bertrand and Sendhil Mullainathan conducted a massive randomized field experiment in the early 2000s. They responded to help-wanted advertisements in Boston and Chicago newspapers by submitting approximately $4,800$ fictitious resumes.

The key experimental manipulation involved randomly assigning first names to identical resumes to vary perceived race. Names like "Emily" and "Greg" were used to signify White applicants, while names like "Lakisha" and "Jamal" were used to signify African-American applicants.

The original study's primary finding revealed that resumes with White-sounding names received 50% more callbacks for interviews than identical resumes with African-American-sounding names.

------

## Source

Bertrand, M., & Mullainathan, S. (2004). Replication data for: Are Emily and Greg more employable than Lakisha and Jamal? A field experiment on labor market discrimination. *American Economic Review*, 94(4), 991–1013. Harvard Dataverse. [https://doi.org/10.7910/DVN/JG939E](https://www.google.com/search?q=https://doi.org/10.7910/DVN/JG939E&authuser=1)

# Dataset: `maid_mindset.csv`

## Description

This dataset contains results from a landmark 2007 psychological study exploring the mind-body connection, specifically tracking whether changing an individual's perception of their daily physical labor could trigger measurable, objective health improvements.

## Format

A comma-separated values (`.csv`) file containing **75 observations** (rows) and **14 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Cond`            | Categorical   | Experimental treatment condition ($1 = \text{informed group}$, $0 = \text{uninformed control group}$). |
| `Age`             | Numerical     | The participant's age in years.                              |
| `Wt`              | Numerical     | The participant's baseline weight at the start of the study, measured in pounds. |
| `Wt2`             | Numerical     | The participant's weight at the conclusion of the study (4 weeks later), measured in pounds. |
| `BMI`             | Numerical     | The participant's baseline Body Mass Index at the start of the study. |
| `BMI2`            | Numerical     | The participant's Body Mass Index at the conclusion of the study (4 weeks later). |
| `Fat`             | Numerical     | The participant's baseline body fat percentage at the start of the study. |
| `Fat2`            | Numerical     | The participant's body fat percentage at the conclusion of the study (4 weeks later). |
| `WHR`             | Numerical     | The participant's baseline waist-to-hip ratio at the start of the study. |
| `WHR2`            | Numerical     | The participant's waist-to-hip ratio at the conclusion of the study (4 weeks later). |
| `Syst`            | Numerical     | The participant's baseline systolic blood pressure at the start of the study, measured in mmHg. |
| `Syst2`           | Numerical     | The participant's systolic blood pressure at the conclusion of the study (4 weeks later), measured in mmHg. |
| `Diast`           | Numerical     | The participant's baseline diastolic blood pressure at the start of the study, measured in mmHg. |
| `Diast2`          | Numerical     | The participant's diastolic blood pressure at the conclusion of the study (4 weeks later), measured in mmHg. |

------

## Details

In 2007, a Harvard University psychologist conducted an experiment involving 75 female hotel maids. While hotel room attendants experience high levels of physical exertion every day, many do not perceive their labor as actual "exercise." To test the physiological power of mindset, the researcher randomly split the maids into two experimental conditions.

The **informed group** ($n = 41$) was explicitly told that their daily workplace routines satisfied the U.S. Surgeon General’s recommendations for a healthy, active lifestyle. They were provided with specific examples showing how activities like changing linens, vacuuming, and scrubbing tubs translated into significant physical exercise. The **uninformed group** ($n = 34$) served as a control and received no such information.

Biometric and physiological markers—including weight, body mass index, body fat percentage, waist-to-hip ratio, and blood pressure—were recorded at baseline and again four weeks later. No physical behavior changes (such as diet or outside gym habits) were introduced; the intervention relied entirely on changing the perception of existing behavior. Participants with missing values for weight change have been omitted from this version of the dataset.

------

## Source

Crum, A. J., & Langer, E. J. (2007). Mind-set matters: Exercise and the placebo effect. *Psychological Science*, 18(2), 165–171. [https://doi.org/10.1111/j.1467-9280.2007.01867.x](https://www.google.com/search?q=https://doi.org/10.1111/j.1467-9280.2007.01867.x&authuser=1)





# Dataset: `smoking_bmi_bp.csv`

## Description

This dataset contains physical, behavioral, and demographic measurements for a sample of adults in the United States, focused on exploring how lifestyle choices and physiological markers correlate with systolic blood pressure.

## Format

A comma-separated values (`.csv`) file containing **500 observations** (rows) and **3 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `SystolicBP`      | Numerical     | The individual's systolic blood pressure, measured in millimeters of mercury (mmHg). |
| `Smoker`          | Categorical   | Tobacco cigarette smoking status ($1 = \text{yes}$, $0 = \text{no}$). |
| `BMI`             | Categorical   | Body Mass Index weight classification category based on clinical ranges (**Normal**, **Overweight**, or **Obese**). |

------

## Details

An individual's systolic blood pressure serves as a vital clinical metric and a primary diagnostic signal for potential underlying cardiovascular issues, including hypertension and chronic heart disease.

This dataset tracks 500 randomly selected adults from the United States, capturing their exact blood pressure reading alongside their self-reported smoking status and calculated BMI classification. The data was compiled as part of an academic case study presentation for the 2003 Annual Meeting of the Statistical Society of Canada (SSC).

------

## Source

Statistical Society of Canada. (2003). *Blood Pressure Case Studies for the 2003 Annual Meeting*. Archived Case Studies. Retrieved from [http://www.ssc.ca/en/education/archived-case-studies/case-studies-for-the-2003-annual-meeting-blood-pressure](https://www.google.com/search?q=http://www.ssc.ca/en/education/archived-case-studies/case-studies-for-the-2003-annual-meeting-blood-pressure&authuser=1)

# Dataset: `speed_dating.csv`

## Description

This dataset contains results and ratings from a series of four-minute speed dates between graduate and professional students, tracking romantic decisions alongside subjective ratings of attraction, personality, and compatibility.

## Format

A comma-separated values (`.csv`) file containing **276 observations** (rows) and **22 variables** (columns). Each observation represents a single interaction between a unique male-female pair.

### Variable Dictionary

| **Variable Name**  | **Data Type** | **Description and Coding Keys**                              |
| ------------------ | ------------- | ------------------------------------------------------------ |
| `DecisionM`        | Categorical   | Match decision from the male participant ($1 = \text{yes, wants another date}$, $0 = \text{no}$). |
| `DecisionF`        | Categorical   | Match decision from the female participant ($1 = \text{yes, wants another date}$, $0 = \text{no}$). |
| `LikeM`            | Numerical     | Overall liking of the partner by the male participant, rated on a $1 \text{ to } 10$ scale. |
| `LikeF`            | Numerical     | Overall liking of the partner by the female participant, rated on a $1 \text{ to } 10$ scale. |
| `PartnerYesM`      | Numerical     | The male's subjective estimate of the probability that the female wants to see him again, rated on a $1 \text{ to } 10$ scale. |
| `PartnerYesF`      | Numerical     | The female's subjective estimate of the probability that the male wants to see her again, rated on a $1 \text{ to } 10$ scale. |
| `AgeM`             | Numerical     | Age of the male participant in years.                        |
| `AgeF`             | Numerical     | Age of the female participant in years.                      |
| `RaceM`            | Categorical   | Racial identity of the male participant (**Asian**, **Black**, **Caucasian**, **Latino**, or **Other**). |
| `RaceF`            | Categorical   | Racial identity of the female participant (**Asian**, **Black**, **Caucasian**, **Latino**, or **Other**). |
| `AttractiveM`      | Numerical     | The male's rating of the female's physical attractiveness, rated on a $1 \text{ to } 10$ scale. |
| `AttractiveF`      | Numerical     | The female's rating of the male's physical attractiveness, rated on a $1 \text{ to } 10$ scale. |
| `SincereM`         | Numerical     | The male's rating of the female's sincerity, rated on a $1 \text{ to } 10$ scale. |
| `SincereF`         | Numerical     | The female's rating of the male's sincerity, rated on a $1 \text{ to } 10$ scale. |
| `IntelligentM`     | Numerical     | The male's rating of the female's intelligence, rated on a $1 \text{ to } 10$ scale. |
| `IntelligentF`     | Numerical     | The female's rating of the male's intelligence, rated on a $1 \text{ to } 10$ scale. |
| `FunM`             | Numerical     | The male's rating of how fun the female is, rated on a $1 \text{ to } 10$ scale. |
| `FunF`             | Numerical     | The female's rating of how fun the male is, rated on a $1 \text{ to } 10$ scale. |
| `AmbitiousM`       | Numerical     | The male's rating of the female's level of ambition, rated on a $1 \text{ to } 10$ scale. |
| `AmbitiousF`       | Numerical     | The female's rating of the male's level of ambition, rated on a $1 \text{ to } 10$ scale. |
| `SharedInterestsM` | Numerical     | The male's rating of how much they share common interests, rated on a $1 \text{ to } 10$ scale. |
| `SharedInterestsF` | Numerical     | The female's rating of how much they share common interests, rated on a $1 \text{ to } 10$ scale. |

------

## Details

The data was originally collected from experimental speed-dating events involving graduate and professional students at Columbia University. Participants were recruited via mass email listservs, flyers posted across campus, and flyers handed out directly by research assistants.

During an event, participants engaged in individual, four-minute "speed dates" with every attendee of the opposite sex, with the pairing sequence and table assignments randomly determined. At the end of each four-minute round, participants filled out a scorecard evaluation rating their date on an integer scale from 1 to 10 across an array of attributes, as well as reporting whether they would want to go on a real date with that person. To simplify the data structure for introductory analysis while preserving independence, this specific file isolates only the very first date that occurred within each testing session.

------

## Source

Gelman, A., & Hill, J. (2007). *Data Analysis Using Regression and Multilevel/Hierarchical Models*. Cambridge University Press. [https://doi.org/10.1017/CBO9780511790942](https://www.google.com/search?q=https://doi.org/10.1017/CBO9780511790942&authuser=1)

# Dataset: `student_lifestyle_sleep.csv`

## Description

This dataset contains real-world data from a study investigating the relationships between sleep patterns, psychological well-being, lifestyle choices, and academic performance among college students.

## Format

A comma-separated values (`.csv`) file containing **253 observations** (rows) and **11 variables** (columns).

### Variable Dictionary

| **Variable Name**  | **Data Type** | **Description and Coding Keys**                              |
| ------------------ | ------------- | ------------------------------------------------------------ |
| `Gender`           | Categorical   | The student's self-reported gender ($1 = \text{male}$, $0 = \text{female}$). |
| `ClassYear`        | Categorical   | The student's year in school ($1 = \text{first year}$, $2 = \text{sophomore}$, $3 = \text{junior}$, $4 = \text{senior}$). |
| `GPA`              | Numerical     | Cumulative semester grade point average (measured on a $0.0 \text{ to } 4.0$ scale). |
| `ClassesMissed`    | Numerical     | The total number of classes the student missed during the semester. |
| `DepressionStatus` | Categorical   | Clinical screening result for depression (**normal**, **moderate**, or **severe**). |
| `AnxietyStatus`    | Categorical   | Clinical screening result for anxiety (**normal**, **moderate**, or **severe**). |
| `Stress`           | Categorical   | Clinical screening result for general stress level (**normal** or **high**). |
| `AlcoholUse`       | Categorical   | Self-reported frequency of alcohol consumption (**Abstain**, **Light**, **Moderate**, or **Heavy**). |
| `Drinks`           | Numerical     | The average number of alcoholic drinks consumed per week.    |
| `WeekdaySleep`     | Numerical     | The average number of hours of sleep the student gets on weekday nights. |
| `WeekendSleep`     | Numerical     | The average bedtime on weekend nights, recorded as a decimal value (e.g., $24.0 = \text{midnight}$, $24.5 = \text{12:30 AM}$, $25.0 = \text{1:00 AM}$). |

------

## Details

The data were obtained from a sample of undergraduate students who participated in a comprehensive study on sleep and cognitive health. Students completed a battery of baseline skills tests to measure cognitive function and filled out a detailed lifestyle survey tracking their personal habits, mental health status, and attitudes toward school. Additionally, participants maintained a daily sleep diary over a continuous two-week period to accurately record the timing, duration, and subjective quality of their sleep.

------

## Source

Onyper, S. V., Thacher, P. V., Gilbert, J. W., & Gradess, S. G. (2012). Class start times, sleep, and academic performance in college: A path analysis. *Chronobiology International: The Journal of Biological and Medical Rhythm Research*, 29(3), 318–335. [https://doi.org/10.3109/07420528.2012.659144](https://www.google.com/search?q=https://doi.org/10.3109/07420528.2012.659144&authuser=1)





# Dataset: `weight_loss_incentive.csv`

## Description

This dataset contains behavioral and physical measurements from a randomized controlled experiment designed to evaluate whether offering financial rewards significantly boosts weight-loss success and helps maintain weight reduction over time.

## Format

A comma-separated values (`.csv`) file containing **38 observations** (rows) and **3 variables** (columns). Each row tracks the progress of a single study participant.

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `WeightLoss`      | Numerical     | Net weight change measured at the end of the active 4-month treatment period ($\text{Baseline Weight} - \text{Month 4 Weight}$ in pounds). Positive values indicate weight loss; negative values indicate weight gain. |
| `Group`           | Categorical   | The experimental group assignment for the participant (**Control** or **Incentive**). |
| `Month7Loss`      | Numerical     | Net weight change measured at the 7-month mark, which includes a 3-month unmonitored follow-up phase ($\text{Baseline Weight} - \text{Month 7 Weight}$ in pounds). Positive values indicate weight loss; negative values indicate weight gain. |

------

## Details

Obesity management is a major public health focus, but sustaining motivation for lifestyle modification remains a substantial barrier to long-term success. To explore behavioral economics as a tool for clinical compliance, researchers conducted a randomized controlled trial tracking individuals over an extended period. Participants were randomly split into an **Incentive group** (eligible for cash rewards if they met predetermined weight reduction milestones) and a **Control group** (enrolled in the same weight-loss program but given no financial compensation).

The trial was divided into two structural phases to test both intervention efficacy and behavioral habituation. The first phase lasted 4 months under active monitoring and intervention. After the Month 4 check, the structural incentives were removed, and participants were left unmonitored for an additional 3 months. At the 7-month mark, researchers conducted a follow-up assessment. 

------

## Source

Volpp, K. G., John, L. K., Troxel, A. B., Norton, L., Fassbender, J., & Loewenstein, G. (2008). Financial incentive–based approaches for weight loss. *JAMA*, 300(22), 2631–2637. [https://doi.org/10.1001/jama.2008.804](https://www.google.com/search?q=https://doi.org/10.1001/jama.2008.804&authuser=1)

# Dataset: `youth_risk_2007.csv`

## Description

This dataset isolates demographic and behavioral responses from a sample of American high school students, focusing on the prevalence and risk factors associated with adolescents riding in a vehicle with an intoxicated driver.

## Format

A comma-separated values (`.csv`) file containing **13,388 observations** (rows) and **5 variables** (columns). Each row represents the anonymous survey responses of a single high school student.

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `ride.alc.driver` | Categorical   | Riding with a Drunk Driver (RDD) indicator within the past 30 days ($1 = \text{yes, rode with a driver who had been drinking}$, $0 = \text{no}$). |
| `female`          | Categorical   | The respondent's biological sex ($1 = \text{female}$, $0 = \text{male}$). |
| `grade`           | Categorical   | The respondent's academic grade standing in high school (**9** = 9th grade/Freshman, **10** = 10th grade/Sophomore, **11** = 11th grade/Junior, **12** = 12th grade/Senior). |
| `age4`            | Categorical   | The respondent's age in years, restricted to adolescent age brackets (**14**, **15**, **16**, **17**, or **18** years old). |
| `smoke`           | Categorical   | Lifetime tobacco experimentation indicator ($1 = \text{yes, has tried smoking cigarettes (even a few puffs)}$, $0 = \text{no}$). |

------

## Details

Public safety campaigns frequently focus on the catastrophic dangers of driving under the influence. However, an equally devastating and overlooked vector for youth traffic fatalities is Riding with a Drunk Driver (RDD). To design effective public health interventions and target safety messaging, researchers must identify which adolescent subgroups are most vulnerable to accepting these rides and explore underlying behavioral correlations.

The data in this file is a streamlined subset derived from the 2007 Youth Risk Behavior Surveillance System (YRBSS), a massive national survey monitored biennially by the Centers for Disease Control and Prevention (CDC). The YRBSS focuses on tracking the prevalence of health-risk behaviors that contribute to the leading causes of death, disability, and social complications among youth in the United States. 

------

## Source

Brooks-Russell, A., Simons-Morton, B., Haynie, D., Farhat, T., & Litvak, E. (2009). Which young people accept a lift from a drunk or drugged driver? *Accident Analysis & Prevention*, 41(4), 703–709. [https://doi.org/10.1016/j.aap.2009.03.004](https://www.google.com/search?q=https://doi.org/10.1016/j.aap.2009.03.004&authuser=1)



Centers for Disease Control and Prevention. (2007). *Youth Risk Behavior Surveillance System (YRBSS) Data and Documentation*. https://www.cdc.gov/yrbs/data/index.html
