(lang dune 2.7)

(name emojitsu)
(version 0.0.5)

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
  (dune (> 2.7))
  
  ; dev
  (curly (and :with-test (>= 0.2.0)))
  (uutf (and :with-test (>= 1.0.2)))

  ; libs
  (bos (and (>= 0.2.0) (< 0.3.0)))
  (re (and (>= 1.9.0) (< 1.10.0)))
  (yojson (and (>= 1.7.0) (< 1.8.0)))

  ; preprocessors
  (ppx_deriving (and (>= 5.1) (< 6.0)))
  (ppx_expect (and (>= v0.14.0) (< v0.15.0)))
  (ppx_inline_test (and (>= v0.14.0) (< v0.15.0)))
  (ppx_string (and (>= v0.14.0) (< v0.15.0)))

   ; pinned, see ./emojitsu.opam.template
  kwdcmd))
(using mdx 0.1)
