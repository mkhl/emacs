
;; emulate textmate bindings
(global-set-key (kbd "M-RET") #'next-line-and-indent)
(global-set-key (kbd "M-;") #'comment-or-uncomment-region-or-line)
(global-set-key (kbd "M-l") #'goto-line)
(global-set-key (kbd "M-q") #'fill-paragraph-or-region)
(global-set-key (kbd "M-u") #'upcase-word-or-region)
(global-set-key (kbd "M-U") #'downcase-word-or-region)
(global-set-key (kbd "M-B") #'mark-sexp)
(global-set-key (kbd "M-L") #'mark-line)
(global-set-key (kbd "C-S-d") #'duplicate-line-or-region)
(global-set-key (kbd "C-S-k") #'kill-whole-line)
(global-set-key (kbd "C-S-j") #'join-line-with-next)
(global-set-key (kbd "C-S-w") #'mark-word)
