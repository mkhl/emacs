
(when (require 'smart-tab nil 'noerror)
  (global-smart-tab-mode t))

(defun mk/setup-smart-tab-org ()
  (defadvice smart-tab-default (around smart-tab-use-org-cycle activate)
    "In `org-mode', use `org-cycle' instead of indenting."
    (case major-mode
      ('org-mode (org-cycle current-prefix-arg))
      (otherwise ad-do-it))))

(defun mk/setup-smart-tab-eshell ()
  (aput 'smart-tab-completion-functions-alist
        'eshell-mode #'pcomplete))

(defun mk/setup-smart-tab-shell ()
  (aput 'smart-tab-completion-functions-alist
        'shell-mode #'comint-dynamic-complete))

(defun mk/setup-smart-tab-emacs-lisp ()
  (dolist (mode '(emacs-lisp-mode lisp-interaction-mode))
    (aput 'smart-tab-completion-functions-alist
          mode #'lisp-complete-symbol)))

(defun mk/setup-smart-tab-scheme-complete ()
  (when (fboundp 'scheme-smart-complete)
    (aput 'smart-tab-completion-functions-alist
          'scheme-mode #'scheme-smart-complete)))

(defun mk/setup-smart-tab-slime ()
  (eval-after-load 'slime
    '(dolist (mode '(lisp-mode clojure-mode))
       (aput 'smart-tab-completion-functions-alist
             mode #'slime-complete-symbol))))

(defun mk/eval-after-smart-tab ()
  (setq smart-tab-using-hippie-expand t)
  (when (boundp 'smart-tab-completion-functions-alist)
   (mk/setup-smart-tab-org)
   (mk/setup-smart-tab-eshell)
   (mk/setup-smart-tab-shell)
   (mk/setup-smart-tab-emacs-lisp)
   (mk/setup-smart-tab-scheme-complete)
   (mk/setup-smart-tab-slime)))

(eval-after-load 'smart-tab
  '(mk/eval-after-smart-tab))
