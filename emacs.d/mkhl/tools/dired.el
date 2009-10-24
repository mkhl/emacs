
(defun dired-open-file ()
  "In Dired, open the file or directory named on this line in Finder.app."
  (interactive)
  (let* ((file-name (dired-get-file-for-visit))
         (open-program "/usr/bin/open"))
    (when (file-exists-p file-name)
      (call-process open-program nil 0 nil file-name))))

(defun dired-generate-autoloads ()
  "Update the autoloads for marked (or next arg) Emacs Lisp files."
  (interactive)
  (dolist (file (dired-get-marked-files nil current-prefix-arg))
    (update-file-autoloads file 'save)))

(when (require 'dired-x)
  (setq-default dired-omit-mode t)
  (setq dired-omit-files (rx bos (| (: (? ".") "#")
                                    (: ".")))))

(define-key dired-mode-map [(meta o)] 'dired-open-file)
(define-key dired-mode-map [(-)] 'dired-up-directory)

(global-set-key [(control x) (control d)] 'dired)