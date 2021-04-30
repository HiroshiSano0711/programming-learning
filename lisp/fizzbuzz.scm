; Fizzの条件を関数で定義 --- (*1)
(define (is-fizz n)
  (= 0 (modulo n 3)))
; Buzzの条件を関数で定義 --- (*2)
(define (is-buzz n)
  (= 0 (modulo n 5)))

; FizzBuzzの値を返す関数を定義 --- (*3)
(define (fizzbuzz n)
  (cond
    ((and (is-fizz n) (is-buzz n)) "FizzBuzz")
    ((is-fizz n) "Fizz")
    ((is-buzz n) "Buzz")
    (else n)))

; 100回fizzbuzz関数を呼び出す --- (*4)
(dotimes (n 100)
  (print (fizzbuzz (+ n 1))))
