open OUnit2

let test_look_and_say = ignore (run_test_tt_main ("tests" >::: [
    "LookAndSay" >::: [
      "returns a string with pairs of counts and the digit" >:: (fun _ ->
          assert_equal "111221" (LookAndSay.next "1211")
        );

      "returns a count and the digit" >:: (fun _ ->
          assert_equal (3, "4") (LookAndSay.count_digit_pair ["4"; "4"; "4"])
        );
    ];

    "MathSequence" >::: [
      "applies f to the initial value the given number of times" >:: (fun _ ->
          assert_equal 7 (MathSequence.iterate ~f:(fun x -> x + 2) 1 ~count:3)
        );

      "returns the initial value when the count is 0" >:: (fun _ ->
          assert_equal 1 (MathSequence.iterate ~f:(fun x -> x + 2) 1 ~count:0)
        );
    ];
  ]))
