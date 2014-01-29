(require 'bigint)

(defun fact (n)
  (let ((acc (bigint-int-to-bigint 1)))
	(dotimes (i n)
	  (setf acc (bigint-multiply acc (bigint-int-to-bigint (+ 1 i)))))
	(bigint-to-string acc)))

(defun reverse-string
  (str)
  (apply #'string (reverse (string-to-list str))))

(defun replace-word-at-point (str)
  (backward-word)
  (forward-word)
  (let ((end (point)))
	(backward-word)
	(delete-region (point) end)
	(insert str)))

(defun minutes-to-seconds ()
  (interactive)
  (replace-word-at-point
   (number-to-string
	(* 60
	   (string-to-number (thing-at-point 'word))))))

(defun reverse-word ()
  (interactive)
  (replace-word-at-point (reverse-string (thing-at-point 'word))))
