# Multiple Regression for Complex Systems

## 5.1 Introduction

Imagine you are a researcher investigating neonatal health. You want to understand what factors correlate with an infant's birth weight. In Chapter 4, you learned how to model a relationship between two variables using simple linear regression. However, human biology and social systems are rarely that simple. A baby's birth weight is not determined by just one factor.



To explore this complexity, we will use a sample of 1,000 live birth events. These records come from the 2014 national natality public-use file in the United States.

- **`births_2014.csv`**: A dataset tracking physical, demographic, and behavioral health metrics for infants and expectant mothers.
  - **`weight`**: A numerical variable recording the final birth weight of the infant in pounds.
  - **`weeks`**: A numerical variable recording the gestational length of the pregnancy in weeks.
  - **`mage`**: A numerical variable tracking the biological mother's age in years.
  - **`visits`**: A numerical variable counting the prenatal medical visits made by the mother.
  - **`habit`**: A categorical variable indicating the mother's tobacco smoking status during pregnancy.
  - **`mature`**: A categorical variable indicating the mother's clinical age maturity status.

In this chapter, you will learn how to expand your modeling toolkit. You will discover how to evaluate multiple overlapping variables at the same time to understand complex real-world systems.

## 5.2 What is Multiple Regression?

In previous chapters, you used simple linear regression to predict a single outcome. You relied on just one predictor to make that estimate. We must now upgrade that tool.



**Multiple regression** is a statistical method that allows you to predict a single response variable using two or more predictors. The outcome we want to predict must still be a continuous numerical measurement. However, we can now feed the model multiple pieces of information simultaneously.



Why do we need this upgrade? Let's look at our dataset. You might start your analysis by running a simple linear model. You try to predict neonatal birth weight (`weight`) using only prenatal visits (`visits`). The software gives you a positive slope. This suggests that as a mother makes more prenatal visits, her baby's birth weight increases.



But we must pause and think about reality. Longer pregnancies create more opportunities for prenatal visits. They also produce heavier babies. A simple linear model is blind to these overlapping influences. It forces all the credit onto the single predictor you provided.



We call this overlapping interference a **confounding factor**. A confounding factor is an underlying third variable that influences both your predictor and your response variable. If we do not account for these external factors, our model suffers from **omitted variable bias**. This bias gives us an inaccurate and potentially misleading slope.



To fix this bias, we must build a multiple regression model. We add gestational duration (`weeks`) to our equation alongside prenatal visits. By adding multiple predictors, we can account for confounding factors and get an accurate picture of what is truly driving the outcome.

## 5.3 What "Controlling For" a Variable Means

When you read news articles about medical research, you often see a specific phrase. The article might say, "Researchers found a link between a new medication and lower blood pressure, even after controlling for age and diet." But what does that mean?



To **control for** a variable means we mathematically hold that variable constant to isolate the true effect of our primary predictor. It is the exact mathematical mechanism we use to neutralize a confounding factor.



Let's look at a practical application using our dataset. Imagine you want to know how the number of prenatal visits (`visits`) affects an infant's birth weight (`weight`). You start by running a simple linear regression just like you did in Chapter 4.

| Predictor | Coefficient | SE | t | p |
| :--- | ---: | ---: | ---: | ---: |
| Intercept | 6.529 | 0.123 | 53.06 | < .001 |
| `visits` | 0.05919 | 0.01019 | 5.81 | < .001 |

: Table 5.1: Simple linear regression predicting birth weight from prenatal visits (n = 944; $R^2$ = 3.45%; adjusted $R^2$ = 3.35%; F(1, 942) = 33.72; p < .001).

*Note: 56 mothers with no recorded number of prenatal visits are excluded, so both models in this section use 944 births.*

When you look at this software output, you might see a positive slope for `visits`. This initial result suggests that as a mother makes more prenatal visits, her baby's birth weight increases. But we must remember our earlier discussion about confounding variables. Are the visits truly driving the heavier birth weight? Or is gestational duration (`weeks`) interfering as a confounding factor behind the scenes?



If we leave gestational duration out of our model, we introduce **omitted variable bias**. This bias occurs because our model is blind to the confounding variable. The slope we calculated for `visits` is inaccurate because it secretly absorbs the effect of the missing variable.

To fix this, we must add predictors to get accurate slopes. We build a multiple regression model by adding `weeks` as a second predictor alongside `visits`.

| Predictor | Coefficient | SE | t | p |
| :--- | ---: | ---: | ---: | ---: |
| Intercept | -3.596 | 0.536 | -6.71 | < .001 |
| `visits` | 0.02489 | 0.00882 | 2.82 | .005 |
| `weeks` | 0.27201 | 0.01412 | 19.26 | < .001 |

: Table 5.2: Multiple regression predicting birth weight from prenatal visits and gestational weeks (n = 944; $R^2$ = 30.76%; adjusted $R^2$ = 30.61%; F(2, 941) = 209.02; p < .001).

When you run this new model, you will observe a structural shift in your primary predictor. The slope for `visits` shrinks by more than half, though it remains statistically significant.



