# Dataset: `gym_membership_searches.csv`

## Description

This dataset contains weekly Google search popularity data for the term "gym membership" in the United States over a five-year period, capturing real-world consumer behavior, cyclical interest, and health-related seasonality.

## Format

A comma-separated values (`.csv`) file containing **262 observations** (rows) and **2 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Week`            | Categorical   | The starting date for the week of data collection, recorded in MM/DD/YYYY format (ranging from 05/16/2021 to 05/17/2026). |
| `gym membership`  | Numerical     | The normalized search interest index for the phrase "gym membership." Google scales these values from 0 to 100, where 100 represents the absolute peak search volume during the five-year window, and other values represent a percentage of that peak. |

## Details

Google Trends isolates a random sample of search traffic to calculate how frequently a specific term is searched relative to the total number of searches conducted during that exact time window. This relative frequency approach prevents raw population growth or shifting internet access rates from artificially inflating the data over time.

Spanning from mid-May 2021 to mid-May 2026, this dataset provides an excellent foundation for introductory statistics students to transition from traditional histograms to basic time-series analysis using line graphs. The data displays highly predictable, recurring seasonal trends.

## Source

Google LLC. (2026). *Google Trends Search Interest for "gym membership"*. Retrieved May 19, 2026, from [https://trends.google.com](https://trends.google.com?authuser=1)
