
(defun load-component (component)
  "Load elisp sources from COMPONENT."
  (let* ((elisp-src (concat dot-emacs-dir component))
         (elisp-dir (file-name-as-directory elisp-src))
         (elisp-rx (rx ".el" eos)))
    (dolist (file (directory-files elisp-dir 'full elisp-rx))
      (load (file-name-sans-extension file) nil 'nomessage))))
