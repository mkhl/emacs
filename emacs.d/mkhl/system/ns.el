
(dolist* ((char . func) '((?h . ns-do-hide-emacs)
                          (?j . exchange-point-and-mark)
                          (?k . kill-this-buffer)
                          (?n . make-frame)
                          (?q . save-buffers-kill-emacs)
                          (?w . delete-frame)))
  (global-set-key (vector (list 'control 'meta 'shift char)) func))
