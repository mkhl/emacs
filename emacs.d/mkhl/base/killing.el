
(defadvice kill-line (around kill-or-join-line activate)
  "At EOL, `delete-indentation', otherwise `kill-line'."
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    ad-do-it))
