
;; Buffer switching
(require 'ibuffer)
(setq bs-default-sort-name "by name")
(global-set-key [(control x) (control b)] #'ibuffer)
;; (require 'bs)
;; (global-set-key [(control x) (control b)] #'bs-show)

;; Undo/Redo
(require 'redo)
(global-set-key [(control _)] #'undo)
(global-set-key [(meta _)]    #'redo)
(global-set-key [(control z)] #'undo)
(global-set-key [(meta z)]    #'redo)

;; Window switching
(require 'windmove)
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

;; Shifted motion
;; (require 's-region)
