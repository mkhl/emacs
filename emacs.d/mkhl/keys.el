
;; Buffer switching
(require 'ibuffer)
(setq bs-default-sort-name "by name")
(global-set-key [(control x) (control b)] #'ibuffer)
;; (require 'bs)
;; (global-set-key [(control x) (control b)] #'bs-show)

;; Kill ring
(when (require 'browse-kill-ring nil 'noerror)
  (setq browse-kill-ring-highlight-current-entry t
        browse-kill-ring-highlight-inserted-item t
        browse-kill-ring-display-duplicates nil
        browse-kill-ring-no-duplicates t)
  (browse-kill-ring-default-keybindings))

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
(setq cua-highlight-region-shift-only t)
(cua-selection-mode t)
