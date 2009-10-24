
;; Fix info path for Carbon Emacs
(when (featurep 'carbon-emacs-package)
  (let* ((emacs-prefix (file-name-as-directory carbon-emacs-package-prefix))
         (emacs-info-directory (concat emacs-prefix "info")))
    (add-to-list 'Info-directory-list emacs-info-directory)))
