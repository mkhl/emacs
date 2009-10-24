
(when (require 'redo nil 'noerror)
  (global-set-key [(meta z)] 'undo)
  (global-set-key [(meta Z)] 'redo)
  (global-set-key [(control z)] 'zap-to-char))
