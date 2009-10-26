
(defun insert-pair-or-skip ()
  "When looking at the character to be inserted, skip over it.
Otherwise call `insert-pair', which see."
  (interactive)
  (labels ((looking-at-char? (char)
             (and (characterp char) (looking-at (char-to-string char)))))
    (let* ((char1 last-command-char)
           (char2 (event-basic-type last-command-event)))
      (if (or (looking-at-char? char1)
              (looking-at-char? char2))
          (call-interactively 'forward-char)
        (call-interactively 'insert-pair)))))

(setq parens-require-spaces nil)

(dolist (pair '((\( . \)) (\[ . \]) (\{ . \})))
  (destructuring-bind (car . cdr) pair
    (global-set-key `[(meta ,car)] 'insert-pair)
    (global-set-key `[(meta ,cdr)] 'up-list)))

(global-set-key [(meta \')] 'insert-pair-or-skip)
(global-set-key [(meta \")] 'insert-pair-or-skip)
