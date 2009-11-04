
(setq ibuffer-default-sorting-mode 'alphabetic
      ibuffer-never-show-predicates `(,(rx bos "*Completions*" eos))
      ibuffer-show-empty-filter-groups nil)

(defun mk/ibuffer-mode-hook ()
  (ibuffer-set-filter-groups-by-mode))

(defun mk/eval-after-ibuffer ()
  (define-key ibuffer-mode-map [(tab)] 'ibuffer-toggle-filter-group)
  (add-hook 'ibuffer-mode-hook 'mk/ibuffer-mode-hook))

(eval-after-load 'ibuffer
  '(mk/eval-after-ibuffer))
