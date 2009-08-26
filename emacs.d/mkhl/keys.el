
;; Don't use Alt-x, use Ctrl-x-m
(global-set-key [(control x) (control m)] 'execute-extended-command)

;; Buffer switching
(global-set-key [(control x) (control b)] 'ibuffer)
;; (global-set-key [(control x) (control b)] 'ibuffer-bs-show)
;; (global-set-key [(control x) (control b)] 'bs-show)

;; Directory editing
(global-set-key [(control x) (control d)] 'dired)

;; Symbol completion
(global-set-key [(shift tab)] 'hippie-expand)

;; Undo/Redo
(when (require 'redo nil 'noerror)
  (global-set-key [(meta z)] 'undo)
  (global-set-key [(meta Z)] 'redo))

;; Shifted motion
(setq cua-highlight-region-shift-only t)
(cua-selection-mode t)

;; Control/Meta motion
(cond ((featurep 'aquamacs)
       (global-set-key [(control left)] 'backward-word)
       (global-set-key [(control right)] 'forward-word)
       (define-key osx-key-mode-map [(alt control up)] 'up-list)
       (define-key osx-key-mode-map [(alt control down)] 'down-list)
       (define-key osx-key-mode-map [(alt control left)] 'backward-sexp)
       (define-key osx-key-mode-map [(alt control right)] 'forward-sexp))
      (t
       (global-set-key [(meta up)] 'backward-paragraph)
       (global-set-key [(meta down)] 'forward-paragraph)
       ;; Tab switching
       (windmove-default-keybindings 'control)))

;; Isearch
(global-set-key [(control s)] 'isearch-forward)
(global-set-key [(control shift s)] 'isearch-backward)
(cond ((featurep 'aquamacs)
       (global-set-key [(alt control s)] 'isearch-forward-regexp)
       (global-set-key [(alt control shift s)] 'isearch-backward-regexp))
      (t
       (global-set-key [(meta control s)] 'isearch-forward-regexp)
       (global-set-key [(meta control shift s)] 'isearch-backward-regexp)))

;; File switching
(global-set-key [(control x) (control n)] 'nav)

;; Version control
(global-set-key [(control x) (control g)] 'magit-status)

;; Compilation
(global-set-key [(control x) (control y)] 'compile)

;; Next line (TextMate)
(defun my/next-line-and-indent ()
  "Insert a newline after the current line and indent it."
  (interactive)
  (end-of-line)
  (if (not (eq indent-line-function 'tab-to-tab-stop))
      (newline-and-indent)
    (newline)
    (indent-to-column
     (save-excursion (forward-line -1)
                     (back-to-indentation)
                     (current-column)))))
(global-set-key [(meta return)] 'my/next-line-and-indent)
(when (featurep 'aquamacs)
  (define-key osx-key-mode-map [(alt return)] 'my/next-line-and-indent)
  (define-key osx-key-mode-map [(alt \;)] 'comment-or-uncomment-region-or-line))

;; Auto-Pairs (TextMate)
(setq parens-require-spaces nil)
(global-set-key [(meta \()] 'insert-pair)
(global-set-key [(meta \))] 'up-list)
(global-set-key [(meta \[)] 'insert-pair)
(global-set-key [(meta \])] 'up-list)
(global-set-key [(meta \{)] 'insert-pair)
(global-set-key [(meta \})] 'up-list)
(global-set-key [(meta \")] 'insert-pair)

;; Finding symbols
(global-set-key [(control x) (shift f)] 'find-function)
(global-set-key [(control x) (shift v)] 'find-variable)

;; Indent yanked text
;; - This doesn't work because the defadvice bodies are only executed
;;   when the advised function was called, i.e. outside of the lexical
;;   environment defined with let and labels.
;; - Workaround: Code duplication. Whoopdeedoo.
;; (let ((indenting-modes '(emacs-lisp-mode
;;                          scheme-mode
;;                          lisp-mode
;;                          c-mode
;;                          c++-mode
;;                          objc-mode
;;                          latex-mode
;;                          plain-tex-mode)))
;;   (labels ((indent-yanked-region ()
;;              (when (member major-mode indenting-modes)
;;                (let ((mark-even-if-inactive t))
;;                  (indent-region (region-beginning) (region-end) nil)))))
;;     (defadvice yank (after my/indent-region activate)
;;       (funcall #'indent-yanked-region))
;;     (defadvice yank-pop (after my/indent-region activate)
;;       (funcall #'indent-yanked-region))))

;; Kill and join
(defadvice kill-line (around my/kill-or-join-line activate)
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    ad-do-it))
