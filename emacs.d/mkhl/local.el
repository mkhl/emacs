
;; Kill ring
(when (require 'browse-kill-ring nil 'noerror)
  (setq browse-kill-ring-highlight-current-entry t
        browse-kill-ring-highlight-inserted-item t
        browse-kill-ring-display-duplicates nil
        browse-kill-ring-no-duplicates t)
  (browse-kill-ring-default-keybindings))

;; Centered cursor
(when (require 'centered-cursor-mode nil 'noerror)
  (global-centered-cursor-mode t))

;; Color theme
(when (require 'color-theme nil 'noerror)
  (color-theme-initialize)
  (color-theme-xemacs))

;; TextMate mode
(when (fboundp 'textmate-mode)
  (textmate-mode t)
  (define-key *textmate-mode-map* [(control c) (control t)] nil)
  (define-key *textmate-mode-map* [(meta return)] nil))

;; YASnippet
(eval-after-load "yasnippet-bundle"
  '(unwind-protect
       (yas/load-directory (concat dot-emacs-dir "snippets"))))
