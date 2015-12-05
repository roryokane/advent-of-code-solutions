(ns advent-of-code-day-5.core-test
  (:require [clojure.test :refer :all]
            [advent-of-code-day-5.core :refer :all]))

(deftest niceness-test
  (testing "strings are correctly recognized as naughty or nice with the old rules"
    (is (= true (old-nice? "ugknbfddgicrmopn")))
    (is (= true (old-nice? "aaa")))
    (is (= false (old-nice? "jchzalrnumimnmhp")))
    (is (= false (old-nice? "haegwjzuvuyypxyu")))
    (is (= false (old-nice? "dvszwmarrgswjxmb"))))
  (testing "strings are correctly recognized as naughty or nice with the new rules"
    (is (= true (new-nice? "qjhvhtzxzqqjkmpb")))
    (is (= true (new-nice? "xxyxx")))
    (is (= false (new-nice? "uurcxstgmygtbstg")))
    (is (= false (new-nice? "ieodomkazucvgmuy")))))
