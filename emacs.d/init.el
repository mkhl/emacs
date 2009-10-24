(require 'cl)

;;; Uncomment to disable loading the "default" library at startup
;; (setq inhibit-default-init t)

;; Load path
(setq dot-emacs-dir (file-name-as-directory
                     (file-name-directory
                      (or (buffer-file-name) load-file-name))))
(add-to-list 'load-path dot-emacs-dir)

;; Loading components
(load "mkhl/load-component")

;; Packages
(load-component "mkhl/packages")

;; Initialization
(load-component "mkhl/helpers")
(load "mkhl/global")
(load "mkhl/keys")
(load "mkhl/mouse")
(load "mkhl/aliases")
(load "mkhl/shell")
(load-component "mkhl/modes")
(load "mkhl/local")
(load-component "mkhl/system")

(setq custom-file (concat dot-emacs-dir "custom.el"))
(load custom-file 'noerror 'nomessage)

;; Go home
(find-file "~")
