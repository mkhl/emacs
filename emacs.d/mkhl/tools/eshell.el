
(setq eshell-save-history-on-exit t
      eshell-cmpl-cycle-completions nil)
(let* ((vc-dir-list '("CVS" ".svn" ".git" ".hg" "_darcs"))
       (vc-regexp `(rx bos (| (: "." (? ".")) ,@vc-dir-list) eos)))
  (setq eshell-cmpl-dir-ignore (eval vc-regexp)))

(eval-after-load 'esh-opt
  '(progn
     (require 'em-prompt)
     (require 'em-term)
     (require 'em-cmpl)
     ;; TODO: for some reason requiring this here breaks it, but
     ;; requiring it after an eshell session is started works fine.
     ;; (require 'eshell-vc)
     (defun mk/eshell-mode-hook ()
       (setenv "PAGER" "cat")
       (setenv "EDITOR" "emacsclient")
       (setenv "VISUAL" "emacsclient"))
     (define-key eshell-mode-map [(control a)] 'eshell-bol)
     (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)
     (add-hook 'eshell-mode-hook 'mk/eshell-mode-hook)))
