
(defun mk/emacs-lisp-mode-hook ()
  (turn-on-eldoc-mode)
  (when (fboundp 'highlight-parentheses-mode)
    (highlight-parentheses-mode t)))

(defun mk/lisp-interaction-keys ()
  (define-key lisp-interaction-mode-map (kbd "C-S-j") 'eval-print-last-sexp))

(defun mk/emacs-lisp-keys ()
  (dolist (mode-map (list emacs-lisp-mode-map
                          lisp-interaction-mode-map))
    (define-key mode-map (kbd "M-.") #'find-function-at-point)
    (define-key mode-map (kbd "C-x F") #'find-function)
    (define-key mode-map (kbd "C-x K") #'find-function-on-key)
    (define-key mode-map (kbd "C-x L") #'find-library)
    (define-key mode-map (kbd "C-x V") #'find-variable)))

(defun mk/lisp-keys ()
  (dolist (mode-map (list emacs-lisp-mode-map
                          lisp-interaction-mode-map
                          lisp-mode-map))
    (define-key mode-map (kbd "M-(") 'insert-parentheses)
    (define-key mode-map (kbd "M-)") 'move-past-close-and-reindent)
    (define-key mode-map (kbd "<C-tab>") 'lisp-complete-symbol)))

(defun mk/setup-lisp-mode ()
  (mk/lisp-keys)
  (mk/emacs-lisp-keys)
  (mk/lisp-interaction-keys)
  (add-hook 'emacs-lisp-mode-hook 'mk/emacs-lisp-mode-hook)
  (add-hook 'lisp-interaction-mode-hook 'mk/emacs-lisp-mode-hook))

(eval-after-load 'lisp-mode
  '(mk/setup-lisp-mode))
