(define (square x) (* x x))

(square 21)

(square (+ 2 5))

(square (square 3))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(sum-of-squares 3 4)

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(f 5)

#|
(f 5)の評価プロセス
fの本体(sum-of-squares (+ a 1) (* a 2))を取り出す。
↓
次に仮引数aを引数5で取り替える。
(sum-of-squares (+ 5 1) (* 5 2))

これで2つの被演算子と演算子sum-of-squaresを持つ組み合わせの評価に帰着する。

(+ 5 1)は6に、(* 5 2)は10になる。
手続きsum-of-squareを6と10に作用させることになる。

この値はsum-of-squareの本体の仮引数xとyとに置き換えられる。
(+ (square x) (square y))
↓
(+ (square 6) (square 10))

さらにsquareの定義を使うと

(+ (* 6 6) (* 10 10))

に帰着し、乗算により
(+ 36 100)

となり、最後に136になる。

このプロセスを手続き作用の置き換えモデルという。
|#

(define (abs x)
  (if (< x 0)
	  (- x)
	  x))

(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
		((< x 0) (- x))))
(abs -1)

(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))
(abs -10)
(define x 8)
(and (> x 5) (< x 10))

10
(+ 5 3 4)
(- 9 1)
(/ 6 2)
(+ (* 2 4) (- 4 6))

(define a 3)
(define b (+ a 1))
b
(+ a b (* a b))
(= a b) ; ==
(= a a)

										; a = 3
; b = 4
(if (and (> b a) (< b (* a b)))
    b
    a)

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

(+ 2 (if (> b a) b
	             a))

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

5 + 4 +(2 -(3-(6 + 4 /5)))
/ 3(6-2)(2-7)

(/ (+ 5 4
	  (- 2
		 (- 3 (+ 6 (/ 4 5)))
	  )
   )
   (* 3 (- 6 2) (- 2 7))
)

; 三つの数値を引数として取り、そのうち⼤きいほう
; から⼆つの数値の⼆乗の和を返す⼿続きを定義せよ。

(define (max x y z)
  (cond ((and (< x y)(< x z)) (+ (* y y)(* z z)))
		((< y z) (+ (* x x)(* z z)))
        (+ (* x x)(* y y))))

; xが一番小さい→ y z
; yが一番小さい→ x z
; zが一番小さい→ x y

(max 1 2 3) ; 2 * 2 + 3 * 3
(max 2 1 3)
(max 3 1 2)

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
(a-plus-abs-b -1 -4)
; 演算⼦が複合式であるような組み合わせが作れる
; イメージ(define +(a b ...)
;  (ADD a b...))

(+ a b) ; true
(- a b) ; false

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

(test 0 (p))

(test 0 (p))
(if (= 0 0) 0 (p))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
       guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 2)

(sqrt 9)
(sqrt (+ 100 37))

(sqrt (+ (sqrt 2) (sqrt 3)))

(square (sqrt 1000))
(sqrt 1000)

;(define (new-if predicate then-clause else-clause)
;(cond (predicate then-clause)
;	  (else else-clause)))

;(define (sqrt-iter guess x)
;(new-if (good-enough? guess x)
;        guess
										;        (sqrt-iter (improve guess x) x)))

;(define (new-if predicate then-clause else-clause)
;        (cond ((good-enough? guess x) guess)
;	          (else (sqrt-iter (improve guess x) x)))

; new-ifを使うと再帰関数は全て無限ループになるはず
;(define (p x) (+ x 1)
;		 　　　(if (= x 0) 0 (p x))
;)
   
;(p 1)

(sqrt 0.001)
(sqrt 0.000001)
(sqrt 0.00000000000000001)
(sqrt 100000000000000000000000000000000000)


; 問題1.7
(define (sqrt-iter before after x)
  (if (good-enough? before after)
       after
      (sqrt-iter after (improve after x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? before guess)
  (< (abs (- 1.0 (- before guess))) 0.001))

(define (sqrt x)
  (sqrt-iter 0 x x))

(sqrt 2.0)
(sqrt 3.0)
(sqrt 1.0e+256)
(sqrt 100000000)


; 問題1.8 立方根
(define (sqrt-iter before after x)
  (if (good-enough? before after)
       after
      (sqrt-iter after (improve after x) x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? before guess)
  (< (abs (- 1.0 (/ before guess))) 0.001))

(define (sqrt x)
  (sqrt-iter 0 x x))

(sqrt 8.0)


; 問題1.9
;(+ 4 5)

;(define (+ a b)
;(if (= a 0) b (inc (+ (dec a) b))))

;(+ 4 5)
;(inc (+ 3 5))
;(inc (inc (+ 2 5)))
;(inc (inc (inc (+ 1 5))))
;(inc (inc (inc (inc (+ 0 5))))
;(inc (inc (inc (inc 5))))
;(inc (inc (inc 6)))
;(inc (inc 7))
;(inc 8)
;9

;(define (+ a b)
;  (if (= a 0) b (+ (dec a) (inc b))))

;(+ 4 5)
;(+ 3 6)
;(+ 2 7)
;(+ 1 8)
;(+ 0 9)
;9

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (6A x (- y 1))))))

(A 1 10)
(A 2 4)
(A 3 3)

(define (f n) (A 0 n)) ; 2n
(define (g n) (A 1 n)) ; 2^n
(define (h n) (A 2 n)) ; 2の累乗の累乗

    2
   2
  2
 2
2

(define (k n) (* 5 n n))

(A 2 3)
(A 1 (A 2 2))
(A 1 (A 1 (A 2 1)))
(A 1 (A 1 2))
(A 1 (A 0 (A 1 1)))
(A 1 (A 0 2))
(A 1 4)
(g 4)

(h 4)
(A 0 (A 1 3))

(define (fib n)
(cond ((= n 0) 0)
((= n 1) 1)
(else (+ (fib (- n 1))
		 (fib (- n 2))))))

(fib 0)
(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 5)

(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins)
        (cond ((= amount 0) 1)
              ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                 (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins )))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
		((= kinds-of-coins 5) 50)))

 (count-change 25)
