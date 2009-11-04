
;; switch windows
(global-set-key (kbd "M-`") 'switch-to-next-window)
(global-set-key (kbd "M-~") 'switch-to-previous-window)

(defun switch-to-next-window (arg)
  (interactive "p")
  (other-window arg))
(defun switch-to-previous-window (arg)
  (interactive "p")
  (other-window (- arg)))
