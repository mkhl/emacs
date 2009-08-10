
(require 'generic-x)

(require 'dired-x)
(setq-default dired-omit-mode t)

;;; Indentation
(autoload 'indent-tabs-maybe "indent-tabs-maybe"
  "Set `indent-tabs-mode' according to buffer contents." t)
(add-hook 'find-file-hook 'indent-tabs-maybe 'append)
(defun mkhl/set-tab-stops (width)
  (make-local-variable 'tab-stop-list)
  (setq tab-stop-list (loop for i from width to 120 by width collect i)))
(defun mkhl/set-indent-to-tab-stops ()
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'tab-to-tab-stop))

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
;;      (setq slime-complete-symbol*-fancy t)
;;      (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)))
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
(labels ((autoload-scm-cmpl (func) (autoload func "scheme-complete" nil t)))
  (let* ((functions '(scheme-complete-or-indent
                      scheme-smart-indent-function
                      scheme-get-current-symbol-info)))
    (map 'nil 'autoload-scm-cmpl functions)))
(eval-after-load 'scheme
  '(define-key scheme-mode-map (kbd "<tab>") 'scheme-complete-or-indent))
(add-hook 'scheme-mode-hook
  (lambda ()
    (make-local-variable 'lisp-indent-function)
    (setq lisp-indent-function 'scheme-smart-indent-function)
    (make-local-variable 'eldoc-documentation-function)
    (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
    (turn-on-eldoc-mode)))

;;; Paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

;;; Haskell
(remove-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook
  (lambda ()
    (turn-on-haskell-simple-indent)
    (require 'hs-lint nil 'noerror)
    (mkhl/set-indent-to-tab-stops)
    (mkhl/set-tab-stops 4)))

;;  '(c-default-style (quote ((java-mode . "java") (awk-mode . "awk") (other . "linux"))))
;;  '(gud-tooltip-mode t)
