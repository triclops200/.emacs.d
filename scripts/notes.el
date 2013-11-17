(defun string-repeat (x n)
  (labels ((rec (acc n)
				(if (= n 0)
					acc
				  (rec (concat acc x) (- n 1)))))
	(rec "" n)))

(defun box-word (x)
  (interactive "sWord to box: ")
  (let ((l (length x)))
	(insert 
	 (concat
	  "
 _" (string-repeat "_" l) "_
"		 "| " (string-repeat " " l) " |
"		 "| " x " |
"		 "|_" (string-repeat "_" l) "_|"))))
