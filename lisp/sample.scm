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

; 
; 肩にn個乗る形になる。
;     2
;    2
;   2
;  2
; 2

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

(count-change 10)

; 
; 肩にn個乗る形になる。
;     2
;    2
;   2
;  2
; 2

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
; 参考URL
; https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%8C%E3%83%BC%E3%82%B9%E3%81%AE%E7%9F%A2%E5%8D%B0%E8%A1%A8%E8%A8%98
; 冪乗の反復（テトレーション）
; 肩にn個乗る形になる。
;     2
;    2
;   2
;  2
; 2

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


;　練習問題1.11

(define (f n)
  (cond ((< n 3) n)
		(else (+ (f (- n 1))
                 (* 2 (f(- n 2)))
				 (* 3 (f(- n 3)))
			  )
		)
  )
)

; 4 + 3 + 2  3 + 2 + 1  2 + 1 0 1 0 -1
(f 3)

; 反復プロセス
(define (f-i n)
  (define (f-iter a b c count)
    (cond ((< count 0) count)
          ((= count 0) c)
          ((= count 1) b)
          (else (f-iter (+ a (* 2 b) (* 3 c)) a b (- count 1)))))
  (f-iter 2 1 0 n))

(f-i -10)

; 練習問題1.14はslackでといた
; 練習問題 1.12
(define (pascal d)
  (define (print-number d)
	(cond ((> d 5) 1)
		  (else (display d)(print-number (+ d 1)))
	)
  )
  (print-number d)
)

(pascal 1)

; 練習問題1.15
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
	  angle
	  (p (sine (/ angle 3.0)))))

(sine 12.15)
(p (sine (4.05)))
(p (p (sine (1.35))))
(p (p (p (sine (0.45)))))
(p (p (p (p (sine (0.15))))))
(p (p (p (p (p (sine (0.05)))))))
(p (p (p (p (p (0.05))))))
(p (p (p (p (xxxx)))))
(p (p (p xxxx)))
(p (p xxxx))
(p xxxx)
xxxx

(p (sine 4.05)) ; if文false
(p (sine 1.35)) ; if文false
(p (sine 0.45)) ; if文false
(p (sine 0.15)) ; if文false
(p (sine 0.05)) ; if文true→angle

; 3倍にした。12.15 → 24.30
(sine 24.30)
(p (sine 8.1))
(p (p (sine 2.7)))
(p (p (p (sine 0.9))))
(p (p (p (p (sine 0.3)))))
(p (p (p (p (p (sine 0.1))))))
(p (p (p (p (p (p (sine 0.0333..)))))))


; 3倍にした。12.15 → 36.45
; ステップ数は5回から6回に増えた
(sine 36.45)
(p (sine 12.15))
(p (p (sine (4.05))))
(p (p (p (sine (1.35)))))
(p (p (p (p (sine (0.45))))))
(p (p (p (p (p (sine (0.15)))))))
(p (p (p (p (p (p (sine (0.05))))))))

; 空間 O(log a)→ 関数 log3 a
; ステップ数O(log a) → 関数 log3 a

n^4
log2 n = 2
n^8
log2 n = 3

n^10
n^5 * n^5
(n * n^5-1) * (n * n^5-1)
(n * n^4) * (n * n^4)
(n * (n^2 * n^2) * (n * (n^2 * n^2)))
(n * (n * n) * (n * n)) * (n * (n * n) * (n *n))

log2 n = 3

; より正確には、必要なかけ算の回数は、底を 2 とした n の対数から1を引いたもの
; にnの2進数表現での1の数を⾜したものになります。
; ↓わかりづらいので文章を直す
; 底を2としたnの対数をとったものから1を引く
; nの2進数表現でのビットが立っている個数を⾜す
; 例
; n = 100
; log2 100 = 6
; 1を引く
; 6 - 1 = 5
; 100の2進数表現
; 1100100
; 3つビットが立っている
; 5 + 3 = 8回


