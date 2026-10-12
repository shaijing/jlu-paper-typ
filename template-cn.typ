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
  fmt: thm-fmt-block.with(
    body-fmt: x => x,
    name-fmt: x => [（#x）],
    separator: [。 ],
  ),
)
#let theorem = statement.with(supplement: "定理")
#let lemma = statement.with(supplement: "引理")
#let proposition = statement.with(supplement: "命题")
#let corollary = statement.with(supplement: "推论")
#let conjecture = statement.with(supplement: "猜想")
#let claim = statement.with(supplement: "断言")
#let definition = statement.with(supplement: "定义")
#let assumption = statement.with(supplement: "假设")
#let remark = statement.with(supplement: "注")
#let example = statement.with(supplement: "例")
#let notation = statement.with(supplement: "记号")
#let problem = statement.with(supplement: "问题")
#let observation = statement.with(supplement: "观察")
#let proof = base.proof.with(
  supplement: "证明",
  fmt: thm-fmt-block.with(
    title-fmt: strong,
    body-fmt: proof-body-fmt,
    name-fmt: x => [（#x）],
    separator: [。 ],
  ),
)
#let algorithm = base.algorithm.with(supplement: "算法")
#let highlight = base.highlight.with(title: "核心思想", font: (
  "Libertinus Serif",
  "Noto Sans CJK SC",
))
