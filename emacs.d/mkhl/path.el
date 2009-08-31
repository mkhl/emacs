
;; Load path components from environment.plist
(let* ((read-command "defaults read $HOME/.MacOSX/environment PATH")
       (path-value (shell-command-to-string read-command)))
  (when (string-match (rx (0+ (any ?\r ?\n)) eos) path-value)
    (setq path-value (replace-match "" 'fixed 'literal path-value)))
  (setenv "PATH" path-value))
