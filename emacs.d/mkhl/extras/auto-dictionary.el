
(when (fboundp 'auto-dictionary-mode)
  (defun auto-dictionary-enable ()
    (auto-dictionary-mode +1))
  (add-hook 'flyspell-mode-hook 'auto-dictionary-enable))
