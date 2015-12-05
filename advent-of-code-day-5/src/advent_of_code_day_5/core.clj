(ns advent-of-code-day-5.core
  (:gen-class))


(defn- contains-three-vowels? [string]
  (>= (count (re-seq #"[aeiou]" string)) 3))

(defn- contains-double-letter? [string]
  (re-find #"(.)\1" string))

(def naughty-strings ["ab" "cd" "pq" "xy"])

(defn- does-not-contain-naughty-string? [string]
  (not-any? (fn [naughty-string]
              (.contains string naughty-string))
            naughty-strings))

(defn old-nice? [string]
  (boolean (and (contains-three-vowels? string)
                (contains-double-letter? string)
                (does-not-contain-naughty-string? string))))


(defn- contains-repeated-pair? [string]
  (re-find #"(..).*\1" string))

(defn- contains-repeated-letter-with-one-char-gap? [string]
  (re-find #"(.).\1" string))

(defn new-nice? [string]
  (boolean (and (contains-repeated-pair? string)
                (contains-repeated-letter-with-one-char-gap? string))))


(defn -main
  "Print the count of nice strings in standard input."
  [& args]
  (->> (slurp *in*)
       (clojure.string/split-lines)
       #_(filter old-nice?) (filter new-nice?)
       (count)
       (println)))
