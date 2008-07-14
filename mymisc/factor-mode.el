;;; factor-mode.el --- Factor mode for Emacs

;; Copyright (C) 2008  James Cash

;; Author: James Cash <james.nvc@gmail.com>
;; Keywords: languages, factor

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;

;;; Code:

(defgroup factor nil
  "Factor mode"
  :tag "Factor"
  :group 'languages
  :prefix "factor-")

(defcustom factor-mode-hook nil
  "Hook for customizing `factor-mode'"
  :group 'factor
  :type 'hook)

(defface factor-word-def
    '(
      (((class color) (background dark))
       :foreground "light blue")
      (((class color) (background light))
       :foreground "dark blue"))
  "Face for highlighting newly defined factor words"
  :group 'factor)

(defface factor-stack-effect
    '((t (:inherit font-lock-comment-face)))
  "Face for highlighting stack effect declarations"
  :group 'factor)

(defvar factor-mode-abbrev-table nil
  "Abbrev table in use in `factor-mode' buffers")
(define-abbrev-table 'factor-mode-abbrev-table ())

(defvar factor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-M-a") 'factor-begining-of-defn)
    (define-key map (kbd "C-M-e") 'factor-end-of-defn)
    map)
  "Key map for use in `factor-mode' buffers")

(defvar factor-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\" "\"  " table)
    (modify-syntax-entry ?  "     " table)
    (modify-syntax-entry ?\t "    " table)
    (modify-syntax-entry ?\f "    " table)
    (modify-syntax-entry ?\n ">   " table)
    ;; Give CR the same syntax as newline, for selective-display.
    (modify-syntax-entry ?\^m ">  " table)
    (modify-syntax-entry ?! "<    " table)
    (modify-syntax-entry ?` "'    " table)
    (modify-syntax-entry ?' "'    " table)
    (modify-syntax-entry ?, "'    " table)
;;;     (modify-syntax-entry ?\( "<)  " table)
;;;     (modify-syntax-entry ?\) ">(  " table)
    (modify-syntax-entry ?\[ "(]  " table)
    (modify-syntax-entry ?\] ")[  " table)
    table)
  "Syntax table used while in Factor mode.")

(defvar factor-menu nil)
(easy-menu-define factor-menu factor-mode-map
  "Factor Mode Commands"
  '("Factor"))

(defcustom factor-begining-of-line-keywords
  (list "USING:" "MIXIN:" "IN:" "INSTANCE:" "DEFER:" "<PRIVATE" "PRIVATE>"
        "SYMBOL:" "MAIN:" "SINGLETONS:")
  "Factor keywords that only appear at the begining of a line"
  :group 'factor
  :type '(repeat string))

(defcustom factor-defining-words
  (list ":" "::" "MEMO:" "MACRO:" "MACRO::" "GENERIC:" "GENERIC#" "MATH:" "HOOK:" "M:" "METHOD:"
        "ERROR:" "TUPLE:" "C:" "SINGILETON:")
  "Words that define new factor words"
  :group 'factor
  :type '(repeat string))

(defvar factor-defining-words-re (concat "^" (regexp-opt factor-defining-words t) " ")
  "Regexp to match Factor defining words")

(defconst factor-word-re
  "\\s \\([^[:space:]]+\\)\\s "
  "Expression for matching a Factor word")

(defconst factor-number-re
  "\\<\\(\\(?:\\+\\|-\\)?[0-9]+\\(?:\\.[0-9]+\\)?\\)\\>"
  "Expression for matching a number")

(defconst factor-mode-font-lock-keywords
  (list
   (concat "^" (regexp-opt factor-begining-of-line-keywords t))
   factor-defining-words-re
;;;    (list (concat "^" (regexp-opt factor-defining-words t) factor-word-re)
;;;          '(1 font-lock-keyword-face) '(2 factor-word-def))
   (cons factor-number-re 'font-lock-constant-face)
   (list "( \\(?:.*? \\)?-- \\(?:.*? \\)?)" 1 'factor-stack-effect)
   )
  "Highlighting rules for `factor-mode' buffers")

(defun factor-indent-line ()
  "Indent current line as Factor code"
  (indent-line-to (+ (current-indentation) 4)))

(defun factor-begining-of-defn ()
  (interactive)
  (search-backward-regexp factor-defining-words-re))

(defun factor-end-of-defn ()
  (interactive)
  (search-forward-regexp "[^\\] ;"))

(defmacro set-local-variable (variable value)
  `(set (make-local-variable ,variable) ,value))

;;;###autoload
(defun factor-mode ()
  "Major mode for editing Factor code

\\{factor-mode-map}"
  (interactive)

  (kill-all-local-variables)

  (setq major-mode 'factor-mode
        mode-name "Factor"
        local-abbrev-table factor-mode-abbrev-table)
  (use-local-map factor-mode-map)
  (set-local-variable 'indent-line-function 'factor-indent-line)
  (set-syntax-table factor-mode-syntax-table)
  (set-local-variable 'comment-start-skip "\\(^\\|[^\\] \\)! +")
  (set-local-variable 'font-lock-defaults '(factor-mode-font-lock-keywords nil nil))
  (set-local-variable 'comment-start "! ")
  (set-local-variable 'font-lock-keywords-case-fold-search nil)

  (run-hooks 'factor-mode-hook))

(provide 'factor-mode)
;;; factor-mode.el ends here
