
(defun isearch-goto-other-end ()
  "Jump to the beginning of an isearch match after searching forward."
  (when (and isearch-forward isearch-other-end)
    (goto-char isearch-other-end)))

(eval-after-load "isearch"
  '(progn
     (global-set-key [(control s)] 'isearch-forward)
     (global-set-key [(control S)] 'isearch-backward)
     (global-set-key [(control meta s)] 'isearch-forward-regexp)
     (global-set-key [(control meta S)] 'isearch-backward-regexp)
     (define-key isearch-mode-map [(control s)] 'isearch-repeat-forward)
     (define-key isearch-mode-map [(control S)] 'isearch-repeat-backward)
     (define-key isearch-mode-map [(control meta s)]
       'isearch-repeat-forward-regexp)
     (define-key isearch-mode-map [(control meta S)]
       'isearch-repeat-backward-regexp)
     (global-set-key [(control *)] 'isearch-forward-at-point)
     (add-hook 'isearch-mode-end-hook 'isearch-goto-other-end)))
