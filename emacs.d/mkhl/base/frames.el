
;; frame-title
(setq frame-title-format '("%b" " - " invocation-name "@" system-name))

;; initial frame
(add-to-list 'initial-frame-alist '(top . 100))
(add-to-list 'initial-frame-alist '(left . 180))

;; default frame
(eval-after-init
  (add-to-list 'default-frame-alist '(height . 50))
  (add-to-list 'default-frame-alist `(font . ,(face-font 'default))))

;; switch frames
(global-set-key [(control meta \`)] 'switch-to-next-frame)
(global-set-key [(control meta ~)] 'switch-to-previous-frame)

(defun switch-to-next-frame (arg)
  (interactive "p")
  (other-frame arg))
(defun switch-to-previous-frame (arg)
  (interactive "p")
  (other-frame (- arg)))
