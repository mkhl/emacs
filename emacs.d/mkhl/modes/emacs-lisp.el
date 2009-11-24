
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
  (find-function-setup-keys))

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
