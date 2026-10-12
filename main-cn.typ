#import "template-cn.typ": (
  algorithm, algorithmic, appendix, assumption, claim, conjecture, corollary,
  definition, example, highlight, jlu-blue, jlu-paper, lemma, notation,
  observation, problem, proof, proposition, remark, subpar, theorem,
)

#show: jlu-paper.with(
  title: [论文标题：\ 清晰简洁的副标题],
  authors: (
    (name: "第一作者", marks: "1"),
    (name: "第二作者", marks: "1"),
    (name: "第三作者", marks: "1§"),
  ),
  affiliations: ((id: "1", name: "吉林大学某某学院，吉林长春，130012"),),
  contributions: ([#super[§]通讯作者],),
  abstract: [
    在此说明研究问题及其重要性，概述现有方法的不足，介绍本文提出的方法，
    并总结主要实验结果及其意义。摘要应独立完整，避免使用未解释的缩写。
    本文档展示吉林大学主题的中文科研论文排版，提供公式、定理、算法、子图和参考文献示例。
    请将标题、作者、摘要和正文中的占位内容替换为实际研究内容，实验表格中的数字仅用于展示格式。
  ],
  metadata: (
    ("通讯邮箱", link("mailto:author@example.com")[#raw("author@example.com")]),
    ("项目地址", link("https://example.com/project")),
    ("关键词", [科研论文；方法设计；实验评估]),
  ),
)

= 引言
介绍研究问题、应用背景和研究动机，说明现有方法与目标之间的差距。
引用文献支持具体论断，例如文档排版的相关工作 @lamport1994latex。

本文的主要贡献如下：
- 给出研究问题的形式化定义，明确主要挑战。
- 提出解决上述问题的方法，并说明关键设计。
- 通过合理的基线和消融实验评估方法的有效性。

= 相关工作
按主题组织已有研究，比较各类方法的假设、适用范围和局限，
说明本文工作的定位。多篇文献可以连续引用 @lamport1994latex @knuth1984texbook。

= 方法
== 问题定义
设输入为 $bold(x)_i in RR^d$，对应目标为 $y_i$。
给定数据集 $cal(D) = {(bold(x)_i, y_i)}_(i=1)^N$，定义经验风险为
$ cal(L)(theta) = 1/N sum_(i=1)^N ell(f_theta(bold(x)_i), y_i). $ <eq:objective>
其中，$theta$ 为模型参数，$ell$ 为损失函数，$N$ 为样本数量。

== 方法概述
说明复现方法所需的输入、处理步骤和输出。优化目标见 @eq:objective，
整体流程见 @fig:pipeline。首次出现的符号和缩写应在正文中解释。

#highlight[在此概括方法的核心思想、研究问题或关键结论。]

#figure(
  grid(
    columns: (1fr, auto, 1fr, auto, 1fr), gutter: 1mm, align: horizon,
    ..("输入", "方法", "输出")
      .enumerate()
      .map(((i, name)) => {
        let stage = block(
          width: 100%,
          inset: (x: 1mm, y: 3mm),
          radius: 1.5mm,
          stroke: .5pt + jlu-blue,
          fill: jlu-blue.lighten(95%),
          align(center, name),
        )
        if i < 2 { (stage, text(fill: jlu-blue)[→]) } else { (stage,) }
      })
      .flatten(),
  ),
  caption: [方法流程示例，请替换为实际研究流程。],
) <fig:pipeline>

== 数学环境
#definition(name: "经验风险")[经验风险是有限数据集上各样本损失的平均值。]
#assumption[数据集至少包含一个样本，所有样本损失均为有限值。]
#theorem(
  name: "非负性",
)[若损失函数非负，则 $cal(L)(theta) >= 0$。] <thm:nonnegative>
#proof[由 @eq:objective 可知，每一项均非负，求和并除以正整数后仍然非负。]
#lemma[若所有样本损失均为零，则经验风险为零。] <lem:zero>
#proposition[若每个样本损失不超过 $M$，则经验风险不超过 $M$。]
#corollary[若各样本损失属于 $[0, M]$，则其平均值也属于该区间。]
#conjecture[在适当条件下，所提方法能够推广至未见数据。]
#notation[使用 $N$ 表示样本数量，$theta$ 表示模型参数。]
#example(name: "两个样本")[当损失分别为 $1$ 和 $3$ 时，经验风险为 $2$。]
#remark(numbering: none)[不编号的环境不会推进共享计数器。]
#problem[寻找使经验风险最小的模型参数。]
#claim[示例中的样本损失均为非负数。]
#observation[两个样本的平均损失介于两者之间。]
非负性保证见 @thm:nonnegative，零损失的特殊情形见 @lem:zero。

== 算法示例
#algorithm("平均损失计算", {
  import algorithmic: *
  Line[*输入：* 样本损失 $ell_1, dots, ell_N$，其中 $N > 0$]
  Line[*输出：* 经验风险]
  Assign[$s$][$0$]
  For($i = 1, dots, N$, { Assign[$s$][$s + ell_i$] })
  Return[$s / N$]
}) <alg:average>
@alg:average 计算 @eq:objective 中的目标值。伪代码保留包提供的英文控制流关键字。

== 子图示例
#subpar.grid(
  figure(
    rect(
      width: 100%,
      height: 18mm,
      fill: jlu-blue.lighten(95%),
      stroke: .5pt + jlu-blue,
    )[#align(center + horizon)[输入]],
    caption: [输入阶段。],
  ),
  <fig:input>,

  figure(
    rect(
      width: 100%,
      height: 18mm,
      fill: jlu-blue.lighten(95%),
      stroke: .5pt + jlu-blue,
    )[#align(center + horizon)[输出]],
    caption: [输出阶段。],
  ),
  <fig:output>,

  columns: (1fr, 1fr),
  gutter: 4mm,
  caption: [包含两张子图的示例。],
  label: <fig:stages>,
)
@fig:stages 包含 @fig:input 和 @fig:output，可以分别引用各张子图。

= 实验
== 实验设置
说明数据集、基线、评估指标、实现细节和计算资源，记录足够的信息以支持复现。

== 主要结果
@tab:results 展示三线表排版。所有数字都是示例值，不代表实际实验结果。
#figure(
  table(
    columns: (1fr, auto, auto),
    align: (left, right, right),
    stroke: none,
    inset: (x: 4pt, y: 5pt),
    table.hline(stroke: .8pt),
    table.header([方法], [得分 $arrow.t$], [耗时 $arrow.b$]),
    table.hline(stroke: .5pt),
    [基线 A], [72.1], [1.20],
    [基线 B], [75.3], [1.05],
    [本文方法], [*79.4*], [*0.92*],
    table.hline(stroke: .8pt),
  ),
  kind: table,
  caption: [结果示例，数值仅用于展示排版。],
) <tab:results>
分析效果差异、不确定性和失败案例，避免只描述表格中的数值。

== 消融实验
分别评估各组件的贡献，说明实验设置和结果所揭示的规律。

= 结论
总结研究发现及其意义，陈述局限，并提出具体的后续研究方向。

#heading(numbering: none)[致谢]
在此填写资助项目、合作支持和其他致谢信息。

#bibliography("references.yaml", style: "ieee", title: [参考文献])

#appendix[
  = 补充资料 <app:details>
  附录默认使用单栏，适合放置较长的推导、额外实验和实现细节。

  == 复现清单
  记录数据版本、预处理流程、超参数、随机种子、软件版本以及硬件配置。
]
