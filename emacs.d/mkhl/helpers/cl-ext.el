
(defmacro* with-gensyms ((&rest names) &body body)
  "Evaluate BODY with each NAME bound to a `gensym'.

\(fn (NAME ...) BODY...)"
  (declare (indent 1))
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro* dolist* ((args list &optional result) &body body)
  "Loop over a list.

Like normal `dolist', except ARGS allows full Common Lisp conventions.

\(fn (ARGS LIST [RESULT]) BODY...)"
  (declare (indent 1))
  (with-gensyms (loop-var)
    `(dolist (,loop-var ,list ,result)
       (destructuring-bind ,args ,loop-var
         ,@body))))
