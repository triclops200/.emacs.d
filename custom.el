(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#262626" "#d70000" "#5f8700" "#af8700" "#0087ff" "#af005f" "#00afaf" "#626262"])
 '(background-color nil)
 '(background-mode dark)
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "/usr/bin/firefox")
 '(cursor-color nil)
 '(custom-safe-themes
   (quote
	("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(foreground-color nil)
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)))
 '(scroll-bar-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "smtp.googlemail.com")
 '(smtpmail-smtp-service 465)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-font-face ((t (:height 35 :family "Bitstream Vera Sans Mono")))))


;;My customizations follow
(add-to-list 'custom-theme-load-path
			 "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)
(quote (set-default-font "-*-Monaco-normal-normal-normal-monospace-13-*-*-*-m-0-iso10646-1"))
(set-default-font "-bitstream-Bitstream Vera Sans Mono-normal-normal-normal-monospace-13-*-*-*-m-0-iso10646-1")
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/secrets/")
(global-linum-mode t)
(load "my-packages.el")
(load "custom-scripts.el")
(load "asthetics-stuff.el")
(load "paredit-stuff.el")
(load "eclim-stuff.el")
(load "my-functions.el")
(load "slime-stuff.el")
(load "ac-stuff.el" )
(load "python-stuff.el")
(load "org-stuff.el")
(load "erc-stuff.el")
(load "c-stuff.el")
(load "semantic-stuff.el")
(load "email-stuff.el")
(load "haskell-stuff.el")
(load "as-stuff.el")
(load "evil-stuff.el")
(load "tern-stuff.el")
(load "znc_servers.el")
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

(if (daemonp)
	(add-hook 'after-make-frame-functions
			  '(lambda (f)
				 (with-selected-frame f
				   (when (window-system f) (load-theme 'solarized-dark t)))))
  (load-theme 'solarized-dark t))
