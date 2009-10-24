
;; Fix `system-name' on Darwin
(case system-type
  ('darwin (setq system-name (first (split-string system-name "\\.")))))
