
(when (require 'eshell-auto nil 'noerror)
  (setq eshell-save-history-on-exit t
        eshell-cmpl-cycle-completions nil
        eshell-cmpl-ignore-case read-file-name-completion-ignore-case)
  (let* ((vc-dir-list '("CVS" ".svn" ".git" ".hg" "_darcs"))
         (vc-regexp `(rx bos (| (: "." (? ".")) ,@vc-dir-list) eos)))
    (setq eshell-cmpl-dir-ignore (eval vc-regexp)))
  (eval-after-load 'eshell
    '(progn
       (require 'eshell-vc)
       (defun mk/eshell-mode-hook ()
         (define-key eshell-mode-map [(control a)] 'eshell-bol)
         (pushnew 'eshell-handle-ansi-color eshell-output-filter-functions)))))

(global-set-key [(control x) (control z)] 'eshell-toggle-cd)
