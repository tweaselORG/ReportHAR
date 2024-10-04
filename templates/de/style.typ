#let tweaselStyle(doc) = [
  #set page(numbering: (current, total) => "Seite " + str(current) + " von " + str(total), number-align: end)
  #set text(font: "Linux Libertine", size: 12pt, lang: "de")
  #set heading(numbering: "1.1.")
  #show link: underline
  #set text(hyphenate: true)
  #set enum(numbering: "a.")
  #set quote(block: true, quotes: true)
  #show quote: set pad(top: -1em)
  #set footnote.entry(indent: 0em)
  #show footnote.entry: set par(hanging-indent: 1em)

  #doc
]
