
(setq-default fill-column 72
              comment-column 40)

(setq require-final-newline t
      kill-whole-line t
      comment-auto-fill-only-comments t)

(add-hook 'find-file-hook 'do-truncate-lines)
(add-hook 'dired-mode-hook 'do-truncate-lines)

(defun do-truncate-lines ()
  (setq truncate-lines t))
