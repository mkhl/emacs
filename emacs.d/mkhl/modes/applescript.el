
(eval-after-load "applescript-mode"
  '(progn
     (defun mk/applescript-mode-hook ()
       (setq indent-tabs-mode t)
       (set-indent-to-tab-stops)
       (define-tab-width 4))
     (add-hook 'applescript-mode-hook 'mk/applescript-mode-hook)))
