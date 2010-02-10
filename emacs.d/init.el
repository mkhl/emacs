
(require 'cl)
(require 'assoc)
(setq vc-follow-symlinks t)

;;; `dot-emacs-dir'
(unless (boundp 'dot-emacs-dir)
  (let ((this-file (or load-file-name (buffer-file-name))))
    (setq dot-emacs-dir (file-name-directory this-file))))

;;; `org' and `org-babel'
(dolist (path '("org/lisp" "org/contrib/lisp"))
  (add-to-list 'load-path (expand-file-name path dot-emacs-dir)))
(require 'org-install)
(require 'org-babel-init)

;;; Load `*.org' using `org-babel'
(dolist (file (directory-files dot-emacs-dir 'full (rx ".org" eos)))
  (org-babel-load-file file))

;;; `custom-file'
(setq custom-file (expand-file-name "custom.el" dot-emacs-dir))
(load custom-file 'noerror 'nomessage)

;;; `emacs-init-time'
;; Useful for benchmarking startup time.
;; (emacs-init-time)
