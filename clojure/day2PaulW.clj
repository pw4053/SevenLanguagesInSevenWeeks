
; ------------------------------------------
; Creating macros: defmacro definline macroexpand-1 macroexpand
; Branching: and or when when-not when-let when-first if-not if-let cond condp
; Looping: for doseq dotimes while
; Working with vars: ns declare defn defmacro definline defmethod defmulti defn- defonce defstruct
; Arranging code differently: .. doto ->
; Dynamic scopes: binding locking time with-in-str with-local-vars with-open with-out-str with-precision
; Creating lazy things (see also Sequences): lazy-cat lazy-cons delay
; Java interop: .. amap areduce gen-class gen-interface proxy proxy-super memfn
; Documenting code: assert comment doc
; Transactions: dosync io!
 

; ------------------------------------------
; A lazy-seq call executes the body once the first time it is accessed,
; then caches and returns the same result whenever it is called again in the
; future.
;
; Usage: (lazy-seq & body) Takes a body of expressions that returns an ISeq or
; nil, and yields a Seqable object that will invoke the body only the first 
; time seq is called, and will cache the result and return it on all 
; subsequent seq calls
;
; range is an easy way to get an infinite lazy sequence of integers     
(take 10 (range))

; map produces lazy sequences, so the following is lazy 
(take 10 (map #(* % %) (range)))

; iterate is a good way of making infinite sequenes of the form x, f(x), f(f(x))
(take 10 (iterate (partial * 2) 1))

; ------------------------------------------

(defmacro unless
  ([test body] `(if (not ~test) ~body))
  ([test body alt] `(if (not ~test) ~body ~alt)))

(unless
    true
    (println "this is the IF condition!")
    (println "this is the ELSE condition!")
)
(unless
    false
    (println "this is the IF condition!")
    (println "this is the ELSE condition!")
)

; ------------------------------------------

(defprotocol Vehicle
   (doors [e no])
   (faster [e speed])
)

(defrecord FastVehicle [topSpeed]
    Vehicle
    (doors [_ no]
       (println (str "vehicle has " no " doors")))
    (faster [_ speed]
       (println (str "top speed is now " (+ speed topSpeed))))
)

(def x (FastVehicle. 100))
(doors x 4)
(faster x 100)

