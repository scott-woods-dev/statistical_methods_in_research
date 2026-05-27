# Dataset: `happy_planet_index_2024.csv`

## Description

This dataset contains country-level measurements from the Happy Planet Index (HPI) project, tracking indicators of sustainable well-being, ecological impact, and demographic metrics across 147 nations.

## Format

A comma-separated values (`.csv`) file containing **147 observations** (rows) and **9 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Country`         | Categorical   | The name of the country.                                     |
| `Region`          | Categorical   | The geographic region of the country, coded as: $1 = \text{Latin America}$ $2 = \text{North America and Oceania}$ $3 = \text{Western Europe}$ $4 = \text{Middle East and North Africa}$ $5 = \text{Sub-Saharan Africa}$ $6 = \text{South Asia}$ $7 = \text{Eastern Europe and Central Asia}$ $8 = \text{East Asia}$ |
| `HPI`             | Numerical     | Happy Planet Index score, measured on a $0 \text{ to } 100$ scale. Higher scores represent higher efficiency at delivering long, happy lives with a sustainable ecological footprint. |
| `HPIRank`         | Numerical     | The global ranking of the country based on its HPI score.    |
| `LifeExpectancy`  | Numerical     | The average life expectancy of a resident in years.          |
| `Footprint`       | Numerical     | Ecological footprint per capita. This measures the biological surface area required to support a country's consumption and absorb its waste. |
| `LOL`             | Numerical     | Ladder of Life score, measured on a $0 \text{ to } 10$ scale. This is a subjective metric where residents rate their own overall well-being and life satisfaction. |
| `GDPperCapita`    | Numerical     | Gross Domestic Product per person, adjusted for purchasing power. |
| `Population`      | Numerical     | The total population of the country, recorded in millions.   |

------

## Details

The Happy Planet Index is an ongoing global project designed to measure how efficiently nations use their ecological resources to support long, high-quality lives for their residents. Unlike traditional economic metrics like GDP, the HPI places ecological limits and human well-being at the center of its calculation.

The index combines three primary pillars: subjective well-being (measured by the "Ladder of Life" survey metric), objective health outcomes (measured by life expectancy), and ecological sustainability (measured by the ecological footprint). This specific dataset represents a global snapshot of 147 countries compiled during the 2024 index report cycle.

------

## Source

Abdallah, S., & Hoffman, A. (2024). *The Happy Planet Index 2024 Data File*. Happy Planet Index Project. Retrieved from http://www.happyplanetindex.org
