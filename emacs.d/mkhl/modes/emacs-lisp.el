
(defun mk/emacs-lisp-keys ()
  (dolist (mode-map (list emacs-lisp-mode-map
                          lisp-interaction-mode-map))
    (mk/any-lisp-setup-keys mode-map)
    (define-key mode-map (kbd "M-.") #'find-function-at-point)
    (define-key mode-map (kbd "M-,") #'find-variable-at-point)
    (define-key mode-map (kbd "<C-tab>") #'lisp-complete-symbol))
  (find-function-setup-keys))

(defun mk/setup-emacs-lisp-mode ()
  (mk/emacs-lisp-keys)
  (add-hook 'emacs-lisp-mode-hook 'mk/any-lisp-mode-hook)
  (add-hook 'lisp-interaction-mode-hook 'mk/any-lisp-mode-hook))

(eval-after-load 'lisp-mode
  '(mk/setup-emacs-lisp-mode))
