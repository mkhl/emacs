
(defun hs-minor-mode-maybe ()
  (when (assoc major-mode hs-special-modes-alist)
    (hs-minor-mode 1)))

(defun hs-display-code-line-counts (overlay)
  (case (overlay-get overlay 'hs)
    ('code (let* ((beg (overlay-start overlay))
                  (end (overlay-end overlay))
                  (display (format "... (%d lines)" (count-lines beg end))))
             (overlay-put overlay 'face 'font-lock-comment-face)
             (overlay-put overlay 'display display)))))

(defun mk/setup-hideshow ()
  (mk/setup-objc-hs-mode)
  (mk/setup-ruby-hs-mode)
  (mk/setup-python-hs-mode)
  (mk/setup-espresso-hs-mode)
  (setq hs-set-up-overlay 'hs-display-code-line-counts)
  (add-hook 'find-file-hook 'hs-minor-mode-maybe))

(defun mk/setup-objc-hs-mode ()
  (aput 'hs-special-modes-alist 'objc-mode
        (aget hs-special-modes-alist 'c-mode)))

(defun mk/setup-ruby-hs-mode ()
  (aput 'hs-special-modes-alist 'ruby-mode
        (list (rx bow (| "class" "def" "do") eow) (rx bow "end" eow) "#"
              'ruby-end-of-block
              nil)))

(defun mk/setup-python-hs-mode ()
  (aput 'hs-special-modes-alist 'python-mode
        (list (rx bow (| "class" "def") eow) nil "#"
              (lambda (&optional arg) (py-end-of-def-or-class 'either arg))
              nil)))

(defun mk/setup-espresso-hs-mode ()
  (aput 'hs-special-modes-alist 'espresso-mode
        (aget hs-special-modes-alist 'c-mode)))

(when (require 'hideshow nil 'noerror)
  (mk/setup-hideshow))
