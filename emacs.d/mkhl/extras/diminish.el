
(when (fboundp 'diminish)
  (let* ((mode-specs '((eldoc-mode (eldoc))
                       (paredit-mode (paredit paredit-21))
                       (ruby-electric-mode (ruby-electric))
                       (smart-tab-mode (smart-tab))
                       (yas/minor-mode (yasnippet yasnippet-bundle)))))
    (dolist* ((mode sources) mode-specs)
      (dolist (from sources)
        (eval-after-load from
          `(diminish ',mode))))))
