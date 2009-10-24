
(when (require 'color-theme nil 'noerror)
  (color-theme-initialize)
  (eval-after-init
    (cond ((fboundp 'color-theme-quiet-light)
           (color-theme-quiet-light))
          ((fboundp 'color-theme-espresso)
           (color-theme-espresso))
          (t (color-theme-xemacs)
             (set-face-background 'default "#F5F5F5")))))