Why did this happen? The multiple regression model is now controlling for gestational duration. It successfully neutralized the confounding variable. It is answering a much more specific and useful question. It asks: "If we only compare mothers whose pregnancies lasted the same number of weeks, does the number of prenatal visits still affect birth weight?" The answer is yes, but the effect is much smaller. The original positive slope was inflated by the confounding factor. Mothers with longer pregnancies made more visits, and longer pregnancies also produced heavier babies. The extra visits were partly a marker for longer gestation, so the simple slope gave them too much credit.



By adding predictors, we strip away the confounding noise. This allows us to see how one specific variable behaves when all other factors in the model are frozen in place.

## 5.4 Evaluating the Model

You just built a multiple regression model to neutralize a confounding factor. However, before you analyze individual variables, you must look at the big picture. Does your new complex model explain anything useful?



To answer this, you will first check the overall model significance. Statistical software provides a test statistic for the entire equation. This is often called an F-value, and it comes with an overall p-value. For our birth weight model, the software calculates a p-value below $0.001$. Because this is less than $0.05$, you have strong evidence that your model is effective. It confirms that at least one of your predictors is successfully tracking the infant's birth weight.



Next, you must assess the model's accuracy. In Chapter 4, you used $R^2$ for this task. Our software reports a regular $R^2$ of $30.76\%$.



At this point, you might be tempted to add more variables to push that percentage higher. In the modern era of data science, computing power is cheap and datasets are massive. It is easy to throw dozens of predictors into a model just to see what sticks. However, regular $R^2$ has a mathematical flaw. It will always increase when you add a new variable, even if that variable is complete nonsense.



To fix this illusion, statistical software calculates an **Adjusted $R^2$**. This modified metric penalizes your model for adding useless variables. If you add a strong predictor, the Adjusted $R^2$ goes up. If you add random noise, the Adjusted $R^2$ actually goes down. When you evaluate a multiple regression model, you should always report the Adjusted $R^2$ to measure true accuracy.



Our software reports an Adjusted $R^2$ of $30.61\%$. It is slightly lower than the regular $R^2$, which reflects the built-in mathematical penalty for using two predictors. This tells us that prenatal visits and gestational duration explain $30.61\%$ of the total variation in infant birth weights. The remaining $69.39\%$ of the variation is driven by other biological or environmental factors that we did not include.



Now you can look at the regression equation itself. Your statistical software generates the following mathematical formula:



$$\text{Predicted Weight} = -3.596 + 0.02489(\text{visits}) + 0.27201(\text{weeks})$$



How do you interpret these specific numbers? You must always include the concept of holding other factors constant. The slope for prenatal visits (`visits`) is $0.02489$. This means for every additional prenatal visit, the infant's birth weight increases by an average of $0.02489$ pounds. Crucially, this interpretation is only true assuming the length of the pregnancy stays exactly the same.



The slope for gestational duration (`weeks`) is $0.27201$. For every additional week of pregnancy, the birth weight increases by an average of $0.27201$ pounds. Again, this specific increase assumes the number of prenatal visits remains perfectly constant.



Finally, look at the starting value, which is the intercept of $-3.596$. By definition, the regression intercept is the predicted outcome when all of your predictors are exactly zero. In this model, that means predicting the birth weight for a mother who made zero prenatal visits and was pregnant for zero weeks. This is biologically impossible. Therefore, this specific intercept simply anchors the math behind the scenes. It has no meaningful real-world interpretation for your research.

## 5.5 Evaluating Predictors

Once you build a multiple regression model, you might wonder which variable is doing the most work. You might be tempted to just look for the largest slope. You must avoid this common trap.



Regression slopes are tied to their specific units of measurement. You cannot directly compare the slope for a number of prenatal visits to the slope for a pregnancy length in weeks. The units simply do not match.



How do we compare the strength of these predictors? We compare each slope to its own **standard error**. The standard error represents the expected background noise or uncertainty for that specific estimate. By dividing the slope by its standard error, we get a rough proxy for the variable's signal strength.



Here is the actual mathematical output for our model predicting neonatal birth weight (`weight`) using prenatal visits (`visits`) and gestational duration (`weeks`):

| Predictor | Coefficient | SE | T-value | p |
| :--- | ---: | ---: | ---: | ---: |
| `visits` | 0.02489 | 0.00882 | 2.82 | .005 |
| `weeks` | 0.27201 | 0.01412 | 19.26 | < .001 |

: Table 5.3: Coefficients, standard errors, and T-values for the two predictors in the model in Table 5.2.

The slope for `visits` is $0.02489$. The slope for `weeks` is $0.27201$. It looks like `weeks` has a much larger effect. But remember, a prenatal visit and a week of pregnancy are different units.



Instead of looking at the raw slopes, we must look at the test statistic. In your software output, this is labeled as the T-Value. This value is simply the slope divided by the standard error.

