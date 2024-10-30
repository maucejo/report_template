#import "report.typ": *

#show: report-template.with(
  title: [Titre du document],
  course: "Projet d'initiation à la recherche",
  authors: ("Auteur A", "Auteur B"),
  supervisors: ("Encadrant A", "Encadrant B"),
  academic-program: [FISA Mécanique -- 3#super[ème] année],
  academic-year: [2024 -- 2025],
  cover-image: image("images/lecnam.jpg"),
  lang: "fr"
)

= Introduction

#lorem(10)