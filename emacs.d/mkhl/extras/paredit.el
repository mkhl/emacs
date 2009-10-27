
(when (fboundp 'paredit-mode)
  (unless (fboundp 'enable-paredit-mode)
    (defun enable-paredit-mode () (paredit-mode 1)))
  (dolist (hook '(emacs-lisp-mode-hook
                  lisp-interaction-mode-hook
                  lisp-mode-hook
                  scheme-mode-hook))
    (add-hook hook 'enable-paredit-mode)))

(eval-after-load 'paredit
  '(progn
     (dolist (key '("M-<up>" "ESC <up>"
                    "M-<down>" "ESC <down>"
                    "C-<right>"
                    "C-<left>"
                    "C-M-<left>" "ESC C-<left>"
                    "C-M-<right>" "ESC C-<right>"))
       (define-key paredit-mode-map (read-kbd-macro key) nil))))
