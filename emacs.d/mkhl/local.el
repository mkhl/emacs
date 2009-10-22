
;; More dired
(when (require 'dired-x)
  (setq-default dired-omit-mode t)
  (setq dired-omit-files (rx (| (: bos (? ".") "#")
                                (: bos ".")))))
(defun dired-open-file ()
  (interactive)
  (let* ((file-name (dired-get-file-for-visit))
         (open-program "/usr/bin/open"))
    (when (file-exists-p file-name)
      (call-process open-program nil 0 nil file-name))))
(define-key dired-mode-map [(meta o)] 'dired-open-file)
(define-key dired-mode-map [(-)] 'dired-up-directory)

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

;; Line numbers
(when (require 'linum)
  (global-linum-mode 1))

;; Color theme
(when (require 'color-theme nil 'noerror)
  (color-theme-initialize)
  (let* ((theme (cond
                 ((fboundp 'color-theme-quiet-light)
                  'color-theme-quiet-light)
                 ((fboundp 'color-theme-espresso)
                  'color-theme-espresso)
                 (t 'color-theme-xemacs))))
    (add-hook 'after-init-hook theme)))

;; W3M
(require 'w3m-load nil 'noerror)

;; TextMate mode
(require 'textmate nil 'noerror)

;; Smex
(when (require 'smex nil 'noerror)
  (let* ((smex-save-base (file-name-nondirectory smex-save-file)))
    (setq smex-save-file (concat dot-emacs-dir smex-save-base)))
  (setq extended-command-command 'smex)
  (smex-initialize)
;;   (global-set-key [(control x) (control m)] 'smex)
;;   (global-set-key [(control x) (m)] 'smex-major-mode-commands)
  (smex-auto-update))

;; YASnippet
(when (require 'yasnippet-bundle nil 'noerror)
  (yas/load-directory (concat dot-emacs-dir "snippets"))
  (yas/global-mode 1))

;; Gist
(eval-after-load "gist"
  '(progn
     (setq gist-view-gist t)))

;; Proof General
(add-hook 'after-init-hook
          (lambda ()
            (let ((proof-assistants '(isar)))
              (require 'proof-site nil 'noerror))))

;; Fix hiding Emacs
;; TODO: Find the proper way to hide Emacs.
(defun my/mac-hide-emacs ()
  (interactive)
  (do-applescript (format "tell application \"System Events\"
    tell application process \"%s\"
        set visible to false
    end tell
end tell" invocation-name)))
(global-set-key [(control meta shift h)] 'my/mac-hide-emacs)
(global-set-key [(alt h)] 'my/mac-hide-emacs)
