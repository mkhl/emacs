
;;; `org-remember'

(defun mk/org-remember ()
  (org-remember-insinuate)
  (setq org-remember-templates
        '(("todo" ?t
           "* TODO %?\n\n  Date: %u\n\n  %i" nil "Todo List")
          ("org-mac remember" ?w
           "* %?\n\n  Source: %u, %c\n  Context: %a\n\n  %i" nil "Remember")
          ("org-mac note" ?z
           "* %?\n\n  Date: %u\n" nil "Notes")))
  (global-set-key (kbd "C-x C-r") #'org-remember-default)
  (global-set-key (kbd "C-x C-t") #'org-remember-todo))

(defun org-remember-with-template (template-char)
  (if (eq '- current-prefix-arg)
      (org-remember current-prefix-arg)
    (org-remember current-prefix-arg template-char)))

(defun org-remember-default ()
  (interactive)
  (org-remember-with-template ?w))

(defun org-remember-todo ()
  (interactive)
  (org-remember-with-template ?t))

;;; `org'

(defun mk/org-keys ()
  (let* ((prefix-key "C-x C-o"))
    (labels ((org-kbd (key) (read-kbd-macro (format "%s %s" prefix-key key))))
      (global-unset-key (read-kbd-macro prefix-key))
      (global-set-key (org-kbd "l") #'org-store-link)
      (global-set-key (org-kbd "a") #'org-agenda)
      (global-set-key (org-kbd "b") #'org-iswitchb))))

(defun mk/org-modules ()
  (dolist (module '(org-mac-messages
                    org-mac-protocol
                    org-mac-iCal
                    org-man))
    (add-to-list 'org-modules module 'append)))

(defun mk/install-org ()
  (require 'calendar)
  (setq org-replace-disputed-keys t
        org-completion-use-ido t
        org-startup-folded 'content)
  (mk/org-keys)
  (mk/org-remember)
  (add-hook 'org-mode-hook 'yas/fix-trigger-key))

(defun mk/setup-org ()
  (setq org-directory (file-name-as-directory org-directory))
  (setq org-default-notes-file (concat org-directory "notes.org")))

(when (require 'org-install nil 'noerror)
  (mk/install-org)
  (mk/org-modules))

(eval-after-load 'org
  '(mk/setup-org))

(defadvice org-publish-projects
  (around org-publish-disable-flymake activate)
  "Disable `flymake' while publishing `org-mode' files."
  (let ((flymake-allowed-file-name-masks))
    ad-do-it))

(add-to-list 'auto-mode-alist `(,(rx ".org" eos) . org-mode))
