(require 'cl)

;;; Uncomment to disable loading the "default" library at startup
;; (setq inhibit-default-init t)

;; Load path
(setq dot-emacs-dir (file-name-as-directory
                     (file-name-directory
                      (or (buffer-file-name) load-file-name))))
(add-to-list 'load-path dot-emacs-dir)
(add-to-list 'load-path (concat dot-emacs-dir "lisp"))
(load "lisp/loaddefs" 'noerror)

;; Initialization
(load "mkhl/global")
(load "mkhl/keys")
(load "mkhl/mouse")
(load "mkhl/aliases")
(load "mkhl/modes")
(load "mkhl/local")
(load "mkhl/elpa")
(load "mkhl/path")
