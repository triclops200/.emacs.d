(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
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
		    auto-complete-clang
		    smart-tabs-mode
		    auctex
		    cdlatex
			xkcd
			sos
			evil
			evil-paredit
			w3m))
(defvar refresh t)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (if refresh
	(progn
	  (setq refresh nil)
	  (package-refresh-contents)))
    (package-install p)))
