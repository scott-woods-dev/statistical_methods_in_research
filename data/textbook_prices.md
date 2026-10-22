# Dataset: `textbook_prices.csv`

## Description

This dataset contains price comparisons for a random sample of required course textbooks, evaluating the cost difference between an online retailer (Amazon) and a local campus bookstore.

## Format

A comma-separated values (`.csv`) file containing **16 observations** (rows) and **4 variables** (columns).

### Variable Dictionary

| **Variable Name**   | **Data Type** | **Description and Coding Keys**                              |
| ------------------- | ------------- | ------------------------------------------------------------ |
| `Amazon`            | Numerical     | The retail price of the textbook on Amazon (in U.S. dollars). |
| `College Bookstore` | Numerical     | The retail price of the textbook at the campus bookstore (in U.S. dollars). |
| `Department`        | Categorical   | The specific academic department requiring the textbook (e.g., MATH, PHIL, RUSS). |
| `School`            | Categorical   | The broader academic division housing the department (**Business**, **Liberal Arts**, **Natural Science**, or **Social Science**). |

## Details

To evaluate whether the campus bookstore charges significantly more than online retailers, a random sample of 16 required course textbooks was collected across four major academic divisions. Because each specific textbook's price is recorded at both Amazon and the campus bookstore, this creates naturally paired, within-subject data.

## Source

Woods, S. (2026). *Textbook price comparison across academic departments* [Dataset]. Prepared for *Statistical Methods in Research*.