
(defadvice save-buffers-kill-terminal
  (around server-done-or-kill-terminal activate)
  "If the current buffer has clients, kill those instead."
  (unless (server-done)
    ad-do-it))

(defadvice server-edit
  (around server-edit-or-bury-buffer activate)
  "If no server editing buffers exist, call `bury-buffer' instead."
  (when ad-do-it
    (bury-buffer)))

(global-set-key (kbd "C-x C-=") #'server-edit)
(global-set-key (kbd "C-x C-#") #'server-edit)

(server-start)
