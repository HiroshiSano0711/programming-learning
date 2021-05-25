(define (pascal d)
  (define (print-number d)
	(cond ((> d 5) 1)
		  (else (display (print-number (+ d 1))))
	)
  )
  (print-number d)
)

(pascal 1)
11
121
1111
