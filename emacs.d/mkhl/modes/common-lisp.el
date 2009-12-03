
;; HyperSpec
(let* ((local-hyperspec-root "/opt/HyperSpec/"))
  (when (file-exists-p local-hyperspec-root)
    (setq common-lisp-hyperspec-root local-hyperspec-root)))

;; lisp-program
(setq inferior-lisp-acl-program "/Applications/Developer/AllegroCL/alisp"
      inferior-lisp-ccl-program "/opt/ccl/scripts/ccl64 -K utf-8"
      inferior-lisp-sbcl-program "/opt/local/bin/sbcl"
      inferior-lisp-clisp-program "/opt/local/bin/clisp")
(setq inferior-lisp-program inferior-lisp-ccl-program)

;; slime autoloads
(require 'slime-autoloads nil 'noerror)

;; slime
(setq slime-net-coding-system 'utf-8-unix)

(defun mk/slime-implementations ()
  (setq slime-default-lisp 'ccl)
  (dolist* ((sym spec) `((clisp ,inferior-lisp-clisp-program)
                         (sbcl ,inferior-lisp-sbcl-program)
                         (acl ,inferior-lisp-acl-program)
                         (ccl ,inferior-lisp-ccl-program)))
    (add-to-list 'slime-lisp-implementations
                 (list sym (split-string spec)))))

(defun mk/setup-slime ()
  (mk/slime-implementations)
  (slime-setup '(slime-fancy)))

(eval-after-load 'slime
  '(mk/setup-slime))
