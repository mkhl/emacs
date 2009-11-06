
(when (require 'org-install nil 'noerror)
  (require 'calendar)
  (setq org-replace-disputed-keys t
        org-completion-use-ido t)
  (let* ((prefix-key "C-x C-o"))
    (labels ((org-kbd (key) (read-kbd-macro (format "%s %s" prefix-key key))))
      (global-unset-key (read-kbd-macro prefix-key))
      (global-set-key (org-kbd "l") 'org-store-link)
      (global-set-key (org-kbd "a") 'org-agenda)
      (global-set-key (org-kbd "b") 'org-iswitchb)))
  (add-to-list 'auto-mode-alist `(,(rx ".org" eos) . org-mode)))
