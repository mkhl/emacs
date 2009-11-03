
(setq ibuffer-default-sorting-mode 'alphabetic
      ibuffer-never-show-predicates `(,(rx bos "*Completions*" eos))
      ibuffer-show-empty-filter-groups nil)

(defun mk/ibuffer-mode-hook ()
  (define-key ibuffer-mode-map [(tab)] 'ibuffer-toggle-filter-group)
  (ibuffer-set-filter-groups-by-mode))

(eval-after-load 'ibuffer
  '(add-hook 'ibuffer-mode-hook 'mk/ibuffer-mode-hook))
