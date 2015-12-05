(ns advent-of-code-day-5.core-test
  (:require [clojure.test :refer :all]
            [advent-of-code-day-5.core :refer :all]))

(deftest niceness-test
  (testing "strings are correctly recognized as naughty or nice"
    (is (= true (nice? "ugknbfddgicrmopn")))
    (is (= true (nice? "aaa")))
    (is (= false (nice? "jchzalrnumimnmhp")))
    (is (= false (nice? "haegwjzuvuyypxyu")))
    (is (= false (nice? "dvszwmarrgswjxmb")))))
