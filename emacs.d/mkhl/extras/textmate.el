
;; emulate textmate bindings
(global-set-key [(meta return)] 'next-line-and-indent)
(global-set-key [(meta shift d)] 'duplicate-line-or-region)
(global-set-key [(meta shift k)] 'kill-whole-line)
(global-set-key [(meta shift l)] 'mark-line)
(global-set-key [(meta q)] 'fill-paragraph-or-region)
(global-set-key [(meta u)] 'upcase-word-or-region)
(global-set-key [(meta shift u)] 'downcase-word-or-region)
(global-set-key [(control meta u)] 'upcase-initials-line-or-region)

;; load `textmate' library
(require 'textmate nil 'noerror)
