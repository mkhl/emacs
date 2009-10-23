
(eval-after-load "python-mode"
  '(progn
     (defun mk/python-mode-hook ()
       (define-tab-width 4)
       (turn-on-eldoc-mode))
     (setq gud-pdb-command-name "python -mpdb")
     (add-hook 'python-mode-hook 'mk/python-mode-hook)))
