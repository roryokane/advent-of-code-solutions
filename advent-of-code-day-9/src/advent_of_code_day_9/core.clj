(ns advent-of-code-day-9.core
  (:require [clojure.string :as string])
  (:gen-class))


(defn parse-distance [distance-string]
  (let [matches (re-matches #"(.+) to (.+) = (\d+)" distance-string)]
    {:locations [(nth matches 1) (nth matches 2)]
     :distance (Integer/parseInt (nth matches 3))}))

(defn- add-directed-edge-to-graph [graph [from to] cost]
  "Returns the graph with a new one-way edge, creating nodes if they do not exist."
  (if (graph from)
    (assoc-in graph [from to] cost)
    (assoc graph from {to cost})))

(defn add-connection-to-graph [graph {[loc1 loc2] :locations, distance :distance}]
  "Returns the graph with a new two-way connection, creating nodes if they do not exist."
  (let [all-directed-edges [[loc1 loc2] [loc2 loc1]]]
    (reduce (fn [graph edge]
              (add-directed-edge-to-graph graph edge distance))
            graph all-directed-edges)))

(defn parse-distance-graph [lines]
  (->> lines
       (map parse-distance)
       (reduce add-connection-to-graph {})))


(defn- remove-all-edges-to-node [graph to-node]
  (reduce (fn [graph from-node]
            (update-in graph [from-node] dissoc to-node))
          graph (keys graph)))

(defn remove-node-from-graph [graph node]
  (-> graph
      (dissoc node)
      (remove-all-edges-to-node node)))

(defn- nodes-in-graph [graph]
  (keys graph))

(declare all-spanning-paths)
(defn spanning-paths-starting-with-node [graph node]
  (map (fn [remaining-path]
         (cons node remaining-path))
       (all-spanning-paths (remove-node-from-graph graph node))))

(defn all-spanning-paths [graph]
  ;; uses brute-force recursion
  "A lazy seq of all spanning paths, assuming all nodes in the graph are connected to all other nodes. Reversed versions of existing paths are still included."
  (if (empty? (nodes-in-graph graph))
    '([]) ; not '(), as would otherwise be implied
    (mapcat (partial spanning-paths-starting-with-node graph)
          (nodes-in-graph graph))))

(defn- distance-of-edge [graph [loc1 loc2]]
  ((graph loc1) loc2))

(defn distance-of-path [graph path]
  (apply + (map (partial distance-of-edge graph)
                (partition 2 1 path))))


;; I tried fixing the duplication in the following code by extracting
;; generic functions like `find-extreme-path`, but the result was overly
;; complex. This arrangement is better.

(defn- min-by [f coll]
  (apply min-key f coll))
(defn- max-by [f coll]
  (apply max-key f coll))

(defn find-shortest-path [graph]
  (min-by (partial distance-of-path graph) (all-spanning-paths graph)))
(defn find-longest-path [graph]
  (max-by (partial distance-of-path graph) (all-spanning-paths graph)))

(defn find-shortest-distance [graph]
  (distance-of-path graph (find-shortest-path graph)))
(defn find-longest-distance [graph]
  (distance-of-path graph (find-longest-path graph)))


(defn -main
  "Read in distances between locations and print the length of the shortest route that visits all locations."
  [& args]
  (->> (slurp *in*)
       (string/split-lines)
       (parse-distance-graph)
       #_(find-shortest-distance)
       (find-longest-distance)
       (println)))
