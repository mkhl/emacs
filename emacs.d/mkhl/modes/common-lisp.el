
;; HyperSpec
(let* ((local-hyperspec-root "/opt/HyperSpec/"))
  (when (file-exists-p local-hyperspec-root)
    (setq common-lisp-hyperspec-root local-hyperspec-root)))

;; lisp-program
(setq inferior-lisp-acl-program "/Applications/Developer/AllegroCL/alisp"
      inferior-lisp-ccl-program "/opt/ccl/scripts/ccl64 -K utf-8"
      inferior-lisp-sbcl-program "/opt/local/bin/sbcl")
(setq inferior-lisp-program inferior-lisp-ccl-program)

;; slime
(require 'slime-autoloads nil 'noerror)
(eval-after-load "slime"
  '(progn
     (setq slime-net-coding-system 'utf-8-unix)
     (add-to-list 'slime-lisp-implementations
                  `(acl (,inferior-lisp-acl-program)) 'append)
     (add-to-list 'slime-lisp-implementations
                  `(ccl (,inferior-lisp-ccl-program)) 'append)
     (add-to-list 'slime-lisp-implementations
                  `(sbcl (,inferior-lisp-sbcl-program)) 'append)
     (slime-setup '(slime-fancy))))
