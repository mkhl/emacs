
(defadvice update-file-autoloads (around generate-local-autoloads activate)
  "Generate autoloads in a file called `autoloads' in FILE's directory."
  (let* ((local-directory (file-name-as-directory
                           (file-name-directory
                            (file-truename (ad-get-arg 0)))))
         (local-autoload-file (concat local-directory "autoloads.el"))
         (use-local-autoload-file (or (null generated-autoload-file)
                                      (not (file-name-absolute-p
                                            generated-autoload-file))))
         (generated-autoload-file (if use-local-autoload-file
                                      local-autoload-file
                                    generated-autoload-file)))
    ad-do-it))
