(lang dune 2.7)
(name emojitsu)
(generate_opam_files true)

; (source (github mirage/ocaml-cohttp))
(license MIT)
(authors "Shon Feder")
(maintainers "TODO")

(package
 (name emojitsu)
 (synopsis "Emoji utilities")
 (description "TODO ")
 (depends
  (dune (> 2.7))
  (alcotest :with-test)
   bos
   ppx_deriving
   kwdcmd                       ; TODO add as pin dep
))
