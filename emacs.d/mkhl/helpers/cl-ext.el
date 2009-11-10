
(defmacro* with-gensyms ((&rest names) &body body)
  "Evaluate BODY with each NAME bound to a `gensym'.
\n(fn (NAME ...) BODY...)"
  (declare (indent 1))
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro* once-only ((&rest names) &body body)
  "Evaluate BODY with each NAME evaluated exactly once beforehand.
\n(fn (NAME ...) BODY...)"
  (declare (indent 1))
  (let ((gensyms (loop for n in names collect (gensym))))
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
       `(let (,,@(loop for g in gensyms for n in names collect ``(,,g ,,n)))
          ,(let (,@(loop for n in names for g in gensyms collect `(,n ,g)))
             ,@body)))))

(defmacro* dolist* ((args list &optional result) &body body)
  "Loop over a list.
\nLike normal `dolist', except ARGS allows full Common Lisp conventions.
\n(fn (ARGS LIST [RESULT]) BODY...)"
  (declare (indent 1))
  (with-gensyms (loop-var)
    `(dolist (,loop-var ,list ,result)
       (destructuring-bind ,args ,loop-var
         ,@body))))
