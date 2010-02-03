
(when (load "fu" 'noerror)
  (setq fuel-factor-fuel-dir (file-truename fuel-factor-fuel-dir)
        fuel-factor-root-dir (expand-file-name "../../" fuel-factor-fuel-dir)))
