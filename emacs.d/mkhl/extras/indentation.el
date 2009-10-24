
(when (fboundp 'indent-tabs-maybe)
  (add-hook 'find-file-hook 'indent-tabs-maybe 'append))
