# Dataset: `youth_risk_2007.csv`

## Description

This dataset isolates demographic and behavioral responses from a sample of American high school students, focusing on the prevalence and risk factors associated with adolescents riding in a vehicle with an intoxicated driver.

## Format

A comma-separated values (`.csv`) file containing **13,387 observations** (rows) and **6 variables** (columns). Each row represents the anonymous survey responses of a single high school student.

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `ride.alc.driver` | Categorical   | Riding with a Drunk Driver (RDD) indicator within the past 30 days ($1 = \text{yes, rode with a driver who had been drinking}$, $0 = \text{no}$). |
| `female`          | Categorical   | The respondent's biological sex ($1 = \text{female}$, $0 = \text{male}$). |
| `grade`           | Categorical   | The respondent's academic grade standing in high school (**9** = 9th grade/Freshman, **10** = 10th grade/Sophomore, **11** = 11th grade/Junior, **12** = 12th grade/Senior). |
| `age4`            | Categorical   | The respondent's age in years, restricted to adolescent age brackets (**14**, **15**, **16**, **17**, or **18** years old). |
| `smoke`           | Categorical   | Lifetime tobacco experimentation indicator ($1 = \text{yes, has tried smoking cigarettes (even a few puffs)}$, $0 = \text{no}$). |
| `DriverLicense`   | Categorical   | Whether the respondent has a driver's license ($1 = \text{yes}$, $0 = \text{no}$); 54 values are missing. |

------

## Details

Public safety campaigns frequently focus on the catastrophic dangers of driving under the influence. However, an equally devastating and overlooked vector for youth traffic fatalities is Riding with a Drunk Driver (RDD). To design effective public health interventions and target safety messaging, researchers must identify which adolescent subgroups are most vulnerable to accepting these rides and explore underlying behavioral correlations.

The data in this file is a smaller subset derived from the 2007 Youth Risk Behavior Surveillance System (YRBSS), a massive national survey monitored biennially by the Centers for Disease Control and Prevention (CDC). The YRBSS focuses on tracking the prevalence of health-risk behaviors that contribute to the leading causes of death, disability, and social complications among youth in the United States.

------

## Source

Brooks-Russell, A., Simons-Morton, B., Haynie, D., Farhat, T., & Litvak, E. (2009). Which young people accept a lift from a drunk or drugged driver? *Accident Analysis & Prevention*, 41(4), 703–709. [https://doi.org/10.1016/j.aap.2009.03.004](https://doi.org/10.1016/j.aap.2009.03.004)

Centers for Disease Control and Prevention. (2007). *Youth Risk Behavior Surveillance System (YRBSS) Data and Documentation*. https://www.cdc.gov/yrbs/data/index.html