; 練習1.16
; a = 1
; b = 2
; n = 6
; 1 * 2^6 = 64
; 1 * 4^3 = 64
; 4 * 4^2 = 64
; 4 * 16^1 = 64
; 64 * 16^0 = 64 → return a



; 練習問題 1.19
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
		((even? count)
		 (fib-iter a
				   b
				   (+ (square p) (square q))
				   (+ (* 2 p q) (square q))
				   (/ count 2)))
		(else (fib-iter (+ (* b q) (* a q) (* a p))
						(+ (* b p) (* a q))
						p
						q
						(- count 1)))))

(fib 8)


; 練習問題1.20 適用順序評価

(define (gcd a b)
  (if (= b 0)
	  a
	  (gcd b (remainder a b))))

(if (= 40 0)
	  206
	  (gcd 40 6))

(if (= 6 0)
	40
	 (gcd 6 4))

(if (= 4 0)
	6
	 (gcd 4 2))

(if (= 2 0)
	4
	 (gcd 2 0))

; 正規順序評価
(define (gcd a b)
  (if (= b 0)
	  a
	  (gcd b (remainder a b))))


(gcd 206 40)

(if (= 40 0)
	  206
	  (gcd 40 (r 206 40))))


(gcd 40 (r 206 40))
  (if (= (r 206 40) 0) ; 1回
	  40
	  (gcd (r 206 40) (r 40 (r 206 40))))

(gcd (r 206 40) (r 40 (r 206 40)))
  (if (= (r 40 (r 206 40)) 0) ; 2回
	  (r 206 40)
	  (gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))))

(gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))
 (if (=  (r (r 206 40) (r 40 (r 206 40))) 0) ; 4回
	  (r 40 (r 206 40))
	  (gcd  (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))))

(gcd  (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))))
 (if (= (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))) 0) ;7回
	 (r (r 206 40) (r 40 (r 206 40))) ; 4回
     (gcd (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))))))
; 1+2+4+7+4 = 18回の評価

; 練習問題1.16

; a * b^n = 不変

; 1 * 2^10   = 1014     a 1 b 2 n 10 a^n = 1024
; 2 * 2^9    = 1024     a 2 b 4 
; 4 * 2^8    = 1024     a 4 * 8
; 8 * 2^7    = 1024     a 8
; 16 * 2^6   = 1024
; 32 * 2^5   = 1024
; 64 * 2^4   = 1024
; 128 * 2^3  = 1024
; 256 * 2^2  = 1024
; 512 * 2^1  = 1024
; 1024 * 2^0 = 1024

; aは1から始まって基数をかけて状態変数として渡せば良さそう
; a * b

; a:状態変数 b:基数 n:乗数 

; a: 1    b: 2   n: 10       ab^n = 1024
; a: 1    b: 4   n: 5        ab^n = 1024
; a: 4    b: 4   n: 4        ab^n = 1024
; a: 4    b: 16  n: 2        ab^n = 1024
; a: 4    b: 256 n: 1        ab^n = 1024
; a: 1024 b: 256 n: 0        終了条件なので計算せず

(define (fast-expt-iter a b n)
    (cond ((= n 0) a)
		  ((even? n) (fast-expt-iter a (square b) (/ n 2)))
		  (else (fast-expt-iter (* a b) b (- n 1)))))

(define (even? n)
(= (remainder n 2) 0))

(fast-expt-iter 1 2 6)


; 練習問題1.17
; a: 基数 b:足す回数
; 5  10 = double(5 * 5)
; 5 * 5 = 5 + (5 * 4)
(define (fast-mul a n)
(cond ((= n 0) a)
	  ((even? n) (double (* a (halve n))))
	  (else (+ a (fast-mul a (- n 1))))))

(define (double n)(* n 2))
(define (halve even_n)(/ even_n 2))

(fast-mul 10 10)

