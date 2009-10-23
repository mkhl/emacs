
;; Load packages from the `site-lisp' subdirectory
(let* ((site-lisp-dir (file-name-as-directory
                       (concat dot-emacs-dir "site-lisp")))
       (autoloads (concat site-lisp-dir "autoloads")))
  (add-to-list 'load-path site-lisp-dir)
  (load autoloads 'noerror))
