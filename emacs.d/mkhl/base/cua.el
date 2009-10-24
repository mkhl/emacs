
(defvar extended-command-command 'execute-extended-command
  "Command to run extended commands with.")

(defun kill-region-or-meta-x ()
  "Kill the region, if active, otherwise run `extended-command-command'."
  (interactive)
  (if (and mark-active transient-mark-mode)
      (call-interactively 'kill-region)
    (call-interactively extended-command-command)))

(global-set-key [(meta x)] 'kill-region-or-meta-x)
(global-set-key [(meta c)] 'copy-region-as-kill)
(global-set-key [(meta v)] 'yank)
(global-set-key [(meta V)] 'yank-pop)

(setq cua-highlight-region-shift-only t)
(cua-selection-mode t)
