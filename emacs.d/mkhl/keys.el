
;; Don't use Alt-x, use Ctrl-x-m
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Buffer switching
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; (require 'bs)
;; (global-set-key (kbd "C-x C-b") 'bs-show)

;; Directory editing
(global-set-key (kbd "C-x C-d") 'dired)

;; Undo/Redo
(when (require 'redo nil 'noerror)
  (global-set-key (kbd "C-_") 'undo)
  (global-set-key (kbd "M-_") 'redo)
  (global-set-key (kbd "C-z") 'undo)
  (global-set-key (kbd "M-z") 'redo))

;; Shifted motion
(setq cua-highlight-region-shift-only t)
(cua-selection-mode t)

;; Tab switching
(labels ((goto-next-window ()
           (interactive)
           (other-window 1))
         (goto-previous-window ()
           (interactive)
           (other-window -1)))
  (global-set-key (kbd "C-<tab>") #'goto-next-window)
  (global-set-key (kbd "C-S-<tab>") #'goto-previous-window))

(when (featurep 'aquamacs)
  ;; Tab switching
  (global-set-key (kbd "C-<tab>") 'next-tab-or-buffer)
  (global-set-key (kbd "C-S-<tab>") 'previous-tab-or-buffer)
  (define-key osx-key-mode-map (kbd "A-C-<right>") 'next-tab-or-buffer)
  (define-key osx-key-mode-map (kbd "A-C-<left>") 'previous-tab-or-buffer)

  ;; Comment/Uncomment
  (define-key osx-key-mode-map (kbd "A-;") 'comment-or-uncomment-region))

;; Next line (TextMate)
(labels ((next-line-and-indent ()
           (interactive)
           (end-of-line)
           (newline-and-indent)))
  (if (featurep 'aquamacs)
      (define-key osx-key-mode-map (kbd "A-<return>") #'next-line-and-indent)
    (global-set-key (kbd "M-<return>") #'next-line-and-indent)))

;; Indent yanked text
;; - This doesn't work because the defadvice bodies are only executed
;;   when the advised function was called, i.e. outside of the lexical
;;   environment defined with let and labels.
;; - Workaround: Code duplication. Whoopdeedoo.
;; (let ((indenting-modes '(emacs-lisp-mode
;;                          scheme-mode
;;                          lisp-mode
;;                          c-mode
;;                          c++-mode
;;                          objc-mode
;;                          latex-mode
;;                          plain-tex-mode)))
;;   (labels ((indent-yanked-region ()
;;              (when (member major-mode indenting-modes)
;;                (let ((mark-even-if-inactive t))
;;                  (indent-region (region-beginning) (region-end) nil)))))
;;     (defadvice yank (after mkhl/indent-region activate)
;;       (funcall #'indent-yanked-region))
;;     (defadvice yank-pop (after indent-region activate)
;;       (funcall #'indent-yanked-region))))

;; Kill and join
(defadvice kill-line (around mkhl/kill-or-join-line activate)
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    ad-do-it))
