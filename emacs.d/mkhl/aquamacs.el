
;; Same-window tweaks
(setq same-window-buffer-names '("*scratch*"
                                 "*eshell*"
                                 "*shell*"
                                 "*mail*"
                                 "*inferior-lisp*"
                                 "*ielm*"
                                 "*scheme*"
                                 "*Ibuffer*"
                                 "*gitsum*"
                                 "*Completions*"
                                 "*Ido Completions*")
      special-display-regexps '("[ ]?\\*info.*\\*[ ]?"
                                "[ ]?\\*[hH]elp.*"
                                "[ ]?\\*Messages\\*[ ]?"
                                "[ ]?\\*Open Recent\\*[ ]?"
                                ".*SPEEDBAR.*"
                                "[ ]?\\*.*\\*[ ]?"))

;; Alt-Control motion
(define-key osx-key-mode-map [(alt control up)] 'up-list)
(define-key osx-key-mode-map [(alt control down)] 'down-list)
(define-key osx-key-mode-map [(alt control left)] 'backward-sexp)
(define-key osx-key-mode-map [(alt control right)] 'forward-sexp)

;; Programming convenience
(define-key osx-key-mode-map [(alt return)] 'my/next-line-and-indent)
(define-key osx-key-mode-map [(alt \;)] 'comment-or-uncomment-region-or-line)
