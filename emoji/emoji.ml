(** Zero Width Joiner: https://en.wikipedia.org/wiki/Zero-width_joiner *)
let zwj = "\u{200D}"

let zwj_code_point = 0x200D

type t =
  { code_points : int list
  ; string : string
  ; name : string
  }
[@@deriving show]

type table = t list [@@deriving show]
