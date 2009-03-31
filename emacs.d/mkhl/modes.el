
(autoload 'indent-tabs-maybe "indent-tabs-maybe"
  "Set `indent-tabs-mode' according to buffer contents."
  t)
(add-hook 'find-file-hook 'indent-tabs-maybe 'append)

(eval-after-load 'dired
  '(progn
     (require 'dired-x)
     (setq-default dired-omit-mode t)))

;; "Generic" major modes
;; (require 'generic-x)

;;  '(c-default-style (quote ((java-mode . "java") (awk-mode . "awk") (other . "linux"))))
;;  '(ediff-window-setup-function (quote ediff-setup-windows-plain))
;;  '(gud-tooltip-mode t)