The T-Value for `visits` is $2.82$. This means the visits signal is $2.82$ times larger than its background noise. The p-value is $0.005$. Because this is less than our standard $0.05$ threshold, the number of prenatal visits is a statistically significant predictor.



Now look at `weeks`. The T-Value is $19.26$. The gestational duration signal is more than $19$ times larger than its background noise. The p-value is below $0.001$, which is highly significant.



Both variables are statistically significant predictors of birth weight. Comparing the T-values reveals the true story: gestational duration provides a much stronger and clearer signal than the number of prenatal visits.

## 5.6 Binary Predictors

Up to this point, all of our predictors have been numerical variables. But what if we want to include a category? In social science research, we frequently need to control for group membership or behavioral choices.



Consider the `habit` variable in our dataset. This categorical variable records the mother's tobacco smoking status during pregnancy. It classifies mothers as either a nonsmoker or a smoker.



Regression models run on mathematical equations. We cannot multiply a slope by a text word like "smoker." We must translate these categories into numbers. We do this by creating an **indicator variable**. Some textbooks refer to this as a dummy variable.



Statistical software handles this translation behind the scenes. It assigns a $1$ to one category and a $0$ to the other. For example, the software might set $1 = \text{smoker}$ and $0 = \text{nonsmoker}$.



We can now introduce this indicator variable into our multiple regression model. We will use the smoking indicator to predict birth weight, while controlling for gestational weeks.

| Predictor | Coefficient | SE | t | p |
| :--- | ---: | ---: | ---: | ---: |
| Intercept | -3.212 | 0.528 | -6.09 | < .001 |
| `weeks` | 0.2704 | 0.01358 | 19.92 | < .001 |
| `smoker` | -0.3865 | 0.1081 | -3.57 | < .001 |

: Table 5.4: Multiple regression predicting birth weight from gestational weeks and smoking status (n = 981; $R^2$ = 30.39%; adjusted $R^2$ = 30.25%; F(2, 978) = 213.51; p < .001).

*Note: 19 mothers with no recorded smoking status are excluded, so the model uses 981 births.*

Your software will generate a regression equation that looks like this:



$$\text{Predicted Weight} = -3.212 + 0.2704(\text{weeks}) - 0.3865(\text{smoker})$$



How do we interpret the slope for an indicator variable? It is actually quite intuitive. Because the variable only equals zero or one, the slope acts like an on-and-off switch. If the mother is a nonsmoker, the variable is zero. The slope of $-0.3865$ is multiplied by zero and vanishes from the equation. If the mother is a smoker, the variable is one. The slope is multiplied by one and stays in the equation.



Therefore, the slope for the smoker indicator represents the average difference in birth weight between a smoker and a nonsmoker. Specifically, the model tells us that babies born to mothers who smoke weigh an average of $0.387$ pounds less than babies born to nonsmokers.



Crucially, this difference assumes we are comparing mothers whose pregnancies lasted the same number of weeks. This allows us to isolate the unique impact of tobacco use on neonatal health, separated from the confounding effect of gestational duration.



## 5.7 Categorical Predictors

The `habit` variable is a binary predictor because it only has two possible answers. But what happens if a survey asks a question with three or more possible categories?



Imagine you want to control for maternal education level. You might have three categories. These categories could be High School, Bachelor's Degree, and Graduate Degree. We cannot just assign $1$, $2$, and $3$ to these categories. That would force the model to treat education as a numerical variable. It would mathematically claim that a Graduate Degree is exactly three times larger than a High School education. That simply does not make sense.



Instead, the software uses a specific rule. If a categorical variable has $k$ possible values, the model will create $k-1$ separate indicator variables. Because our education example has three categories, the software creates two indicator variables. It does this by selecting one category to be the **baseline group**. Some software programs call this a reference group. The baseline group gets hidden inside the model's intercept.



Suppose the software chooses High School as the baseline group. It will then create an on-and-off switch for Bachelor's Degree. It will also create a separate on-and-off switch for Graduate Degree.



Our dataset does not actually track maternal education, so let's look at a hypothetical example to see how the math works. Imagine your software generates the following multiple regression equation. We are predicting birth weight using gestational weeks, a Bachelor's Degree indicator, and a Graduate Degree indicator. High School is our hidden baseline group.



$$\text{Predicted Weight} = -4.05 + 0.28(\text{weeks}) + 0.15(\text{Bachelor}) + 0.22(\text{Graduate})$$



How do you interpret the categorical slopes? You must compare them directly to the baseline group.



The slope for the Bachelor's Degree is $0.15$. This means a mother with a Bachelor's Degree has a heavier infant on average. The baby weighs $0.15$ pounds more than a baby born to a mother with only a High School education. Remember, this interpretation assumes both pregnancies lasted the same number of weeks.



The slope for the Graduate Degree is $0.22$. A mother with a Graduate Degree has an infant weighing $0.22$ pounds more, on average, compared to the High School baseline. Again, this assumes the gestational duration is held perfectly constant.



Notice what the model does not tell you directly. The equation does not immediately show a slope for a High School education. Because both indicator variables turn to zero, that group simply relies on the baseline formula of $-4.05 + 0.28(\text{weeks})$.



