
;; Load path components from `environment.plist'
(case system-type
  ('darwin
   (let* ((defaults "/usr/bin/defaults")
          (environment (expand-file-name "~/.MacOSX/environment"))
          (read-command (format "%s read '%s' PATH" defaults environment))
          (path-value (chomp (shell-command-to-string read-command))))
     (setenv "PATH" path-value)
     (setq exec-path (split-string path-value path-separator)))))
