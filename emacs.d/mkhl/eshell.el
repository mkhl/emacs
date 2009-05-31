
(setq eshell-save-history-on-exit t
      eshell-cmpl-cycle-completions nil
      eshell-cmpl-dir-ignore (rx bot (or (and ?. (opt ?.))
                                         "CVS"
                                         ".svn"
                                         ".git"
                                         ".hg")
                                 eot))
(eval-after-load 'esh-opt
  '(progn
     (require 'em-prompt)
     (require 'em-term)
     (require 'em-cmpl)
     ;; TODO: for some reason requiring this here breaks it, but
     ;; requiring it after an eshell session is started works fine.
     ;; (require 'eshell-vc)
     (setenv "PAGER" "cat")
     (add-hook 'eshell-mode-hook
               '(lambda () (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)))
     (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)))
