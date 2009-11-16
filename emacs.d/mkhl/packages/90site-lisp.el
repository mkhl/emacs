
;; Load packages from the `site-lisp' subdirectory
(let* ((site-lisp-dir (file-name-as-directory
                       (concat dot-emacs-dir "site-lisp")))
       (non-hidden (rx bos (not (in "."))))
       (autoloads (concat site-lisp-dir "autoloads")))
  (dolist (path (directory-files site-lisp-dir 'full non-hidden))
    (add-to-list 'load-path (file-name-as-directory path)))
  (load autoloads 'noerror))
