// Jilin University research-paper layout, adapted from ../jlu-template.
#let jlu-blue = rgb("1D5CAB")
#let front-font = "Libertinus Serif"
#let column-layout = columns

#let highlight(
  title: "Key idea",
  breakable: false,
  font: front-font,
  body,
) = block(
  width: 100%,
  breakable: breakable,
  radius: 1.5mm,
  above: .8em,
  below: .8em,
  fill: jlu-blue.lighten(96%),
  stroke: .5pt + jlu-blue,
  inset: 2mm,
)[
  #set par(first-line-indent: 0pt)
  #text(font: font, weight: "bold", fill: jlu-blue)[#title]
  #v(1.5mm)
  #body
]

// Package-backed environments: only theme and shared-counter configuration live here.
#import "@preview/ctheorems:2.0.0": (
  proof as package-proof, qedhere, tag, thm, thm-rules,
)
#import "@preview/algorithmic:1.0.7" as algorithmic
#import "@preview/subpar:0.2.2" as subpar
#let appendix-mode = state("jlu-appendix-mode", false)
#let statement = thm.with(
  counter: "jlu-statements",
  base: "heading",
  base-level: 1,
  numbering: (..n) => numbering(
    if appendix-mode.get() { "A.1" } else { "1.1" },
    ..n.pos(),
  ),
  above: .8em,
  below: .5em,
)
#let theorem = statement.with(supplement: "Theorem")
#let lemma = statement.with(supplement: "Lemma")
#let proposition = statement.with(supplement: "Proposition")
#let corollary = statement.with(supplement: "Corollary")
#let conjecture = statement.with(supplement: "Conjecture")
#let claim = statement.with(supplement: "Claim")
#let description = statement.with(body-fmt: x => x)
#let definition = description.with(supplement: "Definition")
#let assumption = description.with(supplement: "Assumption")
#let remark = description.with(supplement: "Remark")
#let example = description.with(supplement: "Example")
#let notation = description.with(supplement: "Notation")
#let problem = description.with(supplement: "Problem")
#let observation = description.with(supplement: "Observation")
#let proof = package-proof.with(above: .5em, below: .8em)
#let algorithm = algorithmic.algorithm-figure.with(inset: .15em, indent: 1em)

// Appendices start on a fresh page; their numbering is independent of the body.
#let appendix(body, columns: 1) = {
  pagebreak()
  set page(columns: columns)
  appendix-mode.update(true)
  counter(heading).update(0)
  set heading(numbering: "A.1")
  body
}

#let jlu-paper(
  title: [],
  authors: (),
  affiliations: (),
  contributions: (),
  abstract: [],
  metadata: (),
  logo: "figures/jlu.svg",
  columns: 2,
  lang: "en",
  front-font: front-font,
  university-name: [JILIN UNIVERSITY],
  abstract-title: [Abstract],
  body-font: "New Computer Modern",
  body-size: 10pt,
  body-leading: .5em,
  paragraph-spacing: .7em,
  first-line-indent: 0pt,
  metadata-leading: .45em,
  metadata-spacing: .55em,
  body,
) = {
  set document(title: title, author: authors.map(a => a.name))
  set page(
    paper: "a4",
    margin: (top: 2.75cm, bottom: 2.5cm, x: 2.5cm),
    columns: columns,
    numbering: "1",
    number-align: center,
    header: context {
      if counter(page).get().first() == 1 {
        grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          text(
            font: front-font,
            weight: "regular",
            size: 9pt,
            fill: jlu-blue,
          )[#university-name],
          if logo != none { image(logo, height: 13.5mm) },
        )
      }
    },
    header-ascent: 5mm,
  )
  set text(
    font: body-font,
    size: body-size,
    lang: lang,
    hyphenate: lang == "en",
  )
  show math.equation: set text(font: "New Computer Modern Math")
  show raw: set text(font: "DejaVu Sans Mono")
  set par(
    justify: true,
    leading: body-leading,
    spacing: paragraph-spacing,
    first-line-indent: first-line-indent,
  )
  set column-layout(gutter: 6.5mm)
  set heading(numbering: "1.1")
  show heading: it => {
    block(
      sticky: true,
      above: if it.level == 1 { 1.2em } else { .9em },
      below: if it.level == 1 { .6em } else { .45em },
    )[
      #text(
        font: front-font,
        weight: "bold",
        fill: jlu-blue,
        size: if it.level == 1 { 12pt } else if it.level == 2 { 11pt } else {
          10pt
        },
        it,
      )
    ]
  }
  show link: set text(fill: jlu-blue)
  show ref: set text(fill: jlu-blue)
  set math.equation(numbering: "(1)")
  set math.equation(supplement: if lang == "zh" { [式] } else { [Equation] })
  show math.equation.where(block: true): set block(above: .8em, below: .8em)
  set figure(gap: .65em)
  show figure: set par(first-line-indent: 0pt)
  show figure: set block(above: .9em, below: .9em)
  show figure.caption: it => {
    set text(size: 9pt)
    set par(leading: .45em, spacing: .4em)
    it
  }
  show bibliography: it => {
    set text(size: 9pt)
    set par(leading: .45em, spacing: .6em)
    it
  }
  set list(indent: 0pt, body-indent: 1em, spacing: .3em, tight: lang != "zh")

  // A parent-scoped block spans both columns before the body begins.
  place(top, scope: "parent", float: true, clearance: 8mm, block(width: 100%)[
    #set par(
      justify: false,
      leading: .4em,
      spacing: 0pt,
      first-line-indent: 0pt,
    )
    #align(center)[
      #line(length: 100%, stroke: .5pt + jlu-blue)
      #v(6mm)
      #text(
        font: front-font,
        weight: "bold",
        size: 17pt,
        hyphenate: false,
      )[#title]
      #v(6mm)
      #line(length: 100%, stroke: .5pt + jlu-blue)
      #v(6mm)
      #text(font: front-font, weight: "bold", size: 12pt)[
        #authors.map(a => [#a.name#super(a.at("marks", default: ""))]).join[, ]
      ]
      #v(3mm)
      #text(font: front-font, weight: "regular", size: 10pt)[
        #affiliations.map(a => [#super(a.id)#a.name]).join[, ]
      ]
      #if contributions.len() > 0 {
        v(3mm)
        text(size: 10pt, contributions.join[, ])
      }
    ]
    #v(6mm)
    #block(
      width: 100%,
      inset: (x: 8mm, y: 6mm),
      radius: 2.5mm,
      stroke: .5pt + jlu-blue,
    )[
      #align(center, text(
        font: front-font,
        size: 12pt,
        weight: "bold",
        fill: jlu-blue,
      )[#abstract-title])
      #v(3mm)
      #set par(justify: true, leading: .5em, spacing: .6em)
      #text(size: 10pt)[#abstract]
      #if metadata.len() > 0 {
        v(3mm)
        set text(size: 7.92pt)
        set par(
          justify: false,
          leading: metadata-leading,
          spacing: metadata-spacing,
        )
        for (key, value) in metadata {
          [#text(font: front-font, weight: "bold")[#key#if (
                lang == "zh"
              ) [：] else [:]] #value #parbreak()]
        }
      }
    ]
  ])
  show: thm-rules.with(qed-symbol: $square$)
  show: algorithmic.style-algorithm.with(
    breakable: false,
    hlines: (
      grid.hline(stroke: .5pt + jlu-blue),
      grid.hline(stroke: .5pt + jlu-blue),
      grid.hline(stroke: .5pt + jlu-blue),
    ),
  )
  body
}
