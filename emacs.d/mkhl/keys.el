
;; Find file at point
(require 'ffap)
(ffap-bindings)

;; Buffer switching
(require 'ibuffer)
(setq bs-default-sort-name "by name")
(global-set-key [(control x) (control b)] #'ibuffer)
;; (require 'bs)
;; (global-set-key [(control x) (control b)] #'bs-show)

;; Hippie completion
;; (global-set-key [(meta space)] #'hippie-expand)
;; (global-set-key [(control space)] #'hippie-expand)

;; Undo/Redo
(require 'redo)
(global-set-key [(control _)] #'undo)
(global-set-key [(meta _)]    #'redo)
(global-set-key [(control z)] #'undo)
(global-set-key [(meta z)]    #'redo)

;; Window switching
(require 'windmove)
(windmove-default-keybindings)
;; (global-set-key [(control tab)] #'other-window)
;; (global-set-key [(control shift tab)]
;;                 #'(lambda () (interactive) (other-window -1)))

;; Shifted motion
;; (require 's-region)
