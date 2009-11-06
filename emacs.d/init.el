(require 'cl)

;;; Uncomment to disable loading the "default" library at startup
;; (setq inhibit-default-init t)

;; dot-emacs
(unless (boundp 'dot-emacs-dir)
  (setq dot-emacs-dir (file-name-as-directory
                       (file-name-directory
                        (or (buffer-file-name) load-file-name)))))

;; load-component
(load (concat dot-emacs-dir "mkhl/load-component"))

;;; packages
(load-component "mkhl/packages")

;;; components
(load-component "mkhl/helpers")
(load-component "mkhl/base")
(load-component "mkhl/tools")
(load-component "mkhl/extras")
(load-component "mkhl/modes")
(load-component "mkhl/system")

;;; custom
(setq custom-file (concat dot-emacs-dir "custom.el"))
(load custom-file 'noerror 'nomessage)
