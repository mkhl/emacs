(require 'cl)

;;; Uncomment to disable loading the "default" library at startup
;; (setq inhibit-default-init t)

;; Load path
(setq dot-emacs-dir (file-name-as-directory
                     (file-name-directory
                      (or (buffer-file-name) load-file-name))))
(add-to-list 'load-path dot-emacs-dir)

;; Packages
(load "mkhl/elpa")
(load "mkhl/vendor")
(load "mkhl/lisp")
;; Initialization
(load "mkhl/global")
(load "mkhl/keys")
(load "mkhl/mouse")
(when (eq window-system 'mac)
  (load "mkhl/mac"))
(load "mkhl/aliases")
(load "mkhl/eshell")
(load "mkhl/modes")
(load "mkhl/local")
(load "mkhl/path")

;; Bugfixes
(when (eq system-type 'darwin)
  (setq system-name (car (split-string system-name "\\."))))

;; Go home
(find-file "~")
