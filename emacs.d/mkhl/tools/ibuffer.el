
(setq ibuffer-default-sorting-mode 'alphabetic
      ibuffer-never-show-predicates `(,(rx bos "*Completions*" eos))
      ibuffer-show-empty-filter-groups nil)

(defun mk/ibuffer-mode-hook ()
  (ibuffer-switch-to-saved-filter-groups "mkhl"))

(defun mk/eval-after-ibuffer ()
  (define-key ibuffer-mode-map (kbd "TAB") 'ibuffer-toggle-filter-group)
  (add-hook 'ibuffer-mode-hook 'mk/ibuffer-mode-hook))

(eval-after-load 'ibuffer
  '(mk/eval-after-ibuffer))

(add-to-list 'ibuffer-saved-filter-groups
             `("mkhl"
               ("Emacs" (or (name . ,(rx bos "*scratch*" eos))
                            (name . ,(rx bos "*Messages*" eos))
                            (name . ,(rx bos "*Completions*" eos))
                            (name . ,(rx bos "*Help*" eos))
                            (name . ,(rx bos "*Apropos*" eos))
                            (name . ,(rx bos "*Shell Command Output*" eos))
                            (name . ,(rx bos "*vc*" eos))))
               ("Eshell" (mode . eshell-mode))
               ("Magit" (name . ,(rx bos "*magit")))
               ("Dired" (mode . dired-mode))))
