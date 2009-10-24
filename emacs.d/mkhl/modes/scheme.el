
;; scheme-program
(setq scheme-program-name "gsi -:d-")

;; gambit
(when (locate-library "gambit")
  (autoload 'gambit-inferior-mode "gambit" "Hook Gambit mode into cmuscheme.")
  (autoload 'gambit-mode "gambit" "Hook Gambit mode into scheme.")
  (add-hook 'inferior-scheme-mode-hook 'gambit-inferior-mode)
  (add-hook 'scheme-mode-hook 'gambit-mode))

;; scheme-complete
(when (locate-library "scheme-complete")
  (autoload 'scheme-complete-or-indent "scheme-complete" nil t)
  (autoload 'scheme-smart-indent-function "scheme-complete" nil t)
  (autoload 'scheme-get-current-symbol-info "scheme-complete" nil t))

;; scheme-mode
(eval-after-load 'scheme
  '(progn
     (defun mk/scheme-mode-hook ()
       (set (make-local-variable 'lisp-indent-function)
            'scheme-smart-indent-function)
       (set (make-local-variable 'eldoc-documentation-function)
            'scheme-get-current-symbol-info)
       (turn-on-eldoc-mode))
     (when (fboundp 'scheme-complete-or-indent)
       (define-key scheme-mode-map [(tab)] 'scheme-complete-or-indent))
     (define-key scheme-mode-map [(meta \()] 'insert-parentheses)
     (define-key scheme-mode-map [(meta \))] 'move-past-close-and-reindent)
     (add-hook 'scheme-mode-hook 'mk/scheme-mode-hook)))