; 練習問題1.18
; 5 * 10
; a n
; 偶数 double(5 * 5)
; 奇数 (+ a (* a (- n 1)))
; 5 * 5

; a = 5 b = 10 n = 状態変数

; 5 10 0 = 50
; 10 5  0
; 10 4  10 = 50
; 20 2 10 
; 40 1 10
; 40 0 50 = 50
; (a*b) + n = 不変量

(define (iter a b n)
	(cond ((= b 0) n)
		  ((even? b) (iter (double a) (halve b) n))
		  (else (iter a (- b 1) (+ a n)))))

(iter 11 11 0)
; 11 10 11
; 22  5 11
; 22  4 33
; 44  2 33
; 88  1 33
; 88  0 121 => return n

; 状態変数の考え方
; n = 0;
; for(i = 0, i < 10; i++){
;   n += i;
; }
; return n;

; n = 1, i = 0
; n = 2, i = 1
; n = 3, i = 2
; n = 4, i = 3
; n = 5, i = 4
; n = 6, i = 5


; 16 = 4 * 8
; 1 2 4 8 16
 ; フェルマーの⼩定理: n が素数で、a が n より⼩さい任意の正の整数であるとき、a の n 乗は法 n に関して a と合同である。

; a = {1 2 3 4} n = 5  a^5%5 ≡ a%5
; a^5 ≡ a (mod 5)


(define (expmod base exp m)
(cond ((= exp 0) 1)
	  ((even? exp)
	   (remainder
		(square (expmod base (/ exp 2) m))
		m))
	  (else
	   (remainder
		(* base (expmod base (- exp 1) m))
		m))))

