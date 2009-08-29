
(require 'generic-x)

;;; Indentation
(autoload 'indent-tabs-maybe "indent-tabs-maybe"
  "Set `indent-tabs-mode' according to buffer contents." t)
(add-hook 'find-file-hook 'indent-tabs-maybe 'append)
(defun my/define-tab-width (width)
  "Define `tab-width' and `tab-stop-list' to match the given `width'."
  (setq tab-width width)
  (set (make-local-variable 'tab-stop-list) (number-sequence width 120 width)))
(defun my/set-indent-to-tab-stops ()
  (set (make-local-variable 'indent-line-function) 'tab-to-tab-stop)
  (when (boundp 'yas/indent-line)
    (set (make-local-variable 'yas/indent-line) 'fixed)))

;;; Perl
(defalias 'perl-mode 'cperl-mode)

;;; Emacs-Lisp
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

;;; Common Lisp
(setq inferior-lisp-program "/opt/ccl/scripts/ccl64 -K utf-8")
(require 'slime-autoloads nil 'noerror)
(eval-after-load "slime"
  '(progn
     (setq slime-net-coding-system 'utf-8-unix)
     (slime-setup '(slime-fancy))))

;;; Scheme
(setq scheme-program-name "gsi -:d-")
;; Gambit.el
(when (locate-library "gambit")
  (autoload 'gambit-inferior-mode "gambit" "Hook Gambit mode into cmuscheme.")
  (autoload 'gambit-mode "gambit" "Hook Gambit mode into scheme.")
  (add-hook 'inferior-scheme-mode-hook #'gambit-inferior-mode)
  (add-hook 'scheme-mode-hook #'gambit-mode))
;; Scheme-Complete.el
(dolist (func '(scheme-complete-or-indent
                scheme-smart-indent-function
                scheme-get-current-symbol-info))
  (autoload func "scheme-complete" nil t))
(eval-after-load 'scheme
  '(progn
     (define-key scheme-mode-map [(tab)] 'scheme-complete-or-indent)
     (add-hook 'scheme-mode-hook
               (lambda ()
                 (set (make-local-variable 'lisp-indent-function)
                      'scheme-smart-indent-function)
                 (set (make-local-variable 'eldoc-documentation-function)
                      'scheme-get-current-symbol-info)
                 (turn-on-eldoc-mode)))))

;;; Paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

;;; Factor
(load "fu" 'noerror)

;;; Haskell
(add-to-list 'completion-ignored-extensions ".hi")
(eval-after-load "haskell-mode"
  '(progn
     (remove-hook 'haskell-mode-hook 'turn-on-haskell-indent)
     (remove-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
     (add-hook 'haskell-mode-hook
               (lambda ()
                 (turn-on-eldoc-mode)
                 (c-subword-mode t)
                 (require 'hs-lint nil 'noerror)
                 (local-set-key [(control c) (control h)] 'haskell-hoogle)
                 (local-set-key [(control c) (control v)] 'hs-lint)
                 (setq haskell-hoogle-command nil)
                 (my/define-tab-width 4)
                 (if (not (fboundp 'haskell-indentation-mode))
                     (my/set-indent-to-tab-stops)
                   (haskell-indentation-mode t)
                   (setq haskell-indentation-layout-offset 4
                         haskell-indentation-left-offset 4
                         haskell-indentation-ifte-offset 4))))))

;;; Applescript
(eval-after-load "applescript-mode"
  '(progn
     (add-hook 'applescript-mode-hook
               (lambda ()
                 (setq indent-tabs-mode t)
                 (my/set-indent-to-tab-stops)
                 (my/define-tab-width 4)))))

;;; Python
(setq gud-pdb-command-name "python -mpdb")
(add-hook 'python-mode-hook
          (lambda ()
            (turn-on-eldoc-mode)
            (my/define-tab-width 4)))

;;; C and friends
(eval-after-load "cc-mode"
  '(progn
     (setq-default c-basic-offset 4)
     (setq c-default-style '((java-mode . "java")
                             (awk-mode . "awk")
                             (other . "bsd")))
     (add-hook 'c-mode-common-hook
               (lambda ()
                 (setq c-basic-offset 4)
                 (c-toggle-syntactic-indentation 1)
                 (c-toggle-hungry-state 1)
                 (c-toggle-electric-state 1)
                 (c-toggle-auto-newline 1)))
     (when (fboundp 'google-set-c-style)
       (add-hook 'c-mode-common-hook 'google-set-c-style))))

;;; JavaScript
(eval-after-load "js2-mode"
  '(progn
     (setq-default js2-basic-offset 4)))
