
;; (prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

(ido-mode t)
(savehist-mode t)
(show-paren-mode t)

(global-font-lock-mode t)
(global-hl-line-mode t)

(setq-default indent-tabs-mode nil
              show-trailing-whitespace t
              fill-column 72
              comment-column 40)

(setq inhibit-startup-screen t
      require-final-newline t
      visible-bell t
      ido-enable-flex-matching t
      show-paren-style 'mixed
      frame-title-format '("%b" " - " invocation-name "@" system-name)
      column-number-mode t
      line-number-mode t
      history-length 100
      history-delete-duplicates t
      version-control t
      kept-new-versions 10
      kept-old-versions 2
      delete-old-versions t
      vc-follow-symlinks t
      bs-default-sort-name "by name"
      mark-holidays-in-calendar t
      generated-autoload-file (locate-library "lisp/loaddefs.el")
      diff-switches "-u")

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
;; (when (fboundp 'scroll-bar-mode)
;;   (scroll-bar-mode -1))

(defalias 'yes-or-no-p 'y-or-n-p)

(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(server-start)
