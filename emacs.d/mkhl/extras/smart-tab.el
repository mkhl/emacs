
(when (require 'smart-tab nil 'noerror)
  (global-smart-tab-mode t))

(defun mk/setup-smart-tab-org ()
  (defadvice smart-tab-default (around smart-tab-use-org-cycle activate)
    "In `org-mode', use `org-cycle' instead of indenting."
    (case major-mode
      ('org-mode (org-cycle current-prefix-arg))
      (otherwise ad-do-it))))

(defun mk/setup-smart-tab-eshell ()
  (pushnew '(eshell-mode . pcomplete)
           smart-tab-completion-functions-alist))

(defun mk/setup-smart-tab-shell ()
  (pushnew '(shell-mode . comint-dynamic-complete)
           smart-tab-completion-functions-alist))

(defun mk/setup-smart-tab-emacs-lisp ()
  (dolist (spec '((emacs-lisp-mode . lisp-complete-symbol)
                  (lisp-interaction-mode . lisp-complete-symbol)))
    (pushnew spec smart-tab-completion-functions-alist)))

(defun mk/setup-smart-tab-scheme-complete ()
  (when (fboundp 'scheme-smart-complete)
    (pushnew '(scheme-mode . scheme-smart-complete)
             smart-tab-completion-functions-alist)))

(defun mk/eval-after-smart-tab ()
  (setq smart-tab-using-hippie-expand t)
  (mk/setup-smart-tab-org)
  (mk/setup-smart-tab-eshell)
  (mk/setup-smart-tab-shell)
  (mk/setup-smart-tab-emacs-lisp)
  (mk/setup-smart-tab-scheme-complete))

(eval-after-load 'smart-tab
  '(mk/eval-after-smart-tab))