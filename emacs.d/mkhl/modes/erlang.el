
(when (require 'erlang-start nil 'noerror)
  (let ((start (file-name-directory (file-truename (locate-library "erlang")))))
    (setq erlang-root-dir (expand-file-name "../../../../.." start))))

