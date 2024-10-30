#import "../report.typ": *
#import "utils.typ": *
#import "@preview/mantys:0.1.4": *

#let title = [Template Typst pour la rédaction \ de l'étude bibliographique]

#show: report-template.with(
  title: title,
  course: "Projet d'initiation à la recherche",
  authors: ("Mathieu Aucejo",),
  supervisors: none,
  academic-program: [FISA Mécanique -- 3#super[ème] année],
  academic-year: [2024 -- 2025],
  cover-image: image("../images/lecnam.jpg"),
)

#align(center)[*Résumé*]

Ce package #typst est un modèle pour la rédaction du rapport de synthèse bibliographique dans le cadre du module "Projet d'initiation à la recherche" de 3#super[ème] année de la FISA Mécanique du Conservatoire national des arts et métiers.

= Qu'est-ce que Typst ?

#typst est un nouveau langage de balise open source écrit en Rust et développé à partir de 2019 par deux étudiants allemands, Laurenz Mädje et Martin Haug, dans le cadre de leur projet de master @Mad22 @Hau22. La version 0.1.0 a été publiée sur GitHub le 04 avril 2023.

#typst se présente comme un successeur de #LaTeX plus moderne, rapide et simple d'utilisation. Parmi ses avantages, on peut citer :

- la compilation incrémentale ;
- des messages d'erreur clair et compréhensible ;
- un langage de programmation Turing-complet ;
- une système de style cohérent permettant de configurer aisément tous les aspects de son document (police, pagination, marges, #sym.dots) ;
- une communauté active et sympathique (serveur Discord pour le support, annonce de nouveaux paquets) ;
- un système de paquets simple d'utilisation (pour rechercher ou voir la liste des paquets, n'hésitez pas à visiter #link("https://typst.app/universe", text("Typst: Universe", fill: colors.red))) ;
- des extensions pour VS Code existent, comme `Typst LSP` ou `Tinymist`, pour avoir des fonctionnalités similaires à `LaTeX Workshop`.

Pour finir, la documentation de #typst est suffisamment bien écrite et détaillée pour permettre de créer rapidement ses propres documents. Il faut compter moins d'une heure pour prendre en main la syntaxe (sans mentir #emoji.face.beam). Pour accéder à la documentation, suivez ce #link("https://typst.app/docs", text("lien", fill: colors.red)). Pour faciliter la transition de #LaTeX vers #typst, un guide est disponible #link("https://typst.app/docs/guides/guide-for-latex-users/", text("ici", fill: colors.red)).

= Utilisation

Pour utiliser le modèle, il faut l'importer dans votre fichier principal `typ`. En supposant que le template et le fichier principal sont dans le même dossier, il suffit d'insérer la commande suivante à la première ligne du fichier principal.

#codesnippet[
	```typ
	#import "report.typ": *
	```
]

#ibox[
	#set text(size: 11pt)

	Si vous décomposez votre document en différents fichiers, il faut insérer la commande précédente en préambule de chaque fichier.
]

== Initialisation du modèle

Après avoir importé le modèle, celui doit être initialisé en appliquant une règle d'affichage (`show` rule) avec la commande #cmd("report-template") en passant les options nécessaires avec l'instruction `with` dans votre fichier principal `typ` :

#codesnippet(
	```typ
	#show report-template.with(
	  ...
	)
	```
)

Le modèle #cmd("report-template") possède un certain nombre de paramètres permettant de personnaliser le document. Voici la liste des paramètres disponibles :

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
  #argument("title", default: [Titre du rapport], types: ("string", "content"))[Titre du document]

  #argument("course", default: [Nom du module], types: ("string", "content"))[Intitulé du module d'enseignement]

  #argument("authors", default: "", types: ("array"))[Liste des auteurs

  #underline[exemple :] `("Auteur A", "Auteur B")`
  ]

  #argument("supervisors", default: "", types: (none, "array"))[Liste des encadrants du module

  #underline[exemple :] `("Encadrant A", "Encadrant B")`
  ]

	#argument("academic-program", default: none, types: (none, "string", "content"))[Nom de la formation]

  #argument("academic-year", default: none, types: (none, "string", "content"))[Année universitaire en cours

  #underline[exemple :] `"2024 - 2025"`
  ]

  #argument("cover image", default: none, types: (none, "content"))[Image d'illustration du document

  #underline[exemple :] `image("image.png")`
  ]
]

