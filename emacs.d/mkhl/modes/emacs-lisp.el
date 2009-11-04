
(defun mk/emacs-lisp-mode-hook ()
  (turn-on-eldoc-mode)
  (when (fboundp 'highlight-parentheses-mode)
    (highlight-parentheses-mode t)))

(defun mk/eval-after-lisp-mode ()
  (dolist (mode-map (list emacs-lisp-mode-map
                          lisp-interaction-mode-map
                          lisp-mode-map))
    (define-key mode-map (kbd "M-(") 'insert-parentheses)
    (define-key mode-map (kbd "M-)") 'move-past-close-and-reindent))
  (add-hook 'emacs-lisp-mode-hook 'mk/emacs-lisp-mode-hook)
  (add-hook 'lisp-interaction-mode-hook 'mk/emacs-lisp-mode-hook))

(eval-after-load 'lisp-mode
  '(mk/eval-after-lisp-mode))

(global-set-key (kbd "C-x F") 'find-function)
(global-set-key (kbd "C-x V") 'find-variable)
