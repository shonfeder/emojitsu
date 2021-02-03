open Kwdcmd

let () =
  Exec.select
    ~name:"emojitsu"
    ~version:"0.0.1"
    ~doc:"Techniques for dealing with emoji"
    [ ( cmd
          ~name:"find-name"
          ~doc:"Find the (GitHub) name of an emoji given its unicode"
      @@ let+ unicode = Required.pos "UNICODE" ~conv:Arg.string ~nth:0 () in
         Lib.Github.lookup_name unicode )
    ; ( cmd
          ~name:"find-unicode"
          ~doc:"Find the unicode of an emoji given its (GitHub) name"
      @@ let+ name = Required.pos "EMOJI_NAME" ~conv:Arg.string ~nth:0 () in
         Lib.Github.lookup_unicode name )
    ; ( cmd
          ~name:"emojify"
          ~doc:
            "Replace all names of the form :emoji_name: with the corresponding \
             unicode in the given file"
      @@ let+ name =
           Required.pos
             "FILE"
             ~conv:Arg.(conv (Fpath.of_string, Fpath.pp))
             ~nth:0
             ()
         in
         Lib.Github.emojify name )
    ]
