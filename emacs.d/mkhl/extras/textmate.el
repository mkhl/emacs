
;; emulate textmate bindings
(global-set-key (kbd "M-RET") #'next-line-and-indent)
(global-set-key (kbd "M-;") #'comment-dwim)
(global-set-key (kbd "M-D") #'duplicate-line-or-region)
(global-set-key (kbd "M-K") #'kill-whole-line)
(global-set-key (kbd "M-l") #'goto-line)
(global-set-key (kbd "M-L") #'mark-line)
(global-set-key (kbd "M-q") #'fill-paragraph-or-region)
(global-set-key (kbd "M-u") #'upcase-word-or-region)
(global-set-key (kbd "M-U") #'downcase-word-or-region)
