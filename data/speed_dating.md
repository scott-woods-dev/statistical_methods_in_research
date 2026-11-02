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

Gelman, A., & Hill, J. (2007). *Data Analysis Using Regression and Multilevel/Hierarchical Models*. Cambridge University Press. [https://doi.org/10.1017/CBO9780511790942](https://doi.org/10.1017/CBO9780511790942)
