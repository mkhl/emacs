
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
                                 "*Ido Completions*"))
(when special-display-regexps
  (setq special-display-regexps '("[ ]?\\*info.*\\*[ ]?"
                                  "[ ]?\\*[hH]elp.*"
                                  "[ ]?\\*Messages\\*[ ]?"
                                  "[ ]?\\*Open Recent\\*[ ]?"
                                  ".*SPEEDBAR.*"
                                  "[ ]?\\*.*\\*[ ]?")))

(dolist (pair '((aquamacs osx-key-mode-map)
                (mac-key-mode mac-key-mode-map)))
  (destructuring-bind (feature mode-map) pair
    (eval-after-load feature
      `(progn

         ;; Tiny Mac-like CUA
         (define-key ,mode-map [(alt x)] 'kill-region)
         (define-key ,mode-map [(alt c)] 'copy-region-as-kill)
         (define-key ,mode-map [(alt v)] 'yank)
         (define-key ,mode-map [(alt shift v)] 'yank-pop)

         ;; Alt-Control motion
         (define-key ,mode-map [(alt control up)] 'up-list)
         (define-key ,mode-map [(alt control down)] 'down-list)
         (define-key ,mode-map [(alt control left)] 'backward-sexp)
         (define-key ,mode-map [(alt control right)] 'forward-sexp)

         ;; TextMate-like convenience
         (define-key ,mode-map [(alt return)] 'my/next-line-and-indent)
         (define-key ,mode-map [(alt shift d)] 'my/duplicate-line-or-region)
         (define-key ,mode-map [(alt shift k)] 'kill-whole-line)
         (define-key ,mode-map [(alt shift l)] 'my/mark-line)
         (define-key ,mode-map [(alt \;)] 'comment-dwim)

         ;; Auto-Pairs (TextMate)
         (dolist (pair '((\( . \)) (\[ . \]) (\{ . \})))
           (destructuring-bind (car . cdr) pair
             (define-key ,mode-map (vector (list 'alt car)) 'insert-pair)
             (define-key ,mode-map (vector (list 'alt cdr)) 'up-list)))
         (define-key ,mode-map [(alt \')] 'my/insert-pair-or-skip)
         (define-key ,mode-map [(alt \")] 'my/insert-pair-or-skip)

         ;; The end
         ))))
