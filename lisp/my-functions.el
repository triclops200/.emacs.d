(defun fullpath-relative-to-current-file (file-relative-path)
  (concat (file-name-directory (or load-file-name buffer-file-name)) file-relative-path))
(defun replace-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%s" value))))
(define-key global-map "\C-x\C-j" 'replace-last-sexp)

(defvar my-linum-current-line-number 0)

(setq linum-format 'my-linum-relative-line-numbers)

(defun my-linum-relative-line-numbers (line-number)
  (let ((test2 (1+ (- line-number my-linum-current-line-number))))
    (propertize
     (format "%3d" (cond ((<= test2 0) (1- test2))
                             ((> test2 0) test2)))
     'face 'linum)))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)