By using indicator variables, you can incorporate complex survey responses into your models. You simply must remember which group serves as your hidden baseline comparison.



## 5.8 Interactions

So far, we have assumed that our predictors act independently. We assumed that the penalty for smoking is exactly the same for every mother, regardless of her age. However, social and biological factors often intertwine.



Sometimes, the effect of one variable changes depending on the value of another variable. We call this overlapping influence an **interaction**.



Here is a new research question: Does the negative impact of maternal smoking (`habit`) vary based on clinical age maturity categories (`mature`)? To answer this, we must add an interaction term to our model. Software does this by multiplying the two indicator variables together.



Imagine your software generates this new equation:



$$\text{Predicted Weight} = -3.272 + 0.2710(\text{weeks}) - 0.3621(\text{smoker}) + 0.2260(\text{mature}) - 0.1217(\text{mature} \times \text{smoker})$$

### The Hierarchy Rule for Main Effects

Before we interpret the math, you must memorize a strict structural rule. If you include an interaction term in your model, you must also include the individual variables that make up that interaction. We call these individual variables the **main effects**.



You cannot have the `mature` $\times$ `smoker` interaction term without also keeping the separate `mature` and `smoker` terms in the equation. Why? An interaction term is a specific adjustment to the baseline main effects. If you delete the main effects, the interaction term loses its anchor. It becomes mathematically meaningless.

### Interpreting the Math

How do we read this complex equation? We just look at our on-and-off switches again.

If a younger mother is a nonsmoker, both the `mature` and `smoker` indicators are zero. The interaction term is $0 \times 0$, which equals zero. It vanishes.



If a younger mother is a smoker, the interaction term is $0 \times 1$, which is still zero. It vanishes.

The interaction term only activates when both conditions are met. If a mature mother is a smoker, the interaction term is $1 \times 1$, which equals one. The switch turns on. This mother's predicted baby weight receives the $-0.3621$ penalty for smoking, the $+0.2260$ adjustment for being mature, and an additional $-0.1217$ penalty specifically because she is a mature smoker.

### The Rule for p-values

When you include an interaction term, the mathematical rules for evaluation change. The p-values for your individual main effects no longer tell you the overall story.



In our example, the p-value for the `smoker` variable no longer tests the general effect of smoking. It only tests the effect of smoking specifically for younger mothers. It does this because the younger mother category is where the `mature` variable equals zero. The overall main effect gets absorbed into the complex interaction math.



This leads to a second strict rule for interactions. If your model contains an interaction term, you must ignore the p-values for the individual main effects. You should only look at the p-value for the interaction itself.



In this model, the p-value for the `mature` $\times$ `smoker` interaction is $0.707$. Because this is far above our $0.05$ threshold, the interaction is not statistically significant. The extra $-0.1217$ penalty is just random noise.



When an interaction is not significant, you should delete it from your model. You then rerun the analysis using only the main effects. Once you have that simpler model, you can safely read the p-values for the individual variables again.

## 5.9 Multicollinearity

When we build multiple regression models, we want to add predictors that bring new, unique information to the table. But what happens if two predictors bring the same information?

Imagine trying to predict a student's height using their left shoe size and their right shoe size. These two variables overlap almost entirely. If you put both into a model, the math gets confused. The variables fight each other for the credit.



This disruptive overlap is called **multicollinearity**. When multicollinearity is present, the model cannot figure out which variable is driving the change. As a result, the slopes become unstable and unreliable.



How do we spot this problem? We use a diagnostic metric called the **Variance Inflation Factor (VIF)**. Statistical software calculates a VIF for every predictor in your model.



The interpretation is straightforward. A VIF of $1$ means there is absolutely zero overlap. A VIF between $1$ and $5$ indicates mild, harmless overlap. However, if a VIF climbs above $5$ (or especially above $10$), you have severe multicollinearity. You must fix this by removing one of the overlapping variables.



Let's look for this issue in our dataset. We will build a model to predict birth weight using both the biological mother's age (`mage`) and the biological father's age (`fage`). In society, partners are often similar in age. We might naturally expect these two variables to overlap heavily and cause a severe VIF warning. Here is the resulting equation:



$$\text{Predicted Weight} = 6.822 - 0.00863(\text{fage}) + 0.0242(\text{mage})$$



When we check the software diagnostics, the VIF is only $1.93$.



This is a perfect example of why we rely on data rather than assumptions. While the parents' ages are related, they do not overlap enough to break the model. The VIF is well below the danger zone of $5$. The model can safely distinguish between the two variables.

## 5.10 Common Mistakes and Misconceptions

As you transition from simple models to multiple regression, the math becomes more complex. Here are the most common traps researchers fall into when analyzing multiple variables at once.

### The "Low $R^2$ is a Failure" Trap

In introductory math classes, textbook problems are designed to work out perfectly. You might expect an $R^2$ of $90\%$ or higher. But you are now doing real social science research. As you experimented with our birth weight dataset, you likely noticed that the highest $R^2$ we achieved was roughly $30\%$.



