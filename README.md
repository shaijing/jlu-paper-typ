# 吉林大学 Typst 科研论文模板（中英文）

参考相邻 `jlu-template` 的英文 LaTeX 设计实现：A4 双栏、吉林大学蓝色主题（`#1D5CAB`）、首页校名与校徽、标题横线、作者单位及通讯作者、圆角摘要框。正文提供公式与交叉引用、流程图、三线表、提示框、按章节编号的定理与证明、数字参考文献，以及另起一页的单栏附录。

这是科研论文样式，提供独立的中英文入口。正文内容和表格数值均为占位示例。

## 编译

已使用 Typst 0.15.1 验证。首次编译需要联网下载以下固定版本的 Typst Universe 包，下载后会使用本地缓存：

| 包                                                                   | 用途                                   |
| -------------------------------------------------------------------- | -------------------------------------- |
| [ctheorems 2.0.0](https://typst.app/universe/package/ctheorems/)     | 定理类环境、共享编号、引用与证明结束符 |
| [algorithmic 1.0.7](https://typst.app/universe/package/algorithmic/) | 算法、行号与控制流                     |
| [subpar 0.2.2](https://typst.app/universe/package/subpar/)           | 子图、子图注与引用                     |
| [showybox 2.0.4](https://typst.app/universe/package/showybox/)       | 数学环境的彩色圆角框                   |

在项目根目录执行：

```sh
typst compile main.typ main.pdf
# 中文版
typst compile main-cn.typ main-cn.pdf
# 修改后自动重新编译
typst watch main.typ main.pdf
```

安装 `just` 后，也可使用 `just`（编译）、`just watch`（监听）和 `just clean`（清理生成的 PDF）。中文版使用 `just cn` 编译、`just watch-cn` 监听，`just both` 编译两个版本。生成的 `main.pdf` 和 `main-cn.pdf` 可以直接预览。

使用 Typst 自带字体，无需安装系统字体或指定字体路径，Linux、Windows 和 macOS 均可编译。标题和作者信息使用 Libertinus Serif，正文使用 New Computer Modern，公式使用 New Computer Modern Math，等宽文本使用 DejaVu Sans Mono。

## 中文版

编辑 `main-cn.typ` 的标题、作者、单位、摘要、关键词和正文。中文版复用 `template.typ` 的页面与主题配置，`template-cn.typ` 只负责本地化；数学环境仍使用 ctheorems，算法使用 algorithmic，子图使用 subpar。

中文正文使用 **Noto Serif CJK SC**，标题使用 **Noto Sans CJK SC**。中文字体不是 Typst 自带字体，需要在编译环境中安装；Noto CJK 可用于 Linux、Windows 和 macOS，项目不附带字体文件。使用 `typst fonts` 检查字体是否可用。英文和数学部分保留 Typst 自带字体。

中文版正文每段首行缩进两个字宽，摘要、图表和数学环境不缩进；标题、图表、公式、算法和定理引用显示中文，定理正文使用正体。算法控制流仍采用包默认的英文关键字。参考文献共用 `references.yaml`，样式为 IEEE，并非 GB/T 7714。

中文字体可在 `template-cn.typ` 中替换，或在 `main-cn.typ` 的 `jlu-paper.with(...)` 中设置：

```typ
  body-font: ("New Computer Modern", "Your Chinese Serif Font"),
  front-font: ("Libertinus Serif", "Your Chinese Sans Font"),
```

## 文件

| 文件              | 用途                                 |
| ----------------- | ------------------------------------ |
| `main.typ`        | 英文入口，填写论文信息并替换正文示例 |
| `template.typ`    | 可复用的排版函数、主题色和辅助函数   |
| `references.yaml` | Hayagriva YAML 文献库                |
| `figures/jlu.svg` | 从参考项目 PDF 转换的矢量校徽        |
| `justfile`        | 编译、监听、清理命令                 |

## 修改论文信息

编辑 `main.typ` 的 `#show: jlu-paper.with(...)`。作者和单位使用结构化数组，`marks` 为上标标记，`id` 为单位编号：

```typ
  authors: (
    (name: "Alice", marks: "1,2"),
    (name: "Bob", marks: "1§"),
  ),
  affiliations: (
    (id: "1", name: "Jilin University, Changchun, China"),
    (id: "2", name: "Collaborating Institution, City, Country"),
  ),
```

修改 `title`、`abstract`、`contributions` 和 `metadata`；不需要的贡献说明或元信息设为 `()`。元信息可添加日期、关键词、项目链接。`logo: none` 隐藏校徽，也可以传入其他图片路径。标题中用 `\` 手动换行。

## 正文与引用

`=`、`==`、`===` 分别生成各级标题。公式、图表后加 `<label>`，在正文使用 `@label` 引用。文献条目写入 `references.yaml`，采用 Typst 原生支持的 Hayagriva 格式，使用 `@lamport1994latex` 或 `#cite(<lamport1994latex>, form: "prose")` 引用。

每个顶层键是引用键，作者按“姓, 名”填写。例如：

```yaml
lamport1994latex:
  type: Book
  title: "LaTeX: A Document Preparation System"
  author:
    - "Lamport, Leslie"
  edition: 2
  publisher: Addison-Wesley
  date: 1994
```

参考文献采用 Typst 内置 IEEE 数字样式，与参考项目的 `plainnat` 存在格式差异。引用和文献在一次编译中自动生成。

```typ
#highlight(title: "Key idea")[Your central insight.]
#theorem(name: "Example statement")[Your theorem.]
#proof[Your proof.]
```

定理类环境由 `ctheorems` 提供，模板配置名称、字体样式、间距及计数器，showybox 提供圆角框。以下环境按一级标题重新编号，共享同一个计数器，附录使用 `A.1` 等编号：

| 函数          | 显示名称    | 正文样式 |
| ------------- | ----------- | -------- |
| `theorem`     | Theorem     | 斜体     |
| `lemma`       | Lemma       | 斜体     |
| `proposition` | Proposition | 斜体     |
| `corollary`   | Corollary   | 斜体     |
| `conjecture`  | Conjecture  | 斜体     |
| `claim`       | Claim       | 斜体     |
| `definition`  | Definition  | 正体     |
| `assumption`  | Assumption  | 正体     |
| `remark`      | Remark      | 正体     |
| `example`     | Example     | 正体     |
| `notation`    | Notation    | 正体     |
| `problem`     | Problem     | 正体     |
| `observation` | Observation | 正体     |

从 `template.typ` 导入所需函数后使用，例如：

```typ
#definition(name: "Empirical risk")[The average loss over a finite dataset.]
#lemma[Your lemma.]
#proof(name: [of the lemma])[Your proof.]
#remark(numbering: none)[An unnumbered remark.]
```

使用包原生参数：`name` 设置可选名称，也可写 `#theorem[Name][Body]`；`numbering: none` 不编号且不推进计数器；`breakable: true` 允许长环境跨栏、跨页（默认不拆分）；`body-fmt: x => x` 改为正体。`proof` 不编号，末尾自动添加证明结束符，`qedhere` 可在末行公式中手动定位结束符。正文 Method 部分提供了这些环境、算法和子图的示例。

定理等环境支持直接交叉引用：

```typ
#lemma[Your lemma.] <lem:result>
By @lem:result, the desired result follows.
```

### 数学环境的彩色框

中英文使用同一套配色：定理蓝色、引理青绿色、命题紫色、推论绿色、猜想金棕色、断言钢蓝色、定义蓝绿色、假设橙棕色、注橄榄灰、例玫红色、记号蓝灰色、问题红色、观察橄榄绿、证明灰色。浅色背景、细边框和有色标题保持统一，正文仍为黑色。

配色集中在 `template.typ` 的 `environment-colors` 中。单个环境也可以覆盖颜色或允许长内容拆分：

```typ
#theorem(box-color: rgb("6554A4"), breakable: true)[Your long theorem.]
```

短环境默认保持完整，不会把标题与正文拆到两栏。长环境需设置 `breakable: true`，证明同样适用；编号、标签、引用和证明结束符继续由 ctheorems 提供。

### 算法与伪代码

从 `template.typ` 导入 `algorithm` 和 `algorithmic`。`algorithm` 是包中 `algorithm-figure` 的主题配置版本，使用包原生控制流构造器：

```typ
#algorithm("Average Loss", {
  import algorithmic: *
  Line[*Input:* Losses $ell_1, dots, ell_N$]
  Assign[$s$][$0$]
  For($i = 1, dots, N$, {
    Assign[$s$][$s + ell_i$]
  })
  Return[$s / N$]
}) <alg:average>
See @alg:average.
```

默认显示行号，蓝色三线边框，短算法保持完整。控制流还支持 `If`、`While`、`Procedure` 等；算法的浮动、跨栏和长算法拆分通过包的 `style-algorithm` 配置。

### 子图

从 `template.typ` 导入 `subpar`，每张子图用原生 `figure`，由包生成 `(a)`、`(b)` 等子图编号：

```typ
#subpar.grid(
  figure(image("figures/input.svg", width: 100%), caption: [Input.]), <fig:in>,
  figure(image("figures/output.svg", width: 100%), caption: [Output.]), <fig:out>,
  columns: (1fr, 1fr), gutter: 6.5mm,
  caption: [Method overview.], label: <fig:overview>,
)
See @fig:overview, @fig:in and @fig:out.
```

普通 `figure(...)` 占一栏。跨栏浮动图可以使用：

```typ
#figure(
  image("figures/your-figure.svg", width: 100%),
  caption: [Overview of the method.],
  placement: top,
  scope: "parent",
) <fig:wide>
```

正文单栏：在 `jlu-paper.with(...)` 中添加 `columns: 1`。附录默认单栏，用 `#appendix(columns: 2)[...]` 改为双栏。页面边距、字号和标题格式集中在 `template.typ`，模板参数还支持 `body-font`、`body-size`。

### 间距调整

在 `jlu-paper.with(...)` 中可配置正文和元信息间距：

```typ
  body-leading: .5em,        // 正文行间附加距离
  paragraph-spacing: .7em,  // 正文段落间距
  metadata-leading: .45em,  // 元信息换行时的行距
  metadata-spacing: .55em,  // 两条元信息之间的段距
```

一级标题的上方留白大于二级、三级标题；标题与后续内容保持相邻，避免标题单独留在栏底。摘要、图注和参考文献分别设置行距。短提示框默认不跨栏或跨页拆分，长提示框可使用 `#highlight(breakable: true)[...]` 允许拆分。

## 资源来源

布局参考 `/home/lingyu/ws/latexWS/jlu-template/` 的 `paper.cls`、`preamble.tex` 与 `main.tex`，使用 Typst 重新实现。校徽和示例文献来自该项目，文献已转换为 Hayagriva YAML；校徽通过 `pdftocairo -svg` 转换。原参考项目未为这些资源附独立许可，本项目不另行声明其许可证。字体使用 Typst 自带字体，不再附带 ByteSans 文件。
