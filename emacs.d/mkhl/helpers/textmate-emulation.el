
(defun next-line-and-indent ()
  "Insert a newline after the current line and indent it."
  (interactive)
  (end-of-line)
  (if (not (eq indent-line-function 'tab-to-tab-stop))
      (newline-and-indent)
    (let ((column (save-excursion (back-to-indentation) (current-column))))
      (newline)
      (indent-to-column column))))

(defun mark-line ()
  "Put mark at end of this line, point at beginning."
  (interactive)
  (goto-char (line-beginning-position 1))
  (push-mark (line-beginning-position 2) 'nomsg 'activate))

(defun duplicate-line-or-region ()
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

(defun fill-paragraph-or-region (arg &optional beg end)
  "Fill the current paragraph or, if active, the region."
  (interactive "p\nr")
  (if (and mark-active transient-mark-mode)
      (fill-region beg end)
    (fill-paragraph arg)))

(defun upcase-word-or-region (arg &optional beg end)
  "Convert the following word or, if active, the region, to upper case."
  (interactive "p\nr")
  (if (and mark-active transient-mark-mode)
      (upcase-region beg end)
    (upcase-word arg)))

(defun downcase-word-or-region (arg &optional beg end)
  "Convert the following word or, if active, the region, to lower case."
  (interactive "p\nr")
  (if (and mark-active transient-mark-mode)
      (downcase-region beg end)
    (downcase-word arg)))

(defun upcase-initials-line-or-region (&optional beg end)
  "Convert the initial of each word in the current line or,
if active, the region, to upper case."
  (interactive "r")
  (unless (and mark-active transient-mark-mode)
    (setq beg (line-beginning-position 1)
          end (line-beginning-position 2)))
  (upcase-initials-region beg end))