
(setq comint-prompt-read-only t
      eshell-save-history-on-exit t
      eshell-cmpl-cycle-completions nil
      eshell-cmpl-dir-ignore (rx bos (or (and ?. (opt ?.))
                                         "CVS"
                                         ".svn"
                                         ".git"
                                         ".hg")
                                 eos))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(eval-after-load 'esh-opt
  '(progn
     (require 'em-prompt)
     (require 'em-term)
     (require 'em-cmpl)
     ;; TODO: for some reason requiring this here breaks it, but
     ;; requiring it after an eshell session is started works fine.
     ;; (require 'eshell-vc)
     (setenv "PAGER" "cat")
     (setenv "EDITOR" "emacsclient")
     (setenv "VISUAL" "emacsclient")
     (define-key eshell-mode-map [(control a)] 'eshell-bol)
     (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)))
