;; Various useful modes

;; Need to be set before org.el is loaded
(setq org-return-follows-link t
      org-tab-follows-link t)

(load-library "auctex")
(load-library "preview-latex")
(require 'cc-mode)
(require 'cperl-mode)
(require 'css-mode)
(require 'distel)
(require 'erlang)
(require 'ess-site) ;; R
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(require 'gambit)
(require 'gst-mode)
(require 'haskell-doc)
(require 'haskell-indent)
(require 'haskell-mode)
(require 'inf-ruby)
(require 'lua-mode)
(autoload 'mmm-mode "mmm-mode" "Multiple Major Modes" t)
(require 'muse-mode)
(require 'muse-docbook)
(require 'muse-html)
(require 'muse-latex)
(require 'muse-latex2png)
(require 'muse-project)
(require 'muse-texinfo)
(require 'moz)
(load-library "rng-auto")
(require 'nxml-mode)
(require 'paredit)
(require 'php-mode)
(require 'ipython)
(require 'pymacs)
(require 'remember)
(require 'ruby-electric)
(require 'ruby-mode)
(require 'scala-mode-auto)
(require 'slime)
(require 'smalltalk-mode)
(require 'stumpwm-mode)
(require 'tuareg)
(require 'yaml-mode)

(load-library "python")
(load-library "auto-modes")
(load-library "d-mode")
(load-library "haskell-configs")
(load-library "light-symbol-mode")
(load-library "org")
(load-library "org-config")
(load-library "quack")
(load-library "scheme-configs")
(load-library "js2")

;;; Cedet stuff
(require 'cedet)
(semantic-load-enable-excessive-code-helpers)
(setq senator-minor-mode-name "SN")
(setq semantic-imenu-auto-rebuild-directory-indexes nil)
(global-srecode-minor-mode 1)
(global-semantic-mru-bookmark-mode 1)
(require 'semantic-decorate-include)
;; gcc setup
(require 'semantic-gcc)
;; smart complitions
(require 'semantic-ia)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local erlang-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(require 'eassist)
;; gnu global support
(require 'semanticdb-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)

;; (require 'semantic-load)
(autoload 'jde-mode "jde" nil t)


;;; Pymacs
(setenv "PYMACS_PYTHON" "python2.5")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(pymacs-load "ropemacs" "rope-")

(display-battery-mode 1)
(setq battery-update-interval 30)

(require 'magit)

;; Factor
(setq fuel-factor-root-dir (expand-file-name "~/src/factor"))
(require 'fuel-mode)
(require 'factor-mode)

;; Forth
(setq forth-program-name "gforth")
(load-library "gforth")

;; Javascript
(defalias 'javascript-mode 'js2-mode)
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(defun javascript-custom-setup ()
  (moz-minor-mode 1))

;; Perl
(defalias 'perl-mode 'cperl-mode)
(setq cperl-hairy t)
(setq cperl-electric-keywords t)
(defun my-cperl-eldoc-documentation-function ()
  "Return meaningful doc string for `eldoc-mode'."
  (car
   (let ((cperl-message-on-help-error nil))
     (cperl-get-help))))
(setq cperl-indent-level 4)
;; Template Toolkit
(autoload 'tt-mode "tt-mode")

;; XML and HTML
(defalias 'xml-mode 'nxml-mode)
(defalias 'html-mode 'nxml-mode)

(require 'flyspell)
(setq flyspell-prog-text-faces (append '(nxml-text-face) flyspell-prog-text-faces))


;; Erlang
(setq erlang-root-dir "/usr/lib/erlang")
(distel-setup)

;; For debugging
(setq fsm-use-debug-buffer t)

;; Lisp
(if (file-exists-p "/usr/share/doc/hyperspec/")
    (setq common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/"))
(require 'info-look)
(info-lookup-add-help
 :mode 'lisp-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))
;;; Slime
(setq sbcl-program "/home/james/bin/sbcl")
(setq slime-lisp-implementations
      `((sbcl (,sbcl-program  "--core" "/home/james/lib/sbcl/sbcl.core") :coding-system utf-8-unix)))
(setq slime-backend "/home/james/src/clbuild/.swank-loader.lisp")
(setq slime-use-autodoc-mode t)
(setq slime-complete-symbol*-fancy t)
(setq lisp-indent-function 'common-lisp-indent-function)
(setq slime-complete-symbol-function 'slime-simple-complete-symbol)
(setq slime-complete-symbol 'slime-fuzzy-complete-symbol)
(slime-setup '(slime-fancy slime-tramp slime-banner slime-asdf))
(autoload 'redshank-mode "redshank" "Minor mode for editing and refactoring (Common) Lisp code." t)
(autoload 'turn-on-redshank-mode "redshank" "Turn on Redshank mode.  Please see function `redshank-mode'." t)
(autoload 'cl-lookup "cl-lookup" "View the documentation on ENTRY from the Common Lisp HyperSpec, et al.")
;;; Paredit
(autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)
(define-key paredit-mode-map [?\)] 'paredit-close-parenthesis)
(define-key paredit-mode-map [(meta ?\))] 'paredit-close-parenthesis-and-newline)

;; Clojrue
(load-library "clojure-config")

;; CSS
(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)

;; flymake
(defun my-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line))
