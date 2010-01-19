
(let ((factor-prefix (file-name-as-directory "/opt/factor")))
 (setq fuel-listener-factor-binary (concat factor-prefix "factor")
       fuel-listener-factor-image (concat factor-prefix "factor.image")))

(load "fu" 'noerror)
