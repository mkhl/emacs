
;; HyperSpec
(let* ((local-hyperspec-root "/opt/HyperSpec/"))
  (when (file-exists-p local-hyperspec-root)
    (setq common-lisp-hyperspec-root local-hyperspec-root)))

;; lisp-program
(setq inferior-lisp-acl-program "/Applications/Developer/AllegroCL/alisp"
      inferior-lisp-ccl-program "/opt/ccl/scripts/ccl64 -K utf-8"
      inferior-lisp-sbcl-program "/opt/local/bin/sbcl")
(setq inferior-lisp-program inferior-lisp-ccl-program)

;; slime autoloads
(require 'slime-autoloads nil 'noerror)

;; slime
(eval-after-load "slime"
  '(progn
     (setq slime-net-coding-system 'utf-8-unix)
     (dolist (pair `((sbcl ,inferior-lisp-sbcl-program)
                     (acl ,inferior-lisp-acl-program)
                     (ccl ,inferior-lisp-ccl-program)))
       (destructuring-bind (sym spec) pair
         (add-to-list 'slime-lisp-implementations
                      `(,sym ,(split-string spec)))))
     (slime-setup '(slime-fancy))))
