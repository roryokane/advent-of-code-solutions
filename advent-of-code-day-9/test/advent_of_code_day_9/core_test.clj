(ns advent-of-code-day-9.core-test
  (:require [clojure.test :refer :all]
            [advent-of-code-day-9.core :refer :all]))

(deftest input-parsing
  (testing "parsing a line describing a distance"
    (is (= {:locations ["London" "Dublin"] :distance 464}
           (parse-distance "London to Dublin = 464"))))
  
  (testing "adding one connection to a graph"
    (is (= {"London" {"Dublin" 464, "Belfast" 518}
            "Dublin" {"London" 464}}
           (add-connection-to-graph
             {"London" {"Belfast" 518}}
             {:locations ["London" "Dublin"] :distance 464}))))
  
  (testing "parsing all input into a graph"
    (let [lines ["London to Dublin = 464"
                 "London to Belfast = 518"
                 "Dublin to Belfast = 141"]]
      (is (= {"London" {"Dublin" 464, "Belfast" 518}
              "Belfast" {"London" 518, "Dublin" 141}
              "Dublin" {"London" 464, "Belfast" 141}}
             (parse-distance-graph lines))))))

(deftest finding-extreme-distances
  (let [test-graph
        {"London" {"Dublin" 464, "Belfast" 518}
         "Belfast" {"London" 518, "Dublin" 141}
         "Dublin" {"London" 464, "Belfast" 141}}]
    
    (testing "removing a node from a graph"
      (is (= {"London" {"Dublin" 464}
              "Dublin" {"London" 464}}
             (remove-node-from-graph test-graph "Belfast"))))
    
    (testing "finding all spanning paths"
      (is (= #{["Dublin" "London" "Belfast"]
               ["Dublin" "Belfast" "London"]
               ["London" "Dublin" "Belfast"]
               ["London" "Belfast" "Dublin"]
               ["Belfast" "Dublin" "London"]
               ["Belfast" "London" "Dublin"]}
             (set (all-spanning-paths test-graph)))))

    (testing "finding shortest path"
      (let [shortest-path (find-shortest-path test-graph)]
        (is (or (= ["London" "Dublin" "Belfast"] shortest-path)
                (= ["Belfast" "Dublin" "London"] shortest-path)))))

    (testing "finding shortest distance"
      (is (= 605 (find-shortest-distance test-graph))))
    
    (testing "finding longest path"
      (let [longest-path (find-longest-path test-graph)]
        (is (or (= ["Dublin" "London" "Belfast"] longest-path)
                (= ["Belfast" "London" "Dublin"] longest-path)))))
    
    (testing "finding longest distance"
      (is (= 982 (find-longest-distance test-graph))))))
