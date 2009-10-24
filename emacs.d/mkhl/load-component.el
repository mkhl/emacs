
;; Load elisp from the directory named like this file
(let* ((file-name (or (buffer-file-name) load-file-name))
       (elisp-dir (file-name-as-directory (file-name-sans-extension file-name)))
       (elisp (rx ".el" eos)))
  (dolist (file (directory-files elisp-dir 'full elisp))
    (load file)))
