
;; (prefer-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")

(ido-mode t)
(icomplete-mode t)
(savehist-mode t)
(show-paren-mode t)

(global-font-lock-mode t)
(global-hl-line-mode t)

(setq-default indent-tabs-mode nil
              fill-column 72
              comment-column 40)

(setq inhibit-startup-screen t
      require-final-newline t
      kill-whole-line t
      visible-bell t
      default-truncate-lines t
      ido-enable-prefix t
      ido-enable-flex-matching t
      ido-everywhere t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'ffap-guesser
      ido-use-url-at-point t
      show-paren-style 'mixed
      frame-title-format '("%b" " - " invocation-name "@" system-name)
      column-number-mode t
      line-number-mode t
      size-indication-mode nil
      history-length 100
      history-delete-duplicates t
      delete-by-moving-to-trash t
      auto-save-default nil
      version-control t
      kept-new-versions 10
      kept-old-versions 2
      delete-old-versions t
      vc-follow-symlinks t
      backup-directory-alist `(("." . ,(concat dot-emacs-dir "backup")))
      bs-default-sort-name "by name"
      mark-holidays-in-calendar t
      generated-autoload-file (locate-library "lisp/loaddefs.el")
      diff-switches "-u"
      comment-auto-fill-only-comments t
      x-select-enable-clipboard t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'tabbar-mode)
  (tabbar-mode -1))

(add-to-list 'default-frame-alist '(width . 100))
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'initial-frame-alist '(top . 100))
(add-to-list 'initial-frame-alist '(left . 180))

(setenv "TERM" "dumb")

(server-start)
