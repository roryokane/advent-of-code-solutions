(ns advent-of-code-day-2.core
  (:require [clojure.string :as string]
            [clojure.math.combinatorics :as combo])
  (:gen-class))

(defn parse-dimensions [dimensions-string]
  (map #(Integer/parseInt %) (string/split dimensions-string #"x")))

;(defn calc-face-areas [dimensions]
;  ;; this version doesn’t work –
;  ;; combo/combinations “helpfully” throws out duplicate combinations,
;  ;; so input [1 1 10] results in two face areas instead of three
;  (map (partial apply *) (combo/combinations dimensions 2)))
(defn calc-face-areas [[l h w]]
  [(* l h) (* l w) (* h w)])

(defn wrapping-area [dimensions]
  (let [face-areas (calc-face-areas dimensions)
        smallest-face-area (apply min face-areas)
        surface-area (* 2 (apply + face-areas))]
    (+ surface-area smallest-face-area)))

(defn ribbon-length [dimensions]
  (let [present-length (* 2 (apply + (take 2 (sort dimensions))))
        bow-length (apply * dimensions)]
    (+ present-length bow-length)))

(defn -main
  "Print total wrapping paper needed given present dimensions."
  [& args]
  (->> (slurp *in*)
       (string/split-lines)
       (map parse-dimensions)
       #_(map wrapping-area)
       (map ribbon-length)
       (reduce +)
       (println)))
