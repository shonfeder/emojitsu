open Bos_setup
module EmojiMap = Bimap.Make (String) (String)

let emap =
  let add Emoji.{ string; name; _ } m = EmojiMap.add ~k:name ~v:string m in
  List.fold_right add Github_table.v EmojiMap.empty

let name_to_unicode name = EmojiMap.Key.find_opt name emap

let unicode_to_name unicode = EmojiMap.Val.find_opt unicode emap

(* Entry points *)

let lookup ~f needle =
  f needle
  |> Option.to_result ~none:Rresult.R.(msgf "No entry found for %s" needle)

let lookup_name unicode =
  lookup ~f:unicode_to_name unicode |> Result.map print_endline

let lookup_unicode name =
  lookup ~f:name_to_unicode name |> Result.map print_endline

let ( let* ) = Result.bind

let emoji_name_re =
  let open Re in
  let boundary = alt [bol; eol; space; blank; stop] in
  seq [ (group boundary); char ':'; group (rep1 wordc); char ':'; (group boundary)] |> Re.compile

let replace_emoji_names str =
  let f group =
    (* If group is :woman_artist: ... *)
    (* ... then unchanged is :woman_artist: ... *)
    let unchanged = Re.Group.get group 0 in
    (* ... and name is woman_artist *)
    let name = Re.Group.get group 2 in
    let start_boundary = Re.Group.get group 1 in
    let end_boundary = Re.Group.get group 3 in
    match name_to_unicode name with
    | None ->
      Logs.warn (fun fmt -> fmt "no emoji found for %s" unchanged);
      unchanged
    | Some emoji -> start_boundary ^ emoji ^ end_boundary
  in
  Re.replace emoji_name_re ~f str

let%expect_test "emoji name regex" =
  let check str = replace_emoji_names str |> print_endline in
  (* we don't alter text when names don't appear in it *)
  check "foo";
  [%expect {| foo |}];
  (* nonsense names don't result in alteration *)
  check "foo :bar: baz";
  [%expect {|
    inline_test_runner_lib.exe: [WARNING] no emoji found for  :bar:
    foo :bar: baz |}];
  (* proper names are replaced *)
  check ":woman:";
  [%expect {| 👩 |}];
  check "foo :woman_artist: baz";
  [%expect {| foo 👩‍🎨 baz |}];
  check ":woman_scientist: foo bar";
  [%expect {| 👩‍🔬 foo bar |}];
  check "foo bar :woman_scientist:";
  [%expect {| foo bar 👩‍🔬 |}];
  (* don't replace stuff that has no boundaries *)
  check "foo:woman:bar";
  [%expect {| foo:woman:bar |}]

let emojify file =
  file
  |> OS.File.read
  |> Result.map replace_emoji_names
  >>= OS.File.write file
