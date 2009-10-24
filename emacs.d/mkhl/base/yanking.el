
;; Indent yanked text
;; - This doesn't work because the defadvice bodies are only executed
;;   when the advised function was called, i.e. outside of the lexical
;;   environment defined with let and labels.
;; - Workaround: Code duplication. Whoopdeedoo.
;; (let ((indenting-modes '(emacs-lisp-mode
;;                          scheme-mode
;;                          lisp-mode
;;                          c-mode
;;                          c++-mode
;;                          objc-mode
;;                          latex-mode
;;                          plain-tex-mode)))
;;   (labels ((indent-yanked-region ()
;;              (when (member major-mode indenting-modes)
;;                (let ((mark-even-if-inactive t))
;;                  (indent-region (region-beginning) (region-end) nil)))))
;;     (defadvice yank (after indent-region activate)
;;       (funcall #'indent-yanked-region))
;;     (defadvice yank-pop (after indent-region activate)
;;       (funcall #'indent-yanked-region))))
