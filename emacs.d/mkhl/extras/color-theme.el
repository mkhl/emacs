
(defun mk/after-init-color-theme ()
  (dolist (theme '(color-theme-quiet-light
                   color-theme-espresso
                   color-theme-gtk-ide))
    (when (fboundp theme)
      (funcall theme)
      (return))))

(when (require 'color-theme nil 'noerror)
  (color-theme-initialize)
  (eval-after-init
    (mk/after-init-color-theme)))
