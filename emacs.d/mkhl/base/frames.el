
;; frame-title
(setq frame-title-format '("%b" " - " invocation-name "@" system-name))

;; initial frame
(add-to-list 'initial-frame-alist '(top . 100))
(add-to-list 'initial-frame-alist '(left . 180))

;; default frame
(eval-after-init
  (add-to-list 'default-frame-alist '(background-color . "WhiteSmoke"))
  (add-to-list 'default-frame-alist '(cursor-color . "black"))
  (add-to-list 'default-frame-alist '(cursor-type . bar))
  (add-to-list 'default-frame-alist '(weight . 80))
  (add-to-list 'default-frame-alist '(height . 50))
  (add-to-list 'default-frame-alist `(font . ,(face-font 'default))))

;; switch frames
(global-set-key (kbd "C-M-`") 'switch-to-next-frame)
(global-set-key (kbd "C-M-~") 'switch-to-previous-frame)

(defun switch-to-next-frame (arg)
  (interactive "p")
  (other-frame arg))
(defun switch-to-previous-frame (arg)
  (interactive "p")
  (other-frame (- arg)))
