
;; Don't use Alt-x, use Ctrl-x-m
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Buffer switching
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; (require 'bs)
;; (global-set-key (kbd "C-x C-b") 'bs-show)

;; Directory editing
(global-set-key (kbd "C-x C-d") 'dired)

;; Undo/Redo
;; (require 'redo)
;; (global-set-key (kbd "C-_") 'undo)
;; (global-set-key (kbd "M-_") 'redo)
;; (global-set-key (kbd "C-z") 'undo)
;; (global-set-key (kbd "M-z") 'redo)

;; Shifted motion
(setq cua-highlight-region-shift-only t)
(cua-selection-mode t)

;; Tab switching
(global-set-key (kbd "C-<tab>") 'next-tab-or-buffer)
(global-set-key (kbd "C-S-<tab>") 'previous-tab-or-buffer)

(labels ((next-line-and-indent ()
           (interactive)
           (end-of-line)
           (newline-and-indent)))
  ;; TextMate-like Convenience
  (define-key osx-key-mode-map (kbd "A-<return>") #'next-line-and-indent)
  ;; Comment/Uncomment
  (define-key osx-key-mode-map (kbd "A-;") 'comment-or-uncomment-region))
