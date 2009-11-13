
(defun mk/org-keys ()
  (let* ((prefix-key "C-x C-o"))
    (labels ((org-kbd (key) (read-kbd-macro (format "%s %s" prefix-key key))))
      (global-unset-key (read-kbd-macro prefix-key))
      (global-set-key (org-kbd "l") 'org-store-link)
      (global-set-key (org-kbd "a") 'org-agenda)
      (global-set-key (org-kbd "b") 'org-iswitchb))))

(defun mk/org-remember ()
  (org-remember-insinuate)
  (setq org-default-notes-file (concat org-directory "notes.org"))
  (global-set-key (kbd "C-x C-r") 'org-remember))

(defun mk/setup-org ()
  (eval-after-load 'org
    '(setq org-directory (file-name-as-directory org-directory)))
  (setq org-replace-disputed-keys t
        org-completion-use-ido t)
  (mk/org-keys)
  (mk/org-remember)
  (add-hook 'org-mode-hook 'yas/fix-trigger-key))

(when (require 'org-install nil 'noerror)
  (require 'calendar)
  (mk/setup-org))

(defadvice org-publish-projects
  (around org-publish-disable-flymake activate)
  "Disable `flymake' while publishing `org-mode' files."
  (let ((flymake-allowed-file-name-masks))
    ad-do-it))

(add-to-list 'auto-mode-alist `(,(rx ".org" eos) . org-mode))
