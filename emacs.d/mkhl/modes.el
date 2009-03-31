
(eval-after-load 'dired
  '(progn
     (require 'dired-x)
     (setq-default dired-omit-mode t)))

;; "Generic" major modes
;; (require 'generic-x)

;;  '(c-default-style (quote ((java-mode . "java") (awk-mode . "awk") (other . "linux"))))
;;  '(ediff-window-setup-function (quote ediff-setup-windows-plain))
;;  '(gud-tooltip-mode t)