; (expmod 2 3 3)
; (reminder(* 2 (expmod 2 2 3)) m)
; (reminder(* 2 (reminder(square (expmod 2 1 3)) m) m)
; (reminder(* 2 (reminder(square (reminder(* 2 (expmod 2 0 3)) m) m) m)
;(reminder(* 2 (reminder(square (reminder(* 2 (expmod 2 0 3)) m) m) m)			
; (reminder 2 3)
; 2

(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
(cond ((> (square test-divisor) n) n)
	  ((divides? test-divisor n) test-divisor)
	  (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b) (= (remainder b a) 0))

(smallest-divisor 199) ; 199 素数
(smallest-divisor 1999) ; 1999 素数
(smallest-divisor 19999) ; 7 素数ではない

(define (prime? n)
(= n (smallest-divisor n)))

(prime? 19999)

(use srfi-19) ; 便利なメソッドが使えるようにライブラリを読み込む

fast-prime(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-time)))
(define (start-prime-test n start-time)
  (and (prime? n)
       (report-prime (time-difference (current-time) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
(display elapsed-time))


(timed-prime-test 1009)  ; 0.000014
(timed-prime-test 10007) ; 0.000032
(timed-prime-test 100003); 0.000084 nが100倍で6倍
(timed-prime-test 999983); 0.000216 


; 指定範囲 1000 10000 100000
; 指定の値n (今回は仮で1000)を渡す
; nを素数判定に渡す
; nからはじめて素数判定の結果をmaxに達するまで繰り返す
; (+ n 1)

(define (search-for-primes from to)
  (define (repeat-search from to)
	(timed-prime-test from)
	(if (>= from to)
		(display " 完了 ")
		(repeat-search (+ from 1) to)))
  (repeat-search from to))

(search-for-primes 1000 1020)
; 1009 0.000005 10万分の5
; 1013 0.000004
; 1019 0.000004

(search-for-primes 10000 10040) ; 10007 10009 10037
; 10007  0.000014
; 10009  0.000014
; 10037  0.000014

(search-for-primes 100000 100050) ; 100003 100019 100043
; 100003 0.00009
; 100019 0.000048
; 100043 0.000048 


; 練習問題1.23
; 
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
(cond ((> (square test-divisor) n) n)
	  ((divides? test-divisor n) test-divisor)
	  (else (find-divisor n (next test-divisor)))))

(define (divides? a b) (= (remainder b a) 0))

(define (next n)
  (if (= n 2) 3
	  (+ n 2)))

(smallest-divisor 19999)

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-time)))
(define (start-prime-test n start-time)
  (and (prime? n)
       (report-prime (time-difference (current-time) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
(display elapsed-time))

(use srfi-19)
(use srfi-27)
(search-for-primes 1000 1020)
; 1009 0.000005 → 0.000004
; 1013 0.000004 → 0.000004
; 1019 0.000004 → 0.000004

(search-for-primes 10000 10040)
; 10007  0.000014 → 0.000009
; 10009  0.000014 → 0.000011
; 10037  0.000014 → 0.000009


(search-for-primes 100000 100050)
; 100003 0.000048 → 0.000034
; 100019 0.000048 → 0.000034
; 100043 0.000048 → 0.000034

; 実行時間の比率ははやくはなっているけど2倍ではない
; それはなぜか？
; 処理するnの数は半分になっているが、ステップ数が半分になっていないため。
; 順に1からnまで実行する場合は、squareやdivides?の関数の評価があって、改善後はそれがifの評価に変わっている。1回の処理につきステップ数は1減っているが全体のステップ数は半分にはなっていない。

; 練習問題1.24

(define (expmod base exp m)
(cond ((= exp 0) 1)
	  ((even? exp)
	   (remainder
		(square (expmod base (/ exp 2) m))
		m))
	  (else
	   (remainder
		(* base (expmod base (- exp 1) m))
		m))))

(use srfi-27) ; random-integer
(define (fermat-test n)
  (define (try-it a)
	(= (expmod a n n) a))
(try-it (+ 1 (random-integer (- n 1)))))

(define true #t)
(define false #f)

(define (fast-prime? n times)
(cond ((= times 0) true)
	  ((fermat-test n) (fast-prime? n (- times 1)))
	  (else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-time)))
(define (start-prime-test n start-time)
  (and (fast-prime? n 15)
       (report-prime (time-difference (current-time) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
(display elapsed-time))

(search-for-primes 1000 1020)


(search-for-primes 1000 1020)
; 1009 0.000005 → 0.000004
; 1013 0.000004 → 0.000004
; 1019 0.000004 → 0.000004

; フェルマーテスト
; 1009  0.000018
; 1013  0.000017
; 1019  0.000017


(search-for-primes 10000 10040)
; 10007  0.000014 → 0.000009
; 10009  0.000014 → 0.000011
; 10037  0.000014 → 0.000009

; フェルマーテスト
; 10007 0.00002
; 10009 0.000018
; 10037 0.000021

(search-for-primes 100000 100050)
; 100003 0.000048 → 0.000034
; 100019 0.000048 → 0.000034
; 100048 0.000048 → 0.000034

; フェルマーテスト
; 100003  0.000048
; 100019  0.000046
; 100043  0.000048

(search-for-primes 1000000 1000050)

; 1000003 0.000040
; 1000033 0.000034
; 1000037 0.000034

; 1009  0.000018
; 1013  0.000017
; 1019  0.000017

; フェルマーテストは1000→1000000で実行時間約2倍のように見える。O(log n)っぽい？

; 練習問題1.25
(define (expmod base exp m)
  (cond ((= exp 0) 1)
		((even? exp)
		 (remainder
		  (square (expmod base (/ exp 2) m)) m))
		(else
		 (remainder
		  (* base (expmod base (- exp 1) m)) m))))

; Hackerの書いたコード。ちゃんと素数判定できるか？できるならそれはなぜ？
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
(define (fast-expt b n)
  (cond ((= n 0) 1)
		((even? n) (square (fast-expt b (/ n 2))))
		(else (* b (fast-expt b (- n 1))))))

(search-for-primes 1000 1110) ; 実行できない。固まる