Do not view this as a failure. Humans are incredibly complex, messy, and unpredictable. In epidemiology and social science, explaining $30\%$ of the biological variation in birth weights using just a few survey questions is actually a massive success. The remaining $70\%$ is simply the natural, unmeasured diversity of the human experience. Do not throw away a good model just because it does not look like a perfect math equation.

### The Kitchen Sink Trap and Overfitting

Because regular $R^2$ always increases when you add variables, novice researchers often throw every available column into their model. We call this the kitchen sink approach.



This creates a dangerous problem called **overfitting**. Overfitting happens when your model becomes too complex. Instead of finding the true underlying pattern, an overfitted model starts memorizing the random background noise in your specific sample.



If you use an overfitted model to make predictions on new people, it will fail miserably. It is too customized to your original dataset. On the other end of the spectrum, a model with too few predictors is "underfit" and misses the real story. We saw this earlier when our simple model suffered from omitted variable bias.



Building a multiple regression model is a balancing act. You are looking for the "Goldilocks" model. It should be just complex enough to capture the real signal, but simple enough to ignore the random noise. Always let your original research question guide your choices. Rely on your Adjusted $R^2$ to verify if a new variable actually improves your model's true accuracy.

### The Causation Illusion

Multiple regression is a powerful tool for neutralizing confounding variables. By "controlling for" factors like gestational weeks, we get a much clearer picture of reality. Because the math feels so solid, people often start using words like "causes" or "proves."



You must remember the lesson from Chapter 2. Our birth records dataset is observational data. We did not run a randomized controlled experiment. Even after adding multiple predictors, we can only prove that an association exists. There could always be another unmeasured confounding factor, such as maternal genetics or local environmental pollution, hiding out in the noise.

### The Autopilot Trap

Statistical software often includes a button for **automated model selection**. This tool uses algorithms to add or remove predictors based entirely on p-values. You must avoid using this feature.



These algorithms are blind to reality. They do not understand biology, psychology, or economics. They only see numbers. If you let the software build your model, you will often create nonsensical equations that suffer from severe overfitting.



This brings us to a hard lesson about real research. Sometimes, you should keep a predictor in your model even if its p-value is not significant. If a variable has a strong **theoretical justification**, it belongs in your equation.



For example, an economist might keep a specific financial metric in a model because economic theory demands it. A high p-value simply means this specific sample did not provide enough evidence to confirm the effect. It does not prove the variable is useless in the real world.

You are a human researcher, not a calculator. You must use your understanding of the real world to build your models. Always let logic, prior research, and scientific theory drive your choices, rather than relying on software autopilot.



That perfectly caps off the conceptual lessons for this chapter. We have covered confounding variables, interpreting multiple slopes, binary and categorical predictors, interactions, multicollinearity, and the major conceptual traps.

### The "Bigger Slope Means Bigger Impact" Fallacy

When you look at a multiple regression equation, it is incredibly tempting to just look for the largest slope. You might assume the biggest number is the most important variable. You must avoid this trap.



Regression slopes are tied directly to their units of measurement. You cannot compare a slope measured in years to a slope measured in weeks. To evaluate which predictor provides the strongest signal, you must look at the T-Values in your software output. The T-Value compares the slope against its own background noise, giving you a safe way to evaluate variable strength.

### Forgetting the Baseline Group

When you add categorical variables to a model, the software creates on-and-off switches using indicator variables. It is easy to look at the slope for a category, such as a Bachelor's Degree, and interpret it as an absolute value.



That slope only exists in comparison to the hidden baseline group. If your baseline is a High School education, the Bachelor's Degree slope only tells you the difference between those two specific groups. It does not represent the entire population average.

## 5.11 Reading Published Research

When you read social science journals, you will rarely see a single regression equation. Instead, researchers use a **side-by-side model comparison table**. This format allows you to watch the math change as new control variables are added.



Here is a simulated example. Imagine a team of economists wants to predict a worker's annual starting salary. They build three separate models to explore the returns on education.

| **Predictor Variable**  | **Model 1 (Base)**           | **Model 2 (Demographics)**   | **Model 3 (Full Model)**    |
| ----------------------- | ---------------------------- | ---------------------------- | --------------------------- |
| **Years of Education**  | $4,500\text{***}$ $(450)$    | $3,800\text{***}$ $(410)$    | $2,100\text{*}$ $(850)$     |
| **Years of Experience** |                              | $1,200\text{**}$ $(380)$     | $1,050\text{**}$ $(350)$    |
| **Parental Income**     |                              |                              | $0.15\text{***}$ $(0.02)$   |
| **Intercept**           | $25,000\text{***}$ $(1,200)$ | $18,000\text{***}$ $(1,500)$ | $12,500\text{**}$ $(4,000)$ |
|                         |                              |                              |                             |
| **Adjusted $R^2$**      | $0.12$                       | $0.24$                       | $0.38$                      |
| **Sample Size ($n$)**   | $1,500$                      | $1,500$                      | $1,500$                     |

