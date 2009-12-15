
(add-to-list 'completion-ignored-extensions ".hi")

;; haskell-mode autoloads
(load "haskell-site-file" 'noerror)

(defun mk/haskell-mode-hook ()
  (setq haskell-hoogle-command nil)
  (define-tab-width 4)
  (turn-on-eldoc-mode)
  (subword-mode t)
  (if (not (fboundp 'haskell-indentation-mode))
      (set-indent-to-tab-stops)
    (haskell-indentation-mode t)
    (setq haskell-indentation-layout-offset 4
          haskell-indentation-left-offset 4
          haskell-indentation-ifte-offset 4)))

(defun mk/haskell-keys ()
  (define-key haskell-mode-map (kbd "C-c C-h") #'haskell-hoogle)
  (define-key haskell-mode-map (kbd "C-c C-v") #'hs-lint))

(defun mk/setup-haskell-mode ()
  (mk/haskell-keys)
  (remove-hook 'haskell-mode-hook 'turn-on-haskell-indent)
  (remove-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'mk/haskell-mode-hook))

(eval-after-load 'haskell-mode
  '(mk/setup-haskell-mode))
