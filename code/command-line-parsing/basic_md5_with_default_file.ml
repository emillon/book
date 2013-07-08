open Core.Std

let get_file_data =
  function
  | "-"      -> In_channel.stdin
  | filename -> In_channel.create ~binary:true filename

let do_hash filename () =
  let open Cryptokit in
  get_file_data filename
  |> hash_channel (Hash.md5 ())
  |> transform_string (Hexa.encode ())
  |> print_endline

let command =
  Command.basic
    ~summary:"Generate an MD5 hash of the input data"
    ~readme:(fun () -> "More detailed information")
    Command.Spec.(
      empty 
      +> anon (maybe_with_default "-" ("filename" %: file))
    )
    do_hash

let () =
  Command.run ~version:"1.0" ~build_info:"RWO" command