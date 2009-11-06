
(defadvice kill-line (around kill-or-join-line activate)
  "At EOL, `delete-indentation', otherwise `kill-line'."
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    ad-do-it))

(defun kill-emacs-with-timeout (prompt)
  (let* ((message "will exit automatically in 5 seconds")
         (prompt (format "%s(%s) " prompt message)))
    (y-or-n-p-with-timeout prompt 5 t)))

(setq confirm-kill-emacs 'kill-emacs-with-timeout)
