
(when (require 'smart-tab nil 'noerror)
  (global-smart-tab-mode t))

(defun mk/setup-smart-tab-eshell ()
  (pushnew '(eshell-mode . pcomplete)
           smart-tab-completion-functions-alist))

(defun mk/setup-smart-tab-shell ()
  (pushnew '(shell-mode . comint-dynamic-complete)
           smart-tab-completion-functions-alist))

(defun mk/setup-smart-tab-scheme-complete ()
  (when (fboundp 'scheme-smart-complete)
    (pushnew '(scheme-mode . scheme-smart-complete)
             smart-tab-completion-functions-alist)))

(defun mk/eval-after-smart-tab ()
  (setq smart-tab-using-hippie-expand t)
  (mk/setup-smart-tab-eshell)
  (mk/setup-smart-tab-shell)
  (mk/setup-smart-tab-scheme-complete))

(eval-after-load 'smart-tab
  '(mk/eval-after-smart-tab))
