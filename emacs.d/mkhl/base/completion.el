

(global-set-key [(control tab)] 'hippie-expand)

(setq hippie-expand-try-functions-list '(try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))
