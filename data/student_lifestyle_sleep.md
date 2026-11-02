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

Onyper, S. V., Thacher, P. V., Gilbert, J. W., & Gradess, S. G. (2012). Class start times, sleep, and academic performance in college: A path analysis. *Chronobiology International: The Journal of Biological and Medical Rhythm Research*, 29(3), 318–335. [https://doi.org/10.3109/07420528.2012.659144](https://doi.org/10.3109/07420528.2012.659144)
