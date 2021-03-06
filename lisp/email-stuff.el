(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(setq mu4e-sent-folder "/starfoxprime/sent"
      mu4e-drafts-folder "/starfoxprime/drafts"
      user-mail-address "starfoxprime@gmail.com"
      message-signature-file ".starfoxprime.txt"
      smtpmail-default-smtp-server "smtp.googlemail.com"
      smtpmail-stream-type 'ssl
      smtpmail-smtp-service 465)
(add-to-list 'mu4e-bookmarks
			 '("flag:flagged"       "Flagged Messages"     ?f))
(setq
 mu4e-get-mail-command "offlineimap")

(defvar my-mu4e-account-alist)
(setf my-mu4e-account-alist
      '(("starfoxprime"
		 (mu4e-sent-folder "/starfoxprime/sent")
		 (mu4e-drafts-folder "/starfoxprime/drafts")
		 (user-mail-address "starfoxprime@gmail.com")
		 (message-signature-file ".starfoxprime.txt")
		 (smtpmail-default-smtp-server "smtp.googlemail.com")
		 (smtpmail-smtp-server "smtp.googlemail.com")
		 (smtpmail-stream-type ssl)
		 (smtpmail-smtp-service 465))
		("bryanhoyle1"
		 (mu4e-sent-folder "/bryanhoyle1/sent")
		 (mu4e-drafts-folder "/bryanhoyle1/drafts")
		 (user-mail-address "bryan.hoyle1@googlemail.com")
		 (message-signature-file ".bryanhoyle1.txt")
		 (smtpmail-default-smtp-server "smtp.googlemail.com")
		 (smtpmail-smtp-server "smtp.googlemail.com")
		 (smtpmail-stream-type ssl)
		 (smtpmail-smtp-service 465))
		("bhoyle"
		 (mu4e-sent-folder "/bhoyle/sent")
		 (mu4e-drafts-folder "/bhoyle/drafts")
		 (user-mail-address "bhoyle@masonlive.gmu.edu")
		 (message-signature-file ".bhoyle.txt")
		 (smtpmail-default-smtp-server "pod51000.outlook.com")
		 (smtpmail-smtp-server "pod51000.outlook.com")
		 (smtpmail-stream-type starttls)
		 (smtpmail-smtp-service 587))))
(require 'tls)

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
		  (if mu4e-compose-parent-message
			  (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
				(string-match "/\\(.*?\\)/" maildir)
				(match-string 1 maildir))
			(completing-read (format "Compose with account: (%s) "
									 (mapconcat #'(lambda (var) (car var)) my-mu4e-account-alist "/"))
							 (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
							 nil t nil nil (caar my-mu4e-account-alist))))
		 (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
		(mapc #'(lambda (var)
				  (set (car var) (cadr var)))
			  account-vars)
      (error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
(add-hook 'window-configuration-change-hook 
		  '(lambda ()
			 (setq erc-fill-column (- (window-width) 2))))
;; use imagemagick, if available
(imagemagick-register-types)
(require 'w3m)
(load "mu4e-view")
(setq
 mu4e-view-show-images t
 mu4e-show-images t
 mu4e-view-image-max-width 800
 mu4e-update-interval 600
 mu4e-view-prefer-html t)


(defun html2text ()
  "Replacement for standard html2text using shr."
  (interactive)
  (let ((dom (libxml-parse-html-region (point-min) (point-max))))
	(erase-buffer)
	(shr-insert-document dom)
	(goto-char (point-min))))

(require 'org-mu4e)
(setq org-mu4e-convert-to-html t)
(defalias 'org-mail 'org-mu4e-compose-org-mode)
(defun org-export-string (data &rest rest)
  (let ((org-html-with-latex 'imagemagick))
	(org-export-string-as
	 data 'html t)))

(add-hook 'mu4e-view-mode-hook
		  '(lambda ()
			 (evil-local-mode -1)))
