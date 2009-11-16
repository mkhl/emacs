;; -*- coding:utf-8 -*-
;; Add the following to your init file like .emacs.
;; (autoload 'fs-inspect-region "f-script-mode.el" "inspect the region as F-Script source." t)
;; (autoload 'fs-execute-region "f-script-mode.el" "execute the region as F-Script source." t)
;; (autoload 'fs-mode "f-script-mode.el" "major mode for editing F-Script source." t)
;; (setq auto-mode-alist
;;       (cons '("\\.fs$" . fs-mode) auto-mode-alist)
;;       )
;;

(defconst fs-long-version "$Id: f-script-mode.el,v 0.45 2009/07/02 03:02:23 $"
  "`f-script-mode' long version number.")

(defconst fs-version "$Revision: 0.45 $"
  "`f-script-mode' version number.")

(defgroup f-script nil
  "Major mode for F-Script."
  :group 'languages
  :prefix "fs-")

(defcustom fs-pboard-template "
on run argv
   tell application \"F-Script\"
      	eval \"
        [ | pboard result |
            pboard := NSPasteboard generalPasteboard stringForType: 'NSStringPboardType'.
	    %s
            result := sys executor execute: pboard.
            (result isOK)
            ifTrue:[
                result result.
            ]
            ifFalse:[ | range |
                range := result errorRange.
                'Error: Point at '
                ++ range location description
                ++ ' length '
                ++ range length description
                ++ '\\n'
                ++ result errorMessage.
            ].
        ] value\"
   end tell
end run
"
  "Applescript: Evaluate region in F-Script"
  :type 'string
  :group 'f-script)

(defcustom fs-error-message-regexp
  "Error: Point at \\([0-9]+\\) length \\([0-9]+\\)"
  "Regexp for getting the error point and length")

(defcustom fs-eval-pboard
  ""
  "Applescript: Evaluate a region by the F-Script"
  :type 'string
  :group 'f-script)

(defcustom fs-inspect-pboard
  "pboard := 'sys browse:('++pboard++')'."
  "Applescript: Inspect a region by the F-Script"
  :type 'string
  :group 'f-script)

(defconst fs-name-regexp "[A-Za-z_][A-Za-z0-9_]*"
  "")

(defconst fs-symbol-regexp
  (concat "\\<" fs-name-regexp "\\>")
  "")

(defconst fs-method-regexp
  (concat "\\<\\(" fs-name-regexp "\\):[^=]")
  "")

(defconst fs-assign-regexp
  (concat "\\<" fs-name-regexp "\s*:=")
  "")

(defconst fs-end-of-sentence-regexp
  (concat "\\(;\\|\\.[^0-9]\\)")
  "")

(defconst fs-number-regexp
  (concat "-?[0-9]+\\(\\.[0-9]+\\)?\\(e[-+]?[0-9]+\\)?")
  "")

(defconst fs-elements-of-number
  (concat "-+e0-9\\.")
  "")

(defvar fs-mode-syntax-table 
  (let ((table (make-syntax-table)))
    (setq fs-mode-syntax-table (make-syntax-table))
    (modify-syntax-entry ?!  ".   " table)
    (modify-syntax-entry ?\" "!   " table)
    (modify-syntax-entry ?#  "'   " table)
    (modify-syntax-entry ?$  "/   " table)
    (modify-syntax-entry ?%  ".   " table)
    (modify-syntax-entry ?&  ".   " table)
    (modify-syntax-entry ?'  "\"  " table)
    (modify-syntax-entry ?\( "()  " table)
    (modify-syntax-entry ?\) ")(  " table)
    (modify-syntax-entry ?*  ".   " table)
    (modify-syntax-entry ?+  ".   " table)
    (modify-syntax-entry ?,  ".   " table)
    (modify-syntax-entry ?-  ".   " table)
    (modify-syntax-entry ?/  ".   " table)
    (modify-syntax-entry ?:  ".   " table)
    (modify-syntax-entry ?\; ".   " table)
    (modify-syntax-entry ?<  ".   " table) 
    (modify-syntax-entry ?=  ".   " table)
    (modify-syntax-entry ?>  ".   " table) 
    (modify-syntax-entry ?@  ".   " table)
    (modify-syntax-entry ?\[ "(]  " table)
    (modify-syntax-entry ?\\ ".   " table)
    (modify-syntax-entry ?\] ")[  " table)
    (modify-syntax-entry ?^  ".   " table)
    (modify-syntax-entry ?_  "w   " table)
    (modify-syntax-entry ?{  "(}  " table)
    (modify-syntax-entry ?|  ".   " table)
    (modify-syntax-entry ?}  "){  " table)
    (modify-syntax-entry ?~  ".   " table)
    table)
  "Syntax table used by F-Script mode")

(defvar fs-mode-abbrev-table nil
  "Abbrev table in use in fs-mode buffers.")
(define-abbrev-table 'fs-mode-abbrev-table ())

(defconst fs-font-lock-keywords
  (list
   '("\\<\\(NS\\|FS\\)\\sw*\\>"			. font-lock-constant-face)
   '("\\<[A-Z_]+\\>"				. font-lock-constant-face)
   '("-?[0-9]+\\(\\.[0-9]+\\)?\\(e-?[0-9]+\\)?"	. font-lock-constant-face)
   '("#\\([A-Za-z_][A-Za-z0-9_]*:\\)+"		. font-lock-constant-face)
   '("#[A-Za-z_][A-Za-z0-9_]*"			. font-lock-constant-face)
   '("\\<[A-Za-z_][A-Za-z0-9_]*\s*:="		. font-lock-function-name-face)
   '("\\<[A-Za-z_][A-Za-z0-9_]*:"		. font-lock-type-face)
   '("\\([-+<>=*/?~!%&@^|\\\\]+\\|:=\\)"	. font-lock-keyword-face))
  "Basic F-Script keywords font-locking")

(defconst fs-font-lock-keywords-1
  fs-font-lock-keywords	   
  "Level 1 F-Script font-locking keywords")

(defconst fs-font-lock-keywords-2
  (append fs-font-lock-keywords-1
	  (list 
	   '("\\<\\(true\\|false\\|nil\\|self\\|class\\|super\\)\\>" 
	     . font-lock-keyword-face)
	   '(":[a-z][A-z0-9_]*" . font-lock-variable-name-face)
	   '(" |" . font-lock-type-face)))
  "Level 2 F-Script font-locking keywords")

(defun fs-skip-spaces-forward ()
  ""
  (let ((pos (point)))
    (catch 'end
      (while t
        (forward-comment 1)
        (skip-syntax-forward "-")
        (when (eq pos (point)) (throw 'end nil))
        (setq pos (point))))))

(defun fs-skip-spaces-backward () ;;? 
  ""
  (let ((pos (point)))
    (catch 'end
      (while t
        (forward-comment -1)
        (skip-syntax-backward "-")
        (when (eq pos (point)) (throw 'end nil))
        (setq pos (point))))))

(defun fs-punctuation-chars ()
  ""
  (fs-skip-spaces-forward)
  (when (looking-at "\\.[0-9]")
    (forward-char 1)
    (skip-syntax-forward "w"))
  (let ((pos (point)))
    (cond ((looking-at fs-end-of-sentence-regexp)
           (forward-char 1))
          ((looking-at ":=")
           (forward-char 2))
          ((looking-at ":")
           (forward-char 1))
          (t (skip-syntax-forward ".")))
    (buffer-substring-no-properties pos (point))))

(defun fs-next-sexp (&optional n)
  ""
  (interactive "p")
  (when (eq (point) (point-max)) (signal 'scan-error (list "end of buffer" (point) (point))))
  (let ((pos (point)))
    (skip-syntax-forward "w")
    (fs-skip-spaces-forward)
    (skip-syntax-backward ".")
    (let ((terminator (fs-punctuation-chars)))
      (skip-syntax-forward ".")
      (when (not (eq pos (point)))
        (fs-skip-spaces-forward)
        (setq n (- n 1)))
      (while (< 0 n)
        (forward-sexp 1)
        (setq terminator (fs-punctuation-chars))
        (skip-syntax-forward ".")
        (setq n (- n 1)))
      (fs-skip-spaces-forward)
      ;;(message "%s" terminator)
      terminator)))

(defun fs-looking-back-number ()
  (let ((p1 (point))
        (p0 nil))
    (if (= 0 (skip-chars-backward fs-elements-of-number))
        nil
      (setq p0 (point))
      (search-forward-regexp fs-number-regexp p1 t)
      (when (string-equal (match-string 0) (buffer-substring p0 (point)))
        (goto-char p0)))))

(defun fs-previous-sexp (&optional n)
  ""
  (interactive "p")
  (let ((pos (point))
        (terminator ""))
    (fs-skip-spaces-backward)
    (skip-syntax-backward ".")
    (cond ((looking-at fs-end-of-sentence-regexp)
           (setq terminator (string (char-after))))
          ((looking-at ":=")
           (setq terminator ":="))
          ((looking-at ":")
           (setq terminator ":")))
    (fs-skip-spaces-backward)
    (unless (fs-looking-back-number)
      (backward-sexp n))
    ;;(message "%s" terminator)
    (when (eq pos (point)) (signal 'scan-error (list "beginning of buffer" 0 0)))
    terminator))

(defun fs-looking-at-number ()
  ""
  (looking-at fs-number-regexp))

(defun fs-looking-at-method ()
  ""
  (or (looking-at fs-method-regexp)
      (looking-at ":[^=A-Za-z0-9_]")))

(defun fs-first-method-at-line ()
  ""
  (save-excursion
    (back-to-indentation)
    (if (fs-looking-at-method)
        (point)
      nil)))

(defun fs-last-sexp-of-sentencep ()
  ""
  (save-excursion
    (condition-case error
        (member (fs-next-sexp 1) '("." ";"))
      (scan-error t))))

(defun fs-method-beginning-position ()
  ""
  (let ((pos nil))
    (save-excursion
      (when (fs-last-sexp-of-sentencep)
        (fs-previous-sexp 1))
      (condition-case err
          (catch 'end
            (skip-syntax-backward "w'")
            (while t
              (when (fs-looking-at-method)
                (setq pos (point)))
              (when (or (member (fs-previous-sexp 1) '("." ";" ":="))
                        (= (point) (point-min)))
                (throw 'end nil))))
        (scan-error nil)))
    pos))

(defun fs-beginning-of-method ()
  ""
  (interactive)
  (let ((pos (fs-method-beginning-position)))
    (when pos (goto-char pos))))

(defun fs-current-indent ()
  "Calculate current indentation."
  (condition-case err
      (save-excursion
        (beginning-of-line)
        (backward-up-list)
        (back-to-indentation)
        (- (point) (line-beginning-position)))
    (scan-error (current-column))))

(defun fs-current-indent-list ()
  "Calculate current indent in list."
  (condition-case err
      (save-excursion 
        (beginning-of-line)
        (up-list -1)
        (+(current-column) 1))
    (scan-error 0)))

(defun fs-previous-indent ()
  (save-excursion
    (condition-case err
        (let ((terminator ""))
          (beginning-of-line)
          (while (not (member terminator '("." ";")))
            (setq terminator (fs-previous-sexp)))
          (while (not (string-equal (fs-previous-sexp) ".")))
          (cond
           ((string-equal terminator ".")
            (fs-next-sexp 1))
           ((string-equal terminator ";")
            (fs-next-sexp 2)))
          (- (point) (line-beginning-position)))
      (scan-error (- (third err) (line-beginning-position) -1)))))

(defun fs-indent-methodp ()
  ""
  (save-excursion
    (back-to-indentation)
    (let ((pos (fs-method-beginning-position)))
      (and pos
           (not (= pos (fs-first-method-at-line)))))))

(defun fs-goto-column (column &optional negative)
  "0 <=: from beginning, < 0: from end to beginning"
  (goto-char
   (cond
    ((and (<= 0 column) (eq negative nil))
     (min (line-end-position)
          (+ (line-beginning-position) column)))
    (t
     (max (line-beginning-position)
          (+ (line-end-position) column))))))

(defun fs-indent-line ()
  "Indent line."
  (interactive "*")
  (cond ((save-excursion
           (back-to-indentation)
           (fifth (parse-partial-sexp (point-min) (point))))
         (comment-indent-default))
        ((fs-indent-methodp)
         (fs-indent-method))
        (t
         (let ((rest (- (point) (line-end-position)))
               (pos (point))
               (line-indent (save-excursion
                              (back-to-indentation)
                              (current-column)))
               (indent (max ;;(fs-current-indent)
                        (fs-previous-indent)
                        (fs-current-indent-list)
                        )))
           (beginning-of-line)
           (just-one-space 0)
           (indent-to indent)
           (goto-char (fs-goto-column rest t))))))

(defun fs-indent-method ()
  ""
  (let ((rest (- (point) (line-end-position)))
        (pos 0)
        (col 0))
    (back-to-indentation)
    (setq pos (fs-method-beginning-position))
    (setq col (save-excursion
                (goto-char pos)
                (skip-syntax-forward "w")
                (forward-char)
                (current-column)))
    (beginning-of-line)
    (just-one-space 0)
    (search-forward ":")
    (setq col (max 0 (- col (current-column))))
    (beginning-of-line)
    (indent-to col)
    (goto-char (fs-goto-column rest t))))

(defun fs-indent-whole-buffer ()
  ""
  (interactive "*")
  (indent-region (point-min) (point-max)))

(defun fs-insert-colon (&optional n)
  ""
  (interactive "*p")
  (self-insert-command (if (eq n nil) 1 n))
  (fs-indent-line))

(defun fs-insert-equal (&optional n)
  ""
  (interactive "*p")
  (self-insert-command (if (eq n nil) 1 n))
  (fs-indent-line))

(defun fs-mark-word nil
  "mark a whole word"
  (interactive)
  (skip-syntax-backward "w")
  (set-mark (point))
  (skip-syntax-forward "w")
  )

(defun fs-mark-list nil
  "mark list"
  (interactive)
  (condition-case err
      (progn
        (backward-up-list)
        (mark-sexp))
    (scan-error (mark-paragraph))))

(defun fs-kill-buffer (buf)
  (condition-case nil
      (delete-window (get-buffer-window buf))
    (error nil))
  (kill-buffer buf))

(defun fs-shell-command (cmd)
  (let ((p0 (if mark-active (region-beginning) (point-min)))
        (p1 (if mark-active (region-end      ) (point-max)))
        (source (current-buffer))
        (buf "*F-Script*"))
    (when (get-buffer buf)
      (fs-kill-buffer buf))
    (kill-ring-save p0 p1)
    (when mark-active (deactivate-mark))
    (call-process "osascript" nil buf t "-sh" "-e"
                  (format fs-pboard-template cmd))
    (if (= 0 (buffer-size (get-buffer buf)))
        (fs-kill-buffer buf)
      (switch-to-buffer-other-window buf)
      (compilation-mode)
      (view-buffer buf 'fs-kill-buffer)
      (shrink-window-if-larger-than-buffer)
      (beginning-of-buffer)
      (search-forward-regexp fs-error-message-regexp)
      (when (match-beginning 1)
        (let ((pos (string-to-int (match-string 1)))
              (len (string-to-int (match-string 2))))
          (switch-to-buffer-other-window source)
          (push-mark)
          (push-mark (+ pos len))
          (goto-char pos))))))

(defun fs-execute-region nil
  (interactive)
  (save-buffer)
  (fs-shell-command fs-eval-pboard))

(defun fs-inspect-region nil
  (interactive)
  (save-excursion
   (unless mark-active
     (fs-mark-list))
   (fs-shell-command fs-inspect-pboard)))

(defun fs-search-forward-regexp (regexp)
  (let ((eob nil))
    (forward-sexp 2)
    (backward-sexp)
    (while (and (not eob)
                (not (looking-at regexp)))
      (forward-sexp 2)
      (setq eob (= (point-max) (point)))
      (when eob (signal 'scan-error (list "end of buffer" (point) (point))))
      (backward-sexp))))

(defun fs-search-backward-regexp (regexp)
  (let ((eob nil))
    (backward-sexp)
    (while (and (not eob)
                (not (looking-at regexp)))
      (setq eob (= (point-min) (point)))
      (when eob (signal 'scan-error (list "beginning of buffer" (point) (point))))
      (backward-sexp))))

(defun fs-search-regexp (regexp &optional n)
  (if n (fs-search-backward-regexp regexp)
    (fs-search-forward-regexp regexp)))

(defun fs-search-method ()
  (interactive)
  (when (fs-looking-at-method)
    (fs-forward-sentence)
    (forward-comment -1))
  (while (not (fs-looking-at-method))
      (forward-sexp 2)
      (when (= (point) (point-max)) (signal 'scan-error (list "end of buffer" (point) (point))))
      (backward-sexp)))
;;  (fs-search-regexp fs-method-regexp nil))

(defun fs-rsearch-method ()
  (interactive)
  (let ((pos (point)))
    (while (= pos (fs-beginning-of-method))
      (fs-backward-sentence)
      (forward-comment -1)
      (backward-char)
      (setq pos (point)))))

(defun fs-search-assign ()
  (interactive)
  (fs-search-regexp fs-assign-regexp nil))

(defun fs-rsearch-assign ()
  (interactive)
  (fs-search-regexp fs-assign-regexp t))

(defun fs-forward-sentence ()
  (interactive)
  (while (not (member (fs-next-sexp 1) '("." ";")))))

(defun fs-backward-sentence ()
  (interactive)
  (condition-case err
      (progn
        (while (not (member (fs-previous-sexp 1) '("." ";"))))
        (while (not (member (fs-previous-sexp 1) '("." ";"))))
        (fs-next-sexp 1))
    (scan-error (fs-skip-spaces-forward)
                ;;(goto-char (third err))
                (signal 'scan-error err))))

(defun fs-test ()
  (interactive)
  (message "<< test >>")
  (fs-beginning-of-method))

(defvar fs-mode-map
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap "\C-csa"		'fs-search-assign)
    (define-key keymap "\C-csm"		'fs-search-method)
    (define-key keymap "\C-cra"		'fs-rsearch-assign)
    (define-key keymap "\C-crm"		'fs-rsearch-method)
    (define-key keymap "\C-c\C-d"	'down-list)
    (define-key keymap "\C-c\C-e"	'up-list)
    (define-key keymap "\C-c\C-u"	'backward-up-list)
    (define-key keymap "\C-c\C-f"	'fs-next-sexp)
    (define-key keymap "\C-c\C-b"	'fs-previous-sexp)
    (define-key keymap "\C-c\C-n"	'fs-forward-sentence)
    (define-key keymap "\C-c\C-p"	'fs-backward-sentence)
    (define-key keymap "\C-cm"		'fs-beginning-of-method)
    (define-key keymap "\M-n"		'forward-list)
    (define-key keymap "\M-p"		'backward-list)
    (define-key keymap "\C-i"		'fs-indent-line)
    (define-key keymap "\C-c!"		'fs-inspect-region)
    (define-key keymap "\C-c\C-c"	'fs-execute-region)
    (define-key keymap "\C-c\""		'comment-region)
    (define-key keymap [?\C-c ?\C- ]	'fs-mark-list)
    (define-key keymap [?\C-c ? ]	'fs-mark-word)
    (define-key keymap "\C-c\C-t"	'fs-test)
    (define-key keymap ":"		'fs-insert-colon)
    (define-key keymap "="		'fs-insert-equal)
    keymap)
  "Keymap for F-Script mode")

(easy-menu-define
  expenses-menu fs-mode-map "F-Script Mode menu"
  '("F-Script"
    ["Prev Sentence"		fs-backward-sentence t]
    ["Next Sentence"		fs-forward-sentence t]
    ["Prev Assign"		fs-rsearch-assign t]
    ["Next Assign"		fs-search-assign t]
    ["Prev Method:"		fs-rsearch-method t]
    ["Next Method:"		fs-search-method t]
    "-"
    ["Mark List"		fs-mark-list t]
    ["Mark Word"		fs-mark-word t]
    ["Indent Whole Buffer"	fs-indent-whole-buffer t]
    "-"
    ["Up List"			backward-up-list t]
    ["Exit List"		up-list t]
    ["Down List"		down-list t]
    "-"
    ["Run Region"		fs-execute-region t]
    ["Inspect Region"		fs-inspect-region t]
    ))

(defun fs-mode ()
  "Major mode for editing F-Script code."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'fs-mode)
  (setq mode-name "F-Script")

  (use-local-map fs-mode-map)
  (set-syntax-table fs-mode-syntax-table)
  (set (make-local-variable 'indent-line-function)
       'fs-indent-line)
  (set (make-local-variable 'font-lock-defaults)  
       '(fs-font-lock-keywords-2
       ;;  fs-font-lock-keywords-1
       ;;  fs-font-lock-keywords
         ))
  (set (make-local-variable 'sentence-end) "\\(;\\|\\.[^0-9]\\)")
  (set (make-local-variable 'comment-start) "\"")
  (set (make-local-variable 'comment-end) "\"")
  (set (make-local-variable 'comment-column) 32)
  (set (make-local-variable 'comment-start-skip) "\" *")
  (run-hooks 'fs-mode-hook))

(push '("\\.fs\\'" . fs-mode) auto-mode-alist)
(provide 'fs-mode)
