#import "../report.typ": *
#import "utils.typ": *
#import "@preview/mantys:0.1.4": *

#let title = [Template for the literature \ review report]

#show: report-template.with(
  title: title,
  course: "Strucutral dynamics",
  authors: ("Mathieu Aucejo",),
  supervisors: none,
  academic-program: [Master in Structural Mechanics and Coupled Systems],
  academic-year: [2024 -- 2025],
  cover-image: image("../images/lecnam.jpg"),
  lang: "en"
)

#align(center)[*Abstract*]

This #typst package is a template for writing a literature review report as part of the “Structural Dynamics” module of the master's program "Structural Mechanics and Coupled Systems" at the Conservatoire national des arts et métiers.

= What is Typst ?

#typst is a new open source markup language written in Rust and developed by two German students, Laurenz Mädje and Martin Haug, as part of their master's project @Mad22 @Hau22 from 2019. Version 0.1.0 was released on GitHub on April 04, 2023.

#typst presents itself as a more modern, faster and easier to use successor of #LaTeX. Its advantages include

- incremental compilation;
- clear, understandable error messages;
- a Turing-complete programming language
- a coherent styling system that makes it easy to configure all aspects of your document (font, pagination, margins, #sym.dots);
- an active, friendly community (discord server for support, new package announcements);
- an easy-to-use package system (to search or view the list of packages, visit #link("https://typst.app/universe", text("Type: Universe", fill: colors.red));
- There are extensions for VS Code, such as `Typst LSP` or `Tinymist`, for features similar to `LaTeX Workshop`.

Finally, the #typst documentation is so well written and detailed that you can quickly create your own documents. It takes less than an hour to learn the syntax (no lie #emoji.face.beam). To access the documentation, follow this #link("https://typst.app/docs", text("link", fill: colors.red)). To ease the transition from #LaTeX to #typst, a guide is available #link("https://typst.app/docs/guides/guide-for-latex-users/", text("here", fill: colors.red)).

= Usage

To use the template, you must import it into your `typ` main file. Assuming the template and the main file are in the same folder, simply add the following command to the first line of the main file.

#codesnippet[
	```typ
	#import "report.typ": *
	```
]

#ibox[
	#set text(size: 11pt)

	If you split your document into multiple files, you must include the previous command as a preamble to each file.
]

== Template initialization

After importing the model, it must be initialized by applying a `show` rule with the #cmd("report") command, passing the necessary options with the `with` instruction in your main `typ` file:

#codesnippet(
	```typ
	#show report-template.with(
	  ...
	)
	```
)

The #cmd("report-template") template has a number of parameters to customize the document. Here is a list of available parameters:

#command("report-template", ..args(
title: [Titre du rapport],
course: [Nom du module],
authors: "",
supervisors: "",
academic-program: none,
academic-year: none,
cover-image: none,
lang: "fr",
[body]))[
  #argument("title", default: [Titre du document], types: ("string", "content"))[Title of the report]

  #argument("course", default: [Nom du module], types: ("string", "content"))[Name of the module]

  #argument("authors", default: "", types: ("array"))[List of the authors

  #underline[example :] `("Author A", "Author B")`
  ]

  #argument("supervisors", default: "", types: (none, "array"))[List of the supervisors

  #underline[example :] `("Supervisor A", "Supervisor B")`
  ]

	#argument("academic-program", default: none, types: (none, "string", "content"))[Name of the academic program]

  #argument("academic-year", default: none, types: (none, "string", "content"))[Current academic year

  #underline[example :] `"2024 - 2025"`
  ]

  #argument("cover image", default: none, types: (none, "content"))[Cover image of the report

  #underline[example :] `image("image.png")`
  ]
]

== Writing the document

The content of the document can be written in the main `typ` file or in auxiliary files. To learn the basics of writing a document in #typst, take a look at this #link("https://typst.app/docs/tutorial/", text(fill: colors.red, "tutorial")), which will familiarize you with the main features in less than an hour.

== Bibliography management

To insert a bibliography, insert the following command in the main `typ` file:
#codesnippet[
	```typ
	#bibliography("bliblio-file.yml/bib")
	```
]

#ibox[
#set text(size: 11pt)
The template provides two bibliography formats: YAML and BibTeX.

The YAML file is interpreted by the `hayagriva` module, whose documentation is available #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md", text("here", fill: colors.red)).
]

To cite a bibliographic reference in the text, simply use the #cmd("cite", arg[key]) command, or more simply #text(`@key`, fill: colors.red.darken(15%)) (where `key` is the key associated with the reference).

For more information on managing bibliographic references, see the documentation for the #cmd("bibliography") function in #typst (accessible #link("https://typst.app/docs/reference/model/bibliography/", text("here", fill: colors.red))).

== Appendix management

The template provides an `appendix` environment to distinguish between the body of the document and the appendix information. In this environment the numbering of section headings, figures, tables and equations is adapted to the context. To enable this environment, add the following command to the main `typ` file at the desired location:
#codesnippet[
  ```typ
  #show: appendix
  ```
]

== Additional features

This section introduces the additional features implemented in the template to facilitate document editing.

