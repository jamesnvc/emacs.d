;;; multimarkdown-mode.el --- Major mode to edit Markdown files in Emacs
;;; Based on Jason Blevins' (jrblevin@sdf.lonestar.org) markdown-mode.el
;;; Modifications by James Cash <james.cash@occasionallycogent.com>
;;

(defconst multimarkdown-mode-version "1.0")

;; A hook for users to run their own code when the mode is loaded.
(defvar multimarkdown-mode-hook nil)


;;; Customizable variables ====================================================

(defgroup multimarkdown nil
  "MultiMarkdown mode."
  :prefix "multimarkdown-"
  :group 'languages)

(defcustom multimarkdown-command "Multimarkdown.pl"
  "Command to run MultiMarkdown."
  :group 'multimarkdown
  :type 'string)

(defcustom multimarkdown-xhtml-command "mmd2XHTML.pl"
  "Command to generate XHTML output from MultiMarkdown"
  :group 'multimarkdown
  :type 'string)

(defcustom multimarkdown-latex-command "mmd2latex.pl"
  "Command to generate LaTeX output from MultiMarkdown"
  :group 'multimarkdown
  :type 'string)

(defcustom multimarkdown-rtf-command "mmd2RTF.pl"
  "Command to generate RTF output from MultiMarkdown"
  :group 'multimarkdown
  :type 'string)

(defcustom multimarkdown-pdf-command "mmd2PDF.pl"
  "Command to generate PDF output from MultiMarkdown"
  :group 'multimarkdown
  :type 'string)

(defcustom multimarkdown-hr-length 5
  "Length of horizonal rules."
  :group 'multimarkdown
  :type 'integer)

(defcustom multimarkdown-bold-underscore nil
  "Use two underscores for bold instead of two asterisks."
  :group 'multimarkdown
  :type 'boolean)

(defcustom multimarkdown-italic-underscore nil
  "Use underscores for italic instead of asterisks."
  :group 'multimarkdown
  :type 'boolean)


;;; Regular expressions =======================================================

;; Metadata headers
(defconst metadata-headers
    (concat
     "^"
     (regexp-opt
      '("Title" "XHTML Header" "Author" "CSS" "Base Header Level"
        "LaTeX XSLT" "XMP" "Copyright" "Keywords" "Format") t)
     ":\\s *\\(.*\\)$"))

;; Links
(defconst regex-link-inline "\\(!?\\[.+?\\]\\)\\((.*)\\)"
  "Regular expression for a [text](file) or an image link ![text](file)")
(defconst regex-link-reference "\\(!?\\[.+?\\]\\)[ ]?\\(\\[.*?\\]\\)"
  "Regular expression for a reference link [text][id]")
(defconst regex-footnote-inline "\\(!?\\[\\^.+?\\]\\)"
  "Regular expression for a [^footnote]")
(defconst regex-reference-definition
  "^\\s*\\(\\[.+?\\]\\):\\s*\\([^\\s\n]+\\).*$"
  "Regular expression for a link definition [id]: ...")


;;; Font lock =================================================================

(defconst multimarkdown-mode-font-lock-keywords
  (list
   ;; Latex/itex
;   (cons "\\\\\\[[^$]+\\\\\\]" 'font-lock-string-face)
;   (cons "\\$\\$[^$]+\\$\\$" 'font-lock-string-face)
;   (cons "\\$[^$]+\\$" 'font-lock-string-face)
   ;; Headers and (Horizontal Rules)
   (cons metadata-headers '(1 'font-lock-comment-face))
   (cons metadata-headers '(2 'font-lock-doc-face))
   (cons ".*\n?===+" 'font-lock-function-name-face)     ; === headers
   (cons ".*\n?---+" 'font-lock-function-name-face)     ; --- headers
   (cons "^#+ .*$" 'font-lock-function-name-face)	; ### Headers
   (cons "^\\*[\\*\\s]*$" 'font-lock-function-name-face) ; * * * style HRs
   (cons "^-[-\\s]*$" 'font-lock-function-name-face)	; - - - style HRs
   ;; Blockquotes
   (cons "^>.*$" 'font-lock-comment-face)            ; > blockquote
   ;; Bold
   (cons "[^\\]?\\*\\*.+?\\*\\*" 'font-lock-type-face)     ; **bold**
   (cons "[^\\]?__.+?__" 'font-lock-type-face)             ; __bold__
   ;; Italic
   (cons "[^\\]?\\*.+?\\*" 'font-lock-variable-name-face)  ; *italic*
   (cons "[^\\]?_.+?_" 'font-lock-variable-name-face)      ; _italic_
   ;; Lists
   (cons "^[0-9]+\\." 'font-lock-variable-name-face) ; Numbered list
   (cons "^\\*" 'font-lock-variable-name-face)	     ; Level 1 (no indent)
   (cons "^\\+" 'font-lock-variable-name-face)	     ; Level 1 (no indent)
   (cons "^\\-" 'font-lock-variable-name-face)	     ; Level 1 (no indent)
   (cons "^  [ ]*\\*" 'font-lock-variable-name-face) ; Level 2 (two or more)
   (cons "^  [ ]*\\+" 'font-lock-variable-name-face) ; Level 2 (two or more)
   (cons "^  [ ]*\\-" 'font-lock-variable-name-face) ; Level 2 (two or more)
   ;; Links
   (cons regex-footnote-inline 'font-lock-string-face)
   (cons regex-link-inline '(1 'font-lock-string-face t))
   (cons regex-link-inline '(2 'font-lock-constant-face t))
   (cons regex-link-reference '(1 'font-lock-string-face t))
   (cons regex-link-reference '(2 'font-lock-comment-face t))
   (cons regex-reference-definition '(1 'font-lock-comment-face t))
   (cons regex-reference-definition '(2 'font-lock-constant-face t))
   ;; Wiki links
;   (cons "\\[\\[\\w+\\]\\]" 'font-lock-string-face)  ; Standard wiki link
   (cons "\\[\\[.+\\]\\]" 'font-lock-string-face)
   ;; Code
   (cons "``.+?``" 'font-lock-constant-face)         ; ``inline code``
   (cons "`.+?`" 'font-lock-constant-face)           ; `inline code`
   (cons "^    .*$" 'font-lock-constant-face)        ;     code block
   )
  "Syntax highlighting for MultiMarkdown files.")


;;; Element Insertion ==========================================================

(defun wrap-or-insert (s1 s2)
 "Insert the strings s1 and s2 around the current region or just insert them
if there is no region selected."
 (if (and transient-mark-mode mark-active)
     (let ((a (region-beginning)) (b (region-end)))
       (kill-region a b)
       (insert s1)
       (yank)
       (insert s2))
   (insert s1 s2)))

(defun multimarkdown-insert-hr ()
  "Insert a horizonal rule."
  (interactive)
  (let (hr)
    (dotimes (count (- multimarkdown-hr-length 1) hr)	; Count to n - 1
      (setq hr (concat "* " hr)))	                ; Build HR string
    (setq hr (concat hr "*\n"))				; Add the n-th *
    (insert hr)))

(defun multimarkdown-insert-bold ()
  "Make the active region bold or insert an empty bold word."
  (interactive)
  (if multimarkdown-bold-underscore
      (wrap-or-insert "__" "__")
    (wrap-or-insert "**" "**"))
  (backward-char 2))

(defun multimarkdown-insert-italic ()
  "Make the active region italic or insert an empty italic word."
  (interactive)
  (if multimarkdown-italic-underscore
      (wrap-or-insert "_" "_")
    (wrap-or-insert "*" "*"))
  (backward-char 1))

(defun multimarkdown-insert-code ()
  "Format the active region as inline code or insert an empty inline code
fragment."
  (interactive)
  (wrap-or-insert "`" "`")
  (backward-char 1))

(defun multimarkdown-insert-link ()
  "Creates an empty link of the form []().  If there is an active region,
this text will be used for the link text."
  (interactive)
  (wrap-or-insert "[" "]")
  (insert "()")
  (backward-char 1))

(defun multimarkdown-insert-image ()
  "Creates an empty image of the form ![]().  If there is an active region,
this text will be used for the alternate text for the image."
  (interactive)
  (wrap-or-insert "![" "]")
  (insert "()")
  (backward-char 1))

(defun multimarkdown-insert-header-1 ()
  "Creates a level 1 header"
  (interactive)
  (multimarkdown-insert-header 1))

(defun multimarkdown-insert-header-2 ()
  "Creates a level 2 header"
  (interactive)
  (multimarkdown-insert-header 2))

(defun multimarkdown-insert-header-3 ()
  "Creates a level 3 header"
  (interactive)
  (multimarkdown-insert-header 3))

(defun multimarkdown-insert-header-4 ()
  "Creates a level 4 header"
  (interactive)
  (multimarkdown-insert-header 4))

(defun multimarkdown-insert-header-5 ()
  "Creates a level 5 header"
  (interactive)
  (multimarkdown-insert-header 5))

(defun multimarkdown-insert-header (n)
  "Creates a level n header.  If there is an active region, it is used as the
header text."
  (interactive "p")
  (unless n				; Test to see if n is defined
    (setq n 1))				; Default to level 1 header
  (let (hdr)
    (dotimes (count n hdr)
      (setq hdr (concat "#" hdr)))	; Build a ### header string
    (setq hdrl (concat hdr " "))
    (setq hdrr (concat " " hdr))
    (wrap-or-insert hdrl hdrr))
  (backward-char (+ 1 n)))

(defun multimarkdown-insert-title ()
  "Use the active region to create an \"equals\" style title or insert
a blank title and move the cursor to the required position in order to
insert a title."
  (interactive)
  (if (and transient-mark-mode mark-active)
      (let ((a (region-beginning))
	    (b (region-end))
	    (len 0)
	    (hdr))
	(setq len (- b a))
	(dotimes (count len hdr)
	  (setq hdr (concat "=" hdr)))	; Build a === title underline
	(end-of-line)
	(insert "\n" hdr "\n"))
    (insert "\n==========\n")
    (backward-char 12)))

(defun multimarkdown-insert-section ()
  "Use the active region to create a dashed style section or insert
a blank section and move the cursor to the required position in order to
insert a section."
  (interactive)
  (if (and transient-mark-mode mark-active)
      (let ((a (region-beginning))
	    (b (region-end))
	    (len 0)
	    (hdr))
	(setq len (- b a))
	(dotimes (count len hdr)
	  (setq hdr (concat "-" hdr)))	; Build a --- section underline
	(end-of-line)
	(insert "\n" hdr "\n"))
    (insert "\n----------\n")
    (backward-char 12)))

(defun multimarkdown-insert-blockquote ()
  "Start a blank blockquote section unless there is an active region, in
which case it is turned into a blockquote region."
  (interactive)
  (if (and (boundp 'transient-mark-mode) transient-mark-mode mark-active)
      (blockquote-region)
    (insert "> ")))


;;; Keymap ====================================================================

(defvar multimarkdown-mode-map
  (let ((multimarkdown-mode-map (make-keymap)))
    ;; Element insertion
    (define-key multimarkdown-mode-map "\C-c\C-al" 'multimarkdown-insert-link)
    (define-key multimarkdown-mode-map "\C-c\C-ii" 'multimarkdown-insert-image)
    (define-key multimarkdown-mode-map "\C-c\C-t1" 'multimarkdown-insert-header-1)
    (define-key multimarkdown-mode-map "\C-c\C-t2" 'multimarkdown-insert-header-2)
    (define-key multimarkdown-mode-map "\C-c\C-t3" 'multimarkdown-insert-header-3)
    (define-key multimarkdown-mode-map "\C-c\C-t4" 'multimarkdown-insert-header-4)
    (define-key multimarkdown-mode-map "\C-c\C-t5" 'multimarkdown-insert-header-5)
    (define-key multimarkdown-mode-map "\C-c\C-pb" 'multimarkdown-insert-bold)
    (define-key multimarkdown-mode-map "\C-c\C-ss" 'multimarkdown-insert-bold)
    (define-key multimarkdown-mode-map "\C-c\C-pi" 'multimarkdown-insert-italic)
    (define-key multimarkdown-mode-map "\C-c\C-se" 'multimarkdown-insert-italic)
    (define-key multimarkdown-mode-map "\C-c\C-pf" 'multimarkdown-insert-code)
    (define-key multimarkdown-mode-map "\C-c\C-sc" 'multimarkdown-insert-code)
    (define-key multimarkdown-mode-map "\C-c\C-sb" 'multimarkdown-insert-blockquote)
    (define-key multimarkdown-mode-map "\C-c-" 'multimarkdown-insert-hr)
    (define-key multimarkdown-mode-map "\C-c\C-tt" 'multimarkdown-insert-title)
    (define-key multimarkdown-mode-map "\C-c\C-ts" 'multimarkdown-insert-section)
    ;; Multimarkdown functions
    (define-key multimarkdown-mode-map "\C-c\C-cm" 'multimarkdown)
    (define-key multimarkdown-mode-map "\C-c\C-cp" 'multimarkdown-preview)
    multimarkdown-mode-map)
  "Keymap for Multimarkdown major mode")


;;; Multimarkdown ==================================================================

(defun multimarkdown ()
  "Run multimarkdown on the current buffer and preview the output in another buffer."
  (interactive)
  (if (and (boundp 'transient-mark-mode) transient-mark-mode mark-active)
      (shell-command-on-region region-beginning region-end multimarkdown-command
                               "*multimarkdown-output*" nil)
      (shell-command-on-region (point-min) (point-max) multimarkdown-command
                               "*multimarkdown-output*" nil)))

(defun multimarkdown-preview ()
  "Run multimarkdown on the current buffer and preview the output in a browser."
  (interactive)
  (multimarkdown)
  (browse-url-of-buffer "*multimarkdown-output*"))

(defun multimarkdown-export (export-fn)
  "Run multimarkdown on the current buffer and export in the given format"
  (interactive)
    (if (and (boundp 'transient-mark-mode) transient-mark-mode mark-active)
        (shell-command-on-region region-beginning region-end export-fn
                                 "*multimarkdown-output*" nil)
        (shell-command (concat export-fn " \"" (buffer-file-name) "\""))
        ))

(defun multimarkdown-export-as-latex ()
  "Run multimarkdown on the current buffer and export as LaTeX"
  (interactive)
    (multimarkdown-export multimarkdown-latex-command))

(defun multimarkdown-export-as-xhtml ()
  "Run multimarkdown on the current buffer and export as XHTML"
  (interactive)
    (multimarkdown-export multimarkdown-xhtml-command))

(defun multimarkdown-export-as-rtf ()
  "Run multimarkdown on the current buffer and export as RTF"
  (interactive)
    (multimarkdown-export multimarkdown-rtf-command))

(defun multimarkdown-export-as-pdf ()
  "Run multimarkdown on the current buffer and export as PDF"
  (interactive)
    (multimarkdown-export multimarkdown-pdf-command))


;;; Utilities =================================================================

(defun multimarkdown-show-version ()
  "Show the version number in the minibuffer."
  (interactive)
  (message "multimarkdown-mode, version %s" multimarkdown-mode-version))

(defun blockquote-region ()
  "Blockquote an entire region."
  (interactive)
  (if (and (boundp 'transient-mark-mode) transient-mark-mode mark-active)
      (replace-regexp "^" "> ")))


;; Mode definition  ===========================================================

;;;###autoload
(define-derived-mode multimarkdown-mode fundamental-mode "Multimarkdown"
  "Major mode for editing Multimarkdown files."
  ;; Font lock.
  (set (make-local-variable 'font-lock-defaults)
       '(multimarkdown-mode-font-lock-keywords))
  (set (make-local-variable 'font-lock-multiline) t))

(provide 'multimarkdown-mode)
;;; multimarkdown-mode.el ends here
