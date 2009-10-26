
(if (fboundp 'ns-do-hide-emacs)
    (defalias 'mac-hide-emacs 'ns-do-hide-emacs)
  (defun mac-hide-emacs ()
    (interactive)
    (do-applescript (format "\
tell application \"System Events\"
    tell application process \"%s\"
        set visible to false
    end tell
end tell" invocation-name))))

(global-set-key [(control meta shift h)] 'mac-hide-emacs)
