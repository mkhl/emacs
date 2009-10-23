
(defun define-tab-width (width)
  "Define `tab-width' and `tab-stop-list' to match the WIDTH."
  (setq tab-width width)
  (set (make-local-variable 'tab-stop-list) (number-sequence width 120 width)))

(defun set-indent-to-tab-stops ()
  "Make sure the current buffer indents with `tab-to-tab-stop'."
  (set (make-local-variable 'indent-line-function) 'tab-to-tab-stop)
  (when (boundp 'yas/indent-line)
    (set (make-local-variable 'yas/indent-line) 'fixed)))
