
(when (require 'redo nil 'noerror)
  (global-set-key (kbd "M-z") 'undo)
  (global-set-key (kbd "M-Z") 'redo)
  (global-set-key (kbd "C-z") 'zap-to-char))
