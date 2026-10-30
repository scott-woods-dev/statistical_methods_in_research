# Preface {.unnumbered}

## About This Book

This book is about choosing a statistical method, running it, and explaining the result to someone who was not in the room when you ran it. That last part matters as much as the first two. A number on a screen means very little until you can say what it implies about the question you started with.



You will not find derivations, proofs, or pages of critical values here. Those belong in a mathematical statistics course, and they rarely change the decision in front of you. What you will find is the reasoning behind each method, worked examples on real data, and the software output you are likely to meet in practice.



The book is organized into five units.



**Unit I: Foundations of Data Analysis** (Chapters 1-3) covers describing data with numbers and pictures, turning a research question into formal hypotheses, and testing those hypotheses.



**Unit II: Linear Regression and Transformations** (Chapters 4-5) moves from correlation to simple and multiple regression, including the transformations that straighten a curved relationship before you model it.



**Unit III: Design of Experiments (ANOVA)** (Chapters 6-7) turns to studies you design rather than studies you observe, from the one-way analysis of variance to factorial and repeated-measures designs.



**Unit IV: Categorical Data Analysis** (Chapters 8-9) handles outcomes that are categories rather than measurements, using chi-square tests and then logistic regression.



**Unit V: Advanced Tools and Ethical Considerations** (Chapters 10-13) adds the tools that do not assume a normal distribution, then factor analysis and time series, and closes with the decisions that decide whether a study is trustworthy at all.



The order is deliberate. Each unit uses the vocabulary of the one before it, and the methods appear in the order a researcher usually meets them: describe the data, test a simple claim, model the relationship, then reach for the specialized tool when the standard one does not fit.



Most chapters close with a short list of key concepts and common mistakes. Some add a table of the new notation the chapter introduced. Every chapter ends with exercises.

## Who This Book Is For

If mathematics has felt like a gate you had to get through rather than a language you speak, you are in the intended audience. The book is written in that spirit. A method is a tool for answering a question, and the goal is to hand you the tool with an honest account of when it breaks.



This book is written for two groups:

- **Undergraduates in a second statistics course**, after an introductory course that covered describing data and the basic logic of hypothesis testing.
- **Graduate students in a first statistics course**, usually because a thesis or a research project is waiting and the data are already on the desk.

You do not need calculus, and you do not need to have written code before. Every symbol is defined the first time it appears, and Chapter 1 rebuilds the vocabulary from the ground up for anyone whose first course is a distant memory.

## How to Use This Book

Work the examples with the data the chapter names. Every dataset used in the book is available alongside it, so you can run the same analysis and compare your output with the printed result. Copying an answer teaches you very little; reproducing it teaches you where your understanding is thin.



Each chapter's exercises come in three kinds. Some ask you to interpret output you are given. Some ask you to run a test and report it in formal style. Some describe a short research scenario and ask you to choose a method or find the flaw in someone else's reasoning. The third kind is the one that shows up on exams and in research meetings.



Figures carry captions that state the takeaway rather than restating the variables. Read them. A well-built figure often answers a question before a formal hypothesis test does.



The glossary at the back defines every term the book bolds in the prose. If a word appears in an exercise and you cannot place it, start there.

## Accessibility

This book was built to be usable by readers who use screen readers, screen magnification, keyboard navigation, or color-vision settings, and I treat that as part of the text rather than an add-on.

- Every figure has alt text that describes what the figure shows, so the information is not locked behind an image.
- Every table has a header row and a caption that names its content.
- Figures use a palette chosen for color-vision deficiency, and color never carries meaning by itself. Values are labeled directly, and lines and groups are distinguished by more than hue.
- Headings are structured, navigation regions are labeled, and the HTML edition can be read and operated with a keyboard alone.

The HTML edition is the accessible one. The PDF is not tagged, so screen readers cannot navigate it well. If you use assistive technology, read the web version, which has the same content and the same numbering.



If something in this book blocks you, I want to know. The repository linked from the book's home page has an issue tracker, and a report there helps the next reader as much as it helps you.
