# Dataset: `icu_data.csv`

## Description

This dataset contains clinical, demographic, and admission records for a sample of patients admitted to a hospital's Intensive Care Unit (ICU), with a primary focus on tracking patient survival and critical health indicators.

## Format

A comma-separated values (`.csv`) file containing **200 observations** (rows) and **9 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `ID`              | Categorical   | A unique identification number assigned to each patient.     |
| `Survive`         | Categorical   | The patient's survival status at hospital discharge ($1 = \text{the patient survived to be discharged}$, $0 = \text{the patient died in the hospital}$). |
| `Age`             | Numerical     | The age of the patient in years.                             |
| `AgeGroup`        | Categorical   | The patient's age category, coded as: $1 = \text{Under 50 years old}$ $2 = 50 \text{ to } 69 \text{ years old}$ $3 = \text{70 years or older}$ |
| `Sex`             | Categorical   | The biological sex of the patient ($1 = \text{female}$, $0 = \text{male}$). |
| `Infection`       | Categorical   | Infection status at the time of admission ($1 = \text{an infection is suspected}$, $0 = \text{no infection is suspected}$). |
| `SysBP`           | Numerical     | The patient's systolic blood pressure measured in millimeters of mercury (mmHg). |
| `Pulse`           | Numerical     | The patient's heart rate measured in beats per minute (bpm). |
| `Emergency`       | Categorical   | The type of ICU admission ($1 = \text{emergency admission}$, $0 = \text{elective admission}$). |

------

## Details

An Intensive Care Unit (ICU) handles the most severe, life-threatening cases in a hospital system, demanding continuous monitoring and rapid clinical intervention. Because critical care environments are high-risk, modeling patient survival alongside admission types and physiological baselines is crucial for improving triage and hospital resource management.

This dataset consists of a random sample of $n = 200$ patients extracted from a larger, comprehensive clinical study conducted within an ICU.

------

## Source

The Data and Story Library (DASL). (n.d.). *ICU Datafile*. Carnegie Mellon University. Retrieved from http://lib.stat.cmu.edu/DASL/Datafiles/ICU.html