== Rédaction du document

Le contenu du document est à rédiger dans le fichier principal `typ` ou dans des fichiers annexes. Pour apprendre les bases de la rédaction d'un document en #typst, vous pouvez consulter ce #link("https://typst.app/docs/tutorial/", text(fill: colors.red, "tutoriel")), qui vous permettra de vous familiariser avec les principales fonctionnalités en moins d'une heure.

== Gestion de la bibliographie

Pour insérer une bibliographie, il faut insérer dans le fichier principal `typ` la commande suivante :
#codesnippet[
	```typ
	#bibliography("fichier-biblio.yml/bib")
	```
]

#ibox[
#set text(size: 11pt)
Le modèle propose deux formats de bibliographie : YAML et BibTeX.

Pour le fichier YAML, celui-ci est interprété par le module `hayagriva`, dont la documentation est disponible #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md", text("ici", fill: colors.red)).
]

Pour citer une référence bibliographique dans le texte, il suffit d'utiliser la commande #cmd("cite", arg[key]) ou plus simplement #text(`@key`, fill: colors.red.darken(15%)) (où `key` est la clé associée à la référence).

Pour plus d'informations sur la gestion des références bibliographiques, il faut se référer à la documentation de la fonction #cmd("bibliography") de #typst (accessible #link("https://typst.app/docs/reference/model/bibliography/", text("ici", fill: colors.red))).

== Gestion des annexes

Le modèle propose un environnement `appendix` pour différencier le corps du document des informations annexes. Dans cet environnement, la numérotation des titres de section, des figures, tableaux et équations est adapté au contexte. Pour activer cet environnement, il faut insérer dans le fichier principal `typ` à l'endroit souhaité la commande suivante :
#codesnippet[
  ```typ
  #show: appendix
  ```
]

== Fonctionnalités additionnelles

Cette section présente les fonctions complémentaires implémentées dans le modèle pour faciliter la rédaction du document.

*Figures*

D'une manière générale, les figures sont insérées dans le document à l'aide de la fonction #cmd("figure") de #typst. Cependant, #typst ne dispose pas actuellement de mécanismes permettant de gérer les sous-figures (numérotation et référencement). Pour pallier ce manque, le modèle définit une fonction #cmd("subfigure") permettant de gérer les sous-figures de manière adaptée. Cette fonction encapsule la fonction #cmd("subpar.grid") du package `subpar`.

#codesnippet[
	```typ
	#subfigure(
		figure(image("image1.png"), caption: []),
		figure(image("image2.png"), caption: []), <b>,
		columns: (1fr, 1fr),
		caption: [Titre de la figure],
		label: <fig:subfig>,
	)
	```
]

L'exemple précédent illustre le cas d'une figure composée de deux sous-figures. La première sous-figure est accompagnée d'une légende, tandis que la seconde possède un #dtype("label") mais pas de titre. La seconde sous-figure peut ainsi être référencée dans le texte à l'aide de la commande #text(`@b`, fill: colors.red.darken(15%)).

*Équations*

Pour encadrer une équation importante, la fonction #cmd("boxeq") doit être utilisée.

#codesnippet[
```typ
$
#boxeq[$p(A|B) prop p(B|A) space p(A)$]
$
```
]

Pour créer une équation sans numérotation, il faut utiliser la fonction #cmd("nonumeq").

#codesnippet[
```typ
#nonumeq[$ integral_0^1 f(x) dif x = F(1) - F(0) $]
```
]

= Paquets recommandés

Cette section présente une liste de paquets qui peuvent être pertinents lors de la rédaction d'un document en #typst.

