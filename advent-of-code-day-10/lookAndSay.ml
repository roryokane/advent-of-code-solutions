open Core.Std

let count_digit_pair repeated_digits =
  (List.length repeated_digits, List.hd_exn repeated_digits)

let next digits =
  String.to_list digits
  |> List.group ~break:(Char.(<>))
  |> List.map ~f:count_digit_pair
  |> List.concat_map ~f:(function | (count, digit) -> [Int.to_string count; Char.to_string digit])
  |> String.concat ~sep:""
