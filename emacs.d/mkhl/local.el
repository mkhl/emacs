
(when (require 'dired-x)
  (setq dired-omit-files (rx (| (: bos (? ".") "#") (: bos "."))))
  (setq-default dired-omit-mode t))

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
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
  (color-theme-xemacs)))
(require 'color-theme nil 'noerror)

;; W3M
(when (require 'w3m-load nil 'noerror)
  (setq browse-url-browser-function 'w3m-browse-url))

;; TextMate mode
(when (require 'textmate nil 'noerror)
  (textmate-mode t)
  (define-key *textmate-mode-map* [(control c) (control t)] nil)
  (define-key *textmate-mode-map* [(meta return)] nil))

;; YASnippet
(when (require 'yasnippet-bundle nil 'noerror)
  (yas/load-directory (concat dot-emacs-dir "snippets"))
  (yas/global-mode 1))

;; Proof General
(add-hook 'after-init-hook
          (lambda ()
            (let ((proof-assistants '(isar)))
              (require 'proof-site nil 'noerror))))

;; Go home
(find-file "~")
