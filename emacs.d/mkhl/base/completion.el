
(global-set-key [(control tab)] 'hippie-expand)
(global-set-key [(meta /)] 'hippie-expand)

(setq hippie-expand-try-functions-list
      '(try-expand-all-abbrevs
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-expand-whole-kill))
