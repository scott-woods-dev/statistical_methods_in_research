# Chapter 2 Outline: From Research Questions to Formal Hypotheses

## Motivating Example / Running Dataset
- **Study**: Bertrand & Mullainathan (2004) field experiment on racial discrimination in corporate hiring
- **Dataset**: `labor_market_discrimination.csv` — subset of ~4,800 fictitious resumes submitted to help-wanted ads in Boston and Chicago newspapers
- **Variables used**:
  - `first_name`: categorical — specific first name assigned (e.g., "Emily"/"Greg" for White, "Lakisha"/"Jamal" for African-American)
  - `race`: categorical — perceived racial identity ('b' = Black, 'w' = White)
  - `call`: categorical outcome — callback received (1 = yes, 0 = no)
  - `n_jobs`: numerical — total prior jobs listed on resume
  - `years_exp`: numerical — years of professional experience listed
- **Key finding**: White-sounding names received 50% more callbacks than identical African-American-sounding name resumes

## Section 2.1: Introduction
- Chapter objective: translate broad research interests into a concrete statistical framework (measurable variables, data quality evaluation, formal null/alternative hypotheses)

## Section 2.2: The Scientific Process
- **Research goal**: general statement about the phenomenon to understand (e.g., "investigate systemic racial discrimination in corporate hiring")
- **Research question**: specific, measurable relationship between defined variables derived from the research goal
- One research goal can spawn multiple valid research questions (examples given: salary offers, promotion rates, recruiter reading time)

## Section 2.3: Operationalization of Variables and Proxy Variables
- **Operationalization**: process of defining exactly how an abstract concept will be measured in a study
- **Proxy variable**: measurable characteristic that stands in for an unobservable or difficult-to-measure concept
- Example from motivating study: `first_name` used as proxy variable for perceived racial identity

## Section 2.4: Measurement Quality — Reliability and Validity
- **Reliability**: consistency of measurement across repeated attempts under same conditions
- **Validity**: whether the measurement actually captures what it claims to measure
- A measure can be reliable without being valid (broken scale analogy)
- Example from motivating study: `call` is a valid measure of *initial* labor market interest, but not a valid measure of ultimate hiring rates or starting salary

## Section 2.5: Internal Consistency and Cronbach's Alpha
- **New dataset**: `amas_math_anxiety.csv` — Abbreviated Math Anxiety Scale (AMAS), administered to 2,200 adults
- AMAS uses nine items (`item_1` through `item_9`), rated 1–5 (low to high anxiety) in various scenarios
- **Summated scale**: measurement tool combining multiple targeted questions into a single overall score
- **Internal consistency**: type of reliability measuring how well different survey items hang together
- **Cronbach's alpha ($\alpha$)**: statistic ranging from 0 to 1; threshold of **0.70 or higher** considered acceptable in social sciences; AMAS exceeds 0.80

## Section 2.6: Methods of Data Gathering
### Observational Studies
- Researchers observe and measure without manipulating the environment
- Examples: surveys, polls, tax records analysis
- Vulnerabilities: bias (poorly worded questions, non-response bias), confounding variables
- Cannot prove cause-and-effect; can only show association

### Experimental Design
- Three core principles: **Control**, **Randomization**, **Replication**
- Bertrand & Mullainathan study applied all three: identical resumes (control), random name assignment (randomization), ~4,800 submissions (replication)
- Randomized controlled experiments are the gold standard for causal claims

## Section 2.7: Translating Research Questions into Statistical Questions
- A statistical question must meet three requirements:
  1. Requires gathering data
  2. Accounts for variability across samples
  3. Identifies a specific statistical measure (mean, median, or proportion)
- Choice of measure depends on the outcome variable type and distribution:
  - **Example 1** (hiring bias): categorical yes/no outcome → use **proportion**; statistical question compares proportions of callbacks between White-sounding and African-American-sounding name groups
  - **Example 2** (student sleep): numerical, symmetric distribution → use **mean**; compares mean weeknight sleep hours for athletes vs. non-athletes
  - **Example 3** (student debt): numerical, right-skewed with outliers → use **median**; compares median student debt of public vs. private university graduates

## Section 2.8: Formalizing Hypotheses
### Null and Alternative Hypotheses
- **Null hypothesis ($H_0$)**: default assumption of "no effect," "no difference," or "no relationship"; always uses strict equality (=)
- **Alternative hypothesis ($H_1$)**: claim that an effect, difference, or relationship exists; also denoted $H_a$ in some fields; always uses $\neq$ (two-sided testing)

### Burden of Proof
- Null represents the skeptical baseline (analogy to criminal trial presumption of innocence)
- Medical placebo example: assume new drug does nothing ($H_0$); researchers must provide overwhelming evidence for $H_1$

### Hypothesis Universals Table
| Feature | $H_0$ | $H_1$ |
|---|---|---|
| Core Meaning | No effect/difference/relationship | Effect/difference/relationship exists |
| Philosophical Stance | Assumed baseline; zero evidence needed to maintain | Requires evidence; burden of proof rests here |
| Mathematical Boundary | Strict equality (=) | Does not equal ($\neq$) |

### Stating Hypotheses with Parameters
- Population parameters use Greek letters (e.g., $\pi$ for true population proportion)
- For the hiring bias study:
  - $\pi_W$: true callback proportion for White-sounding names
  - $\pi_B$: true callback proportion for African-American-sounding names
  - $H_0$: $\pi_W = \pi_B$ (or software format: $\pi_W - \pi_B = 0$)
  - $H_1$: $\pi_W \neq \pi_B$ (or software format: $\pi_W - \pi_B \neq 0$)

## Section 2.9: Common Mistakes and Misconceptions
- **Writing hypotheses after gathering data**: violates scientific method; leads to p-hacking (explored in final chapter on ethics)
- **Confusing reliability with validity**: especially critical for proxy variables; a measurement must be valid before its reliability matters
- **Causation illusion in observational studies**: only randomized experiments can prove causation; observational studies show association only
  - Note: meta-analysis can pool many studies to build convincing causal arguments

## Section 2.10: Key Concepts
1. Scientific process requires translating broad research goal → specific, measurable research question before data collection
2. Operationalization defines how abstract concepts are measured; proxy variables used when direct observation is impossible
3. Validity = accuracy of measurement; Reliability = consistency of measurement
4. Cronbach's alpha ($\alpha$) measures internal consistency of summated scales (0–1 range, 0.70+ threshold)
5. Observational studies identify connections; only randomized experiments prove cause-and-effect
6. Statistical questions must require data, account for variation, and specify a mathematical measure
7. $H_0$: default assumption of no effect/difference; burden of proof to reject it
8. $H_1$: claim of significant effect/difference; established only with overwhelming evidence
9. Two-sided testing ($\neq$) is the modern ethical standard
