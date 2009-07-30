
(when (featurep 'mouse)
  ;; Mouse
  ;; (require 'scroll-in-place nil 'noerror)
  (setq mouse-yank-at-point t
        mouse-wheel-follow-mouse t
        mouse-wheel-progressive-speed nil
        mouse-avoidance-mode 'exile
        mac-emulate-three-button-mouse nil))
