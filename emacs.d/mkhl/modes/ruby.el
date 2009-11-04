
(defun mk/ruby-mode-hook ()
  (define-tab-width 2)
  (ruby-electric-mode t))

(defun mk/eval-after-ruby-mode ()
  (define-key ruby-mode-map (kbd "TAB") nil)
  (add-hook 'ruby-mode-hook 'mk/ruby-mode-hook))

(eval-after-load 'ruby-mode
  '(mk/eval-after-ruby-mode))

(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist `(,(rx ".rake" eos) . ruby-mode))
