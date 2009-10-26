
(setq-default fill-column 72
              comment-column 40)

(setq require-final-newline t
      kill-whole-line t
      comment-auto-fill-only-comments t)

(add-hook 'find-file-hook 'set-truncate-lines)
(add-hook 'dired-mode-hook 'set-truncate-lines)
(defun set-truncate-lines ()
  (setq truncate-lines t))
