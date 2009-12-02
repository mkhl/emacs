
;; initial frame
(aput 'initial-frame-alist 'top 40)
(aput 'initial-frame-alist 'left 100)

;; default frame
(eval-after-init
  (aput 'default-frame-alist 'background-color "WhiteSmoke")
  (aput 'default-frame-alist 'cursor-color "black")
  (aput 'default-frame-alist 'cursor-type 'bar)
  (aput 'default-frame-alist 'weight 80)
  (aput 'default-frame-alist 'height 50)
  (aput 'default-frame-alist 'font (face-font 'default)))

;; special frames
(setq special-display-regexps (list (rx bos "*Help" eow)
                                    (rx bos "*Apropos" eow)
                                    (rx bos "*info" eow)
                                    (rx bos "*Man" eow)
                                    (rx bos "*WoMan" eow)))
(aput 'special-display-frame-alist 'height 30)

;; switch frames and windows
(global-set-key (kbd "M-`") #'next-multiframe-window)
(global-set-key (kbd "M-~") #'previous-multiframe-window)
