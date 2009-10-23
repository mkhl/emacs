(require 'cl)

;;; Uncomment to disable loading the "default" library at startup
;; (setq inhibit-default-init t)

;; Load path
(setq dot-emacs-dir (file-name-as-directory
                     (file-name-directory
                      (or (buffer-file-name) load-file-name))))
(add-to-list 'load-path dot-emacs-dir)

;; Packages
(load "mkhl/packages")

;; Initialization
(load "mkhl/helpers")
(load "mkhl/global")
(load "mkhl/keys")
(load "mkhl/mouse")
(load "mkhl/aliases")
(load "mkhl/shell")
(load "mkhl/modes")
(load "mkhl/local")
(load "mkhl/path")

(setq custom-file (concat dot-emacs-dir "custom.el"))
(load custom-file 'noerror 'nomessage)

;; Bugfixes
(case system-type
  ('darwin (setq system-name (first (split-string system-name "\\.")))))

;; Go home
(find-file "~")
