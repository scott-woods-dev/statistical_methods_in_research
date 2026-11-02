# Dataset: `weight_loss_incentive.csv`

## Description

This dataset contains behavioral and physical measurements from a randomized controlled experiment designed to evaluate whether offering financial rewards significantly boosts weight-loss success and helps maintain weight reduction over time.

## Format

A comma-separated values (`.csv`) file containing **38 observations** (rows) and **3 variables** (columns). Each row tracks the progress of a single study participant.

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `WeightLoss`      | Numerical     | Net weight change measured at the end of the active 4-month treatment period ($\text{Baseline Weight} - \text{Month 4 Weight}$ in pounds). Positive values indicate weight loss; negative values indicate weight gain. |
| `Group`           | Categorical   | The experimental group assignment for the participant (**Control** or **Incentive**). |
| `Month7Loss`      | Numerical     | Net weight change measured at the 7-month mark, which includes a 3-month unmonitored follow-up phase ($\text{Baseline Weight} - \text{Month 7 Weight}$ in pounds). Positive values indicate weight loss; negative values indicate weight gain. |

------

## Details

Obesity management is a major public health focus, but sustaining motivation for lifestyle modification remains a substantial barrier to long-term success. To explore behavioral economics as a tool for clinical compliance, researchers conducted a randomized controlled trial tracking individuals over an extended period. Participants were randomly split into an **Incentive group** (eligible for cash rewards if they met predetermined weight reduction milestones) and a **Control group** (enrolled in the same weight-loss program but given no financial compensation).

The trial was divided into two structural phases to test both intervention efficacy and behavioral habituation. The first phase lasted 4 months under active monitoring and intervention. After the Month 4 check, the structural incentives were removed, and participants were left unmonitored for an additional 3 months. At the 7-month mark, researchers conducted a follow-up assessment.

------

## Source

Volpp, K. G., John, L. K., Troxel, A. B., Norton, L., Fassbender, J., & Loewenstein, G. (2008). Financial incentive–based approaches for weight loss. *JAMA*, 300(22), 2631–2637. [https://doi.org/10.1001/jama.2008.804](https://doi.org/10.1001/jama.2008.804)
