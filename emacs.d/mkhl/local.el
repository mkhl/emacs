
(eval-after-load "dired-x"
  '(progn
     (setq dired-omit-files (rx (| (: bos (? ".") "#") (: bos "."))))
     (setq-default dired-omit-mode t)))
(require 'dired-x)

;; Kill ring
(eval-after-load "browse-kill-ring"
  '(progn
     (setq browse-kill-ring-highlight-current-entry t
           browse-kill-ring-highlight-inserted-item t
           browse-kill-ring-display-duplicates nil
           browse-kill-ring-no-duplicates t)
     (browse-kill-ring-default-keybindings)))
(require 'browse-kill-ring nil 'noerror)

;; Centered cursor
(eval-after-load "centered-cursor-mode"
  '(progn
     (global-centered-cursor-mode t)))
(require 'centered-cursor-mode nil 'noerror)

;; Color theme
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
  (color-theme-xemacs)))
(require 'color-theme nil 'noerror)

;; TextMate mode
(eval-after-load "textmate"
  '(progn
     (textmate-mode t)
     (define-key *textmate-mode-map* [(control c) (control t)] nil)
     (define-key *textmate-mode-map* [(meta return)] nil)))
(require 'textmate nil 'noerror)

;; YASnippet
(eval-after-load "yasnippet-bundle"
  '(unwind-protect
       (progn
         (yas/load-directory (concat dot-emacs-dir "snippets"))
         (yas/global-mode 1))))
(require 'yasnippet-bundle nil 'noerror)

;; Go home
(find-file "~")
