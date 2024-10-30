#import "@preview/subpar:0.1.1"

// Global settings
#let pir-param = (
  paper: "a4",
  text-size: 13pt,
  text-font: "Libertinus",
  math-font: ("Libertinus Math", "New Computer Modern Math"),
  fig-supplement: [Figure],
)

#let colors = (
  red: rgb("#c1002a"),
  gray: rgb("#405A68")
)

#let states = (
  isapp: state("isapp", false)
)

// Environnements
// Appendix
#let appendix(body) = {
  counter(math.equation).update(0)
  set heading(numbering: "A.1.")
  // Reset heading counter
  counter(heading.where(level: 1)).update(0)
  // Reset heading counter for the table of contents
  counter(heading).update(0)

  set math.equation(numbering: n => numbering("(A.1)", counter(heading).get().first(), n))

  show figure.where(kind: image): set figure(
    numbering: n => numbering("A.1", counter(heading).get().first(), n)
  )

  states.isapp.update(true)

  body
}

// Subfigure
#let subfigure = {
  subpar.grid.with(
    numbering: n => if states.isapp.get() {numbering("A.1", counter(heading).get().first(), n)
      } else {
        numbering("1", n)
      },
    numbering-sub-ref: (m, n) => if states.isapp.get() {numbering("A.1a", counter(heading).get().first(), m, n)
      } else {
        numbering("1a", m, n)
      },
    supplement: pir-param.fig-supplement
  )
}

// Boxed equation
#let boxeq(body) = {
  set align(center)
  box(
    stroke: 1pt + colors.gray,
    radius: 5pt,
    inset: 0.5em,
    fill: colors.gray.lighten(60%),
  )[#body]
}

// Unnumbered equation
#let nonumeq(x) = {
   set math.equation(numbering: none)
   x
}

// Template
#let report-template(
  title: [Titre du rapport],
  course: [Nom du module],
  authors: "",
  supervisors: "",
  academic-program: none,
  academic-year: none,
  cover-image: none,
  lang: "fr",
  body
) = {
  // localization
  let localization = json("resources/i18n/fr.json")
  if lang == "en" {
    localization = json("resources/i18n/en.json")
  }

  // Document metadata
  set document(author: authors, title: title)

  // Text settings
  set text(font: pir-param.text-font, size: pir-param.text-size, lang: lang)
  show math.equation: set text(font: pir-param.math-font)

  // Paragraph settings
  set par(justify: true)

  // Page settings
  let header = {
    set text(fill: colors.gray)
    context{
      let page-number = counter(page).at(here()).first()
      if page-number > 0 {
        grid(
          columns: (1fr, 1fr),
          [#set align(left)
           #course],
          [#set align(right)
           #academic-year]
        )
        v(-0.5em)
        line(length: 100%, stroke: 0.5pt + colors.red)
      }
    }
  }

  let footer = {
    context{
      let page-number = counter(page).at(here()).first()
      let page-final = counter(page).final().first()
      if page-number > 0 {
       set align(right)
       set text(fill: colors.gray)
       [Page #page-number #localization.of #page-final]
      }
    }

  }

  set page(
    paper: pir-param.paper,
    header: none,
    footer: none
  )

  // Headings
  set heading(numbering: "1.1.")
  show heading: it => {
    it
    v(0.5em)

    context{
      if it.level == 1 and states.isapp.get() {
        counter(math.equation).update(0)
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: table)).update(0)
      }
    }
  }

  // Equations
  set math.equation(numbering: "(1)", supplement: localization.equation)

  // Tables
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    it
  }

  // Figures
  show figure: set figure.caption(separator: [ -- ])
  show figure.where(kind: image): set figure(
    supplement: pir-param.fig-supplement,
    numbering: "1"
  )

  // Listes et Énumération
  set list(marker: [#text(fill:colors.red)[#sym.bullet]])
  set enum(numbering: n => text(fill:colors.red)[#n.])

  // Title page
  // Logo
  align(top + right)[
    #if lang == "fr" {
      image("resources/assets/eicnam.png", width: 25%)
    } else {
      image("resources/assets/leCnam_Logo.png", width: 25%)
    }
  ]

  // Cover image
  if cover-image != none {
    cover-image
    v(-8em)
  }

  // Title of the document
  align(center + horizon)[
    #if course != none {
      set text(size: 1.25em)
      smallcaps(course)
    }

    #v(-1em)
    #if title != none {
      set text(size: 2em)
      line(length: 100%, stroke: 0.5pt + colors.red)
      [*#title*]
      line(length: 100%, stroke: 0.5pt + colors.red)
    }
  ]

  // Author + Supervisor
  grid(
    columns: (1fr, 1fr),
    [
      #set align(left)
      #if authors.len() > 1 {
        [*#localization.authors*]
      } else {
        [*#localization.author*]
      }
      #linebreak()
      #for author in authors {
        author
        linebreak()
      }
    ],
    [
      #set align(right)
      #if supervisors != none {
        if supervisors.len() > 1 {
          [*#localization.supervisors*]
        } else {
          [*#localization.supervisor*]
        }
        linebreak()
        for supervisor in supervisors {
          supervisor
          linebreak()
        }
      }
    ]
  )

  // Bas de la page de titre
  align(center + bottom)[
    #if academic-program != none {
      academic-program
    }

    #if academic-year != none {
      [#localization.academic-year #academic-year]
    }
  ]

  // Table des matières
  pagebreak()
  outline(title: localization.toc, depth: 3, indent: true)
  pagebreak()

  set page(
    paper: pir-param.paper,
    header: header,
    footer: footer
  )

  counter(page).update(1)

  body
}