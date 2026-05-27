# Chapter Summary Instructions

## Purpose
These summaries are outlines intended for an LLM that will use them to understand what previous chapters covered before writing a future chapter. They are **not** human-readable study guides — they are structural reference documents.

## What to Include
- **Every section heading and subheading** from the chapter, preserving the original numbering (e.g., 5.1, 5.2)
- **The dataset(s) used** throughout the chapter, including variable names and types
- **All notation introduced**: symbols, what they represent, sample vs. population distinctions
- **Specific examples used**, including which variables were paired together in each example (e.g., "GDPperCapita vs. Footprint")
- **Numerical values from worked examples**: specific $r$ values, slopes, intercepts, $R^2$, confidence intervals, Cook's Distance thresholds, etc. — these ground the chapter and may be referenced later
- **Rules of thumb, cutoffs, and checklists** (e.g., Cohen's guidelines, L.I.N.E. acronym)
- **Warnings and caveats** stated in the text (e.g., "do not use ordinal variables as response variable")
- **Cross-references to other chapters** mentioned in the text (e.g., "covered in Chapter 10", "will be covered in Chapter 5")

## What to Exclude
- Explanations, analogies, metaphors, and pedagogical framing meant for student comprehension
- Motivational introductions or narrative hooks
- Exercise questions
- The "Key Concepts" summary section (stop before it)
- The "New Notation" table (notation is already captured inline throughout the outline)
- Any prose that explains *why* something matters — only record *what* was covered

## Format
- Use markdown headings matching the chapter's section structure
- Bullet points for content under each heading
- Keep entries concise: one line per concept, example, or rule
- Preserve mathematical notation in LaTeX format (e.g., `$r$`, `$R^2$`, `$\rho$`)

## Where to Stop
Stop right before the chapter's "Key Concepts" section. Do not summarize Key Concepts, New Notation tables, Exercises, or any other end-of-chapter review material. The outline should cover all substantive sections leading up to that point.
