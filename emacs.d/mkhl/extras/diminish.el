
(when (fboundp 'diminish)
  (let* ((mode-specs '((eldoc-mode (eldoc))
                       (abbrev-mode (abbrev))
                       (paredit-mode (paredit paredit-21))
                       (ruby-electric-mode (ruby-electric))
                       (highlight-80+-mode (highlight-80+))
                       (highlight-parentheses-mode (highlight-parentheses))
                       (highlight-symbol-mode (highlight-symbol))
                       (smart-tab-mode (smart-tab))
                       (yas/minor-mode (yasnippet yasnippet-bundle)))))
    (dolist* ((mode sources) mode-specs)
      (dolist (from sources)
        (eval-after-load from
          `(diminish ',mode))))))
