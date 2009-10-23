
(defmacro eval-after-init (&rest body)
  "Arrange that, if `user-init-file' is ever loaded, BODY will be run
at that time.  If `user-init-file' is already loaded, evaluate BODY
right now."
  (declare (indent 0))
  `(eval-after-load user-init-file
     '(progn
        ,@body)))
