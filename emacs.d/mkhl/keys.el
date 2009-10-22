
;; Don't use Alt-x, use Ctrl-x-m
(global-set-key [(control x) (control m)] 'execute-extended-command)

;; Server buffers
(global-set-key [(control x) (control =)] 'server-edit)

;; Buffer switching
(global-set-key [(control x) (control b)] 'ibuffer)

;; Directory editing
(global-set-key [(control x) (control d)] 'dired)

;; File switching
(global-set-key [(control x) (control n)] 'nav)

;; Version control
(global-set-key [(control x) (g)] 'magit-status)

;; Compilation
(global-set-key [(control x) (control y)] 'compile)
(global-set-key [(control x) (control z)] 'compile)

;; Scrolling
(global-set-key [(control v)] 'scroll-up)
(global-set-key [(control shift v)] 'scroll-down)

;; Finding symbols
(global-set-key [(control x) (shift f)] 'find-function)
(global-set-key [(control x) (shift v)] 'find-variable)

;; Window switching
(global-set-key [(meta \`)] 'switch-to-next-window)
(global-set-key [(meta ~)] 'switch-to-previous-window)

(defun switch-to-next-window (arg)
  (interactive "p")
  (other-window arg))
(defun switch-to-previous-window (arg)
  (interactive "p")
  (other-window (- arg)))

;; Symbol completion
(global-set-key [(shift tab)] 'hippie-expand)

;; Undo/Redo
(when (require 'redo nil 'noerror)
  (global-set-key [(meta z)] 'undo)
  (global-set-key [(meta Z)] 'redo)
  (global-set-key [(control z)] 'zap-to-char))

;; Kill region or Execute extended command
(defvar extended-command-command 'execute-extended-command
  "Command to run extended commands.")
(defun kill-region-or-m-x ()
  (interactive)
  (if (and mark-active transient-mark-mode)
      (call-interactively 'kill-region)
    (call-interactively extended-command-command)))

;; Tiny Mac-like CUA
(global-set-key [(meta x)] 'kill-region-or-m-x)
(global-set-key [(meta c)] 'copy-region-as-kill)
(global-set-key [(meta v)] 'yank)
(global-set-key [(meta shift v)] 'yank-pop)

;; Shifted motion
(setq cua-highlight-region-shift-only t)
(cua-selection-mode t)

;; Control/Meta motion
(global-set-key [(control left)] 'backward-word)
(global-set-key [(control right)] 'forward-word)
(global-set-key [(meta up)] 'backward-paragraph)
(global-set-key [(meta down)] 'forward-paragraph)

;; Isearch
(defun isearch-other-end ()
  "Jump to the beginning of an isearch match after searching forward."
  (when (and isearch-forward isearch-other-end)
    (goto-char isearch-other-end)))
(eval-after-load "isearch"
  '(progn
     (let* ((modifier (if (featurep 'aquamacs) 'alt 'meta))
            (forward [(control s)])
            (backward [(control shift s)])
            (forward-regexp (vector (list 'control modifier 's)))
            (backward-regexp (vector (list 'control modifier 'shift 's))))
       (global-set-key forward 'isearch-forward)
       (global-set-key backward 'isearch-backward)
       (define-key isearch-mode-map forward 'isearch-repeat-forward)
       (define-key isearch-mode-map backward 'isearch-repeat-backward)
       (global-set-key forward-regexp 'isearch-forward-regexp)
       (global-set-key backward-regexp 'isearch-backward-regexp)
       (define-key isearch-mode-map forward-regexp
         'isearch-repeat-forward-regexp)
       (define-key isearch-mode-map backward-regexp
         'isearch-repeat-backward-regexp)
       (global-set-key [(control *)] 'isearch-forward-at-point)
       (add-hook 'isearch-mode-end-hook 'isearch-other-end))))

;; General TextMate emulation
(global-set-key [(meta return)] 'next-line-and-indent)
(global-set-key [(meta shift d)] 'duplicate-line-or-region)
(global-set-key [(meta shift k)] 'kill-whole-line)
(global-set-key [(meta shift l)] 'mark-line)
(global-set-key [(meta q)] 'fill-paragraph-or-region)
(global-set-key [(meta u)] 'upcase-word-or-region)
(global-set-key [(meta shift u)] 'downcase-word-or-region)
(global-set-key [(control meta u)] 'upcase-initials-line-or-region)

;; Auto-Pairs (TextMate)
(setq parens-require-spaces nil)
(defun insert-pair-or-skip (&optional arg)
  (interactive "P")
  (let ((char1 (char-to-string last-command-char))
        (char2 (char-to-string (event-basic-type last-command-event))))
    (if (or (looking-at char1)
            (looking-at char2))
        (forward-char)
      (insert-pair arg))))
(dolist (pair '((\( . \)) (\[ . \]) (\{ . \})))
  (destructuring-bind (car . cdr) pair
    (global-set-key (vector (list 'meta car)) 'insert-pair)
    (global-set-key (vector (list 'meta cdr)) 'up-list)))
(global-set-key [(meta \')] 'insert-pair-or-skip)
(global-set-key [(meta \")] 'insert-pair-or-skip)

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
;;     (defadvice yank (after indent-region activate)
;;       (funcall #'indent-yanked-region))
;;     (defadvice yank-pop (after indent-region activate)
;;       (funcall #'indent-yanked-region))))

;; Kill and join
(defadvice kill-line (around kill-or-join-line activate)
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    ad-do-it))
