
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

(defun bounds-of-thing-at-point-or-region (thing)
  "Determine the start and end buffer locations for the THING at
point, or, if active, the region. THING is a symbol which
specifies the kind of syntactic entity you want.  Possibilities
include `symbol', `list', `sexp', `defun', `filename', `url',
`word', `sentence', `whitespace', `line', `page' and others.

See the file `thingatpt.el' for documentation on how to define
a symbol as a valid THING.

The value is a cons cell (START . END) giving the start and end positions
of the textual entity that was found."
  (if (region-active-p)
      (cons (region-beginning) (region-end))
    (bounds-of-thing-at-point thing)))

(defun mark-thing (thing)
  "Put mark at end of this THING, point at beginning."
  (interactive (list (primary-thing)))
  (destructuring-bind (beg . end) (bounds-of-thing-at-point thing)
    (goto-char beg)
    (push-mark end 'nomsg 'activate)))

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
