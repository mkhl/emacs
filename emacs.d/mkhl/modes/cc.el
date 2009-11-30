
(defun mk/c-mode-common-hook ()
  (c-toggle-syntactic-indentation 1)
  (c-toggle-hungry-state 1)
  (c-toggle-electric-state 1)
  (c-toggle-auto-newline 1)
  (c-subword-mode t))

(defun mk/google-c-style ()
  (when (require 'google-c-style nil 'noerror)
    (c-add-style "Google" google-c-style)
    (add-to-list 'c-default-style '(objc-mode . "Google"))))

(defun mk/setup-cc-mode ()
  (setq-default c-basic-offset 4)
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "bsd")))
  (mk/google-c-style)
  (add-hook 'c-mode-common-hook 'mk/c-mode-common-hook))

(eval-after-load 'cc-mode
  '(mk/setup-cc-mode))
