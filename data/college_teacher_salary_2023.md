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
