
(setq delete-by-moving-to-trash t
      auto-save-default nil
      version-control t
      kept-new-versions 10
      kept-old-versions 2
      delete-old-versions t
      vc-follow-symlinks t
      backup-directory-alist `(("." . ,(concat dot-emacs-dir "backup"))))
