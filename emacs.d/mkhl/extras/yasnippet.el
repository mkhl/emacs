
(when (require 'yasnippet-bundle nil 'noerror)
  (yas/load-directory (concat dot-emacs-dir "snippets"))
  (yas/global-mode 1))
