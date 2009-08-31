
(let* ((vendor-dir (file-name-as-directory (concat dot-emacs-dir "vendor"))))
  (dolist (this-path (directory-files vendor-dir 'full (rx bos (not (in ".")))))
    (let* ((info-path (concat (file-name-as-directory this-path) "doc")))
      (add-to-list 'load-path this-path)
      (message info-path)
      (when (file-exists-p info-path)
        (add-to-list 'Info-additional-directory-list info-path)))))
