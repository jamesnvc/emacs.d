; -*- mode: emacs-lisp -*-
;;
;; Load DVC easily ...
;;
;; Manually, you can run
;;
;;   M-x load-file RET /path/to/dvc-load.el RET
;;
;; (usefull when you want to load DVC after starting "emacs -q"!), or
;; add
;;
;;   (load-file "/path/to/this/file/in/installdir/dvc-load.el")
;;
;; to your ~/.emacs.el

(add-to-list 'load-path "$(prefix)/share/emacs/site-lisp/dvc/")
(unless (locate-library "ewoc")
  (add-to-list 'load-path "$(prefix)/share/emacs/site-lisp/dvc/contrib"))
(add-to-list 'Info-default-directory-list "${datarootdir}/info")

(if (featurep 'dvc-core)
    (dvc-reload)
  (if (featurep 'xemacs)
      (require 'auto-autoloads)
    (require 'dvc-autoloads)))