*Figures*

Typically, figures are inserted into the document using #typst's #cmd("figure") function. However, #typst currently lacks mechanisms for managing sub-figures (numbering and referencing). To overcome this shortcoming, the template defines a #cmd("subfigure") function to manage subfigures in an appropriate way. This function encapsulates the #cmd("subpar.grid") function in the `subpar` package.

#codesnippet[
	```typ
	#subfigure(
		figure(image("image1.png"), caption: []),
		figure(image("image2.png"), caption: []), <b>,
		columns: (1fr, 1fr),
		caption: [Title of the figure],
		label: <fig:subfig>,
	)
	```
]

The previous example illustrates the case of a figure that consists of two sub-figures. The first has a caption, while the second has a #dtype("label") but no caption. The second sub-picture can therefore be referenced in the text with the command #text(`@b`, fill: colors.red.darken(15%)).

*Equations*

To box an important equation, use the #cmd("boxeq") function.

#codesnippet[
```typ
$
#boxeq[$p(A|B) prop p(B|A) space p(A)$]
$
```
]

To create an equation without numbering, use the #cmd("nonumeq") function.

#codesnippet[
```typ
#nonumeq[$ integral_0^1 f(x) dif x = F(1) - F(0) $]
```
]

= Recommended packages

This section presents a list of packages that may be relevant when writing a document in #typst.

#pagebreak()

*Drawing* -- `CeTZ`
	- *Description*: This package is intended to be a #typst equivalent of TiKZ for #LaTeX.
	- *Links* - #link("https://typst.app/universe/package/cetz", text("Typst: Universe", fill: colors.red)), #link("https://github.com/cetz-package/cetz", text("GitHub repository", fill: colors.red)) and #link("https://github.com/cetz-package/cetz/blob/stable/manual.pdf?raw=true", text("documentation", fill: colors.red)).

#v(0.5em)

*Boxes* -- `showybox`.
	- *Description*: This package creates customizable content boxes (text, #sym.dots).
	- *Links* - #link("https://typst.app/universe/package/showybox", text("Type: Universe", fill: colors.red)), #link("https://github.com/Pablo-Gonzalez-Calderon/showybox-package", text("GitHub repository", fill: colors.red)) and #link("https://github.com/Pablo-Gonzalez-Calderon/showybox-package/blob/main/Showybox's%20Manual.pdf", text("documentation", fill: colors.red)).
#v(0.5em)

*Code* -- `codelst`
	- *Description* : This package allows you to format blocks of source code, including line numbering.
	- *Links* #link("https://typst.app/universe/package/codelst", text("Typst: Universe", fill: colors.red)), #link("https://github.com/jneug/typst-codelst", text("GitHub repository", fill: colors.red)) and #link("https://github.com/jneug/typst-codelst/blob/main/manual.pdf", text("documentation", fill: colors.red)).

#v(0.5em)

*Algorithm* -- `lovelace`
	- *Description*: This package allows you to write pseudocode with customizable formatting.
	- *Links* - #link("https://typst.app/universe/package/lovelace", text("Type: Universe", fill: colors.red)), #link("https://github.com/andreasKroepelin/lovelace", text("GitHub repository", fill: colors.red)) and documentation (see ReadMe on GitHub).

#v(0.5em)

*Mathematics* -- `physica`
	- *Description*: This package provides shortcuts for writing mathematical symbols.
	- *Links* - #link("https://typst.app/universe/package/physica", text("Type: Universe", fill: colors.red)), #link("https://github.com/Leedehai/typst-physics", text("GitHub repository", fill: colors.red)) and #link("https://github.com/Leedehai/typst-physics/blob/v0.9.3/physica-manual.pdf", text("documentation", fill: colors.red)).

#v(0.5em)

*Glossary* - `glossarium`.
	- *Description*: This package will create a glossary.
	- *Links* - #link("https://typst.app/universe/package/glossarium", text("Type: Universe", fill: colors.red)), #link("https://github.com/ENIB-Community/glossarium", text("GitHub repository", fill: colors.red)) and #link("https://github.com/ENIB-Community/glossarium/blob/master/docs/main.pdf", text("documentation", fill: colors.red)).

#v(0.5em)

*Index* - `in-dexter`.
	- *Description*: This package makes it easy to create an index.
	- *Links*: #link("https://typst.app/universe/package/in-dexter", text("Type: Universe", fill: colors.red)), #link("https://github.com/RolfBremer/in-dexter", text("GitHub repository", fill: colors.red)) and #link("https://github.com/RolfBremer/in-dexter/blob/main/sample-usage.pdf", text("documentation", fill: colors.red)).

#v(0.5em)

*Presentation* - `polylux`
  - *Description*: This package allows you to create `PowerPoint` or `Beamer`-like presentations.
  - *Links* : #link("https://typst.app/universe/package/polylux", text("Type: Universe", fill: colors.red)), #link("https://github.com/andreasKroepelin/polylux", text("GitHub repository", fill: colors.red)) and #link("https://polylux.dev/book/", text("documentation", fill: colors.red)).

// #pagebreak()
#bibliography("biblio.yml", style: "ieee")



