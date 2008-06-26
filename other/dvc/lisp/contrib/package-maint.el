;;; package-maint.el --- Utilities for package mainteners
;; Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2003,
;; 2004, 2005, 2007
;;        Free Software Foundation, Inc.

;; This file is base on dgnushack.el in GNU Emacs
;; Author: Lars Magne Ingebrigtsen <larsi@gnus.org>
;; Version: 4.19
;; Keywords: news, path

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
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This file provide the compilation stuff for the package.
;;
;; You must set package-maint-pkg to something usefull, it's the name
;; of your package.
;;
;; You may want to override the list of compiled files, just set
;; package-maint-files (remove unwanted files for exemple).
;;
;; To use this, provide a file which require package-maint (for
;; example pkg-build.el) and set package-maint-pkg, then in you
;; Makefile use something like this:
;;
;; EMACS_COMP = srcdir=@srcdir@ lispdir=@lispdi@ $(EMACS) -l @srcdir@/pkg-build.el
;;
;; all: clean pkg-load.el
;;      $(EMACS_COMP) -l @srcdir@/pkg-build.el -f package-maint-compile
;;
;; pkg-load.el
;;      $(EMACS_COMP) -f package-maint-make-cus-load @srcdir@
;;      $(EMACS_COMP) -f package-maint-make-auto-load @srcdir@
;;      $(EMACS_COMP) -f package-maint-make-load

;;; Code:

(defalias 'facep 'ignore)

