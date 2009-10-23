;;; indent-tabs-maybe.el --- guess whether to use indent-tabs-mode when finding file

;; Copyright (C) 2003  Free Software Foundation, Inc.

;; Author: Dave Love <fx@gnu.org>
;; Keywords: convenience, files

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.


;;; Commentary:

;; Defines function `indent-tabs-maybe' for addition to
;; `find-file-hooks'.  Allows setting `indent-tabs-mode' appropriate
;; to the file's existing indentation style.

;;; Code:

(defcustom indent-tabs-maybe-search-size 10000
  "Number of characters from start of buffer within which to look for tabs.
See `indent-tabs-maybe'."
  :group 'indent
  :type 'integer)

(defun indent-tabs-maybe ()
    "Set `indent-tabs-mode' according to buffer contents.
If the current buffer contains a line with a leading tab within the first
`indent-tabs-maybe-search-size' characters, use t, otherwise nil.
Exception: do nothing if buffer is empty.
Intended for use in `find-file-hooks'."
    (when (> (point-max) 1)
      (save-excursion
        (save-restriction
          (widen)
          (goto-char 1)
          (if (re-search-forward "^\t" indent-tabs-maybe-search-size t)
              (setq indent-tabs-mode t)
            (setq indent-tabs-mode nil))))))

;; Have it show up in the right place under Custom.
(add-hook 'find-file-hooks
          'indent-tabs-maybe)

(provide 'indent-tabs-maybe)
;;; indent-tabs-maybe.el ends here
