(ns advent-of-code-day-1.core-test
  (:require [clojure.test :refer :all]
            [advent-of-code-day-1.core :refer :all]))

(deftest visiting-floors-from-parentheses
  (testing "calculate-floor returns the count of '(' minus the count of ')'"
    (is (= 0 (calculate-floor "")))
    (is (= 0 (calculate-floor "(())")))
    (is (= 0 (calculate-floor "()()")))
    (is (= 2 (calculate-floor "(()()(")))
    (is (= 3 (calculate-floor "))(((((")))
    (is (= -1 (calculate-floor "())")))
    (is (= -1 (calculate-floor "move ( ))."))))
  (testing "first-basement-position returns the number of the first character that instructs to enter the basement"
    (is (= 1 (first-basement-position ")")))
    (is (= 5 (first-basement-position "()())")))
    (is (= 5 (first-basement-position "()())))(((")))
    #_(is (= "undefined…" (first-basement-position "(")))))
