(require 'org)
(require 'ox-beamer)
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files
      (list "~/todo/main.org"))
(add-hook 'org-mode-hook 'org-indent-mode)


(org-babel-do-load-languages ; babel, for executing 
 'org-babel-load-languages   ; code in org-mode.
 '((sh . t)
   (emacs-lisp . t)
   (haskell . t)))

(setq org-export-latex-listings 'minted)
(setq org-export-latex-minted-options
      '(("frame" "lines")
        ("fontsize" "\\scriptsize")
        ("linenos" "")))
(setq org-export-latex-custom-lang-environments
	  '(
		(emacs-lisp "common-lispcode")
		))
(setq org-export-latex-minted-options
	  '(("frame" "lines")
		("fontsize" "\\scriptsize")
		("linenos" "")))
(setq org-latex-pdf-process
	  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
		"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
		"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
