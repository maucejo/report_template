#import "presentation.typ": *

#let colors = (
  red: rgb("c1200a")
)

// Title of presentation
#let title = [Title
#v(-0.5em)
#line(length: 15%, stroke: 0.075em + colors.red)
#v(-0.5em)
#text(size: 0.8em, [Subtitle])
]

// Authors
#let authors = [#text(fill: colors.red, [Author A]) #h(1em) Author B]

// Template initialization
#show: presentation-theme.with(
  lang: "en",
  config-info(
    title: title,
    short-title: [Short title],
    author: authors,
  )
)

// Title slide
#title-slide

// Content slide
#content-slide

// New section slide
= First section

== Slide title <first-slide>

#subtitle("A subtitle")

// Normal slide
#emphbox[
$
bold(z)_(k + 1) = bold(A) bold(z)_k + bold(B) bold(u)_k + bold(w)_k \
bold(y)_k = bold(C) bold(z)_k + bold(v)_k
$
]

- #lorem(20)

#link-box(<code-slide>, "Go to code slide")

= Second section

== Slide title

#info[#lorem(10)]
#tip[#lorem(10)]
#important[#lorem(10)]
#question[#lorem(10)]

= Third section

== Slide title <code-slide>

A piece of code

#code(lang:"Julia")[
```julia
# A comment
function squared(x)
  return x^2
end
```
]

#link-box(<first-slide>, "Go to first slide")

// Focus slide
#focus-slide[
  Thank you for your attention !

  Questions ?
]

#show: appendix
// Appendix slide
= Appendix <touying:hidden>

== An appendix slide