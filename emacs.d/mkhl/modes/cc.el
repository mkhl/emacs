
(eval-after-load "cc-mode"
  '(progn
     (defun mk/c-mode-common-hook ()
       (setq c-basic-offset 4)
       (c-toggle-syntactic-indentation 1)
       (c-toggle-hungry-state 1)
       (c-toggle-electric-state 1)
       (c-toggle-auto-newline 1))
     (setq-default c-basic-offset 4)
     (setq c-default-style '((java-mode . "java")
                             (awk-mode . "awk")
                             (other . "bsd")))
     (when (fboundp 'google-set-c-style)
       (add-hook 'c-mode-common-hook 'google-set-c-style))
     (add-hook 'c-mode-common-hook 'mk/c-mode-common-hook)))