(require 'cl)
(require 'loadhist)

(defvar package-maint-pkg "pkg" "*Name of the package*")

(defvar srcdir (or (getenv "srcdir") "."))
(defvar contribdir (or (getenv "contribdir") "contrib"))
(defvar otherdirs (or (getenv "otherdirs") nil))
(defvar loaddir (and load-file-name (file-name-directory load-file-name)))

(defvar package-maint-compile-warnings '(free-vars unresolved callargs redefine)
  "*Warnings enabled during compilation*")

(defvar package-maint-files (directory-files srcdir nil "^[^=].*\\.el$")
  "*List of source files*")

(defvar package-maint-files-dep nil "*Alist of files and their
direct dependencies*")

(defvar package-maint-files-rdep nil "*Alist of files and their
reverse dependencies*")

(defun my-getenv (str)
  (let ((val (getenv str)))
    (if (equal val "no") nil val)))

(if (my-getenv "lispdir")
    (add-to-list 'load-path (my-getenv "lispdir")))

(add-to-list 'load-path srcdir)
(when (file-exists-p contribdir)
  (add-to-list 'load-path contribdir))
(add-to-list 'load-path loaddir)

;; Add otherdirs to load-path
(mapcar '(lambda (dir)
	   (when (file-exists-p dir)
	     (add-to-list 'load-path dir)))
	(split-string otherdirs " "))

(defvar package-maint-load-file
  (if (featurep 'xemacs)
      (expand-file-name "auto-autoloads.el")
    (expand-file-name (concat package-maint-pkg "-autoloads.el"))))

(defvar package-maint-cus-load-file
  (if (featurep 'xemacs)
      (expand-file-name "custom-load.el")
    (expand-file-name "cus-load.el")))


(require 'bytecomp)

(defun byte-compile-dest-file (source)
  "Convert an Emacs Lisp source file name to a compiled file name.
 In addition, remove directory name part from SOURCE."
  (setq source (byte-compiler-base-file-name source))
  (setq source (file-name-sans-versions source))
  (setq source (file-name-nondirectory source))
  (if (memq system-type '(win32 w32 mswindows windows-nt))
      (setq source (downcase source)))
  (cond ((eq system-type 'vax-vms)
         (concat (substring source 0 (string-match ";" source)) "c"))
        ((string-match emacs-lisp-file-regexp source)
         (concat (substring source 0 (match-beginning 0)) ".elc"))
        (t (concat source ".elc"))))

;; To avoid having defsubsts and inlines happen.
;(if (featurep 'xemacs)
;    (require 'byte-optimize)
;  (require 'byte-opt))
;(defun byte-optimize-inline-handler (form)
;  "byte-optimize-handler for the `inline' special-form."
;  (cons 'progn (cdr form)))
;(defalias 'byte-compile-file-form-defsubst 'byte-compile-file-form-defun)

(when (and (not (featurep 'xemacs))
           (= emacs-major-version 21)
           (>= emacs-minor-version 3)
           (condition-case code
               (let ((byte-compile-error-on-warn t))
                 (byte-optimize-form (quote (pop x)) t)
                 nil)
             (error (string-match "called for effect"
                                  (error-message-string code)))))
  (defadvice byte-optimize-form-code-walker (around silence-warn-for-pop
                                                    (form for-effect)
                                                    activate)
    "Silence the warning \"...called for effect\" for the `pop' form.
It is effective only when the `pop' macro is defined by cl.el rather
than subr.el."
    (let (tmp)
      (if (and (eq (car-safe form) 'car)
               for-effect
               (setq tmp (get 'car 'side-effect-free))
               (not byte-compile-delete-errors)
               (not (eq tmp 'error-free))
               (eq (car-safe (cadr form)) 'prog1)
               (let ((var (cadr (cadr form)))
                     (last (nth 2 (cadr form))))
                 (and (symbolp var)
                      (null (nthcdr 3 (cadr form)))
                      (eq (car-safe last) 'setq)
                      (eq (cadr last) var)
                      (eq (car-safe (nth 2 last)) 'cdr)
                      (eq (cadr (nth 2 last)) var))))
          (progn
            (put 'car 'side-effect-free 'error-free)
            (unwind-protect
                ad-do-it
              (put 'car 'side-effect-free tmp)))
        ad-do-it))))

(when (and (not (featurep 'xemacs))
           (byte-optimize-form '(and (> 0 1) foo) t))
  (defadvice byte-optimize-form-code-walker
    (around fix-bug-in-and/or-forms (form for-effect) activate)
    "Optimize the rest of the and/or forms.
It has been fixed in XEmacs before releasing 21.4 and also has been
fixed in Emacs after 21.3."
    (if (and for-effect (memq (car-safe form) '(and or)))
        (let ((fn (car form))
              (backwards (reverse (cdr form))))
          (while (and backwards
                      (null (setcar backwards
                                    (byte-optimize-form (car backwards) t))))
            (setq backwards (cdr backwards)))
          (if (and (cdr form) (null backwards))
              (byte-compile-log
               "  all subforms of %s called for effect; deleted" form))
          (when backwards
            (setcdr backwards
                    (mapcar 'byte-optimize-form (cdr backwards))))
          (setq ad-return-value (cons fn (nreverse backwards))))
      ad-do-it)))

;; Work around for an incompatibility (XEmacs 21.4 vs. 21.5), see the
;; following threads:
;;
;; http://thread.gmane.org/gmane.emacs.gnus.general/56414
;; Subject: attachment problems found but not fixed
;;
;; http://thread.gmane.org/gmane.emacs.gnus.general/56459
;; Subject: Splitting mail -- XEmacs 21.4 vs 21.5
;;
;; http://thread.gmane.org/gmane.emacs.xemacs.beta/20519
;; Subject: XEmacs 21.5 and Gnus fancy splitting.
(when (and (featurep 'xemacs)
           (let ((table (copy-syntax-table emacs-lisp-mode-syntax-table)))
             (modify-syntax-entry ?= " " table)
             (with-temp-buffer
               (with-syntax-table table
                 (insert "foo=bar")
                 (goto-char (point-min))
                 (forward-sexp 1)
                 (eolp)))))
  ;; The original `with-syntax-table' uses `copy-syntax-table' which
  ;; doesn't seem to copy modified syntax entries in XEmacs 21.5.
  (defmacro with-syntax-table (syntab &rest body)
    "Evaluate BODY with the SYNTAB as the current syntax table."
    `(let ((stab (syntax-table)))
       (unwind-protect
           (progn
             ;;(set-syntax-table (copy-syntax-table ,syntab))
             (set-syntax-table ,syntab)
             ,@body)
         (set-syntax-table stab)))))

(defun package-maint-remove-files (&optional files)
  "Remove unwanted files from package-maint-files, take care to
remove load-file and cus-load-file if not specified."
  (dolist (file (append files `(,(file-name-nondirectory package-maint-load-file)
				,(file-name-nondirectory package-maint-cus-load-file)
			        "package-maint.el")))
    (setq package-maint-files (delete file package-maint-files))))

(defun package-maint-changed-source-p (file)
  "Check if a source file is newer than its elc if any."
  (let ((source (expand-file-name file srcdir))
	(elc (byte-compile-dest-file file)))
    (or (not (file-exists-p elc))
	      (file-newer-than-file-p source elc))))

(defun package-maint-list-changed-sources (files)
  "Return the list of .el files newer than their .elc."
  (let (need-compile)
    (dolist (file files need-compile)
      (when (package-maint-changed-source-p file)
	(push file need-compile)))))

(defun package-maint-load-files (files)
  "Load FILES"
  (dolist (file files)
	(condition-case err
		(load (expand-file-name file srcdir) t t t)
	  (error
	   (message (format "Error loading %s: %s"
			    (expand-file-name file srcdir) err))
	   (backtrace)))))

(defun package-maint-get-file-dep (file)
  "Return a list with CAR the FILE and CDR the list of FILES required.
List dependencies only in package-maint-files."
  (let ((depends (file-requires (expand-file-name file srcdir)))
	(build-dep (list)))
    (dolist (dep depends)
      (let ((file-dep (concat (symbol-name dep) ".el")))
	(when (member file-dep package-maint-files)
	  (push file-dep build-dep))))
    (list file build-dep)))

(defun package-maint-get-file-rdep (file)
  "Return a list with CAR the filename and CDR the list of files which
depend on FILE.
List dependencies only in package-maint-files."
  (let ((depends (file-dependents (expand-file-name file srcdir)))
	(build-dep (list)))
    (dolist (dep depends)
      (let ((file-dep (file-name-nondirectory dep)))
	(when (member file-dep package-maint-files)
	  (push file-dep build-dep))))
    (list file build-dep)))

(defun package-maint-delete-autoloads ()
  "Delete autoloads and cus load if exists."
  (let ((autoloadselc (byte-compile-dest-file package-maint-load-file))
	(cusloadelc (byte-compile-dest-file package-maint-cus-load-file)))
    (dolist (file (list autoloadselc cusloadelc
			package-maint-load-file
			package-maint-cus-load-file))
      (when (file-exists-p file)
	(delete file)))))

(defun package-maint-clean-elc (files)
  "Delete ELC of changed source and then all the reverse
dependencies' .elc, return LIST of files to byte-compile."
  (let ((max-lisp-eval-depth (* 300 max-lisp-eval-depth)))
    (defun recurse-do(files &optional need-compile-files)
      (if (null files)
	  need-compile-files
	(progn
	  (let* ((file (car files))
		 (rest (cdr files))
		 (source (expand-file-name file srcdir))
		 (elc (byte-compile-dest-file file)))
	    (when (file-exists-p elc)
	      (delete-file elc))
	    (when (not (member file need-compile-files))
	      (push file need-compile-files))
	    (when package-maint-files-rdep
	      (let ((depends (cadr (assoc file package-maint-files-rdep))))
		(dolist (file depends)
		  (when (member file need-compile-files)
		    (delete file depends))
		  (when (member file rest)
		    (delete file rest)))
		(setq rest (append rest depends))))
	    (recurse-do rest need-compile-files)))))
    (recurse-do files)))

(defun package-maint-clean-some-elc ()
  "Build the list of changed source files and call
  package-maint-clean-elc on it."
  (let ((changed (package-maint-list-changed-sources package-maint-files)))
    (when (not (null changed))
      (package-maint-load-files package-maint-files)
      (package-maint-build-dep changed)
      (package-maint-clean-elc changed))))

(defun package-maint-build-dep (files)
  "Build dependencies between package-maint-files."
  (let (deps rdeps)
    (dolist (file files)
;;       (push (package-maint-get-file-dep file) deps)
      (push (package-maint-get-file-rdep file) rdeps))
;;     (setq package-maint-files-deps deps)
    (setq package-maint-files-rdep rdeps)))

(defun package-maint-compile-file-verbosely (file)
  (package-maint-compile-file file t))

(defun package-maint-compile-file (file &optional warn)
  "Compile a file."
  (unless warn
    (setq byte-compile-warnings package-maint-compile-warnings))
  (when (package-maint-changed-source-p file)
    (ignore-errors
      (byte-compile-file (expand-file-name file srcdir)))))

(defun package-maint-compile-verbosely ()
  "Call package-maint-compile with warnings ENABLED.  If you are compiling
patches to the package, you should consider modifying make.bat to call
package-maint-compile-verbosely.  All other users should continue to use
package-maint-compile."
  (package-maint-compile t))

(defun package-maint-compile (&optional warn)
  "Compile FILES in package-maint-files list if not up to date,
cleaning old .elc and reverse dependencies if needed."
  (package-maint-remove-files)
  (let ((to-compile (package-maint-clean-some-elc)))
    (when (not (null to-compile))
      (dolist (file to-compile)
	(package-maint-compile-file file warn)))))

(defun package-maint-make-cus-load ()
  "Make custom load file in current directory."
  (if (not (package-maint-list-changed-sources package-maint-files))
      ;; Consume remaining command line args to avoid errors
      (setq command-line-args-left nil)
    (load "cus-dep")
    (let ((cusload-base-file package-maint-cus-load-file))
      (if (fboundp 'custom-make-dependencies)
	  (custom-make-dependencies)
	(Custom-make-dependencies))
      (when (featurep 'xemacs)
	(message "Compiling %s..." package-maint-cus-load-file)
	(byte-compile-file package-maint-cus-load-file)))))

(defun package-maint-make-auto-load ()
  "Make autoloads file in current directory."
  (if (and (file-exists-p package-maint-load-file)
	   (null (package-maint-list-changed-sources package-maint-files)))
      ;; Consume remaining command line args to avoid errors
      (setq command-line-args-left nil)
    (require 'autoload)
    (unless (make-autoload '(define-derived-mode child parent name
			      "docstring" body)
			   "file")
      (defadvice make-autoload (around handle-define-derived-mode activate)
	"Handle `define-derived-mode'."
	(if (eq (car-safe (ad-get-arg 0)) 'define-derived-mode)
	    (setq ad-return-value
		  (list 'autoload
			(list 'quote (nth 1 (ad-get-arg 0)))
			(ad-get-arg 1)
			(nth 4 (ad-get-arg 0))
			t nil))
	  ad-do-it))
      (put 'define-derived-mode 'doc-string-elt 3))
    (let ((generated-autoload-file package-maint-load-file)
	  (make-backup-files nil)
	  (autoload-package-name package-maint-pkg))
      (if (featurep 'xemacs)
	  (if (file-exists-p generated-autoload-file)
	      (delete-file generated-autoload-file))
	(with-temp-file generated-autoload-file
	  (insert ?\014)))
      (batch-update-autoloads))))

(defun package-maint-make-load ()
  "Merge custom load and autoloads for GNU Emacs and compile the result."
  (when (or (not (file-exists-p package-maint-load-file))
	    (package-maint-list-changed-sources package-maint-files))
    (unless (featurep 'xemacs)
      (message "Generating %s..." package-maint-load-file)
      (with-temp-file package-maint-load-file
	(insert-file-contents package-maint-cus-load-file)
	(delete-file package-maint-cus-load-file)
	(goto-char (point-min))
	(search-forward ";;; Code:")
	(forward-line)
	(delete-region (point-min) (point))
	(insert (concat "\
;;; " package-maint-pkg "-autoloads.el --- automatically extracted custom dependencies and autoload
;;
;;; Code:
"))
	(goto-char (point-max))
	(if (search-backward "custom-versions-load-alist" nil t)
	    (forward-line -1)
	  (forward-line -1)
	  (while (eq (char-after) ?\;)
	    (forward-line -1))
	  (forward-line))
	(delete-region (point) (point-max))
	(insert "\n")
	(insert-file-contents package-maint-load-file)
	(goto-char (point-max))
	(when (search-backward "\n(provide " nil t)
	  (forward-line -1)
	  (delete-region (point) (point-max)))
	(insert (concat "\

\(provide '" package-maint-pkg "-autoloads)

;;; Local Variables:
;;; version-control: never
;;; no-update-autoloads: t
;;; End:
;;; " package-maint-pkg "-autoloads.el ends here
"))))
    (message "Compiling %s..." package-maint-load-file)
    (byte-compile-file package-maint-load-file)
    (when (featurep 'xemacs)
      (message (concat "Creating dummy " package-maint-pkg "-autoloads.el..."))
      (with-temp-file (expand-file-name (concat package-maint-pkg "-autoloads.el"))
	(insert (concat "\

\(provide '" package-maint-pkg "-autoloads)

;;; Local Variables:
;;; version-control: never
;;; no-update-autoloads: t
;;; End:
;;; " package-maint-pkg "-autoloads.el ends here"))))))

(provide 'package-maint)

