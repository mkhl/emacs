
(defvar indent-region-modes '(emacs-lisp-mode
                              lisp-mode
                              scheme-mode
                              clojure-mode
                              c-mode
                              c++-mode
                              objc-mode)
  "List of modes that support smart indentation of the region.")

(defun indent-yanked-region ()
  (when (or (member major-mode indent-region-modes)
            (derived-mode-p indent-region-modes))
    (let* ((mark-even-if-inactive t))
      (indent-region (region-beginning) (region-end)))))

(defadvice yank (after indent-region activate)
  "Indent yanked text if `major-mode' supports it."
  (indent-yanked-region))

(defadvice yank-pop (after indent-region activate)
  "Indent yanked text if `major-mode' supports it."
  (indent-yanked-region))
