
(setq-default c-basic-offset 4)
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "bsd")))

(defun mk/c-mode-common-hook ()
  (c-toggle-syntactic-indentation 1)
  (c-toggle-hungry-state 1)
  (c-toggle-electric-state 1)
  (c-toggle-auto-newline 1))

(defun mk/eval-after-cc-mode ()
  (add-hook 'c-mode-common-hook 'mk/c-mode-common-hook)
  (when (fboundp 'google-set-c-style)
    (add-hook 'c-mode-common-hook 'google-set-c-style 'append)))

(eval-after-load 'cc-mode
  '(mk/eval-after-cc-mode))
