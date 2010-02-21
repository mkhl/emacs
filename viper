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
