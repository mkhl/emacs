
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

(dolist (pair '((\( . \)) (\[ . \]) (\{ . \})))
  (destructuring-bind (car . cdr) pair
    (global-set-key `[(meta ,car)] 'insert-pair)
    (global-set-key `[(meta ,cdr)] 'up-list)))

(global-set-key [(meta \')] 'insert-pair-or-skip)
(global-set-key [(meta \")] 'insert-pair-or-skip)
