
(defun mk/any-lisp-mode-hook ()
  (turn-on-eldoc-mode)
  (when (fboundp 'highlight-parentheses-mode)
    (highlight-parentheses-mode t)))

(defun mk/any-lisp-setup-keys (mode-map)
  (define-key mode-map (kbd "M-(") #'insert-parentheses)
  (define-key mode-map (kbd "M-)") #'move-past-close-and-reindent))
