
;; Don't use Alt-x, use Ctrl-x-m
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Buffer switching
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; (global-set-key (kbd "C-x C-b") 'bs-show)

;; Directory editing
(global-set-key (kbd "C-x C-d") 'dired)

;; Symbol completion
(global-set-key (kbd "S-<tab>") 'hippie-expand)

;; Undo/Redo
(when (require 'redo nil 'noerror)
  (global-set-key (kbd "M-z") 'undo)
  (global-set-key (kbd "M-Z") 'redo))

;; Shifted motion
(setq cua-highlight-region-shift-only t)
(cua-selection-mode t)

;; Meta motion
(global-set-key (kbd "M-<up>") 'backward-paragraph)
(global-set-key (kbd "M-<down>") 'forward-paragraph)

;; Tab switching
(windmove-default-keybindings 'control)

;; Next line (TextMate)
(labels ((next-line-and-indent ()
           (interactive)
           (end-of-line)
           (if (not (eq indent-line-function 'tab-to-tab-stop))
               (newline-and-indent)
             (newline)
             (indent-to-column
              (save-excursion (forward-line -1)
                              (back-to-indentation)
                              (current-column))))))
  (if (featurep 'aquamacs)
      (define-key osx-key-mode-map (kbd "A-<return>") #'next-line-and-indent)
    (global-set-key (kbd "M-<return>") #'next-line-and-indent)))

;; Auto-Pairs (TextMate)
(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-]") 'up-list)
(global-set-key (kbd "M-{") 'insert-pair)
(global-set-key (kbd "M-}") 'up-list)

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
