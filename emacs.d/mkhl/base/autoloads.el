
(defadvice update-file-autoloads (around generate-local-autoloads activate)
  "Generate autoloads in a file called `autoloads' in FILE's directory."
  (let* ((dir (file-name-as-directory (file-name-directory (ad-get-arg 0))))
         (generated-autoload-file (concat dir "autoloads.el")))
    ad-do-it))
