; -----------------------------------------
; A queue implementation that blocks when the queue is 
; empty and waits for a new item in the queue
;
; clojure.contrib.seq.fill-queue
; filler-func will be called in another thread with a single arg
; 'fill'. filler-func may call fill repeatedly with one arg each
; time which will be pushed onto a queue, blocking if needed until
; this is possible. fill-queue will return a lazy seq of the values
; filler-func has pushed onto the queue, blocking if needed until each
; next element becomes available. filler-func's return value is ignored.
;
; -----------------------------------------
; Use refs to create a vector of accounts in memory. Create debit and
; credit functions to change the balance of an account.

; used a map instead of a vector.......
(def accounts (ref {}))

(defn make-account 
    [accounts account-number credit-amount]
    (dosync
        (alter accounts conj {account-number, credit-amount})
    )
) 

(defn credit
    [accounts account-number credit-amount]
    (dosync
        (let [new-balance (+ (get @accounts account-number) credit-amount)]
        (alter accounts assoc account-number new-balance))
    )
)

(defn debit
    [accounts account-number debit-amount]
    (credit
        accounts
        account-number
        (- debit-amount)
    )
)
 
(make-account accounts "123" 50)
(make-account accounts "456" 50)
(make-account accounts "789" 50)

(println "after initialisation......")
(println @accounts)

(credit accounts "123" 50)

(println "after credit..............")
(println @accounts)

(println "after debit...............")
(debit accounts "789" 10)

(println @accounts)

; -----------------------------------------
; In this section, I. going to outline a single problem called sleeping barber.
; It was created by Edsger Dijkstra in 1965. It has these characteristics:
; .A barber shop takes customers.
; .Customers arrive at random intervals, from ten to thirty milliseconds.
; .The barber shop has three chairs in the waiting room.
; .The barber shop has one barber and one barber chair.
; .When the barber. chair is empty, a customer sits in the chair, wakes
;   up the barber, and gets a haircut.
; .If the chairs are occupied, all new customers will turn away.
; .Haircuts take twenty milliseconds.
; .After a customer receives a haircut, he gets up and leaves.
; Write a multithreaded program to determine how many haircuts a barber
; can give in ten seconds.

(def waiting-customers (atom 0))
(def waiting-room-size 3)
(def number-of-haircuts (atom 0))

(def open? (atom true))

(defn open-shop [duration]
  (future
      (println "opening shop")
      (Thread/sleep (* 1000 duration))
      (swap! open? not)
      (println "closing shop")
  )
)

(defn spawn-customers []
  (future
    (while @open?
      (if (< @waiting-customers waiting-room-size)
        (do
           (swap! waiting-customers inc)
           (Thread/sleep (+ 10 (rand-int 20)))
        )
      )
    )
  )
)

(defn gotowork []
  (future
    (while @open?
      (if (> @waiting-customers 0)
        (do
          (swap! waiting-customers  dec)
          (swap! number-of-haircuts inc)
          (Thread/sleep 20)
        )
      )
    )
  )
)


(def shopthread (open-shop 10))
(spawn-customers)
(gotowork)
(deref shopthread)
(println @number-of-haircuts)

; -----------------------------------------



