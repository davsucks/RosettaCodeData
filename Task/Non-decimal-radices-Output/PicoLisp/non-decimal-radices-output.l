(de printNumber (N Base)
   (when (>= N Base)
      (printNumber (/ N Base) Base) )
   (let C (% N Base)
      (and (> C 9) (inc 'C 39))
      (prin (char (+ C `(char "0")))) ) )

(printNumber 26 16))
(prinl)
(printNumber 123456789012345678901234567890 36))
(prinl)
