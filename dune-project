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
  (ppx_jane (>= v0.14.0))

  (curly (>= 0.2.0))
  (re (>= 1.9.0))

   ; pinned
   kwdcmd

  ; test deps
  (alcotest :with-test)))
