
;;; `things'

(defvar primary-thing-mode-alist
  '((emacs-lisp-mode . sexp)
    (lisp-interaction-mode . sexp)
    (lisp-mode . sexp)
    (scheme-mode . sexp))
  "Alist of major mode symbols vs corresponding primary `thing's.

Each element looks like (MODE . THING).
THING should be a symbol specifying the kind of `building blocks'
MODE buffers use (like `line's, say), and should be recognized by
`thing-at-point', which see.")

(defun primary-thing ()
  "Determine the primary kind of `thing' used by `major-mode'."
  (aget primary-thing-mode-alist major-mode 'line))

(defun bounds-of-thing-or-line-at-point (thing)
  "Determine the start and end buffer locations for the THING at
point, or, if unavailable, the current line."
  (if (region-active-p)
      (cons (region-beginning) (region-end))
    (or (bounds-of-thing-at-point thing)
        (bounds-of-thing-at-point 'line))))

(defun bounds-of-thing-at-point-or-region (thing)
  "Determine the start and end buffer locations for the THING at
point, or, if active, the region."
  (if (region-active-p)
      (cons (region-beginning) (region-end))
    (bounds-of-thing-or-line-at-point thing)))

(defun mark-thing (thing)
  "Put mark at end of this THING, point at beginning."
  (interactive (list (primary-thing)))
  (destructuring-bind (beg . end) (bounds-of-thing-or-line-at-point thing)
    (goto-char beg)
    (push-mark end 'nomsg 'activate)))

(unless (fboundp 'mark-word)
  (defun mark-word ()
    "Put mark at end of this word, point at beginning."
    (interactive)
    (mark-thing 'word)))

(unless (fboundp 'mark-line)
  (defun mark-line ()
    "Put mark at end of this line, point at beginning."
    (interactive)
    (mark-thing 'line)))

(unless (fboundp 'mark-sexp)
  (defun mark-sexp ()
    "Put mark at end of this sexp, point at beginning."
    (interactive)
    (mark-thing 'sexp)))

(defun duplicate-thing-or-region (thing)
  "Duplicate the current THING or, if active, the region."
  (interactive (list (primary-thing)))
  (destructuring-bind (beg . end) (bounds-of-thing-at-point-or-region thing)
    (let* ((mark-was-active mark-active)
           deactivate-mark)
      (goto-char beg)
      (insert (buffer-substring-no-properties beg end))
      (when mark-was-active
        (push-mark (+ end (- end beg)) 'nomsg 'activate)))))

(defun duplicate-line-or-region ()
  "Duplicate the current line or, if active, the region."
  (interactive)
  (duplicate-thing-or-region 'line))

;;; Reformat ...

(defun fill-paragraph-or-region ()
  "Fill the current paragraph or, if active, the region."
  (interactive)
  (call-interactively (if (region-active-p)
                          'fill-region
                        'fill-paragraph)))

;;; Text -> Convert -> ...

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

(defun upcase-initials-word-or-region ()
  "Convert the initial of the current word or, if active, the
region, to upper case."
  (interactive)
  (destructuring-bind (beg . end) (bounds-of-thing-at-point-or-region 'word)
    (upcase-initials-region beg end)))

(defun upcase-initials-line-or-region ()
  "Convert the initial of each word in the current line or,
if active, the region, to upper case."
  (interactive)
  (destructuring-bind (beg . end) (bounds-of-thing-at-point-or-region 'line)
    (upcase-initials-region beg end)))

;;; Source -> Comments -> ...

(defun comment-or-uncomment-region-or-line ()
  "Like `comment-or-uncomment-region', but acts on the current
line if mark is not active."
  (interactive)
  (destructuring-bind (beg . end) (bounds-of-thing-at-point-or-region 'line)
    (comment-or-uncomment-region beg end current-prefix-arg)))

;;; Source -> Move to EOL -> ...

(defun next-line-and-indent ()
  "Insert a newline after the current line and indent it."
  (interactive)
  (end-of-line)
  (if (not (eq indent-line-function 'tab-to-tab-stop))
      (newline-and-indent)
    (let* ((column (save-excursion (back-to-indentation) (current-column))))
      (newline)
      (indent-to-column column))))

;;; Text -> Join Line With Next

(defun join-line-with-next ()
  "Join this line to following line."
  (interactive)
  (delete-indentation t))
