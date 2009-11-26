
;;; `comint'

(defun mk/setup-comint ()
  (setq comint-prompt-read-only t)
  (add-hook 'comint-mode-hook 'ansi-color-for-comint-mode-on))

(eval-after-load 'comint
  '(mk/setup-comint))

;;; `shell'

(defun mk/setup-shell ()
  (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on))

(eval-after-load 'shell
  '(mk/setup-shell))

;;; `shell-current-directory'

(when (fboundp 'shell-current-directory)
  (global-set-key (kbd "C-x C-l") 'shell-current-directory))
