
;; Load packages installed via `elpa'
(when (require 'package "elpa/package" 'noerror)
  (package-initialize))
