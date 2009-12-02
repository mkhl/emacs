
(global-set-key (kbd "<s-left>") #'move-beginning-of-line)
(global-set-key (kbd "<s-right>") #'move-end-of-line)
(global-set-key (kbd "<s-up>") #'beginning-of-buffer)
(global-set-key (kbd "<s-down>") #'end-of-buffer)

(global-set-key (kbd "<C-left>") #'backward-word)
(global-set-key (kbd "<C-right>") #'forward-word)
(global-set-key (kbd "<M-up>") #'backward-paragraph)
(global-set-key (kbd "<M-down>") #'forward-paragraph)
(global-set-key (kbd "M-p") #'backward-paragraph)
(global-set-key (kbd "M-n") #'forward-paragraph)

(global-set-key (kbd "C-M-n") #'up-list)
(global-set-key (kbd "C-M-p") #'backward-down-list)
(global-set-key (kbd "C-M-u") #'backward-up-list)
(global-set-key (kbd "C-M-d") #'down-list)
