
(defun mk/applescript-mode-hook ()
  (setq indent-tabs-mode t)
  (set-indent-to-tab-stops)
  (define-tab-width 4)
  (c-subword-mode t))

(defun mk/setup-applescript-mode ()
  (add-hook 'applescript-mode-hook 'mk/applescript-mode-hook))

(eval-after-load 'applescript-mode
  '(mk/setup-applescript-mode))
