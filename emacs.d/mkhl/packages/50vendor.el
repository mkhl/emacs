
;; Make sure `Info-additional-directory-list' is available
(require 'info)

;; Load packages from the `vendor' subdirectory
(let* ((vendor-dir (file-name-as-directory (concat dot-emacs-dir "vendor")))
       (non-hidden (rx bos (not (in ".")))))
  (dolist (path (directory-files vendor-dir 'full non-hidden))
    (let* ((path (file-name-as-directory path))
           (lisp-path (concat path "lisp"))
           (info-path (concat path "doc"))
           (autoloads (concat path "autoloads")))
      (add-to-list 'load-path path)
      (add-to-list 'load-path lisp-path)
      (load autoloads 'noerror)
      (when (file-exists-p info-path)
        (add-to-list 'Info-additional-directory-list info-path)))))
