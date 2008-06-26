;;; hbfc.el --- highlight beyond the fill-column.

;;; Code:
(defgroup hbfc nil
  "Fontify beyond the fill-column."
  :group 'fill)

(defface hbfc-face
  '((((class color)) (:foreground "red" :inverse-video t))
    (t (:inverse-video t)))
  "Face used to highlight beyond the fill-column."
  :group 'hbfc)

(defconst hbfc-font-lock-keywords
  '((hbfc-font-lock-beyond-fill-column
     0 'hbfc-face t)))

(defun hbfc-font-lock-beyond-fill-column (bound)
  "Function for font-lock to highlight beyond the `fill-column' until BOUND."
  (when (eolp)
    (forward-line 1))
  (move-to-column fill-column)
  (while (and (< (point) bound)
              (<= (- (point-at-eol) (point-at-bol)) fill-column))
    (forward-line 1)
    (move-to-column fill-column))
  (let ((begin (point))
        (end (min (point-at-eol) bound)))
    (goto-char end)
    (when (and (< begin end))
      (set-match-data (list begin end))
      t)))

(defun hbfc-activate ()
  "Activate highlighting beyond the fill column."
  (font-lock-add-keywords nil hbfc-font-lock-keywords 'append))

(defun hbfc-deactivate ()
  "Deactivate highlighting beyond the fill column."
  (font-lock-remove-keywords nil hbfc-font-lock-keywords))

;;;###autoload
(define-minor-mode hbfc-mode
  "Toggle the highlight beyond fill column (hbfc) minor mode.
With prefix ARG, turn hbfc minor mode on iff ARG is positive."
  nil " hbfc" nil
  (cond
   (hbfc-mode
    (add-hook 'font-lock-mode-hook 'hbfc-activate nil 'local)
    (font-lock-mode -1)
    (font-lock-mode 1))
   (t
    (remove-hook 'font-lock-mode-hook 'hbfc-activate 'local)
    (hbfc-deactivate)
    (font-lock-fontify-buffer))))

(provide 'hbfc)

;;; hbfc.el ends here
