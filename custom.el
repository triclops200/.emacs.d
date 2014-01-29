(require 'package)
(package-initialize)
(set-default-font "-bitstream-Bitstream Vera Sans Mono-normal-normal-normal-monospace-13-*-*-*-m-0-iso10646-1")
(add-to-list 'custom-theme-load-path
	     "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)
(add-to-list 'load-path "~/.emacs.d")
(defun fullpath-relative-to-current-file (file-relative-path)
  (concat (file-name-directory (or load-file-name buffer-file-name)) file-relative-path))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)



(defvar my-packages)
(setq my-packages '(clojure-mode
		    clojure-test-mode
		    cider
		    org
		    paredit
		    auto-complete
		    slime
		    emacs-eclim
		    ess
		    znc
		    ac-c-headers
		    malabar-mode
		    auctex
		    cdlatex))
(defvar refresh t)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (if refresh
	(progn
	  (setq refresh nil)
	  (package-refresh-contents)))
    (package-install p)))
(require 'org-latex)

(setq inferior-lisp-program "sbcl")
(add-to-list 'load-path (fullpath-relative-to-current-file "slime"))
(require 'slime-autoloads)
(require 'slime)
(slime-setup '(slime-fancy slime-repl slime-sbcl-exts slime-autodoc))


(add-to-list 'load-path "~/.emacs.d/scripts")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)
(load "indentfile.el")
(load "gitpush.el")
(load "notes.el")



(global-unset-key (kbd "C-c g"))
(global-unset-key (kbd "C-c n"))
(global-set-key (kbd "C-c i") 'indent-file)
(global-set-key (kbd "C-c g g") 'git-push-all)
(global-set-key (kbd "C-c g a") 'git-add-all)
(global-set-key (kbd "C-c g w") 'git-push)
(global-set-key (kbd "C-c g c") 'git-commit)
(global-set-key (kbd "C-c g y") 'git-pull)
(global-set-key (kbd "C-c n b") 'box-word)
(global-set-key (kbd "M-<tab>") 'auto-complete)

(require 'eclim)
(require 'eclimd)
(global-eclim-mode)
;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)
(defun eclim-run-test ()
  (interactive)
  (if (not (string= major-mode "java-mode"))
      (message "Sorry cannot run current buffer."))
  (compile (concat eclim-executable " -command java_junit -p " eclim--project-name " -t " (eclim-package-and-class))))
(add-hook 'after-init-hook 'global-auto-complete-mode)

(setq inferior-lisp-program "sbcl --dynamic-space-size 2000")




(defface esk-paren-face
  '((((class color) (background dark))
     (:foreground "grey50"))
    (((class color) (background light))
     (:foreground "grey55")))
  "Face used to dim parentheses."
  :group 'starter-kit-faces)


(font-lock-add-keywords 'emacs-lisp-mode
                        '(("(\\|)" . 'esk-paren-face)))
(font-lock-add-keywords 'lisp-mode
                        '(("(\\|)" . 'esk-paren-face)))
(font-lock-add-keywords 'clojure-mode
                        '(("(\\|)" . 'esk-paren-face)))

(add-to-list 'auto-mode-alist '("\\.sml\\'" . scheme-mode))
(unless window-system
  (when (getenv "DISPLAY")
    ;; Callback for when user cuts
    (defun xsel-cut-function (text &optional push)
      ;; Insert text to temp-buffer, and "send" content to xsel stdin
      (with-temp-buffer
	(insert text)
	;; I prefer using the "clipboard" selection (the one the
	;; typically is used by c-c/c-v) before the primary selection
	;; (that uses mouse-select/middle-button-click)
	(call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    ;; Call back for when user pastes
    (defun xsel-paste-function()
      ;; Find out what is current selection by xsel. If it is different
      ;; from the top of the kill-ring (car kill-ring), then return
      ;; it. Else, nil is returned, so whatever is in the top of the
      ;; kill-ring will be used.
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
	(unless (string= (car kill-ring) xsel-output)
	  xsel-output )))
    ;; Attach callbacks to hooks
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)
    (menu-bar-mode -1)))
(global-linum-mode t)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'paredit-mode)

(defun my:ac-c-headers-init ()
  (require 'ac-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)

(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
 "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
 "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files
      (list "~/todo/main.org"))
(add-hook 'org-mode-hook 'org-indent-mode)

(defun replace-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%s" value))))
(define-key global-map "\C-x\C-j" 'replace-last-sexp)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#262626" "#d70000" "#5f8700" "#af8700" "#0087ff" "#af005f" "#00afaf" "#626262"])
 '(background-color nil)
 '(background-mode dark)
 '(cursor-color nil)
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(foreground-color nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "smtp.googlemail.com")
 '(smtpmail-smtp-service 465)
 '(tool-bar-mode nil)
 '(znc-servers (quote (("Triclops200.com" 11337 nil ((Triclops200 "Triclops200" "Superfly123")))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load "znc_servers.el")
(setq auto-mode-alist
      (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("SConscript" . python-mode) auto-mode-alist))
(defun find-sconstruct ()
  "recursively searches upwards from buffer's current dir for file named SConstruct and returns that dir. Or nil if not found or if buffer is not visiting a file"
  (labels
      ((find-sconstruct-r (path)
			  (let* ((parent (file-name-directory path))    
				 (possible-file (concat parent "SConstruct")))
			    (cond
			     ((file-exists-p possible-file)
			      (throw 'found-it possible-file))
			     ((string= "/SConstruct" possible-file)
			      (error "No SConstruct found"))
			     (t (find-sconstruct-r (directory-file-name parent)))))))
    (if (buffer-file-name)
    	(catch 'found-it
    	  (find-sconstruct-r (buffer-file-name)))
      (error "Buffer is not visiting a file"))))


(defun project-root ()    
  (file-name-directory (find-sconstruct)))

(defun set-compile-command-C ()
  (setq compile-command (concat "cd " (project-root) " && scons")))

(add-hook 'c-mode-hook 'set-compile-command-C)
(add-hook 'c++-mode-hook 'set-compile-command-C)
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode))
(semantic-mode 1)
(require 'malabar-mode)
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(setq
 mu4e-view-show-images t
 w3m-command "/usr/bin/w3m")
(require 'mu4e)
(setq mu4e-sent-folder "/starfoxprime/sent"
      mu4e-drafts-folder "/starfoxprime/drafts"
      user-mail-address "starfoxprime@gmail.com"
      message-signature-file ".starfoxprime.txt"
      smtpmail-default-smtp-server "smtp.googlemail.com"
      smtpmail-stream-type 'ssl
      smtpmail-smtp-service 465)
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
'("vdinh3"
  (mu4e-sent-folder "/vdinh3/sent")
  (mu4e-drafts-folder "/vdinh3/drafts")
  (user-mail-address "vdinh3@masonlive.gmu.edu")
  (message-signature-file ".vdinh3.txt")
  (smtpmail-default-smtp-server "pod51000.outlook.com")
  (smtpmail-smtp-server "pod51000.outlook.com")
  (smtpmail-stream-type starttls)
  (smtpmail-smtp-service 587))
'("lvkdinh"
  (mu4e-sent-folder "/lvkdinh/sent")
  (mu4e-drafts-folder "/lvkdinh/drafts")
  (user-mail-address "lvkdinh@gmail.com")
  (message-signature-file ".lvkdinh.txt")
  (smtpmail-default-smtp-server "smtp.googlemail.com")
  (smtpmail-smtp-server "smtp.googlemail.com")
  (smtpmail-stream-type ssl)
  (smtpmail-smtp-service 465))

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

(setq
 mu4e-view-show-images t
  mu4e-view-image-max-width 800
 w3m-command "/usr/bin/w3m")
(require 'org-mu4e)
(setq org-mu4e-convert-to-html t)
(defalias 'org-mail 'org-mu4e-compose-org-mode)
