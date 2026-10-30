# Dataset: `maid_mindset.csv`

## Description

This dataset contains results from a landmark 2007 psychological study exploring the mind-body connection, specifically tracking whether changing an individual's perception of their daily physical labor could trigger measurable, objective health improvements.

## Format

A comma-separated values (`.csv`) file containing **75 observations** (rows) and **14 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Cond`            | Categorical   | Experimental treatment condition ($1 = \text{informed group}$, $0 = \text{uninformed control group}$). |
| `Age`             | Numerical     | The participant's age in years.                              |
| `Wt`              | Numerical     | The participant's baseline weight at the start of the study, measured in pounds. |
| `Wt2`             | Numerical     | The participant's weight at the conclusion of the study (4 weeks later), measured in pounds. |
| `BMI`             | Numerical     | The participant's baseline Body Mass Index at the start of the study. |
| `BMI2`            | Numerical     | The participant's Body Mass Index at the conclusion of the study (4 weeks later). |
| `Fat`             | Numerical     | The participant's baseline body fat percentage at the start of the study. |
| `Fat2`            | Numerical     | The participant's body fat percentage at the conclusion of the study (4 weeks later). |
| `WHR`             | Numerical     | The participant's baseline waist-to-hip ratio at the start of the study. |
| `WHR2`            | Numerical     | The participant's waist-to-hip ratio at the conclusion of the study (4 weeks later). |
| `Syst`            | Numerical     | The participant's baseline systolic blood pressure at the start of the study, measured in mmHg. |
| `Syst2`           | Numerical     | The participant's systolic blood pressure at the conclusion of the study (4 weeks later), measured in mmHg. |
| `Diast`           | Numerical     | The participant's baseline diastolic blood pressure at the start of the study, measured in mmHg. |
| `Diast2`          | Numerical     | The participant's diastolic blood pressure at the conclusion of the study (4 weeks later), measured in mmHg. |

------

## Details

In 2007, a Harvard University psychologist conducted an experiment involving 75 female hotel maids. While hotel room attendants experience high levels of physical exertion every day, many do not perceive their labor as actual "exercise." To test the physiological power of mindset, the researcher randomly split the maids into two experimental conditions.

The **informed group** ($n = 41$) was explicitly told that their daily workplace routines satisfied the U.S. Surgeon General's recommendations for a healthy, active lifestyle. They were provided with specific examples showing how activities like changing linens, vacuuming, and scrubbing tubs translated into significant physical exercise. The **uninformed group** ($n = 34$) served as a control and received no such information.

Biometric and physiological markers (including weight, body mass index, body fat percentage, waist-to-hip ratio, and blood pressure) were recorded at baseline and again four weeks later. No physical behavior changes (such as diet or outside gym habits) were introduced; the intervention relied entirely on changing the perception of existing behavior. Participants with missing values for weight change have been omitted from this version of the dataset.

------

## Source

Crum, A. J., & Langer, E. J. (2007). Mind-set matters: Exercise and the placebo effect. *Psychological Science*, 18(2), 165–171. [https://doi.org/10.1111/j.1467-9280.2007.01867.x](https://www.google.com/search?q=https://doi.org/10.1111/j.1467-9280.2007.01867.x&authuser=1)
