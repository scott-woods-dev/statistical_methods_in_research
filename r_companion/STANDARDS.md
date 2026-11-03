# R Companion Standards

Rules for every companion chapter and script. The book's `CLAUDE.md` style rules
(no em dashes, the banned words, U.S. English, second person) apply here too.

## Who it is for

Students who have never written code. They do not need to learn R; they need to
copy our code, change the marked lines, and get the values and graphs a chapter
covers for their own data and research. Our datasets and code are the worked
examples. The companion is not tied to the textbook's exercises, so the homework
can change without the companion changing. The textbook explains the
statistics. The companion explains the clicks and the code, with at most a
one-sentence reminder of why a step matters.

## Files

| Path | Role |
| :--- | :--- |
| `_quarto.yml` | Companion book config; renders to `_book/`; `tools/publish.sh` copies it to `../docs/companion/` |
| `index.qmd` | Welcome page: how to use the companion |
| `chapter-NN.qmd` | The guide for chapter NN, beside the book's chapter NN |
| `scripts/chapter_NN.R` | The script students download and run; the guide shows its code |
| `images/chapter_NN/` | Screenshots, named `NN_<what it shows>_<win\|mac>.png` (no ending if both systems look the same) |
| `SCREENSHOTS.md` | Screenshots still needed from the author, with IDs matching `<!-- SCREENSHOT Snn -->` markers in the chapters |
| `companion.scss` | Companion-only styles over the textbook's `custom.scss` |
| `tools/check_scripts.R` | Runs every script against `data/` and reports errors |

The guide never retypes code. Each script is split into named pieces with
`## ---- name ----` lines, and the guide displays them with
`{r name}` chunks (knitr `read_chunk`). The script and the guide cannot drift
apart, and what students download is what they read.

## Scripts

- **Same order every time:** header block, load packages, read the data, then one
  numbered section per analysis, in the order the guide teaches them.
- **Header block:** chapter number and title, a numbered list of what the script
  makes, and the "before you run it" steps (same folder, set working directory).
- **Comments** say what the line does in plain words, above the line. No
  statistics lessons.
- **Every argument is explained** the first time it appears in the companion:
  what it does and what its value means, with units (`width = 7` is 7 inches).
  When students can ignore it, say so ("You can leave it as is"). Functions
  get the same treatment (`c()` combines several values into one list).
- **`# CHANGE THIS:`** goes on its own line directly above each line students
  edit to use their own data, followed by what to put there (for example
  `# CHANGE THIS: your variable name`). Never at the end of a code line.
- **Line length:** 68 characters at most, comments included, so nothing wraps
  in the guide's code boxes.
- **One way of doing things:** base `read.csv()`; `data$Variable` for single
  columns; `ggplot()` for every graph; no pipes (`|>`, `%>%`), no `dplyr` unless
  a chapter needs it, no shortcuts that hide what happens.
- **Named data:** the data frame is called by what it holds (`students`,
  `teachers`), never `df` or `d`.
- **Every graph** has `labs()` with a title and both axis labels in plain words,
  and ends with `theme_minimal(base_size = 14)`. When color shows groups, shape
  shows them too, so the graph reads without color.
- **Colors** come from the textbook's Okabe-Ito palette, written as codes with
  the color's name in a comment: `"#0072B2"` blue for one-color graphs, then
  `"#D55E00"` vermillion, `"#009E73"` green, `"#CC79A7"` pink for more groups,
  in that order (at most four). Filled shapes (bars, boxes) get a black
  outline. Each script's header lists the codes. Never use the palette's
  yellow or orange for points or lines on white; they are too faint.
- **Packages:** `ggplot2`, `psych`, `car`, `emmeans`, `pROC`, `forecast`, and
  base R. Add one only when no listed package does the job.

## Guide chapters

Section order:

1. One short paragraph: what you will make, and which textbook chapter it goes
   with.
2. **The data:** the CSV (backticked file name), a download link, and the
   variables used, with coding keys copied exactly from `data/<name>.md`.
3. One `##` section per analysis: a sentence on what it is for, the code chunk,
   its real output, then where to find each value in that output.
4. A **With your own data** tip box at the end of each analysis: which lines to
   change, and anything that changes with different data (for example, groups
   stored as numbers). It never names an exercise number.

Callouts:

- `callout-warning`, titled `Common error: <what you see>`, placed right after
  the step where the error happens. Body in three parts: **What you see** (the
  exact message R prints, in a code block), **What it means**, **How to fix it**.
  Copy R's error text from a real run, never from memory. Messages from
  installers and websites are described in words, without a code block, until a
  screenshot confirms the wording.
- `callout-tip`, titled `With your own data`, for what to change.
- `callout-note` for an optional extra (saving a graph, a keyboard shortcut).

Callout titles are bold (`companion.scss` in HTML, `fonttitle` in the PDF) and
callouts never split across PDF pages. The type is named in the title text, so
the icon and border color are extras, not the only signal.

Error messages appear more often in early chapters. From chapter 3 on, a
callout covers only errors new to that chapter.

## Coverage and demonstration data

Each chapter covers the main methods of its textbook chapter, enough to get the
values that chapter teaches, but not every option or variation. Choose the
methods students are most likely to need in their own research; the first
chapters cover a small subset, later chapters more of their content.

Our datasets are the examples. Prefer the five datasets the book does not use
(`acs_2023`, `census_at_school`, `smoking_bmi_bp`, `weight_loss_incentive`,
`youth_risk_2007`), then other variables from the chapter's own dataset. Avoid
repeating an exact exercise analysis, so the companion does not become an answer
key.

## Accessibility

- Every graph chunk has `fig-cap` and `fig-alt`. Alt text describes what the graph
  shows (shape, direction, notable values), written after looking at the output.
- Every screenshot has alt text naming the window and what to click.
- No meaning carried by color alone, in graphs or in the prose ("the red button").
- Tables have header rows.
- **Links:** the link text says where the link goes and makes sense read on its
  own, because screen readers can list a page's links out of context. Write
  "[Download `census_at_school.csv`]", never "download it", "here", or "click
  here", and never give two different destinations the same link text. Show a
  bare URL only when students need to see or type the address (CRAN, Posit).
  Links to other sections name the section ("see Install and load packages in
  Getting Set Up"), so the sentence still works on paper.
- **PDF:** links are colored and every web link also gets a footnote with its
  address (`links-as-notes`), so links are not marked by color alone. Long
  code and output lines wrap at the margin. The PDF is not tagged, so it has no
  alt text; the HTML edition is the accessible one, as for the textbook.

## Checks

- `Rscript r_companion/tools/check_scripts.R` runs every script in a temporary
  folder with copies of the CSVs. A script that errors fails the check.
- `tools/style/check_style.sh` covers the companion `.qmd` and `.md` files.
- The companion renders without errors: `quarto render r_companion`.
