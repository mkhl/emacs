
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

;; Symbol completion
(global-set-key [(shift tab)] 'hippie-expand)

;; Undo/Redo
(when (require 'redo nil 'noerror)
  (global-set-key [(meta z)] 'undo)
  (global-set-key [(meta Z)] 'redo)
  (global-set-key [(control z)] 'zap-to-char))

;; Tiny Mac-like CUA
(global-set-key [(meta x)] 'kill-region)
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
(defun my/isearch-other-end ()
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
       (add-hook 'isearch-mode-end-hook 'my/isearch-other-end))))

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
  (let* ((had-mark mark-active) beg end)
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

;; Fill paragraph/selection (TextMate)
(defun my/fill-paragraph-or-region (beg end)
  "Fill the current paragraph or, if active, the region."
  (interactive "r")
  (if (and mark-active transient-mark-mode)
      (fill-region beg end)
    (fill-paragraph nil)))

(global-set-key [(meta return)] 'my/next-line-and-indent)
(global-set-key [(meta shift d)] 'my/duplicate-line-or-region)
(global-set-key [(meta shift k)] 'kill-whole-line)
(global-set-key [(meta shift l)] 'my/mark-line)
(global-set-key [(meta q)] 'my/fill-paragraph-or-region)

;; Auto-Pairs (TextMate)
(setq parens-require-spaces nil)
(dolist (pair '((\( . \)) (\[ . \]) (\{ . \})))
  (destructuring-bind (car . cdr) pair
    (global-set-key (vector (list 'meta car)) 'insert-pair)
    (global-set-key (vector (list 'meta cdr)) 'up-list)))
(defun my/insert-pair-or-skip (&optional arg)
  (interactive "P")
  (let ((char last-command-char))
    (if (looking-at (char-to-string char))
        (forward-char)
      (insert-pair arg))))
(global-set-key [(meta \')] 'my/insert-pair-or-skip)
(global-set-key [(meta \")] 'my/insert-pair-or-skip)

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
