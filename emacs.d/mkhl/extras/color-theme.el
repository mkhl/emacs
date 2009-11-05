
(when (require 'color-theme nil 'noerror)
  (color-theme-initialize)
  (eval-after-init
    (dolist (theme '(color-theme-quiet-light
                     color-theme-espresso
                     color-theme-gtk-ide))
      (when (fboundp theme)
        (funcall theme)
        (return)))))
