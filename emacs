(require 'cl)

;; Load implementation specific init-file
(labels
    ((mkhl-load (file)
       (load (file-name-sans-extension file) 'noerror 'nomessage))
     (mkhl-format-dir (dir)
       (expand-file-name (file-name-as-directory (format "~/.%s" dir))))
     (mkhl-init (dir)
       (lexical-let* ((init-dir (mkhl-format-dir dir))
                      (init (concat init-dir "init.el"))
                      (custom (concat init-dir "custom.el")))
         (setq user-init-file init)
         (setq custom-file custom)
         (mkhl-load user-init-file)
         (mkhl-load custom-file))))
  (cond ((featurep 'sxemacs)            ; SXEmacs
         (mkhl-init 'sxemacs))
        ((or (featurep 'xemacs)         ; XEmacs
             (string-match "XEmacs\\|Lucid" emacs-version))
         (mkhl-init 'xemacs))
        ((featurep 'emacs)              ; GNU Emacs
         (mkhl-init 'emacs.d))))
