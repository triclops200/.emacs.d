
(defun git-commit (commit-message)
  (interactive "sCommit Message: ")
  (shell-command (concat "git commit -m\""commit-message"\"")))

(defun git-add-all ()
  (interactive)
  (shell-command "git add -A"))

(defun git-pull ()
  (interactive)
  (save-window-excursion
	(let ((buf (generate-new-buffer "async")))
	  (async-shell-command  "git pull origin master" buf)
	  (run-with-timer 10 nil (lambda (buf) (kill-buffer buf)) buf))))

(defun git-push ()
  (interactive)
  (save-window-excursion
	(let ((buf (generate-new-buffer "async")))
	  (async-shell-command  "git push origin master" buf)
	  (run-with-timer 10 nil (lambda (buf) (kill-buffer buf)) buf))))

(defun git-push-all (commit-message)
  (interactive "sCommit Message: ")
  (git-add-all)
  (git-commit commit-message)
  (git-push))
