
(defun isearch-goto-other-end ()
  "Jump to the beginning of an isearch match after searching forward."
  (when (and isearch-forward isearch-other-end)
    (goto-char isearch-other-end)))

(defun mk/eval-after-isearch ()
  (global-set-key (kbd "C-s") 'isearch-forward)
  (global-set-key (kbd "C-S") 'isearch-backward)
  (global-set-key (kbd "C-M-s") 'isearch-forward-regexp)
  (global-set-key (kbd "C-M-S") 'isearch-backward-regexp)
  (define-key isearch-mode-map (kbd "C-s") 'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "C-S") 'isearch-repeat-backward)
  (define-key isearch-mode-map (kbd "C-M-s") 'isearch-repeat-forward-regexp)
  (define-key isearch-mode-map (kbd "C-M-S") 'isearch-repeat-backward-regexp)
  (add-hook 'isearch-mode-end-hook 'isearch-goto-other-end))

(eval-after-load "isearch"
  '(mk/eval-after-isearch))
