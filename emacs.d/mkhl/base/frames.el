
;; initial frame
(add-to-list 'initial-frame-alist '(top . 40))
(add-to-list 'initial-frame-alist '(left . 100))

;; default frame
(eval-after-init
  (add-to-list 'default-frame-alist '(background-color . "WhiteSmoke"))
  (add-to-list 'default-frame-alist '(cursor-color . "black"))
  (add-to-list 'default-frame-alist '(cursor-type . bar))
  (add-to-list 'default-frame-alist '(weight . 80))
  (add-to-list 'default-frame-alist '(height . 50))
  (add-to-list 'default-frame-alist `(font . ,(face-font 'default))))

;; special frames
(setq special-display-regexps `(,(rx bos "*Help" eow)
                                ,(rx bos "*Apropos" eow)
                                ,(rx bos "*info" eow)
                                ,(rx bos "*Man" eow)
                                ,(rx bos "*WoMan" eow)))
(add-to-list 'special-display-frame-alist '(height . 24))

;; switch frames
(global-set-key (kbd "C-M-`") 'ns-next-frame)
(global-set-key (kbd "C-M-~") 'ns-prev-frame)
