
;;; `ruby-mode'

(defun mk/ruby-mode-hook ()
  (define-tab-width 2)
  (ruby-electric-mode t))

(defun mk/setup-ruby-mode ()
  (define-key ruby-mode-map (kbd "TAB") nil)
  (add-hook 'ruby-mode-hook 'hs-minor-mode-maybe)
  (add-hook 'ruby-mode-hook 'mk/ruby-mode-hook))

(eval-after-load 'ruby-mode
  '(mk/setup-ruby-mode))

(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist `(,(rx ".rake" eos) . ruby-mode))

;;; `inf-ruby'

(defun mk/setup-inf-ruby ()
  (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on))

(eval-after-load 'inf-ruby
  '(mk/setup-inf-ruby))
