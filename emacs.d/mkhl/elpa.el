
(require 'package)
(package-initialize)

(eval-after-load "yasnippet-bundle"
  '(defadvice yas/expand (around mkhl-yas/expand-or-indent)
     (let ((in-indentation? (looking-back (rx bol (0+ blank)))))
       (if in-indentation?
           (funcall (or (lookup-key (current-local-map) yas/trigger-key)
                        (lookup-key (current-global-map) yas/trigger-key)))
         ad-do-it))))
