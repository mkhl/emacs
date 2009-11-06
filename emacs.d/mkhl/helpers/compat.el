
(unless (fboundp 'region-active-p)
  (defun region-active-p ()
    "Return t if Transient Mark mode is enabled and the mark is active."
    (and transient-mark-mode mark-active)))
