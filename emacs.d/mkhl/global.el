
;; (prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

(ido-mode t)
(show-paren-mode t)

(global-font-lock-mode t)
(global-hl-line-mode t)

(setq-default indent-tabs-mode nil
              fill-column 78
              comment-column 40)

(setq inhibit-startup-screen t
      require-final-newline t
      visible-bell t
      frame-title-format '("%b" " - " invocation-name "@" system-name)
      column-number-mode t
      line-number-mode t
      transient-mark-mode t
      version-control t
      kept-new-versions 10
      kept-old-versions 2
      delete-old-versions t
      diff-switches "-u")

(require 'dired-x)
(setq-default dired-omit-mode t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(defalias 'yes-or-no-p 'y-or-n-p)

(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
