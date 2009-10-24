
(defun chomp (string)
  "Return STRING without trailing newlines."
  (let* ((newlines (rx (0+ (any ?\r ?\n)) eos)))
    (if (string-match newlines string)
        (replace-match "" 'fixed 'literal string)
      string)))
