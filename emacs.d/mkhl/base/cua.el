
(defvar extended-command-command 'execute-extended-command
  "Command to run extended commands with.")

(defun kill-region-or-meta-x ()
  "Kill the region, if active, otherwise run `extended-command-command'."
  (interactive)
  (if (region-active-p)
      (call-interactively 'kill-region)
    (call-interactively extended-command-command)))

(global-set-key (kbd "M-x") 'kill-region-or-meta-x)
(global-set-key (kbd "M-c") 'copy-region-as-kill)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-V") 'yank-pop)

(setq cua-highlight-region-shift-only nil)
(cua-selection-mode t)