: Table 5.7: A simulated side-by-side comparison of three regression models predicting annual starting salary.

*Note: Standard errors are reported in parentheses with the coefficients.*

\* p < 0.05, \*\* p < 0.01, \*\*\* p < 0.001



At first glance, this wall of numbers can look intimidating. However, you can decode it easily by following a four-step visual checklist.

### Step 1: Demystifying the Asterisks

Academic journals have strict page limits. Researchers do not have room to print the exact p-value for every single slope. Instead, they use **significance stars**.



Look at the footnote at the bottom of the table. A single star means the p-value is less than $0.05$. Two stars mean the p-value is less than $0.01$. Three stars mean the p-value is less than $0.001$. You can quickly scan the table for stars to see which variables are statistically significant. Remember that more stars simply indicate a stronger signal cutting through the noise. They do not necessarily mean the real-world effect is large.

### Step 2: Decoding the Parentheses

The numbers next to the slopes in parentheses are actually standard errors. Novice researchers often confuse these with confidence intervals, but they are actually quite different.



Journals provide the standard error so readers can independently verify the precision of the estimate. This gives you a fantastic mental shortcut. If you double the standard error and add and subtract it from the slope, you will get a rough 95% confidence interval.



For example, look at the Years of Experience in Model 3. The slope is $1,050$ and the standard error is $350$. Doubling the standard error gives us $700$. This means we can be roughly 95% confident that the true population return on a year of experience is somewhere between $350$ and $1,750$.



However, unless you need to analyze a specific variable's exact range, you can generally ignore the parentheses on your first read-through and focus on the main slopes and their significance stars.

### Step 3: Tracing a Variable Across Models

This is the most important step. You must trace your primary variable horizontally from left to right. This allows you to spot omitted variable bias in action.



In Model 1, the slope for the "Years of Education" variable is $4,500. This suggests a large financial return for every extra year of schooling. Now look at Model 2. The researchers added "Years of Experience" to the equation. The slope for education drops to $3,800. Finally, look at Model 3. The researchers added "Parental Income." This is a major confounding factor in both educational access and financial networking. When we control for parental income, the slope for education plummets to $2,100. It also loses two significance stars. The correct interpretation here is that the original $4,500 slope was heavily inflated by confounding variables.

### Step 4: Evaluating the Big Picture

Finally, examine the bottom rows of the table. You want to see if the added complexity was worth it.



Let's take a look at the Adjusted $R^2$. In Model 1, education alone only explained $12\%$ of the variation in starting salaries. By Model 3, the Adjusted $R^2$ climbs to $38\%$. This steady increase proves that adding experience and parental income was theoretically justified. The full model gives us a much more accurate and honest picture of reality. Be suspicious of more complex models that end up have lower Adjusted $R^2$, as that typically means the additional complexity did not add utility to the model.

## 5.12 Guided Analysis: The Wage Gap

To bring all of these concepts together, we will walk through a complete research scenario. We will explore the gender wage gap in higher education using the `college_teacher_salary_2023.csv` dataset. This dataset contains a random sample of 200 postsecondary educators in the United States.



**The Research Question:** Does a postsecondary educator's biological sex influence their annual teaching salary, even after controlling for age and educational attainment?

We will focus on four variables:

- **`Salary`**: A numerical response variable recording annual pay in thousands of dollars.
- **`Sex`**: A categorical predictor where 1=male and 0=female.
- **`Age`**: A numerical predictor tracking the educator's age in years.
- **`PhD`**: A categorical predictor where 1=holds a PhD and 0=does not hold a PhD.

### Step 1: The Raw Gap

We begin by looking at the raw, unadjusted relationship. We run a simple linear regression using only `Sex` to predict `Salary`.

| Predictor | Coefficient | SE | t | p |
| :--- | ---: | ---: | ---: | ---: |
| Intercept | 61.670 | 7.030 | 8.77 | < .001 |
| `Sex` | 31.427 | 9.796 | 3.21 | .002 |

: Table 5.5: Simple linear regression predicting annual teaching salary, in thousands of dollars, from sex (1 = male, 0 = female; n = 200; $R^2$ = 4.94%; adjusted $R^2$ = 4.46%; F(1, 198) = 10.29; p = .002).

The software reports a slope of 31.43 for the `Sex` indicator variable. Because 1=male and the salary is measured in thousands, this means the average male educator in our sample makes $31,427 more than the average female educator. The p-value for this slope is 0.002. This tells us the initial wage gap in this dataset is statistically significant.

### Step 2: Adding Confounders

However, we must think critically. Are men simply paid more? Or are there confounding variables at play? Perhaps the men in this specific random sample happen to be older, meaning they have more years of experience. Perhaps a higher percentage of the men in this sample hold a PhD. Both age and education strongly influence salary.



If we ignore these factors, our model suffers from omitted variable bias. To fix this, we build a multiple regression model. We predict `Salary` using `Sex`, `Age`, and `PhD` all at the same time.

