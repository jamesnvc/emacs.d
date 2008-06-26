(define-derived-mode
  d-mode
  c-mode
  "D Mode"
  "Major Mode for editing D code."
  ;; Various settings we want on go here: e.g.
  ;;   (set (make-local-variable
  ;;       'require-final-newline)
  ;;      mode-require-final-newline))
  (font-lock-add-keywords 'd-mode '(("\\(import\\)" . font-lock-keyword-face)
				    ("\\(template\\)" . font-lock-keyword-face)
				    ("\\(foreach\\)" . font-lock-keyword-face)))
  )

(defvar d-mode-map
  (let ((map c-mode-map)) ;; To make a new one would be (make-sparse-keymap)
    ;; (define-key map (kbd "C-c C-c") 'some-new-command)
    map)
  "Keymap for `D-mode'.")

;; (defvar d-mode-syntax-table
;;   (let ((syn (copy-syntax-table c-mode-syntax)))
;;     (modify-syntax-entry )
