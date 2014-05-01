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
(setq org-src-fontify-natively t)
(setq org-export-htmlize-output-type 'css)
(setq org-src-preserve-indentation t)

(require 'ob-clojure)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (R . t)
   (python . t)
   (C . t)
   (clojure . t)
   (haskell . t)
   (ruby . t)
   (lisp . t)
   (org . t)
   (scheme . t)
   (sh . t)))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
		 "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
		 "* %?\nEntered on %U\n  %i\n  %a")))

