(package-initialize)
(require 'package)
(defun fullpath-relative-to-current-file (file-relative-path)
  (concat (file-name-directory (or load-file-name buffer-file-name)) file-relative-path)
)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(defvar my-packages '(
					  clojure-mode
					  clojure-test-mode
					  cider
					  company))

(dolist (p my-packages)
  (when (not (package-installed-p p))
	(package-install p)))

(package-initialize)
(setq inferior-lisp-program "sbcl")
(add-to-list 'load-path (fullpath-relative-to-current-file "slime"))
(require 'slime-autoloads)
(require 'slime)
(slime-setup '(slime-fancy slime-repl slime-sbcl-exts slime-autodoc))
(require 'slime-autoloads)

(add-to-list 'load-path "~/.emacs.d/scripts")
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

(add-to-list 'auto-mode-alist '("\\.sml\\'" . scheme-mode))
