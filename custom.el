;;(package-initialize)
;;(require 'package)
(defun fullpath-relative-to-current-file (file-relative-path)
<<<<<<< HEAD
  (concat (file-name-directory (or load-file-name buffer-file-name)) file-relative-path))
=======
  (concat (file-name-directory (or load-file-name buffer-file-name)) file-relative-path)
  )
>>>>>>> cd9f28ca2e1c34a8b3c42fd022d93a14906d97f0
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(defvar my-packages '(
					  clojure-mode
					  clojure-test-mode
					  cider
					  company
					  org
					  solarized-theme
					  paredit
					  autocomplete))

(dolist (p my-packages)
  (when (not (package-installed-p p))
	(package-install p)))

;;(package-initialize)
(setq inferior-lisp-program "sbcl")
(add-to-list 'load-path (fullpath-relative-to-current-file "slime"))
(require 'slime-autoloads)
(require 'slime)
(slime-setup '(slime-fancy slime-repl slime-sbcl-exts slime-autodoc))
;;(require 'slime-autoloads)

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
(global-set-key (kbd "M-<tab>") 'company-complete)

(require 'eclim)
(require 'eclimd)
(global-eclim-mode)
;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)
(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(slime-setup '(slime-company))
(defun eclim-run-test ()
  (interactive)
  (if (not (string= major-mode "java-mode"))
	  (message "Sorry cannot run current buffer."))
  (compile (concat eclim-executable " -command java_junit -p " eclim--project-name " -t " (eclim-package-and-class))))
(add-hook 'after-init-hook 'global-company-mode)

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
<<<<<<< HEAD

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)




=======
(defun my:ac-c-headers-init ()
    (require 'auto-complete-c-headers)
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
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
>>>>>>> cd9f28ca2e1c34a8b3c42fd022d93a14906d97f0
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
<<<<<<< HEAD
(setq org-agenda-files
      (list "~/todo/main.org"))
(add-hook 'org-mode-hook 'org-indent-mode)
=======
(setq org-agenda-files (list "~/todo/main.org"))
(defun replace-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%s" value))))
(define-key global-map "\C-x\C-j" 'replace-last-sexp)

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
>>>>>>> cd9f28ca2e1c34a8b3c42fd022d93a14906d97f0
