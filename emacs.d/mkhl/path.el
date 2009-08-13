
;; Load path components from /etc/paths.d/*
(let ((files (directory-files "/etc/paths.d" 'full (rx bos (not (in "."))))))
  (dolist (this-path (split-string
                      (with-temp-buffer
                        (dolist (this-file files)
                          (insert-file-contents this-file))
                        (buffer-string))))
    (add-to-list 'exec-path this-path)))

(setenv "PATH" (mapconcat 'identity exec-path path-separator))
