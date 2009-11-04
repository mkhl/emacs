
;; scheme-program
(setq inferior-scheme-gsi-program "gsi -:d-"
      inferior-scheme-csi-program "csi"
      inferior-scheme-guile-program "guile"
      inferior-scheme-scsh-program "scsh")
(setq scheme-program-name inferior-scheme-gsi-program)

;; gambit
(when (locate-library "gambit")
  (eval-after-load 'scheme
    '(add-hook 'scheme-mode-hook 'gambit-mode))
  (eval-after-load 'cmuscheme
    '(add-hook 'inferior-scheme-mode-hook 'gambit-inferior-mode)))

;; scheme-mode
(defun mk/scheme-mode-hook ()
  (set (make-local-variable 'lisp-indent-function)
       'scheme-smart-indent-function)
  (set (make-local-variable 'eldoc-documentation-function)
       'scheme-get-current-symbol-info)
  (turn-on-eldoc-mode))

(defun mk/eval-after-scheme ()
  (when (fboundp 'scheme-complete-or-indent)
    (define-key scheme-mode-map [(tab)] 'scheme-complete-or-indent))
  (define-key scheme-mode-map [(meta \()] 'insert-parentheses)
  (define-key scheme-mode-map [(meta \))] 'move-past-close-and-reindent)
  (add-hook 'scheme-mode-hook 'mk/scheme-mode-hook))

(eval-after-load 'scheme
  '(mk/eval-after-scheme))
