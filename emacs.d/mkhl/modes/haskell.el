
(load "haskell-site-file" 'noerror)
(add-to-list 'completion-ignored-extensions ".hi")
(eval-after-load "haskell-mode"
  '(progn
     (defun mk/haskell-mode-hook ()
       (require 'hs-lint nil 'noerror)
       (setq haskell-hoogle-command nil)
       (define-tab-width 4)
       (turn-on-eldoc-mode)
       (c-subword-mode t)
       (if (not (fboundp 'haskell-indentation-mode))
           (set-indent-to-tab-stops)
         (haskell-indentation-mode t)
         (setq haskell-indentation-layout-offset 4
               haskell-indentation-left-offset 4
               haskell-indentation-ifte-offset 4)))
     (define-key haskell-mode-map [(control c) (control h)] 'haskell-hoogle)
     (define-key haskell-mode-map [(control c) (control v)] 'hs-lint)
     (remove-hook 'haskell-mode-hook 'turn-on-haskell-indent)
     (remove-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
     (add-hook 'haskell-mode-hook 'mk/haskell-mode-hook)))
