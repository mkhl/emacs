

(defun restart ()
  "Kill all unmodified buffers except for `shell', `eshell' and `org-agenda'."
  (interactive)
  (let* ((kept-buffers '("*shell*" "*eshell*" "*Org Agenda*")))
    (dolist (buffer (buffer-list))
      (unless (or (member (buffer-name buffer) kept-buffers)
                  (and (buffer-file-name buffer)
                       (buffer-modified-p buffer)))
        (kill-buffer buffer)))))
