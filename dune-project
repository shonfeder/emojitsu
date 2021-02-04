(lang dune 2.7)
(name emojitsu)
(version 0.0.1)

(generate_opam_files true)

(source (github shonfeder/emojitsu))
(license MIT)
(authors "Shon Feder")
(maintainers "shon.feder@gmail.com")

(package
 (name emojitsu)
 (synopsis "Tiny executable techniques for dealing with emoji")
 (description "A utility for convering to and from emoji names and unicode.

Currently supports:

- look up emoji unicode by (GitHub) name
- look up emoji (GitHub) names by unicode
- replace all (GitHub) names in a file (or stdin) with the corresponding unicode ")
 (depends
  ; build
  (dune (> 2.7))
  
  ; dev
  (curly (and :with-test (>= 0.2.0)))
  (uutf (and :with-test (>= 1.0.2)))

  ; libs
  (bos (>= 0.2.0))
  (re (>= 1.9.0))

  ; preprocessors
  (ppx_deriving (>= 4.5))
  (ppx_jane (>= v0.14.0))

   ; pinned, see ./emojitsu.opam.template
  kwdcmd))
(using mdx 0.1)
