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
| `premie`          | Categorical   | Gestational maturity classification of the infant at birth (**full term** or **premie**). |
| `visits`          | Numerical     | The total number of prenatal medical or hospital visits made by the mother during the pregnancy. |
| `gained`          | Numerical     | Total physical weight gained by the mother during the pregnancy, measured in pounds. |
| `weight`          | Numerical     | The final birth weight of the infant, measured in pounds.    |
| `lowbirthweight`  | Categorical   | Clinical birth weight classification (**low** or **not low**). |
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

United States Department of Health and Human Services, Centers for Disease Control and Prevention, National Center for Health Statistics. (2016). *Natality Detail File, 2014 United States* (ICPSR 36461-v1). Inter-university Consortium for Political and Social Research. [https://doi.org/10.3886/ICPSR36461.v1](https://doi.org/10.3886/ICPSR36461.v1)
