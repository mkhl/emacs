
;; Don't use Alt-x, use Ctrl-x-m
(global-set-key [(control x) (control m)] #'execute-extended-command)

;; Buffer switching
(require 'ibuffer)
(global-set-key [(control x) (control b)] #'ibuffer)
;; (require 'bs)
;; (global-set-key [(control x) (control b)] #'bs-show)

;; Directory editing
(global-set-key [(control x) (control d)] #'dired)

;; Undo/Redo
;; (require 'redo)
;; (global-set-key [(control _)] #'undo)
;; (global-set-key [(meta _)]    #'redo)
;; (global-set-key [(control z)] #'undo)
;; (global-set-key [(meta z)]    #'redo)

;; Window switching
;; (require 'windmove)
;; (windmove-default-keybindings 'meta)
;; (setq windmove-wrap-around t)

;; Shifted motion
(setq cua-highlight-region-shift-only t)
(cua-selection-mode t)
