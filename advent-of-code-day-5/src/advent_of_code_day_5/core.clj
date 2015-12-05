(ns advent-of-code-day-5.core
  (:gen-class))

(defn- contains-three-vowels [string]
  (>= (count (re-seq #"[aeiou]" string)) 3))

(defn- contains-double-letter [string]
  (re-find #"(.)\1" string))

(def naughty-strings ["ab" "cd" "pq" "xy"])

(defn- does-not-contain-naughty-string [string]
  (not-any? (fn [naughty-string]
              (.contains string naughty-string))
            naughty-strings))

(defn nice? [string]
  (boolean (and (contains-three-vowels string)
                (contains-double-letter string)
                (does-not-contain-naughty-string string))))

(defn -main
  "Print the count of nice strings in standard input."
  [& args]
  (->> (slurp *in*)
       (clojure.string/split-lines)
       (filter nice?)
       (count)
       (println)))
