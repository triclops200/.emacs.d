(defun git-push-all (commit-message)
  (interactive "sCommit Message: ")
  (shell-command "git add -A")
  (shell-command (concat "git commit -m \"" commit-message "\""))
  (save-window-excursion
	(let ((buf (generate-new-buffer "async")))
	  (async-shell-command  "git push origin master &" buf)
	  (run-with-timer 10 nil (lambda (buf) (kill-buffer buf)) buf))))
