
;; Kill ring
(when (require 'browse-kill-ring nil 'noerror)
  (setq browse-kill-ring-highlight-current-entry t
        browse-kill-ring-highlight-inserted-item t
        browse-kill-ring-display-duplicates nil
        browse-kill-ring-no-duplicates t)
  (browse-kill-ring-default-keybindings))

;; Color theme
(when (require 'color-theme nil 'noerror)
  (color-theme-initialize)
  (color-theme-xemacs))

;; TextMate mode
(when (fboundp 'textmate-mode)
  (textmate-mode t)
  (define-key *textmate-mode-map* (kbd "C-c C-t") nil)
  (define-key *textmate-mode-map* (kbd "M-<return>") nil))
