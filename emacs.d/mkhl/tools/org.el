
(when (require 'org-install nil 'noerror)
  (require 'calendar)
  (setq org-replace-disputed-keys t)
  (add-to-list 'auto-mode-alist `(,(rx ".org" eos) . org-mode)))
