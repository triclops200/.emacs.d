(ac-config-default)
(require 'auto-complete-clang)
(require 'auto-complete-config)
(setq clang-completion-suppress-error 't)
(add-hook 'after-init-hook 'global-auto-complete-mode)
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.7.3/include/g++-v4
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.7.3/include/g++-v4/x86_64-pc-linux-gnu
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.7.3/include/g++-v4/backward
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.7.3/include
 /usr/local/include
 /usr/lib/gcc/x86_64-pc-linux-gnu/4.7.3/include-fixed
 /usr/include
"
               )))
(defun my:ac-c-headers-init ()
  (require 'ac-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)
