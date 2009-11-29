
(defun mk/after-init-color-theme ()
  (dolist (theme '(color-theme-quiet-light
                   color-theme-gtk-ide))
    (when (fboundp theme)
      (funcall theme)
      (return))))

(when (load "color-theme-autoloads" 'noerror)
  (color-theme-initialize)
  (eval-after-init
    (mk/after-init-color-theme)))
