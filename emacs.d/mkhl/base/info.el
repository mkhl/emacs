
(let ((path (getenv "EMACS_INFOPATH")))
  (when path
    (setq Info-default-directory-list (split-string path path-separator))))
