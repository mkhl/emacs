
(defun hs-display-code-line-counts (overlay)
  (case (overlay-get overlay 'hs)
    ('code (let* ((beg (overlay-start overlay))
                  (end (overlay-end overlay))
                  (display (format "... (%d lines)" (count-lines beg end))))
             (overlay-put overlay 'face 'font-lock-comment-face)
             (overlay-put overlay 'display display)))))

(defun mk/eval-after-hideshow ()
  (mk/setup-ruby-hs-mode)
  (setq hs-set-up-overlay 'hs-display-code-line-counts))

(defun mk/setup-ruby-hs-mode ()
  (pushnew (list 'ruby-mode
                 (rx bow (| "class" "def" "do") eow)
                 (rx bow "end" eow)
                 "#"
                 'ruby-end-of-block
                 nil)
           hs-special-modes-alist
           :key 'car))

(eval-after-load 'hideshow
  '(mk/eval-after-hideshow))
