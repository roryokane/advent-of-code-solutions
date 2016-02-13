open Core.Std

let times_to_repeat = 40

let () =
  let require_line = (function
      | None -> failwith "input required"
      | Some line -> line) in
  In_channel.input_line stdin |> require_line
  |> MathSequence.iterate ~f:LookAndSay.next ~count:times_to_repeat
  |> String.length |> Int.to_string
  |> print_string
