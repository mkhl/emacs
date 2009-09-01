
;; Load path components from environment.plist
(let* ((read-command "defaults read $HOME/.MacOSX/environment PATH")
       (path-value (shell-command-to-string read-command)))
  (when (string-match (rx (0+ (any ?\r ?\n)) eos) path-value)
    (setq path-value (replace-match "" 'fixed 'literal path-value)))
  (setenv "PATH" path-value)
  (setq exec-path (split-string path-value path-separator)))

;; Info path fix for Carbon Emacs
(when (featurep 'carbon-emacs-package)
  (let* ((carbon-emacs-info-directory
          (concat (file-name-as-directory carbon-emacs-package-prefix) "info")))
    (add-to-list 'Info-directory-list carbon-emacs-info-directory)))
