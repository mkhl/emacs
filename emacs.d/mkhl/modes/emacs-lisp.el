
(eval-after-load "lisp-mode"
  '(progn
     (dolist (mode-map (list emacs-lisp-mode-map
                             lisp-interaction-mode-map
                             lisp-mode-map))
       (define-key mode-map [(meta \()] 'insert-parentheses)
       (define-key mode-map [(meta \))] 'move-past-close-and-reindent))
     (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
     (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)))
