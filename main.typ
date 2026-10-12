#import "template.typ": (
  algorithm, algorithmic, appendix, assumption, claim, conjecture, corollary,
  definition, example, highlight, jlu-blue, jlu-paper, lemma, notation,
  observation, problem, proof, proposition, remark, subpar, theorem,
)

#show: jlu-paper.with(
  title: [Your Paper Title:\ A Clear and Concise Subtitle],
  columns: 2,
  authors: (
    (name: "First Author", marks: "1"),
    (name: "Second Author", marks: "1"),
    (name: "Third Author", marks: "1§"),
  ),
  affiliations: (
    (
      id: "1",
      name: "School of Your Discipline, Jilin University, Changchun, China",
    ),
  ),
  contributions: ([#super[§]Corresponding author],),
  abstract: [
    State the problem and explain why it matters. Briefly describe the limitation
    of existing approaches, introduce your method, and summarize the main results.
    Conclude with the practical significance of your findings. Replace this text
    with a self-contained abstract of approximately 150–250 words.
  ],
  metadata: (
    (
      "Correspondence",
      link("mailto:author@example.com")[#raw("author@example.com")],
    ),
    ("Code", link("https://example.com/project")),
    // ("Date", [October 2026]),
    // ("Keywords", [Research; methodology; evaluation]),
  ),
)

= Introduction
Introduce the research problem, its motivation, and the setting in which it
arises. Explain the gap between current methods and the desired outcome.
Use citations to support specific claims, for example the standard reference
on typesetting #cite(<lamport1994latex>, form: "prose").

_Contributions._ Summarize the contributions in concrete terms:
- A formulation of the problem and its main challenges.
- A method that addresses the identified limitations.
- An evaluation with appropriate baselines and ablations.

= Related Work
Organize prior work by theme and explain how your approach relates to it.
Multiple references can be cited together @lamport1994latex @knuth1984texbook.

= Method
== Problem Formulation
Let $bold(x)_i in RR^d$ denote an input and $y_i$ its target. Given a dataset
$cal(D) = {(bold(x)_i, y_i)}_(i=1)^N$, we optimize
$ cal(L)(theta) = 1/N sum_(i=1)^N ell(f_theta(bold(x)_i), y_i). $ <eq:objective>
Define all symbols before introducing the method.

== Proposed Approach
Describe the steps needed to reproduce the approach. Refer to @eq:objective
for the objective and @fig:pipeline for an overview.

#highlight[
  Replace this box with a central insight, research question, or concise
  summary of the proposed method.
]

#figure(
  align(center, grid(
    columns: (1fr, auto, 1fr, auto, 1fr), align: horizon, gutter: 1mm,
    ..("Input", "Method", "Output")
      .enumerate()
      .map(((i, name)) => {
        let stage = block(
          width: 100%,
          inset: (x: 1mm, y: 3mm),
          radius: 1.5mm,
          stroke: .5pt + jlu-blue,
          fill: jlu-blue.lighten(95%),
          align(center, text(size: 9pt, name)),
        )
        if i < 2 { (stage, text(fill: jlu-blue)[→]) } else { (stage,) }
      })
      .flatten(),
  )),
  caption: [An example pipeline. Replace it with an overview of your method.],
) <fig:pipeline>

#theorem(name: "Example statement")[
  If $ell$ is nonnegative, then $cal(L)(theta) >= 0$.
] <thm:nonnegative>
#proof[Every summand in @eq:objective is nonnegative.]

The nonnegativity guarantee is stated in @thm:nonnegative.

== Mathematical Environments
The following statements illustrate the available environments.
Their mathematical content is only an example.

#definition(name: "Empirical risk")[
  The empirical risk is the average loss over a finite dataset.
]
#assumption[The dataset contains at least one sample, and all losses are finite.]
#lemma[If each sample has zero loss, then the empirical risk is zero.] <lem:zero>
#proof[The average of finitely many zeros is zero.]
#proposition[If each sample loss is at most $M$, then the empirical risk is at most $M$.]
#corollary[If all sample losses belong to $[0, M]$, their average belongs to $[0, M]$.]
#conjecture[The proposed approach generalizes to unseen data under suitable conditions.]
#notation[We use $N$ for the number of samples and $theta$ for model parameters.]
#example(
  name: "Two samples",
)[Losses of $1$ and $3$ yield an empirical risk of $2$.]
#remark(
  numbering: none,
)[An unnumbered environment does not advance the shared counter.]
#problem[Find model parameters that minimize the empirical risk.]
#claim[The example losses are nonnegative.]
#observation[The two-sample average lies between the two sample losses.]
For a zero-loss special case, see @lem:zero.

== Algorithm Example
#algorithm("Average Loss", {
  import algorithmic: *
  Line[*Input:* Sample losses $ell_1, dots, ell_N$, with $N > 0$]
  Line[*Output:* Empirical risk]
  Assign[$s$][$0$]
  For($i = 1, dots, N$, {
    Assign[$s$][$s + ell_i$]
  })
  Return[$s / N$]
}) <alg:average>
@alg:average computes the objective in @eq:objective.

== Subfigure Example
#subpar.grid(
  figure(
    rect(
      width: 100%,
      height: 18mm,
      fill: jlu-blue.lighten(95%),
      stroke: .5pt + jlu-blue,
    )[#align(center + horizon)[Input]],
    caption: [Input stage.],
  ),
  <fig:input>,

  figure(
    rect(
      width: 100%,
      height: 18mm,
      fill: jlu-blue.lighten(95%),
      stroke: .5pt + jlu-blue,
    )[#align(center + horizon)[Output]],
    caption: [Output stage.],
  ),
  <fig:output>,

  columns: (1fr, 1fr),
  gutter: 6.5mm,
  caption: [An example with two subfigures.],
  label: <fig:stages>,
)
@fig:stages contains @fig:input and @fig:output.

= Experiments
== Experimental Setup
Describe datasets, baselines, metrics, implementation details, and resources.
Report enough information for another researcher to reproduce the evaluation.

== Main Results
@tab:results illustrates a compact three-line table. All numbers below are
placeholders, rather than measured experimental results.

#figure(
  table(
    columns: (1fr, auto, auto),
    align: (left, right, right),
    stroke: none,
    inset: (x: 4pt, y: 5pt),
    table.hline(stroke: .8pt),
    table.header([Method], [Score $arrow.t$], [Time $arrow.b$]),
    table.hline(stroke: .5pt),
    [Baseline A], [72.1], [1.20],
    [Baseline B], [75.3], [1.05],
    [Ours], [*79.4*], [*0.92*],
    table.hline(stroke: .8pt),
  ),
  kind: table,
  supplement: [Table],
  caption: [Example results (illustrative values only).],
) <tab:results>
Discuss effect sizes and uncertainty, along with relevant failure cases.

== Ablation Study
Isolate the effect of each component and explain what the results reveal.

= Conclusion
Summarize the findings and their implications. State the limitations and
identify concrete directions for future work.

#heading(numbering: none)[Acknowledgments]
Add acknowledgments and funding information here when appropriate.

#bibliography("references.yaml", style: "ieee", title: [References])

#appendix[
  = Additional Details <app:details>
  The appendix uses a single-column layout for longer derivations, additional
  experiments, and implementation details. Set `columns: 2` on the appendix
  helper if you prefer a two-column appendix.

  == Reproducibility Checklist
  Record dataset versions, preprocessing, hyperparameters, random seeds,
  software versions, and the hardware used for the experiments.


]
