
(defmacro define-flymake-init-function (name args &rest body)
  "Define a `flymake-*-init' function.
\nThe generated function will create a temporary file containing
a copy of the current buffer, bind its relative name to VAR, and
then evaluate BODY.  The result should be a list
\(COMMAND (COMMAND-ARGS ...)) to be executed by flymake.
\n(fn NAME (VAR) BODY...)"
  (declare (indent 2))
  (destructuring-bind (var) args
    (let* ((temp-file (gensym)))
      `(defun ,name ()
         (let* ((,temp-file (flymake-init-create-temp-buffer-copy
                             'flymake-create-temp-inplace))
                (,var (file-relative-name
                       ,temp-file
                       (file-name-directory buffer-file-name))))
           ,@body)))))

(define-flymake-init-function flymake-python-init (local-file)
  `("pyflakes" (,local-file)))

(define-flymake-init-function flymake-ruby-init (local-file)
  `("ruby" ("-wc" ,local-file)))

(setq flymake-allowed-mode-alist '((python-mode . flymake-python-init)
                                   (ruby-mode . flymake-ruby-init)))

(defun mk/flymake-allow-modes ()
  (dolist (mode-pair flymake-allowed-mode-alist)
    (destructuring-bind (mode . func) mode-pair
      (dolist (auto-pair (remove* mode auto-mode-alist :test-not 'eq :key 'cdr))
        (destructuring-bind (regexp . ignored) auto-pair
          (pushnew (list regexp func) flymake-allowed-file-name-masks))))))

(defun mk/eval-after-flymake ()
  (mk/flymake-allow-modes)
  (add-hook 'find-file-hook 'flymake-find-file-hook))

(eval-after-load 'flymake
  '(mk/eval-after-flymake))
