
(defun mk/setup-clojure-mode ()
  (mk/any-lisp-setup-keys clojure-mode-map)
  (add-hook 'clojure-mode-hook 'mk/any-lisp-mode-hook))

(eval-after-load 'clojure-mode
  '(mk/setup-clojure-mode))

