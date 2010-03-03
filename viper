;;  -*- mode: emacs-lisp -*-
(setq viper-inhibit-startup-message 't)
(setq viper-expert-level '5)
(setq viper-ex-style-editing nil)
(setq viper-vi-style-in-minibuffer nil)
(setq viper-want-ctl-h-help t)

(setq viper-replace-state-cursor-color nil)
(setq viper-insert-state-cursor-color nil)
(setq viper-emacs-state-cursor-color nil)
(setq viper-vi-state-cursor-color nil)

(set-face-foreground 'viper-minibuffer-emacs nil)
(set-face-foreground 'viper-minibuffer-insert nil)
(set-face-foreground 'viper-minibuffer-vi nil)
(set-face-background 'viper-minibuffer-emacs nil)
(set-face-background 'viper-minibuffer-insert nil)
(set-face-background 'viper-minibuffer-vi nil)

(defadvice viper-maybe-checkout (around viper-never-checkout activate)
  "Don't try to checkout files, the concept is just broken." nil)

(eval-after-load 'hideshow
  '(progn (define-key viper-vi-basic-map "za" 'hs-toggle-hiding)
          (define-key viper-vi-basic-map "zm" 'hs-hide-all)
          (define-key viper-vi-basic-map "zr" 'hs-show-all)
          (define-key viper-vi-basic-map "zo" 'hs-show-block)
          (define-key viper-vi-basic-map "zc" 'hs-hide-block)
          (define-key viper-vi-basic-map "zi" 'hs-minor-mode)))
