# Dataset: `sunscreen_searches.csv`

## Description

This dataset contains monthly Google search popularity data for the term "sunscreen" in the United States over a five-year period, capturing seasonal interest in sun protection.

## Format

A comma-separated values (`.csv`) file containing **61 observations** (rows) and **2 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Month`           | Categorical   | The starting date for the month of data collection, recorded in MM-DD-YY format (ranging from 10-01-21 to 10-01-26). |
| `sunscreen`       | Numerical     | The normalized search interest index for the phrase "sunscreen." Google scales these values from 0 to 100, where 100 represents the absolute peak search volume during the five-year window, and other values represent a percentage of that peak. |

---

## Details

Google Trends isolates a random sample of search traffic to calculate how frequently a specific term is searched relative to the total number of searches conducted during that exact time window. This relative frequency approach prevents raw population growth or shifting internet access rates from artificially inflating the data over time.



Because Google Trends now reports this term at monthly resolution, this file is monthly rather than weekly. It spans October 2021 to October 2026 and is used alongside the weekly `gym_membership_searches.csv` in the Chapter 12 exercises.

---

## Source

Google LLC. (2026). *Google Trends Search Interest for "sunscreen"*. Retrieved October 20, 2026, from [https://trends.google.com](https://trends.google.com?authuser=1)
