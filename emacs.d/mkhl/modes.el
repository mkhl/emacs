
(autoload 'indent-tabs-maybe "indent-tabs-maybe"
  "Set `indent-tabs-mode' according to buffer contents."
  t)
(add-hook 'find-file-hook 'indent-tabs-maybe 'append)

(eval-after-load 'dired
  '(progn
     (require 'dired-x)
     (setq-default dired-omit-mode t)))

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook '(lambda () (paredit-mode +1)))
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook '(lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

;; "Generic" major modes
;; (require 'generic-x)

;;  '(c-default-style (quote ((java-mode . "java") (awk-mode . "awk") (other . "linux"))))
;;  '(ediff-window-setup-function (quote ediff-setup-windows-plain))
;;  '(gud-tooltip-mode t)
