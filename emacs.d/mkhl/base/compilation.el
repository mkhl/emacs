
(when (fboundp 'compilation-recenter-end-enable)
  (add-hook 'compilation-mode-hook 'compilation-recenter-end-enable))
