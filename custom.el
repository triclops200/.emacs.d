(add-to-list 'load-path "~/.emacs.d/scripts")
(load "slime-company.el")
(load "indentfile.el")
(load "gitpush.el")
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(global-unset-key (kbd "C-c g"))
(global-set-key (kbd "C-c i") 'indent-file)
(global-set-key (kbd "C-c g g") 'git-push-all)
(global-set-key (kbd "C-c g a") 'git-add-all)
(global-set-key (kbd "C-c g w") 'git-push)
(global-set-key (kbd "C-c g c") 'git-commit)
(global-set-key (kbd "C-c g y") 'git-pull)
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
(defvar my-packages '(starter-kit
					   starter-kit-lisp
					   starter-kit-bindings
					   starter-kit-eshell
					   clojure-mode
					   clojure-test-mode
					   cider))

(dolist (p my-packages)
  (when (not (package-installed-p p))
	(package-install p)))

