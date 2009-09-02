
;; Don't use Alt-x, use Ctrl-x-m
(global-set-key [(control x) (control m)] 'execute-extended-command)

;; Buffer switching
(global-set-key [(control x) (control b)] 'ibuffer)

;; Directory editing
(global-set-key [(control x) (control d)] 'dired)

;; Symbol completion
(global-set-key [(shift tab)] 'hippie-expand)

;; Undo/Redo
(when (require 'redo nil 'noerror)
  (global-set-key [(meta z)] 'undo)
  (global-set-key [(meta Z)] 'redo)
  (global-set-key [(control z)] 'zap-to-char))

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
       (global-set-key [(meta up)] 'beginning-of-buffer)
       (global-set-key [(meta down)] 'end-of-buffer)
       (global-set-key [(meta left)] 'beginning-of-line)
       (global-set-key [(meta right)] 'end-of-line)))

;; Isearch
(defun my/isearch-other-end ()
  "Jump to the beginning of an isearch match after searching forward."
  (when isearch-forward (goto-char isearch-other-end)))
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
  (add-hook 'isearch-mode-end-hook 'my/isearch-other-end))

;; File switching
(global-set-key [(control x) (control n)] 'nav)

;; Version control
(global-set-key [(control x) (control g)] 'magit-status)

;; Compilation
(global-set-key [(control x) (control y)] 'compile)
(global-set-key [(control x) (control z)] 'compile)

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

;; Select line (TextMate)
(defun my/mark-line ()
  "Put mark at end of this line, point at beginning."
  (interactive)
  (goto-char (line-beginning-position 1))
  (push-mark (line-beginning-position 2) 'nomsg 'activate))

;; Duplicate line/selection (TextMate)
(defun my/duplicate-line-or-region ()
  "Duplicate the current line or, if active, the region."
  (interactive)
  (let* ((had-mark mark-active)
         beg end)
    (if (and mark-active transient-mark-mode)
        (setq beg (region-beginning)
              end (region-end))
      (setq beg (line-beginning-position 1)
            end (line-beginning-position 2)))
    (let* (deactivate-mark)
      (goto-char beg)
      (insert (buffer-substring-no-properties beg end))
      (when had-mark
        (push-mark (+ end (- end beg)) 'nomsg 'activate)))))

(global-set-key [(meta return)] 'my/next-line-and-indent)
(global-set-key [(meta shift d)] 'my/duplicate-line-or-region)
(global-set-key [(meta shift l)] 'my/mark-line)
(when (featurep 'aquamacs)
  (define-key osx-key-mode-map [(alt return)] 'my/next-line-and-indent)
  (define-key osx-key-mode-map [(alt \;)]
    'comment-or-uncomment-region-or-line))

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
