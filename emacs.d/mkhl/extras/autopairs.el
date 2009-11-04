
(defun insert-pair-or-skip ()
  "When looking at the character to be inserted, skip over it.
Otherwise call `insert-pair', which see."
  (interactive)
  (let* ((char (event-basic-type last-command-event)))
    (if (and (characterp char)
             (looking-at (char-to-string char)))
        (call-interactively 'forward-char)
      (call-interactively 'insert-pair))))

(setq parens-require-spaces nil)

(dolist (pair '(("M-(" . "M-)")
                ("M-[" . "M-]")
                ("M-{" . "M-}")))
  (destructuring-bind (car . cdr) pair
    (global-set-key (read-kbd-macro car) 'insert-pair)
    (global-set-key (read-kbd-macro cdr) 'up-list)))

(global-set-key (kbd "M-\'") 'insert-pair-or-skip)
(global-set-key (kbd "M-\"") 'insert-pair-or-skip)
