#import "@preview/touying:0.5.3": *
#import "@preview/showybox:2.0.3": *
#import "@preview/codelst:2.0.2": sourcecode

// Emphasized box (for equations)
#let _emphbox(self: none, body) = {
  set align(center)
  box(
    stroke: 1pt + self.colors.box.lighten(20%),
    radius: 5pt,
    inset: 0.5em,
    fill: self.colors.box.lighten(80%),
  )[#body]
}
#let emphbox(body) = touying-fn-wrapper(_emphbox.with(body))
//----

#let _subtitle(self: none, body) = {
  if self.store.navigation == "topbar" {
    set text(size: 1.2em, fill: self.colors.primary, weight: "bold")
    place(top + left, pad(left: -0.8em, top: -0.25em, body))
    v(1em)
  }
}
#let subtitle(body) = touying-fn-wrapper(_subtitle.with(body))

//---- Utilities for boxes ----
#let box-title(a, b) = {
  grid(columns: 2, column-gutter: 0.5em, align: (horizon),
    a,
    b
  )
}

#let colorize(svg, color) = {
  let blk = black.to-hex();
  if svg.contains(blk) {
    svg.replace(blk, color.to-hex())
  } else {
    svg.replace("<svg ", "<svg fill=\""+color.to-hex()+"\" ")
  }
}

#let color-svg(
  path,
  color,
  ..args,
) = {
  let data = colorize(read(path), color)
  return image.decode(data, ..args)
}
//----

