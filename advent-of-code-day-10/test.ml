open Foo
open OUnit2

let test_foo = ignore (run_test_tt_main ("foo" >::: [

  "returns the specified argument" >:: (fun _ ->
    assert_equal 2 (identity 2)
  )

]))