*Dessin* -- `CeTZ`
	- *Description* : Ce paquet se veut être un équivalent #typst de TiKZ pour #LaTeX.
	- *Liens* - #link("https://typst.app/universe/package/cetz", text("Typst: Universe", fill: colors.red)), #link("https://github.com/cetz-package/cetz", text("dépôt GitHub", fill: colors.red)) et #link("https://github.com/cetz-package/cetz/blob/stable/manual.pdf?raw=true", text("documentation", fill: colors.red)).

#v(0.5em)

*Boîtes* -- `showybox`
	- *Description* : Ce paquet permet de créer des boîtes de contenus (textes, #sym.dots) personnalisables.
	- *Liens* - #link("https://typst.app/universe/package/showybox", text("Typst: Universe", fill: colors.red)), #link("https://github.com/Pablo-Gonzalez-Calderon/showybox-package", text("dépôt GitHub", fill: colors.red)) et #link("https://github.com/Pablo-Gonzalez-Calderon/showybox-package/blob/main/Showybox's%20Manual.pdf", text("documentation", fill: colors.red)).

#v(0.5em)

*Code* -- `codelst`
	- *Description* : Ce paquet permet de formatter des blocs de code source en incluant notamment la numérotation des lignes.
	- *Liens* #link("https://typst.app/universe/package/codelst", text("Typst: Universe", fill: colors.red)), #link("https://github.com/jneug/typst-codelst", text("dépôt GitHub", fill: colors.red)) et #link("https://github.com/jneug/typst-codelst/blob/main/manual.pdf", text("documentation", fill: colors.red)).

#v(0.5em)

*Algorithme* -- `lovelace`
	- *Description* : Ce paquet permet d'écrire du pseudo-code, dont le formattage est personnalisable.
	- *Liens* - #link("https://typst.app/universe/package/lovelace", text("Typst: Universe", fill: colors.red)), #link("https://github.com/andreasKroepelin/lovelace", text("dépôt GitHub", fill: colors.red)) et documentation (voir ReadMe sur GitHub).

#v(0.5em)

*Mathématiques* - `physica`
	- *Description* : Ce paquet propose des raccourcis pour l'écriture de symboles mathématiques.
	- *Liens* - #link("https://typst.app/universe/package/physica", text("Typst: Universe", fill: colors.red)), #link("https://github.com/Leedehai/typst-physics", text("dépôt GitHub", fill: colors.red)) et #link("https://github.com/Leedehai/typst-physics/blob/v0.9.3/physica-manual.pdf", text("documentation", fill: colors.red)).

#v(0.5em)

*Glossaire* - `glossarium`
	- *Description* : Ce paquet permet de créer un glossaire.
	- *Liens* - #link("https://typst.app/universe/package/glossarium", text("Typst: Universe", fill: colors.red)), #link("https://github.com/ENIB-Community/glossarium", text("dépôt GitHub", fill: colors.red)) et #link("https://github.com/ENIB-Community/glossarium/blob/master/docs/main.pdf", text("documentation", fill: colors.red)).

#v(0.5em)

*Index* - `in-dexter`
	- *Description* : Ce paquet permet de créer aisément un index.
	- *Liens* : #link("https://typst.app/universe/package/in-dexter", text("Typst: Universe", fill: colors.red)), #link("https://github.com/RolfBremer/in-dexter", text("dépôt GitHub", fill: colors.red)) et #link("https://github.com/RolfBremer/in-dexter/blob/main/sample-usage.pdf", text("documentation", fill: colors.red)).

#v(0.5em)

*Présentation* - `polylux`
  - *Description* : Ce paquet permet de créer des présentations de type `PowerPoint` ou `Beamer`.
  - *Liens* : #link("https://typst.app/universe/package/polylux", text("Typst: Universe", fill: colors.red)), #link("https://github.com/andreasKroepelin/polylux", text("dépôt GitHub", fill: colors.red)) et #link("https://polylux.dev/book/", text("documentation", fill: colors.red)).

#pagebreak()
#bibliography("biblio.yml", style: "ieee")



