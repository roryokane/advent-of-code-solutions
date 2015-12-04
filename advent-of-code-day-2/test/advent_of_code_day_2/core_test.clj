(ns advent-of-code-day-2.core-test
  (:require [clojure.test :refer :all]
            [advent-of-code-day-2.core :refer :all]))

(deftest present-packaging-test
  (testing "dimension parsing"
    (is (= [1 2 3] (parse-dimensions "1x2x3"))))
  (testing "face-areas"
    (is (= [4 4 4] (calc-face-areas (parse-dimensions "2x2x2"))))
    (is (=
         (sort [(* 2 3) (* 2 4) (* 3 4)])
         (sort (calc-face-areas (parse-dimensions "2x3x4"))))))
  (testing "wrapping paper area calculation for a present"
    (is (= 58 (wrapping-area (parse-dimensions "2x3x4"))))
    (is (= 43 (wrapping-area (parse-dimensions "1x1x10")))))
  (testing "ribbon length calculation for a present"
    (is (= 34 (ribbon-length (parse-dimensions "2x3x4"))))
    (is (= 14 (ribbon-length (parse-dimensions "1x1x10"))))))
