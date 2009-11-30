
(defun isearch-goto-other-end ()
  "Jump to the beginning of an isearch match after searching forward."
  (when (and isearch-forward isearch-other-end)
    (goto-char isearch-other-end)))

(defun mk/setup-isearch ()
  (global-set-key (kbd "C-s") #'isearch-forward)
  (global-set-key (kbd "C-S-s") #'isearch-backward)
  (global-set-key (kbd "C-M-s") #'isearch-forward-regexp)
  (global-set-key (kbd "C-M-S-s") #'isearch-backward-regexp)
  (define-key isearch-mode-map (kbd "C-s") #'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "C-S-s") #'isearch-repeat-backward)
  (define-key isearch-mode-map (kbd "C-M-s") #'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "C-M-S-s") #'isearch-repeat-backward)
  (add-hook 'isearch-mode-end-hook #'isearch-goto-other-end))

(eval-after-load "isearch"
  '(mk/setup-isearch))
