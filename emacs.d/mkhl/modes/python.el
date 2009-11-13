
(defun mk/python-mode-hook ()
  (define-tab-width 4)
  (turn-on-eldoc-mode))

(defun mk/setup-python-mode ()
  (setq py-pychecker-command "pyflakes"
        py-pychecker-command-args nil)
  (add-hook 'python-mode-hook 'hs-minor-mode-maybe)
  (add-hook 'python-mode-hook 'mk/python-mode-hook))

(eval-after-load 'python-mode
  '(mk/setup-python-mode))

(eval-after-load 'gud
  '(setq gud-pdb-command-name "python -mpdb"))
