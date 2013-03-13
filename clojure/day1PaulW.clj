; Implement a function called (big st n) that returns true if
; a string st is longer than n characters.

(defn big 
     "documentation goes here"
     [st n]
     (> (count st) n)
)

(println (big "" 3))
(println (big "x" 3))
(println (big "xx" 3))
(println (big "xxx" 3))
(println (big "xxxx" 3))
(println (big "xxxxx" 3))


; Write a function called (collection-type col) that 
; returns :list, :map, or :vector based on the type of collection col.

(defn collection-type
     "documentation goes here"
     [col]
     (cond
        (list? col) :list
        (vector? col) :vector
        (map? col) :map
     )
)

(println "myList:" (collection-type '(1 2 3)))
(println "myMap:" (collection-type {:a 1, :b 2, :c 3}))
(println "myMap:" (collection-type [1 2 3]))

