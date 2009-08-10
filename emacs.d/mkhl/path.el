
;; Load path components from /etc/paths.d/*
(labels ((add-to-exec-path (item) (add-to-list 'exec-path item 'append)))
  (let* ((buffer (with-temp-buffer
                   (map 'nil (lambda (file) (insert-file-contents file))
                        (directory-files "/etc/paths.d" 'full
                                         (rx (not (in ".")))))
                   (buffer-string))))
    (map 'nil 'add-to-exec-path (split-string buffer))))
(setenv "PATH" (mapconcat 'identity exec-path path-separator))