//---- Utility boxes ----
// Information box
#let _info(self: none, body) = {
  set text(size: 0.8em)

  showybox(
    title: box-title(color-svg("resources/assets/icons/info.svg", self.colors.info, width: 1em), [*Note*]),
    title-style: (
      color: self.colors.info,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.info.lighten(80%),
      border-color: self.colors.info,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let info(body) = touying-fn-wrapper(_info.with(body))

// Tip box
#let _tip(self: none, body) = {
  set text(size: 0.8em)

  showybox(
    title: box-title(color-svg("resources/assets/icons/light-bulb.svg", self.colors.tip, width: 1em), [*Tip*]),
    title-style: (
      color: self.colors.tip,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.tip.lighten(80%),
      border-color: self.colors.tip,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let tip(body) = touying-fn-wrapper(_tip.with(body))

// Important box
#let _important(self: none, body) = {
  set text(size: 0.8em)
  showybox(
    title: box-title(color-svg("resources/assets/icons/report.svg", self.colors.important, width: 1em), [*Important*]),
    title-style: (
      color: self.colors.important,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.important.lighten(80%),
      border-color: self.colors.important,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let important(body) = touying-fn-wrapper(_important.with(body))

// Question box
#let _question(self: none, body) = {
  set text(size: 0.8em)
  showybox(
    title: box-title(color-svg("resources/assets/icons/question.svg", self.colors.question, width: 1em), [*Question*]),
    title-style: (
      color: self.colors.question,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.question.lighten(80%),
      border-color: self.colors.question,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let question(body) = touying-fn-wrapper(_question.with(body))

// Code box
#let _code(self: none, lang: none, body) = sourcecode(
    frame: showybox.with(
      title: [*Code* #h(1fr) #strong(lang)],
      frame: (
        title-color: self.colors.primary,
        border-color: self.colors.primary,
        body-color: none,
        thickness: (left: 3pt),
        radius: (top-left: 0pt, top-right: 1em),
      )
    ),
    body
)
#let code(lang: none, body) = touying-fn-wrapper(_code.with(lang: lang, body))

// Link box
#let _link-box(self: none, location, name) = {
  block(fill: self.colors.primary, radius: 1em, inset: 0.5em)[
    #set text(fill: white, size: 0.8em, weight: "bold")
    #link(location, name)
  ]
}
#let link-box(location, name) = touying-fn-wrapper(_link-box.with(location, name))

#let _typst-builtin-align = align

#let _typst-builtin-align = align

#let slide(
  title: auto,
  subtitle: none,
  align: horizon,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
    if align != auto {
      self.store.align = align
    }

    let align = _typst-builtin-align
    set strong(delta: 0)
    let header(self) = {
      if self.store.navigation == "topbar" {
        set align(top)
        show: components.cell.with(fill: self.colors.primary, inset: 1em)
        set align(horizon)
        set text(fill: white, size: 1.25em)
        strong(utils.display-current-heading(level: 1, numbered: false))
        h(1fr)
        text(size: 0.8em, strong(utils.display-current-heading(level: 2, numbered: false)))
      } else if self.store.navigation == "mini-slides" {
        show: components.cell.with(fill: gradient.linear(self.colors.background.darken(10%), self.colors.background, dir: ttb))
        components.mini-slides(
          self:self,
          fill: self.colors.primary,
          alpha: 60%,
          display-section: self.store.mini-slides.at("display-section", default: false),
          display-subsection: self.store.mini-slides.at("display-subsection", default: true),
          short-heading: self.store.mini-slides.at("short-heading", default: true),
          linebreaks: false
        )
        line(length: 100%, stroke: 0.5pt + self.colors.primary)

        place(dx: 1em, dy: 0.65em, text(size: 1.2em, fill: self.colors.primary, weight: "bold", utils.display-current-heading(level: 2, numbered: false)))
      }
    }

    let footer(self) = {
       set align(bottom)
       set text(size: 0.8em)

       place(dx: 1em, dy: -1em, {
         grid(
          columns: (1fr, 4fr, 1fr),
          align: center + horizon,
          [ #set image(height: 1.75em)
            #self.info.footer-logo
          ],
          [
            #v(0.25em)
            #text(fill:self.colors.primary, strong(self.info.short-title))
          ],
          [
            #set text(fill:self.colors.primary, weight: "bold")
            #if self.appendix {
              self.store.app-count.step()
              context{
                pad(right: 2em, bottom: 1.5em, top: 0.25em,
                box(stroke: 1.75pt + self.colors.primary, radius: 5pt, inset: -1em,outset: 1.5em)[
                #align(horizon)[#text(fill: self.colors.primary, strong([A | #self.store.app-count.at(here()).first() / #self.store.app-count.final().first()]))]
                ])
              }
            } else {
              context box(stroke: 1.75pt + self.colors.primary, radius: 5pt, inset: -0.5em,outset: 1em)[#utils.slide-counter.display() / #utils.last-slide-number]
            }
          ]
        )
      })

      if self.appendix {
        let appendix-progress-bar = {
          context{
            let ratio = self.store.app-count.at(here()).first()/self.store.app-count.final().first()
            grid(
              columns: (ratio*100%, 1fr),
              components.cell(fill: self.colors.primary),
              components.cell(fill: self.colors.secondary.lighten(50%))
            )
          }
        }
        place(bottom, block(height: 2pt, width: 100%, spacing: 0pt, appendix-progress-bar))
      } else {
        place(bottom, components.progress-bar(height: 2pt, self.colors.primary, self.colors.secondary.lighten(40%)))
      }
    }

    let self = utils.merge-dicts(
    self,
    config-page(
      fill: self.colors.background,
      header: header,
      footer: footer,
    ),
  )

  let new-setting = body => {
    show: align.with(self.store.align)
    show: setting

    if self.store.navigation == "topbar" {v(-1em)}
    body
  }

  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
  }
)

#let title-slide = touying-slide-wrapper(self => {
  set strong(delta: 0)
  let content = {
    set align(center + horizon)
    if self.info.logo != none{
      set image(height: self.info.title-logo-height)
      if type(self.info.logo) == content {
        place(top + right, dx: -2cm, dy: 0.25cm, self.info.logo)
      } else {
        let im-grid = {
          grid(
            columns: self.info.logo.len(),
            column-gutter: 1fr,
            align: center + horizon,
            inset: 2cm,
            ..self.info.logo.map((logos) => logos)
          )
        }

        place(top, dy: -1.75cm, im-grid)
      }
    }

    block(width: 100%, inset: 2cm, {
      line(length: 100%, stroke: 0.15em + self.colors.primary)
      text(size: 1.75em, strong(self.info.title))
      line(length: 100%, stroke: 0.15em + self.colors.primary)

      if self.info.author != none {
        v(0.5em)
        set text(size: 1em)
        block(spacing: 1em, strong(self.info.author))
      }

      if self.info.institution != none {
        set text(size: 0.85em)
        block(spacing: 1em, self.info.institution)
      }
    })
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: self.colors.background,
      margin: (top: 0em, bottom: 0em, x: 0em)
    )
  )
  touying-slide(self: self, content)
  }
)

#let content-slide = touying-slide-wrapper(self => {
  let toc = "Table des matières"
  if self.store.lang == "en" {
    toc = "Contents"
  }

  set strong(delta: 0)
  let header = {
    if self.store.navigation == "topbar" {
      set align(top)
      show: components.cell.with(fill: self.colors.primary, inset: 1em)
      set align(horizon)
      set text(fill: white, size: 1.25em)
      strong(toc)
    } else if self.store.navigation == "mini-slides" {
      set align(top)
      show: components.cell.with(fill: gradient.linear(self.colors.background.darken(10%), self.colors.background, dir: ttb))
      v(0.8em)
      set align(horizon)
      set text(fill: self.colors.primary, size: 1.25em)
      h(0.75em) + strong(localizaton.toc)
      v(-0.6em)
      line(length: 100%, stroke: 0.5pt + self.colors.primary)
    }
  }

 let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: self.colors.background,
      header: header,
    ),
  )

  let content = {
    show outline.entry: it => {
      let number = it.body.children.first()
      let section = it.body.children.slice(1).join()
      block(above: 2em, below: 0em)
      [#text([#number], fill: self.colors.primary) #h(0.25em) #section]
    }

    set align(horizon)
    components.adaptive-columns(text(size: 1.2em, strong(outline(title:none, indent: 1em, depth: 1, fill: none))))
}

  touying-slide(self: self, content)
})

