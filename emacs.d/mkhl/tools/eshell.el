
(defun mk/eshell-mode-hook ()
  (setenv "TERM" "eshell")
  (pushnew 'eshell-handle-ansi-color eshell-output-filter-functions)
  (define-key eshell-mode-map (kbd "C-a") 'eshell-bol))

(defun mk/eval-after-eshell ()
  (add-hook 'eshell-mode-hook 'mk/eshell-mode-hook))

(eval-after-load 'eshell
  '(mk/eval-after-eshell))

(when (require 'eshell-auto nil 'noerror)
  (setq eshell-save-history-on-exit t
        eshell-cmpl-cycle-completions nil
        eshell-cmpl-ignore-case read-file-name-completion-ignore-case)
  (let* ((vc-dir-list '("CVS" ".svn" ".git" ".hg" "_darcs"))
         (vc-regexp `(rx bos (| (: "." (? ".")) ,@vc-dir-list) eos)))
    (setq eshell-cmpl-dir-ignore (eval vc-regexp)))
  (global-set-key (kbd "C-x C-z") 'eshell-toggle))
