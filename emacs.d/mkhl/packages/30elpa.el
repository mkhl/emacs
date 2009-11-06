
;; Load packages installed via `elpa'
(let* ((elpa-path (concat dot-emacs-dir "elpa/package")))
  (when (require 'package elpa-path 'noerror)
    (package-initialize)))
