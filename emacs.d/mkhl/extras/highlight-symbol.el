
(when (locate-library "highlight-symbol")
  (setq highlight-symbol-on-navigation-p t)
  (global-set-key (kbd "C-*") 'highlight-symbol-next)
  (global-set-key (kbd "C-#") 'highlight-symbol-prev))
