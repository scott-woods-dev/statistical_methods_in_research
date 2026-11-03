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
| `gender`                  | Categorical   | The gender identity of the individual (**M** = Male or **F** = Female). |
| `race`                    | Categorical   | The racial or ethnic background of the individual, coded as: **W** = White, non-Hispanic **B** = Black, non-Hispanic **H** = Hispanic **A** = Asian **N** = Native American **O** = Other / Unknown |
| `city`                    | Categorical   | The municipality or county where the fatal shooting took place. |
| `state`                   | Categorical   | The two-letter postal abbreviation for the U.S. state where the incident occurred. |
| `signs_of_mental_illness` | Categorical   | Indicator of acute mental distress or psychiatric history (**True** = documented signs or history of mental illness, **False** = no documented signs). |
| `threat_level`            | Categorical   | Classification of the immediate threat posed by the individual: **attack** = Highest threat level (e.g., firing a weapon, direct physical assault) **other** = Significant threat but not a direct assault **undetermined** = Insufficient data to evaluate threat |
| `flee`                    | Categorical   | The individual's movement behavior during the encounter (**Car**, **Foot**, **Not fleeing**, or **Other**). |
| `body_camera`             | Categorical   | Indicates whether a responding officer was equipped with an active body-worn camera during the incident (**True** or **False**). |

------

## Details

This dataset is derived directly from an ongoing investigative database maintained by *The Washington Post*, which tracks every fatal shooting by an on-duty police officer in the United States. Launched to address a lack of comprehensive, centralized tracking at the federal level, the database relies on local news reports, public records, social media, and independent verification platforms to log incidents.

The dataset includes structural variables designed to classify the circumstances surrounding each fatal encounter, including demographic markers, geographic locations, whether body cameras were deployed, and behavioral risk profiles (such as active flight attempts or visible indicators of psychological crisis).

------

## Source

The Washington Post. (2024). *Fatal Force: National archive of police-involved shootings*. Retrieved from https://github.com/washingtonpost/data-police-shootings