| Predictor | Coefficient | SE | t | p |
| :--- | ---: | ---: | ---: | ---: |
| Intercept | 6.522 | 14.575 | 0.45 | .655 |
| `Sex` | 27.645 | 9.132 | 3.03 | .003 |
| `Age` | 0.734 | 0.306 | 2.40 | .017 |
| `PhD` | 48.554 | 9.303 | 5.22 | < .001 |

: Table 5.6: Multiple regression predicting annual teaching salary, in thousands of dollars, from sex (1 = male, 0 = female), age, and PhD status (1 = holds a PhD, 0 = does not; n = 200; $R^2$ = 22.06%; adjusted $R^2$ = 20.86%; F(3, 196) = 18.49; p < .001).

### Step 3: Controlling for Variables in Action

When we look at the new model, we see a dramatic shift. The slope for `Age` is 0.73 (an extra $734 per year of age). The slope for `PhD` is 48.55 (an extra $48,554 for holding a doctorate).

But look at what happened to the slope for `Sex`. It shifted to 27.64. Furthermore, the new p-value for `Sex` is 0.003.



Because this is still less than 0.05, the wage gap remains statistically significant. This is exactly what it means to **control for** a variable. The new slope of 27.64 represents the average pay difference between a man and a woman *even when they are the same age and hold the same degree status*. While the gap may have changed from our initial estimate, controlling for age and education establishes that the discrepancy is not just a statistical shadow cast by experience or degree status.

### Step 4: APA Reporting

When reporting multiple regression results in formal research, you must provide the reader with the overall model accuracy, the overall model significance, and the strength of the individual predictors. If your model has many predictors, researchers typically place the slopes and standard errors into a formatted table. For smaller models, you can report the findings directly in the text.



Here is how you would write an APA-formatted conclusion for our analysis:

> "A multiple regression was conducted to predict annual teaching salary from biological sex, age, and doctoral degree status. The overall model was statistically significant, *F*(3, 196) = 18.49, *p* < .001, with an Adjusted $R^2$ of .21. While age (*p* = .017) and holding a PhD (*p* < .001) were significant positive predictors of salary, biological sex was also a significant predictor (*p* = .003) when controlling for these factors."

## 5.13 Key Concepts

1. **Multiple regression** expands our modeling toolkit by allowing us to predict a continuous numerical outcome using two or more predictors simultaneously.
2. Adding predictors allows us to account for **confounding factors** and cure **omitted variable bias**.
3. To **control for** a variable means to mathematically hold it constant, isolating the unique effect of your primary predictor.
4. You cannot compare the raw slopes of different variables because they rely on different units of measurement. You must use the **T-Value** to compare a slope against its standard error to evaluate a variable's strength.
5. Categorical predictors are entered into regression equations using **indicator variables** (or dummy variables) that act as mathematical on-and-off switches.
6. If a categorical variable has $k$ possible values, the model requires $k-1$ indicator variables. The left-out category becomes the hidden **baseline group**, and all categorical slopes are interpreted as a direct comparison against that baseline.
7. **Interactions** occur when the effect of one variable changes based on the value of another variable. If an interaction term is included in a model, the individual **main effects** must also be included, and their individual p-values should be ignored.
8. **Multicollinearity** happens when predictors overlap heavily and fight for credit in the equation. It is tracked using the **Variance Inflation Factor (VIF)**, where values above 5 signal a dangerous overlap.
9. **Adjusted $R^2$** penalizes a model for adding useless variables. It is the best metric for evaluating multiple regression accuracy and helps prevent researchers from **overfitting** their models to random noise.

## 5.14 New Notation

| **Symbol**         | **How it is read aloud**               | **What it represents in plain words**                        |
| ------------------ | -------------------------------------- | ------------------------------------------------------------ |
| $R^2_{\text{adj}}$ | "Adjusted R-squared"                   | The percentage of variation in the response variable explained by the model, mathematically penalized for the inclusion of useless predictors. |
| VIF                | "V-I-F" or "Variance Inflation Factor" | A diagnostic test statistic that measures how much a specific predictor overlaps with the other predictors in the model. |

: Table 5.8: Notation introduced in this chapter.

## 5.15 Exercises

### Interpretation

1. A public health researcher is trying to predict a county's average life expectancy. They build a multiple regression model using the median household income and the percentage of residents who smoke. The model has an Adjusted $R^2$ of $42\%$. They then decide to add a third variable tracking the number of fast-food restaurants in the county. After running the new model, the regular $R^2$ goes up to $43\%$, but the Adjusted $R^2$ drops to $40\%$. Explain what this drop in Adjusted $R^2$ tells the researcher about their new variable.
2. An educational psychologist builds a model to predict standardized test scores. The model uses "hours studied" and a binary indicator variable for "took a prep course" (where $1 = \text{took the course}$ and $0 = \text{did not take the course}$). The software reports a slope of $+12.5$ for the prep course indicator. Interpret what this slope means in plain English. Be sure to mention the concept of holding the other variable constant.
3. A corporate analyst is trying to predict employee job satisfaction. They include three predictors in their model: base salary, annual bonus amount, and total yearly compensation. The software flags the total yearly compensation variable with a Variance Inflation Factor (VIF) of 14. What does this VIF value tell you about the variables in the model, and how should the analyst fix the problem?
4. A real estate economist is investigating housing prices. They create a model using square footage, a binary indicator for having a swimming pool, and an interaction term between square footage and the pool indicator. The p-value for the interaction term is $0.45$. What does this p-value tell the economist about the relationship between house size and swimming pools, and what exact step should they take next with their model?

