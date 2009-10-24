
(setq comint-prompt-read-only t)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-set-key [(control x) (control z)] 'shell-current-directory)
