
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

(defun mk/scheme-keys ()
  (when (fboundp 'scheme-complete-or-indent)
    (define-key scheme-mode-map (kbd "TAB") 'scheme-complete-or-indent))
  (define-key scheme-mode-map (kbd "M-(") 'insert-parentheses)
  (define-key scheme-mode-map (kbd "M-)") 'move-past-close-and-reindent))

(defun mk/setup-scheme ()
  (mk/scheme-keys)
  (add-hook 'scheme-mode-hook 'mk/scheme-mode-hook))

(eval-after-load 'scheme
  '(mk/setup-scheme))
