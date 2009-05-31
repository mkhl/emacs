
(require 'generic-x)

(autoload 'indent-tabs-maybe "indent-tabs-maybe"
  "Set `indent-tabs-mode' according to buffer contents."
  t)
(add-hook 'find-file-hook 'indent-tabs-maybe 'append)

(require 'dired-x)
(setq-default dired-omit-mode t)

(add-hook 'text-mode-hook 'longlines-mode)

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)
;; (add-hook 'emacs-lisp-mode-hook '(lambda () (paredit-mode +1)))
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
;; (add-hook 'lisp-interaction-mode-hook '(lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

(defalias 'perl-mode 'cperl-mode)

;;  '(c-default-style (quote ((java-mode . "java") (awk-mode . "awk") (other . "linux"))))
;;  '(ediff-window-setup-function (quote ediff-setup-windows-plain))
;;  '(gud-tooltip-mode t)
