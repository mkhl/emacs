
(defun minibuffer-truncate-lines ()
  (setq truncate-lines nil))
(add-hook 'minibuffer-setup-hook 'minibuffer-truncate-lines)
