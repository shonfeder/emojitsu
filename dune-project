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
  (bos (>= 0.2.0))
  (ppx_deriving (>= 4.5))
  (ppx_deriving_yojson (>= 3.6.1))

   ; pinned
   kwdcmd
  (curly (>= 0.2.0))

  ; test deps
  (alcotest :with-test)))
