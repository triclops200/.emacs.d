(defun indent-file ()
    (interactive)
	  (setq moreLines 0 )
		(setq oldPos (point))
		  (goto-char 1)
			(while (= moreLines 0)
					   (indent-according-to-mode)
						   (setq moreLines (forward-line 1)))
			  (goto-char oldPos))


