(require 'erc)
(defun erc-my-privmsg-sound (proc parsed)
  (let* ((tgt (car (erc-response.command-args parsed)))
	 (privp (erc-current-nick-p tgt)))
    (and
     privp
     (ding)
     nil)))

(add-hook 'erc-server-PRIVMSG-functions
	  'erc-my-privmsg-sound)
(add-hook 'erc-insert-post-hook 
	  (lambda () (goto-char (point-min)) 
	    (when (re-search-forward
		   (regexp-quote  (erc-current-nick)) nil t) (ding))))

(add-hook 'window-configuration-change-hook 
	  '(lambda ()
	     (setq erc-fill-column (- (window-width) 2))))
