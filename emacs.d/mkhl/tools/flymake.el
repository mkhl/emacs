
;;; `flymake' allowed modes

(defun flymake-python-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-inplace t t
   (file-name-nondirectory buffer-file-name)
   (lambda (source base-dir)
     `("pyflakes" (,source)))))

(defun flymake-ruby-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-inplace t t
   (file-name-nondirectory buffer-file-name)
   (lambda (source base-dir)
     `("ruby" ("-wc" ,source)))))

(defun flymake-js-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-inplace t t
   (file-name-nondirectory buffer-file-name)
   (lambda (source base-dir)
     `("js" ("-s" ,source)))))

(setq flymake-allowed-mode-alist
      '((python-mode . flymake-python-init)
        (ruby-mode . flymake-ruby-init)
        (espresso-mode . flymake-js-init)))

(defun mk/flymake-allow-modes ()
  (dolist* ((mode . func) flymake-allowed-mode-alist)
    (dolist* ((regexp . ignored)
              (remove* mode auto-mode-alist :test-not 'eq :key 'cdr))
      (pushnew (list regexp func) flymake-allowed-file-name-masks))))

;;; `flymake' compatible `next-error' replacements

(defun mk/setup-flymake-error-bindings ()
  (defun mk/navigate-errors (compile-func flymake-func)
    (if (condition-case nil (next-error-find-buffer) (error nil))
        (call-interactively compile-func)
      (call-interactively flymake-func)
      (let ((err (get-char-property (point) 'help-echo)))
        (when err (message err)))))
  (defun mk/next-error ()
    (interactive)
    (mk/navigate-errors 'next-error 'flymake-goto-next-error))
  (defun mk/previous-error ()
    (interactive)
    (mk/navigate-errors 'previous-error 'flymake-goto-prev-error))
  (global-set-key [remap next-error] #'mk/next-error)
  (global-set-key [remap previous-error] #'mk/previous-error))

;;; `flymake' configuration

(defun mk/setup-flymake ()
  ;; Override the broken default `flymake-xml-init'
  (defun flymake-xml-init ()
    (list "xmllint" (list "--valid" (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))))
  (mk/flymake-allow-modes)
  (mk/setup-flymake-error-bindings))

(when (require 'flymake nil 'noerror)
  (mk/setup-flymake))
