
(defun mk/applescript-mode-hook ()
  (setq indent-tabs-mode t)
  (set-indent-to-tab-stops)
  (define-tab-width 4))

(defun mk/eval-after-applescript-mode ()
  (add-hook 'applescript-mode-hook 'mk/applescript-mode-hook))

(eval-after-load 'applescript-mode
  '(mk/eval-after-applescript-mode))
