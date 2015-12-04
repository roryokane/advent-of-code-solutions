(ns advent-of-code-day-1.core
  (:gen-class))

(defn- get-next-floor [current-floor chr]
  (case chr
    \( (inc current-floor)
    \) (dec current-floor)
    current-floor))

(defn calculate-floor [string]
  (reduce get-next-floor 0 string))

(defn- floors-sequence [movement-string]
  "Returns a sequence of current floors after reading each character."
  (reductions get-next-floor 0 movement-string))

(defn first-basement-position [string]
  (let [indexed-floors
        (map-indexed vector (floors-sequence string))
        
        indexed-basement-floors
        (filter (fn [[idx floor]] (= floor -1)) indexed-floors)
        
        basement-floor-indexes
        (map first indexed-basement-floors)]
    (first basement-floor-indexes)))

(defn -main
  [& args]
  (let [input (read-line)]
    (println (calculate-floor input))
    (println (first-basement-position input))))
