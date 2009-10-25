
(when (require 'yasnippet-bundle nil 'noerror)
  (yas/load-directory (concat dot-emacs-dir "snippets"))
  (add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand)
  (yas/global-mode 1))
