# Dataset: `labor_market_discrimination.csv`

## Description

This dataset contains a subset of records from a landmark 2004 field experiment investigating racial discrimination in the United States labor market by measuring callback rates for fictitious resumes assigned distinctly African-American or White-sounding names.

## Format

A comma-separated values (`.csv`) file containing **4,870 observations** (rows) and **7 variables** (columns), a selection of the 63 variables in the original data that introductory analyses use most often.

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

Bertrand, M., & Mullainathan, S. (2004). Replication data for: Are Emily and Greg more employable than Lakisha and Jamal? A field experiment on labor market discrimination. *American Economic Review*, 94(4), 991–1013. Harvard Dataverse. [https://doi.org/10.7910/DVN/JG939E](https://doi.org/10.7910/DVN/JG939E)
