;;; lish.el --- Hybrid Lisp/system shell

;; Copyright (C) 2006 by Massimiliano Mirra
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
;;
;; Author: Massimiliano Mirra, <bard [at] hyperstruct [dot] net>

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; This is a prototype.  See `Status' below.
;;
;; Through a couple of macros and tricks, Lish tries to make external
;; process invocation straightforward enough that ELisp could be used
;; as an everyday shell interaction language.  
;;
;; Unlike Eshell, it does not aim at look like bash & friends.  On the
;; contrary, it tries to make the outside world a little more lispy.
;;
;;
;; Example interaction:
;;
;; Invoke with M-x lish
;;
;;     ($ )
;;
;;
;; Write a shell command.
;;
;;     ($ ls -l /)
;;     total 84
;;     drwxr-xr-x    2 root root   4096 2006-01-03 16:57 bin
;;     drwxr-xr-x    4 bard bard   4096 2006-01-09 21:45 boot
;;     [...]
;;     => 0
;;
;;
;; The `0' is the return code of the process.  (To disable printing
;; return codes from processes and return values from lisp
;; expressions, customize `lish-print-return-values'.)
;;
;; Pressing `,' at the beginning of a sexp switches the shell cue on
;; and off.  (`^' below indicates where point should be.)
;;
;;     ($ )
;;        ^
;;
;; Pressing `,' will thus switch to Lisp mode:
;;
;;     ()
;;
;;
;; Pressing `,' again will switch back to shell mode:
;;
;;     ($ )
;;
;;
;; When in Lisp mode, Lisp expressions can be entered as usual:
;;
;;     (print "hello")
;;
;;
;; Modes can be intermixed.
;;
;;     ($ echo (upcase "hello"))
;;     HELLO
;;     => 0
;;     (format "echo returned %d" ($ echo "hello"))
;;     hello
;;     => "echo returned 0"
;;     (with-temp-buffer ($ cat /etc/passwd) (elt (split-string (buffer-string)) 0))
;;     => "root:x:0:0:root:/root:/bin/bash"
;;     (mapc (lambda (file) ($ rm $file)) (directory-files "." nil "txt$"))
;;     => ("bar.txt" "foo.txt")
;;     
;;
;; Lisp variables can be brought inside shell mode by prefixing them
;; with `$':
;;
;;     (let ((x 3.14)) ($ echo $x))
;;     3.14
;;     => 0
;;           
;;
;; The special `($ cd)' command can enter not only in directories but
;; in files, too.
;;
;;     ($ cd /etc/passwd)
;;     "/etc/passwd"
;;
;;
;; It is then possible to operate on the file with the `chunk' command
;; (though the only thing that it does now is accessing lines by
;; number and by regexp pattern).
;;
;;     ($ chunk 0)
;;     "root:x:0:0:root:/root:/bin/bash"
;;     ($ chunk "sys")
;;     "sys:x:3:3:sys:/dev:/bin/sh"
;;
;;
;; You can define aliases that take precedence over both system and
;; lisp commands.  For example, to create a `foo' shell alias, write a
;; `lish-shell-alias-foo' defun; to create a `bar' Lisp alias, write
;; `lish-lisp-alias-bar'.

;;; Status:

;; Definitely NOT ready to replace your favourite shell.  Perfectly
;; ready, though, for being hacked to death (or life, depending on the
;; point of view).
;;
;; Cue expansion (e.g. changing `$' to `lish-cmd') is not done through
;; macro expansion to avoid abusing the global namespace with
;; unqualified macro names like `$'.

;;; To do:

;; - line history
;;
;; - terminal handling (needed for e.g. programs who disable echo to
;;   request passwords).  Maybe by redirecting to term-mode?
;;
;; - programmable completion
;;
;; - multi-line input mode
;;
;; - capture stderr
;;
;; - extend the chunk function to make use of Emacs's knowledge of
;;   file types (major modes), file parsers, and whatnot.  Also, make
;;   it operate on directories, where chunk is a file name and
;;   metadata.
;;
;; - pipes


;;; Code:

(defgroup lish nil
  "Hybrid Lisp/system shell interaction."
  :tag "Lish"
  :group 'languages
  :prefix "lish-")

(defcustom lish-shell-escape '$
  "Symbol that starts a shell expression."
  :group 'lish
  :type 'symbol)

(defcustom lish-print-return-values t
  "Print return values of Lisp expressions or shell commands."
  :group 'lish
  :type 'symbol)

;; ------------------------------------------------------------------------ ;;

(defvar lish-provide-shell-escape t
  "Whether next line will begin with a shell escape or not.")

(defvar lish-current-entity-filename nil
  "Filename of currently examined entity.")

;; ------------------------------------------------------------------------ ;;

(defun lish ()
  "Run the Lish shell."
  (interactive)
  (let ((lish-buffer (get-buffer "*lish*")))
    (if lish-buffer
        (switch-to-buffer lish-buffer)
      (switch-to-buffer (get-buffer-create "*lish*"))
      (lish-mode)
      (lish-print-prompt))))

(define-derived-mode lish-mode emacs-lisp-mode "Lish"
  "Hybrid Lisp/system shell interaction mode.

\\{lish-mode-map}"
  (define-key lish-mode-map (kbd "RET") 'lish-eval)
  (define-key lish-mode-map (kbd "C-RET") 'newline-and-indent)
  (define-key lish-mode-map (kbd ",") 'lish-self-insert-or-switch-cue)
  (define-key lish-mode-map (kbd "M->") 'lish-end-of-buffer)
  (define-key lish-mode-map (kbd "\"") 'lish-skeleton-pair-insert-maybe-with-space)
  (define-key lish-mode-map (kbd "(") 'insert-parentheses)
  (add-hook 'window-scroll-functions
            (lambda (window display-start)
              (recenter -3))
            nil t))

;; ------------------------------------------------------------------------ ;;

(defun lish-eval ()
  "Read the top-level form at point, expand Lish cues, and eval it."
  (interactive)
  (let* ((lish-buffer (current-buffer))
         (standard-output lish-buffer)
         (form (lish-read-expand-toplevel-form)))
    (when form
      (end-of-defun)
      (let ((result (eval form)))
        (with-current-buffer lish-buffer
          (if lish-print-return-values
              (progn
                (unless (bolp)
                  (insert "\n"))
                (insert (format "=> %s\n" result)))
            (unless (bolp)
              (insert "\n")))
          (lish-print-prompt))))))

(defun lish-read-expand-toplevel-form ()
  (save-excursion
    (beginning-of-defun)
    (let ((form (read (current-buffer))))
      (unless (or (null form)
                  (equal form (list lish-shell-escape)))
        (lish-expand-car form)))))

(defmacro lish-cmd (command &rest args)
  "Executes the system command given by the COMMAND symbol or a
Lish alias.  ARGS are expanded with
`lish-preprocess-cmd-arguments' if processing a system command,
left alone if processing an alias."
  (let ((alias (intern (concat "lish-shell-alias-" (symbol-name command)))))
    (if (fboundp alias)
        (apply alias args)
      (let ((args (mapcar 'lish-preprocess-cmd-arg args)))
        `(progn
           (terpri)
           (condition-case e
               (call-process-shell-command
                (symbol-name ',command)
                nil
                standard-output
                t
                ,@args)
             (file-error e)))))))

(defun lish-preprocess-cmd-arg (arg)
  "Adopt simple heuristics to evaluate a Lisp argument into
something digestible by a system command."
  (cond ((stringp arg) arg)
        ((symbolp arg)
         (let ((argstr (symbol-name arg)))
           (if (string-match "^\\$" argstr)
               (intern (substring argstr 1))
             (symbol-name arg))))
        (t (with-temp-buffer
             (let ((standard-output (current-buffer)))
               (princ (eval arg)))
             (buffer-string)))))
    
(defun lish-current-entity-buffer ()
  "Return the buffer where entities to be examined are placed."
  (or (get-buffer "*lish-entity*")
      (generate-new-buffer "*lish-entity*")))

(defun lish-shell-alias-l (&rest args)
  `(lish-cmd ls -lF ,@args))

(defun lish-shell-alias-e (&rest args)
  (dolist (arg args)
    (find-file (lish-preprocess-cmd-arg arg))))

(defun lish-shell-alias-v (&rest args)
  (dolist (arg args)
    (find-file (lish-preprocess-cmd-arg arg))
    (view-mode)))

(defun lish-shell-alias-cd (entity)
  "Enter a directory or a file."
  (let ((entity (lish-preprocess-cmd-arg entity)))
    (if (file-directory-p entity)
        (funcall #'cd entity)
      (when (file-exists-p entity)
        (setq lish-current-entity-filename entity)
        (with-current-buffer (lish-current-entity-buffer)
          (erase-buffer)
          (insert-file-contents-literally
           lish-current-entity-filename t)
          lish-current-entity-filename)))))

(defun lish-lisp-alias-chunk (number-or-regexp)
  "Examine current chunk."
  (with-current-buffer (lish-current-entity-buffer)
    (beginning-of-buffer)
    (when
        (if (numberp number-or-regexp)
            (goto-line number-or-regexp)
          (condition-case nil
              (progn
                (re-search-forward number-or-regexp)
                t)
            (error nil)))
      (beginning-of-line)
      (let ((bol (point)))
        (end-of-line)
        (buffer-substring bol (point))))))

(defun lish-system-command-p (program)
  (let ((dir (find program exec-path
                   :test (lambda (program directory)
                           (file-executable-p
                            (concat (file-name-as-directory directory)
                                    program))))))
    (when dir
      (concat (file-name-as-directory dir)
              program))))

(defun lish-translate-car (atom)
  (let ((lisp-alias (intern (concat "lish-lisp-alias-" (symbol-name atom)))))
    (cond
     ((fboundp lisp-alias) lisp-alias)
     ((eql atom lish-shell-escape) 'lish-cmd)
     (t atom))))

(defun lish-expand-car (form)
  (unless (null form)
    (cons (lish-translate-car (car form))
          (mapcar (lambda (part)
                    (if (listp part)
                        (lish-expand-car part)
                      part))
                  (cdr form)))))

(defun lish-print-prompt ()
  (insert "(")
  (when lish-provide-shell-escape
    (insert (symbol-name lish-shell-escape) " "))
  (save-excursion
    (insert ")")))

(defun lish-self-insert-or-switch-cue ()
  (interactive)
  (unless (lish-switch-shell-escape)
    (insert last-command-char)))

(defun lish-switch-shell-escape ()
  (interactive)
  (let ((cue (concat (symbol-name lish-shell-escape) " ")))
    (cond
     ((looking-back cue)
      (save-excursion
        (backward-up-list)
        (forward-char)
        (delete-char (length cue)))
      (setq lish-provide-shell-escape nil)
      t)
     ((looking-back "(")
      (insert cue)
      (setq lish-provide-shell-escape t)
      t)
     (t nil))))

(defun lish-skeleton-pair-insert-maybe-with-space (arg)
  (interactive "*P")
  (cond ((looking-back "[ (]") nil)
        ((looking-at "\"") (forward-char) (insert " "))
        (t (insert " ")))
  (skeleton-pair-insert-maybe arg))

(defun lish-end-of-buffer ()
  (interactive)
  (end-of-buffer)
  (re-search-backward ")"))

(provide 'lish)

;;; lish.el ends here