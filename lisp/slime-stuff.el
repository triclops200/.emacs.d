(setq inferior-lisp-program "sbcl --dynamic-space-size 2000")
(add-to-list 'load-path (fullpath-relative-to-current-file "slime"))
(require 'slime-autoloads)
(require 'slime)
(slime-setup '(slime-fancy slime-repl slime-sbcl-exts slime-autodoc))


