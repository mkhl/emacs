
(defadvice update-file-autoloads (around generate-local-autoloads activate)
  "Generate autoloads in a file called `autoloads' in FILE's directory."
  (let* ((dir (file-name-as-directory
               (file-name-directory
                (file-truename (ad-get-arg 0)))))
         (generated-autoload-file (if (null generated-autoload-file)
                                      (concat dir "autoloads.el")
                                    generated-autoload-file)))
    ad-do-it))
