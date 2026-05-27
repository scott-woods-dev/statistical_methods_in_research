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
