;;; dvc-build.el --- compile-time helper.

;; Copyright (C) 2004-2007 by all contributors

;; Author: Matthieu Moy <Matthieu.Moy@imag.fr>
;; Inspired from the work of Steve Youngs <steve@youngs.au.com>

;; This file is part of DVC.
;;
;; DVC is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; DVC is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This file is the package maintener part for build system.
;; It uses package-maint.el (an adaptation of dgnushack.el)
;; For the moment package-maint.el is only part of DVC.

;; FIXME: defined here because package-maint.el is part of DVC for now.
(setq srcdir (or (getenv "srcdir") "."))
(setq contribdir (or (getenv "contribdir") (concat srcdir "/contrib")))
(setq otherdirs (or (getenv "otherdirs") ""))

(setq loaddir (and load-file-name (file-name-directory load-file-name)))

;; Increase the max-specpdl-size size to avoid an error on some platforms
(setq max-specpdl-size (max 1000 max-specpdl-size))

(add-to-list 'load-path srcdir)
(when (file-exists-p contribdir)
  (add-to-list 'load-path contribdir t))
(add-to-list 'load-path loaddir)

;; Add otherdirs to load-path
(mapcar '(lambda (dir)
	   (when (file-exists-p dir)
	     (add-to-list 'load-path dir)))
	(split-string otherdirs " "))

;(setq debug-on-error t)

;; The name of our package
(setq package-maint-pkg "dvc")

;; dvc-version.el is generated in lispdir, not in load-path
;; load it manually if it exists.
(if (file-exists-p "dvc-version.el")
    (load-file "dvc-version.el"))

;; Avoid free-vars
(setq package-maint-compile-warnings '(unresolved callargs redefine))

;; Avoid interference from VC.el
(setq vc-handled-backends nil)

;; List of files to compile: default to $(srcdir)/*.el
(setq package-maint-files (directory-files srcdir nil "^[^=].*\\.el$"))

;; List of files to remove from package-maint-files
(setq no-compile-files '("dvc-build.el" "dvc-preload.el"))

(when (not (locate-library "ewoc"))
  (push "contrib/ewoc.el" package-maint-files))

(when (not (locate-library "tree-widget"))
  (push "tla-browse.el" no-compile-files))


(if (not (featurep 'xemacs))
    (push "dvc-xemacs.el" no-compile-files)
  (progn
    ;; Do not use GNU Emacs compatibility stuff
    (push "dvc-emacs.el" no-compile-files)

    (autoload 'setenv (if (emacs-version>= 21 5) "process" "env") nil t)
    ;; DVC things
    (autoload 'replace-regexp-in-string "dvc-xemacs.el")
    (autoload 'line-number-at-pos       "dvc-xemacs.el")
    (autoload 'line-beginning-position  "dvc-xemacs.el")
    (autoload 'line-end-position        "dvc-xemacs.el")
    (autoload 'match-string-no-properties "dvc-xemacs.el")
    (autoload 'tla--run-tla-sync        "tla-core.el")
    (autoload 'dvc-switch-to-buffer     "dvc-buffers.el")
    (autoload 'dvc-trace                "dvc-utils.el")
    (autoload 'dvc-flash-line           "tla")
    (autoload 'tla-tree-root            "tla")
    (autoload 'tla--name-construct      "tla-core")
    (defalias 'dvc-cmenu-mouse-avoidance-point-position
      'mouse-avoidance-point-position)
    ;; External things
    (autoload 'debug                    "debug")
    (autoload 'tree-widget-action       "tree-widget")
    (autoload 'ad-add-advice            "advice")
    (autoload 'customize-group          "cus-edit" nil t)
    (autoload 'dired                    "dired" nil t)
    (autoload 'dired-other-window       "dired" nil t)
    (autoload 'dolist "cl-macs" nil nil 'macro)
    (autoload 'easy-mmode-define-keymap "easy-mmode")
    (autoload 'minibuffer-prompt-end    "completer")
    (autoload 'mouse-avoidance-point-position "avoid")
    (autoload 'read-passwd              "passwd")
    (autoload 'read-kbd-macro           "edmacro" nil t)
    (autoload 'regexp-opt               "regexp-opt")
    (autoload 'reporter-submit-bug-report "reporter")
    (autoload 'view-file-other-window   "view-less" nil t)
    (autoload 'view-mode                "view-less" nil t)
    (autoload 'with-electric-help       "ehelp")
    (autoload 'read-kbd-macro           "edmacro")
    (autoload 'pp-to-string             "pp")))

(unless (fboundp 'defadvice)
  (autoload 'defadvice "advice" nil nil 'macro))

(require 'package-maint)

;; We prepend dvc-preload.el to the autoload file, defadvice
;; package-maint-make-load because package-maint-make-autoloads use
;; batch-update-autoloads which kill XEmacs (so no advice possible).
(defadvice package-maint-make-load (before add-preload activate)
  "Prepend dvc-preload.el to the autoloads file and append
dvc-custom.el if GNU Emacs"
  (with-temp-file package-maint-load-file
    (insert-file-contents package-maint-load-file)
    (unless (looking-at
             ";; Code to insert at the beginning of dvc-autoloads.el")
      (insert-file-contents (expand-file-name "dvc-preload.el" srcdir)))))

;; Remove unneeded files from compilation
(package-maint-remove-files no-compile-files)

;;; dvc-build.el ends here
