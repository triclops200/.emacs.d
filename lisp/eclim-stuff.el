(require 'eclim)
(require 'eclimd)
(setq eclimd-default-workspace "~/CS310")
(add-to-list 'eclim--file-coding-system-mapping '("utf-8-emacs-dos" . "utf-8"))
;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)
;; add the emacs-eclim source
(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)

(defun eclim-run-test ()
  (interactive)
  (if (not (string= major-mode "java-mode"))
      (message "Sorry cannot run current buffer."))
  (compile (concat eclim-executable " -command java_junit -p " eclim--project-name " -t " (eclim-package-and-class))))

(add-hook 'java-mode-hook 'company-mode)

(add-hook 'java-mode-hook
		  (lambda () (auto-complete-mode -1)
			(local-set-key (kbd "M-<tab>") 'company-complete)))
