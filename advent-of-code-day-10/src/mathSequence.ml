open Core.Std

(** apply f to the value repeatedly the given number of times *)
let rec iterate ~f initial_value ~count =
  match count with
  | 0 -> initial_value
  | _ -> iterate ~f (f initial_value) ~count:(count - 1)
