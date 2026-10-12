// Chinese localization; environment behavior comes from the shared packages.
#import "template.typ" as base
#import "@preview/ctheorems:2.0.0": proof-body-fmt, thm-fmt-block
#let jlu-blue = base.jlu-blue
#let algorithmic = base.algorithmic
#let subpar = base.subpar
#let appendix = base.appendix
#let qedhere = base.qedhere
#let tag = base.tag
#let jlu-paper = base.jlu-paper.with(
  lang: "zh",
  body-font: ("New Computer Modern", "Noto Serif CJK SC"),
  front-font: ("Libertinus Serif", "Noto Sans CJK SC"),
  university-name: [吉林大学 JILIN UNIVERSITY],
  abstract-title: [摘要],
  body-leading: .65em,
  first-line-indent: (amount: 2em, all: true),
)
#let statement = base.statement.with(
  fmt: base.boxed-thm.with(format: thm-fmt-block.with(
    body-fmt: x => x,
    name-fmt: x => [（#x）],
    separator: [。 ],
  )),
)
#let theorem = statement.with(
  supplement: "定理",
  box-color: base.environment-colors.theorem,
)
#let lemma = statement.with(
  supplement: "引理",
  box-color: base.environment-colors.lemma,
)
#let proposition = statement.with(
  supplement: "命题",
  box-color: base.environment-colors.proposition,
)
#let corollary = statement.with(
  supplement: "推论",
  box-color: base.environment-colors.corollary,
)
#let conjecture = statement.with(
  supplement: "猜想",
  box-color: base.environment-colors.conjecture,
)
#let claim = statement.with(
  supplement: "断言",
  box-color: base.environment-colors.claim,
)
#let definition = statement.with(
  supplement: "定义",
  box-color: base.environment-colors.definition,
)
#let assumption = statement.with(
  supplement: "假设",
  box-color: base.environment-colors.assumption,
)
#let remark = statement.with(
  supplement: "注",
  box-color: base.environment-colors.remark,
)
#let example = statement.with(
  supplement: "例",
  box-color: base.environment-colors.example,
)
#let notation = statement.with(
  supplement: "记号",
  box-color: base.environment-colors.notation,
)
#let problem = statement.with(
  supplement: "问题",
  box-color: base.environment-colors.problem,
)
#let observation = statement.with(
  supplement: "观察",
  box-color: base.environment-colors.observation,
)
#let proof = base.proof.with(
  supplement: "证明",
  fmt: base.boxed-thm.with(format: thm-fmt-block.with(
    title-fmt: strong,
    body-fmt: proof-body-fmt,
    name-fmt: x => [（#x）],
    separator: [。 ],
  )),
)
#let algorithm = base.algorithm.with(supplement: "算法")
#let highlight = base.highlight.with(title: "核心思想", font: (
  "Libertinus Serif",
  "Noto Sans CJK SC",
))
