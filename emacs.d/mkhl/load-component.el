
(defun load-component (component)
  "Load elisp sources from COMPONENT."
  (let* ((elisp-dir (file-name-as-directory (concat dot-emacs-dir component)))
         (elisp (rx ".el" eos)))
    (dolist (file (directory-files elisp-dir 'full elisp))
      (load file))))
