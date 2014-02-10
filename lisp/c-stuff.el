(setq auto-mode-alist
      (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("SConscript" . python-mode) auto-mode-alist))
(defun find-sconstruct ()
  "recursively searches upwards from buffer's current dir for file named SConstruct and returns that dir. Or nil if not found or if buffer is not visiting a file"
  (labels
      ((find-sconstruct-r (path)
			  (let* ((parent (file-name-directory path))    
				 (possible-file (concat parent "SConstruct")))
			    (cond
			     ((file-exists-p possible-file)
			      (throw 'found-it possible-file))
			     ((string= "/SConstruct" possible-file)
			      (error "No SConstruct found"))
			     (t (find-sconstruct-r (directory-file-name parent)))))))
    (if (buffer-file-name)
    	(catch 'found-it
    	  (find-sconstruct-r (buffer-file-name)))
      (error "Buffer is not visiting a file"))))
(defun project-root ()    
  (file-name-directory (find-sconstruct)))
(defun set-compile-command-C ()
  (setq compile-command (concat "cd " (project-root) " && scons"))
  (local-set-key (kbd "C-c C-k") 'compile))
(add-hook 'c-mode-hook 'set-compile-command-C)
(add-hook 'c++-mode-hook 'set-compile-command-C)

