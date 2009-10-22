;; Make sure `Info-additional-directory-list' is available
(require 'info)

(let* ((vendor-dir (file-name-as-directory (concat dot-emacs-dir "vendor")))
       (non-hidden (rx bos (not (in ".")))))
  (dolist (this-path (directory-files vendor-dir 'full non-hidden))
    (let* ((that-path (file-name-as-directory this-path))
           (info-path (concat that-path "doc"))
           (autoloads (concat that-path "autoloads")))
      (add-to-list 'load-path this-path)
      (load autoloads 'noerror 'nomessage)
      (when (file-exists-p info-path)
        (add-to-list 'Info-additional-directory-list info-path)))))
