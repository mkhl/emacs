
(when (require 'yasnippet-bundle nil 'noerror)
  (setq yas/use-menu 'abbreviate)
  (add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand)
  (yas/load-directory (concat dot-emacs-dir "snippets"))
  (yas/global-mode 1))

(defun yas/fix-trigger-key ()
  (setq yas/fallback-behavior `(apply ,(local-key-binding (kbd "TAB"))))
  (local-set-key (kbd "<tab>") 'yas/expand))
