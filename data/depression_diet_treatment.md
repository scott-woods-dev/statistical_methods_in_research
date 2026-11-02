# Dataset: `depression_diet_treatment.csv`

## Description

This dataset contains results from a randomized controlled experiment tracking the impact of a short-term, three-week healthy diet intervention on depression symptoms and body mass index (BMI) among young adults.

## Format

A comma-separated values (`.csv`) file containing **75 observations** (rows) and **10 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Group`           | Categorical   | The experimental group assignment for the student (**Control** or **Diet**). |
| `CESD1`           | Numerical     | Center for Epidemiologic Studies Depression Scale (CESD) score measured at baseline on Day 1. High scores indicate greater depression severity. |
| `CESD21`          | Numerical     | Center for Epidemiologic Studies Depression Scale (CESD) score measured at the conclusion of the study on Day 21. |
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

Francis, H. M., Stevenson, R. J., Chambers, J. R., Joint, D., Dickie, E. W., & Burger, C. (2019). A brief diet intervention can reduce symptoms of depression in young adults: A randomised controlled trial. *PLoS ONE*, 14(10), e0222768. [https://doi.org/10.1371/journal.pone.0222768](https://doi.org/10.1371/journal.pone.0222768)
