(add-to-list 'load-path "/home/jsvlrt/.emacs.d/tern/emacs")
(autoload 'tern-mode "tern.el" nil t)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
