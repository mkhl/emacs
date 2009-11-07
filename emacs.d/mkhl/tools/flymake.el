
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
  (dolist (mode-pair flymake-allowed-mode-alist)
    (destructuring-bind (mode . func) mode-pair
      (dolist (auto-pair (remove* mode auto-mode-alist :test-not 'eq :key 'cdr))
        (destructuring-bind (regexp . ignored) auto-pair
          (pushnew (list regexp func) flymake-allowed-file-name-masks))))))

;;; `flymake' configuration

(defun mk/eval-after-flymake ()
  (mk/flymake-allow-modes)
  (add-hook 'find-file-hook 'flymake-find-file-hook))

(when (require 'flymake nil 'noerror)
  (mk/eval-after-flymake))