### Choosing a Method

5. A sociologist notices a strong positive correlation between a city's monthly ice cream sales and the number of political protests that occur in that same month. It looks like ice cream consumption might be driving political unrest. Identify a likely confounding variable that is missing from this analysis. Explain how building a multiple regression model could help the sociologist isolate the true relationship.
6. You are designing a study to predict a person's credit score based on their annual income and their relationship status. Your survey tracks relationship status using four distinct categories (Single, Married, Divorced, Widowed). When you put this categorical variable into your statistical software, how many indicator variables will the software create behind the scenes? Explain what happens to the remaining category.
7. An economist wants to predict a state's median household income. They have data on the percentage of adults with college degrees (a numerical variable) and the geographic region of the state (a categorical variable with categories like Northeast, South, Midwest, West). Should they use a simple linear regression, a multiple regression, or an independent samples t-test? Justify your choice based on the types and number of variables involved.

### Communicating Results

8. A fellow student is presenting their research on commute times. They used a multiple regression model to predict the total commute time in minutes. Their predictors were the distance traveled in miles (slope = $1.2$) and the driver's age in years (slope = $0.05$). The student concludes their presentation by stating, "Because the slope for distance is so much larger than the slope for age, distance is a much stronger predictor." Explain the fatal flaw in this communication and tell the student which metric they should look at to compare variable strength.
9. A journalist reads a published multiple regression study about academic success. The study shows that eating a nutritious breakfast is positively associated with higher college GPAs, even after the researchers explicitly controlled for family income and high school performance. The journalist publishes an article with the headline: "Study Proves Eating Breakfast Causes Better Grades." Explain why this headline is ethically and scientifically flawed, and provide a more accurate alternative.
10. You are reviewing a research paper draft written by a colleague. They proudly explain that they used their software's "Automated Model Selection" button to build their regression equation. The software tested 50 different variables and spit out a final model with 12 predictors. Half of these predictors have no logical connection to the research topic. Explain the dangers of the "Autopilot Trap" to your colleague. Introduce the concept of overfitting and explain why theoretical justification is required in real research.

### Software Application

For this section, you will use statistical software to analyze the `college_teacher_salary_2023.csv` dataset. This dataset contains a random sample of 200 postsecondary educators in the United States. You will investigate the complex factors that influence a professor's annual teaching salary, which is recorded in thousands of dollars.



11. **Exploring the Wage Gap:** We often hear about the gender wage gap in education. Let's explore this using our dataset.
a) Run a simple linear regression predicting `Salary` using only the `Sex` indicator variable ($1 = \text{male}$, $0 = \text{female}$). What is the slope for `Sex`, and what does it tell you about the raw difference in pay?
b) Now, build a multiple regression model by adding `Age` to the equation. Look at the new slope for `Sex`. Did the gap widen, shrink, or reverse?
c) Explain conceptually why the slope for `Sex` changed when you added the other variables. Use the phrase "controlling for" in your answer.



12. **Evaluating the Model and Predictors:** Evaluate the overall accuracy and the individual predictors in your multiple regression model from Question 1b.
a) Find the Adjusted $R^2$ value in your software output. Interpret what this percentage means regarding the variation in teacher salaries. Why should you report this metric instead of the regular $R^2$?
b) Look at the slopes for `Age` and `Sex`. Because they use entirely different units (years versus a biological sex), you cannot compare the slopes directly. Which specific metric in your software output should you use instead to see which variable has a stronger influence on salary?
c) Compare those specific metrics for `Age` and `Sex`. Which variable provides the stronger signal in this dataset?



13. **Checking for Multicollinearity:** Before finalizing a model, researchers must check for overlapping variables that might confuse the math.
a) Construct a multiple regression model with `Age`, `Sex`, and `PhD` as predictors and `Salary` as the response. Use your software to calculate and report the Variance Inflation Factor (VIF) for  each predictor in your multiple regression model.
b) Based on our rule of thumb, is multicollinearity a severe problem in this specific dataset? Explain your reasoning.



14. **Testing for Interactions:** We might wonder if the financial reward for earning a PhD is identical for both men and women, or if those two variables interact.
a) Use your software to add an interaction term between `Sex` and `PhD` to your multiple regression model.
b) Locate and report the p-value specifically for this new interaction term.
c) Based on this p-value, does the interaction belong in your final equation, or should you delete it? Explain the rule you used to make this decision.
