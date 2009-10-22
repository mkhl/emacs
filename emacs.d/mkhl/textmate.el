
;;; Pretty symbols

(defun* pretty-lambdas (&optional (regexp "(?\\(lambda\\>\\)"))
  "Make NAME render as λ."
  (font-lock-add-keywords
   nil `((,regexp
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))

(defun* pretty-sigmas (&optional (regexp "(?\\(\\\\sigma\\>\\)"))
  "Make NAME render as σ."
  (font-lock-add-keywords
   nil `((,regexp
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 113))
                    nil))))))

(defun* pretty-thetas (&optional (regexp "(?\\(\\\\theta\\>\\)"))
  "Make NAME render as θ."
  (font-lock-add-keywords
   nil `((,regexp
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 104))
                    nil))))))

;;; TextMate emulation

;; Next line
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

;; Select line
(defun my/mark-line ()
  "Put mark at end of this line, point at beginning."
  (interactive)
  (goto-char (line-beginning-position 1))
  (push-mark (line-beginning-position 2) 'nomsg 'activate))

;; Duplicate line/selection
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

;; Fill paragraph/selection
(defun my/fill-paragraph-or-region (&optional beg end)
  "Fill the current paragraph or, if active, the region."
  (interactive "r")
  (if (and mark-active transient-mark-mode)
      (fill-region beg end)
    (fill-paragraph nil)))

;; Uppercase
(defun my/upcase-word-or-region (arg &optional beg end)
  "Convert the following word or, if active, the region, to upper case."
  (interactive "p\nr")
  (if (and mark-active transient-mark-mode)
      (upcase-region beg end)
    (upcase-word arg)))

;; Lowercase
(defun my/downcase-word-or-region (arg &optional beg end)
  "Convert the following word or, if active, the region, to lower case."
  (interactive "p\nr")
  (if (and mark-active transient-mark-mode)
      (downcase-region beg end)
    (downcase-word arg)))

;; Titlecase
(defun my/upcase-initials-line-or-region (&optional beg end)
  "Convert the initial of each word in the current line or,
if active, the region, to upper case."
  (interactive "r")
  (unless (and mark-active transient-mark-mode)
    (setq beg (line-beginning-position 1)
          end (line-beginning-position 2)))
  (upcase-initials-region beg end))
