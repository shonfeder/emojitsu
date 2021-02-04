(* Fetches the latest emoji data from the gitup API, updates ./gen/emoji_table.ml *)
let fetch_json () : Yojson.Safe.t =
  let Curly.Response.{ body; _ } =
    Curly.get "https://api.github.com/emojis" |> Result.get_ok
  in
  Yojson.Safe.from_string body

let unicode_url =
  Re.str "https://github.githubassets.com/images/icons/emoji/unicode/"

let unicode_url_re = Re.(seq [ unicode_url; any ] |> compile)

let url_re =
  let open Re in
  let code_point = group (rep1 alnum |> rep1) in
  seq
    [ unicode_url
    ; code_point
    ; opt (seq [ char '-'; code_point ])
    ; str ".png"
    ; rep any
    ]
  |> compile

let str_to_point s = int_of_string [%string "0x%{s}"]

let str_to_unicode s =
  let buf = Buffer.create 16 in
  str_to_point s |> Uchar.of_int |> Uutf.Buffer.add_utf_8 buf;
  Buffer.contents buf

(* TODO Add support for unicode.org chart names: https://unicode.org/emoji/charts/emoji-list.html
 * So users can pick which dictionary they want to use *)

let ( let* ) = Option.bind

let parse_png_url url =
  let* matches = Re.exec_opt url_re url in
  Some (Re.Group.all matches |> Array.to_list |> List.tl)

exception Invalid_png_url of string

exception Invalid_entry of Yojson.Safe.t

let validate_entry = function
  | (_, `String _) as e -> e
  | _, err              -> raise (Invalid_entry err)

let make_entry (name, `String png_url) =
  match parse_png_url png_url with
  | None           -> None
  | Some [ x; "" ] ->
      Some
        Emoji.
          { code_points = [ str_to_point x ]; string = str_to_unicode x; name }
  | Some [ x; y ]  ->
      Some
        Emoji.
          { code_points =
              [ str_to_point x; Emoji.zwj_code_point; str_to_point y ]
          ; string =
              String.concat "" [ str_to_unicode x; Emoji.zwj; str_to_unicode y ]
          ; name
          }
  | _              -> raise (Invalid_png_url png_url)

exception Invalid_response of Yojson.Safe.t

let make_table : Yojson.Safe.t -> Emoji.table = function
  | `Assoc fields ->
      fields |> List.map validate_entry |> List.filter_map make_entry
  | json          -> raise (Invalid_response json)

let run arg =
  let decl =
    let table_str = fetch_json () |> make_table |> Emoji.show_table in
    "let v = " ^ table_str
  in
  let contents =
    String.concat "\n" [ {|(** WARNING: THIS FILE IS GENERATED *)|}; ""; decl ]
  in
  match arg with
  | Some fpath -> Bos.OS.File.write fpath contents
  | None       -> Ok (print_endline decl)

let () =
  let open Kwdcmd in
  let conv = Kwdcmd.Arg.conv ~docv:"OUT_FILE" Fpath.(of_string, pp) in
  Exec.run
    ~name:"gen-github-emoji"
    ~version:"0.0.1"
    ~doc:"tool used internal to emojitsu to generate a table of github emoji"
    ( const run
    $ Optional.pos
        "OUT_FILE"
        ~conv
        ~nth:0
        ~doc:"File to write emoji table into. When absent, writes to stdout."
        () )
