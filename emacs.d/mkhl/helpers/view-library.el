
(defun view-library ()
  (interactive)
  (let ((load-suffixes '(".el")))
    (view-file (call-interactively 'locate-library))))
