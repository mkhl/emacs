
(defun next-line-and-indent ()
  "Insert a newline after the current line and indent it."
  (interactive)
  (end-of-line)
  (if (not (eq indent-line-function 'tab-to-tab-stop))
      (newline-and-indent)
    (let* ((column (save-excursion (back-to-indentation) (current-column))))
      (newline)
      (indent-to-column column))))

(defun mark-line ()
  "Put mark at end of this line, point at beginning."
  (interactive)
  (goto-char (line-beginning-position 1))
  (push-mark (line-beginning-position 2) 'nomsg 'activate))

(defun duplicate-line-or-region (&optional beg end)
  "Duplicate the current line or, if active, the region."
  (interactive "r")
  (unless (region-active-p)
    (setq beg (line-beginning-position 1)
          end (line-beginning-position 2)))
  (let* ((mark-was-active mark-active)
         deactivate-mark)
    (goto-char beg)
    (insert (buffer-substring-no-properties beg end))
    (when mark-was-active
      (push-mark (+ end (- end beg)) 'nomsg 'activate))))

(defun fill-paragraph-or-region ()
  "Fill the current paragraph or, if active, the region."
  (interactive)
  (call-interactively (if (region-active-p)
                          'fill-region
                        'fill-paragraph)))

(defun upcase-word-or-region ()
  "Convert the following word or, if active, the region, to upper case."
  (interactive)
  (call-interactively (if (region-active-p)
                          'upcase-region
                        'upcase-word)))

(defun downcase-word-or-region ()
  "convert the following word or, if active, the region, to lower case."
  (interactive)
  (call-interactively (if (region-active-p)
                          'downcase-region
                        'downcase-word)))

(defun upcase-initials-line-or-region (&optional beg end)
  "Convert the initial of each word in the current line or,
if active, the region, to upper case."
  (interactive "r")
  (unless (region-active-p)
    (setq beg (line-beginning-position 1)
          end (line-beginning-position 2)))
  (upcase-initials-region beg end))
