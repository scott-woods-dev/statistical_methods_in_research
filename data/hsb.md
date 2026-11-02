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

UCLA Institute for Digital Research & Education. (n.d.). *High School and Beyond (HS&B) Dataset*. Statistical Consulting Archive. Retrieved from [https://stats.oas.ucla.edu/](https://stats.oas.ucla.edu/)
