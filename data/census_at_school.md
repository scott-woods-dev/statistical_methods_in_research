# Dataset: `census_at_school.csv`

## Description

This dataset contains a wide range of physical, behavioral, and demographic measurements from a sample of high school seniors in the state of Pennsylvania, collected during the 2023 and 2024 academic years.

## Format

A comma-separated values (`.csv`) file containing **500 observations** (rows) and **35 variables** (columns).

### Variable Dictionary

| **Variable Name** | **Data Type** | **Description and Coding Keys**                              |
| ----------------- | ------------- | ------------------------------------------------------------ |
| `Year`            | Categorical   | The year the student submitted their data (**2023** or **2024**). |
| `Gender`          | Categorical   | The individual's gender (**Female** or **Male**).            |
| `Age`             | Numerical     | The student's age in years.                                  |
| `Hand`            | Categorical   | The student's dominant hand (**Left**, **Right**, or **Both**). |
| `Height`          | Numerical     | The student's height measured in centimeters.                |
| `Foot`            | Numerical     | The student's foot length measured in centimeters.           |
| `Armspan`         | Numerical     | The student's armspan measured in centimeters.               |
| `Languages`       | Numerical     | The number of languages the student speaks fluently.         |
| `GetToSchool`     | Categorical   | Main mode of transportation used to get to school (**Bus**, **Car**, or **Walk**—where Walk includes bicycles and skateboards). |
| `TravelTime`      | Numerical     | The time it takes the student to travel to school, recorded in minutes. |
| `ReactionTime`    | Numerical     | The time, in seconds, it takes the student to click a button when a visual color changes during an online test. |
| `MemoryScore`     | Numerical     | The score achieved by the student in a standard online memory card-matching game. |
| `Activity`        | Categorical   | The student's self-reported favorite physical activity or sport. |
| `Music`           | Categorical   | The student's favorite genre of music.                       |
| `BirthMonth`      | Categorical   | The month the student was born.                              |
| `Season`          | Categorical   | The student's favorite season (**Autumn**, **Spring**, **Summer**, or **Winter**). |
| `Allergies`       | Categorical   | Whether the student has known allergies (**Yes** or **No**). |
| `Vegetarian`      | Categorical   | Whether the student follows a vegetarian diet (**Yes** or **No**). |
| `FavFood`         | Categorical   | The student's favorite food category.                        |
| `FavDrink`        | Categorical   | The beverage the student consumes most often during the day. |
| `FavSubject`      | Categorical   | The student's favorite academic subject in school.           |
| `Sleep1`          | Numerical     | The typical number of hours of sleep the student gets on a school night. |
| `Sleep2`          | Numerical     | The typical number of hours of sleep the student gets on a non-school night (weekends/holidays). |
| `Occupants`       | Numerical     | The total number of people living in the student's primary home. |
| `Communicate`     | Categorical   | The method the student uses most often to communicate with friends (e.g., Text, FaceTime, In-Person). |
| `TextsSent`       | Numerical     | The estimated number of text messages the student sent during the previous day. |
| `HangHours`       | Numerical     | The total number of hours the student spent hanging out with friends over the last week. |
| `HWHours`         | Numerical     | The total number of hours the student spent doing homework over the last week. |
| `VideoGameHours`  | Numerical     | The total number of hours the student spent playing video/computer games over the last week. |
| `ComputerHours`   | Numerical     | The total number of hours the student spent using a computer for non-gaming purposes over the last week. |
| `TVHours`         | Numerical     | The total number of hours the student spent watching TV/streaming services over the last week. |
| `WorkHours`       | Numerical     | The total number of hours the student spent working at a paid job over the last week. |
| `SchoolPressure`  | Categorical   | The student's subjective assessment of the amount of pressure they feel due to schoolwork (e.g., None, Very Little, Some, A Lot). |
| `Superpower`      | Categorical   | The superpower the student desires most (**Fly**, **Freeze time**, **Invisibility**, **Super strength**, or **Telepathy**). |
| `Preference`      | Categorical   | The life outcome the student would prefer most if they could only choose one (**Famous**, **Happy**, **Healthy**, or **Rich**). |

------

## Details

Census at School is an ongoing, international classroom project hosted in the United States by the American Statistical Association (ASA). The initiative is designed to engage students in grades 4 through 12 in statistical problem-solving by having them securely submit their own anonymous data to a national database, which can then be sampled for educational use.

This specific dataset represents a random sample of $n = 500$ high school seniors from the state of Pennsylvania who participated in the program across the 2023 and 2024 collection periods. It provides an excellent real-world playground for analyzing multivariate data, exploring outliers, and comparing categorical preferences against numerical lifestyle choices.

------

## Source

American Statistical Association. (2024). *U.S. Census at School Program*. Retrieved from https://ww2.amstat.org/censusatschool/
