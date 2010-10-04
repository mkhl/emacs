
(require 'cl)
(require 'assoc)
(setq vc-follow-symlinks t)

;;; `org' and `org-babel'
(dolist (path '("org/lisp" "org/contrib/lisp"))
  (add-to-list 'load-path (expand-file-name path user-emacs-directory)))
(require 'org-install)

;;; Load `*.org' using `org-babel'
(dolist (file (directory-files user-emacs-directory 'full (rx ".org" eos)))
  (org-babel-load-file file))

;;; `custom-file'
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)

;;; `emacs-init-time'
;; Useful for benchmarking startup time.
;; (emacs-init-time)
