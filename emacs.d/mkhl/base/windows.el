
;;; `windmove'

(let ((modifier '(control meta)))
  (global-set-key (vector `(,@modifier left))  'windmove-left)
  (global-set-key (vector `(,@modifier right)) 'windmove-right)
  (global-set-key (vector `(,@modifier up))    'windmove-up)
  (global-set-key (vector `(,@modifier down))  'windmove-down))
