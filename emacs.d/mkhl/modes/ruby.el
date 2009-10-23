
(eval-after-load "ruby-mode"
  '(progn
     (defun mk/ruby-mode-hook ()
       (define-tab-width 2)
       (ruby-electric-mode t))
     (define-key ruby-mode-map (kbd "TAB") nil)
     (add-hook 'ruby-mode-hook 'mk/ruby-mode-hook)))
