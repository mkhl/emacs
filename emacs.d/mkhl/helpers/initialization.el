
(defmacro eval-after-init (&rest body)
  "Arrange that BODY will be run in `after-init-hook'."
  (declare (indent 0))
  `(add-hook 'after-init-hook
             (lambda () ,@body)))