#let new-section-slide(level: 1, numbered: true, title) = touying-slide-wrapper(self => {
  let content = {
    set strong(delta: 0)
    self.store.sec-count.step()

    set align(horizon)
    show: pad.with(10%)
    set text(size: 1.5em)
    v(-0.7em)

    let section-progress-bar = {
      context{
        let ratio = self.store.sec-count.at(here()).first()/self.store.sec-count.final().first()
        grid(
          columns: (ratio*100%, 1fr),
          components.cell(fill: self.colors.primary),
          components.cell(fill: self.colors.secondary.lighten(50%))
        )
      }
    }

   stack(
      dir: ttb,
      spacing: 0.5em,
      [*#utils.display-current-heading(level: level, numbered: false)*],
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        section-progress-bar
      ),
    )
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.background)
  )
  touying-slide(self: self, content)
}
)

#let focus-slide(align: center + horizon, body) = touying-slide-wrapper(self => {
  let _align = align
  let align = _typst-builtin-align

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.primary, margin: 2em),
  )

  set text(fill: white, size: 2em)
  set strong(delta: 0)
  touying-slide(self: self, align(_align, strong(body)))
})

#let presentation-theme(
  aspect-ratio: "16-9",
  lang: "fr",
  navigation: "topbar",
  ..args,
  body
) = {
  show: touying-slides.with(
    config-info(
      title: none,
      short-title: none,
      author: none,
      institution: none,
      font: "Lato",
      math-font: "Lete Sans Math",
      code-font: "DejaVu Sans Mono",
      logo: if lang == "fr" {
        image("resources/assets/eicnam.png")
      } else {
        image("resources/assets/leCnam_Logo.png")
      },
      footer-logo: image("resources/assets/leCnam_Logo.png"),
      title-logo-height: if lang == "fr" {
        3em
      } else {
        2em
      },
    ),

    config-colors(
      primary: rgb("#c1002a"),
      secondary: rgb("#405a68"),
      background: rgb("#405a68").lighten(95%),
      box: rgb("#405a68"),
      info: rgb("#c1002a"),
      tip: rgb(31, 136, 61),
      important: rgb(9, 105, 218),
      question: rgb(130, 80, 223),
    ),

    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 30%,
      footer-descent: 30%,
      margin: (top: 3em, bottom: 1.5em, x: 2em),
    ),

    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),

    config-methods(
      init: (self: none, body) => {
        set text(font: self.info.font, size: 20pt, lang: lang, ligatures: false)
        show math.equation: set text(font: self.info.math-font)
        show raw: set text(font: self.info.code-font)
        set par(justify: true)

        set list(marker: ([#text(fill:self.colors.primary)[#sym.bullet]], [#text(fill:self.colors.primary)[#sym.triangle.filled.small.r]]))
        set enum(numbering: n => text(fill:self.colors.primary)[#n.])

        body
      }
    ),

    config-store(
      align: align,
      lang: lang,
      navigation: navigation,
      mini-slides: (display-section: false, display-subsection: true, short-heading: false),
      sec-count: counter("sec-count"),
      app-count: counter("app-count"),
    ),
    ..args,
  )

  set heading(numbering: "1.")
  body
}