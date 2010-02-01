
(defun mk/yasnippet-keys ()
  (dolist (key (append yas/next-field-key yas/prev-field-key))
    (define-key yas/keymap (read-kbd-macro key) nil))
  (setq yas/next-field-key '("C-/")
        yas/prev-field-key '("C-?"))
  (define-key yas/keymap (kbd "C-/") #'yas/next-field)
  (define-key yas/keymap (kbd "C-?") #'yas/prev-field))

(defun mk/yasnippet-hippie-expand ()
  (eval-after-load 'hippie-exp
    '(add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand)))

(defun mk/yasnippet-snippets ()
  (let ((snippets-dir (concat dot-emacs-dir "snippets")))
   (when (file-exists-p snippets-dir)
     (yas/load-directory snippets-dir))))

(defun mk/setup-yasnippet ()
  (mk/yasnippet-keys)
  (mk/yasnippet-hippie-expand)
  (mk/yasnippet-snippets)
  (setq yas/use-menu 'abbreviate)
  (yas/global-mode 1))

(when (require 'yasnippet-bundle nil 'noerror)
  (mk/setup-yasnippet))

(defun yas/fix-trigger-key ()
  (when (featurep 'yasnippet)
    (setq yas/fallback-behavior `(apply ,(local-key-binding (kbd "TAB"))))
    (local-unset-key (kbd "TAB"))
    (local-unset-key (kbd "<tab>"))))

