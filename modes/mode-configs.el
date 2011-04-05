;; Various useful modes

;; Need to be set before org.el is loaded
(setq org-return-follows-link t
      org-tab-follows-link t)

(load-library "auctex")
(load-library "preview-latex")
(require 'actionscript-mode)
(require 'arorem)
(require 'arorem-rhtml)
(require 'cc-mode)
(require 'google-c-style)
(require 'cperl-mode)
(require 'css-mode)
(require 'distel)
(require 'django-html-mode)
(require 'erlang)
(require 'ess-site) ;; R
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
;; (require 'gambit)
;; (require 'gst-mode)
(require 'haml-mode)
(require 'haskell-doc)
(require 'haskell-indent)
(require 'haskell-mode)
(require 'inf-ruby)
(require 'lua-mode)
(autoload 'mmm-mode "mmm-mode" "Multiple Major Modes" t)
(require 'multimarkdown-mode)
(require 'muse-mode)
(require 'muse-docbook)
(require 'muse-html)
(require 'muse-latex)
(require 'muse-latex2png)
(require 'muse-project)
(require 'muse-texinfo)
(require 'moz)
;; (load-library "rng-auto")
(require 'nxml-mode)
(require 'paredit)
(require 'php-mode)
;; (require 'ipython)
;; (require 'pymacs)
(require 'rainbow-mode)
(require 'remember)
(require 'ruby-mode)
(require 'ruby-electric)
(require 'rinari)
(require 'sass-mode)
(require 'scala-mode-auto)
(require 'slime)
(require 'smalltalk-mode)
(require 'stumpwm-mode)
(require 'tuareg)
(require 'yaml-mode)
(require 'zencoding-mode)

(load (concat emacs-root "modes/nxhtml/autostart.el"))

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
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)

(require 'semantic-load)
(autoload 'jde-mode "jde" nil t)
(setq jde-build-function '(jde-ant-build))

;;; Pymacs
;; (setenv "PYMACS_PYTHON" "python2.5")
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; 
;; (pymacs-load "ropemacs" "rope-")

(display-battery-mode 1)
(setq battery-update-interval 30)

(require 'magit)

;; Use my own multimarkdown mode in preference to markdown-mode
(defalias 'markdown-mode 'multimarkdown-mode)

;; Factor
(load-file (expand-file-name "~/src/factor/misc/fuel/fu.el"))
;; (setq fuel-factor-root-dir (expand-file-name "~/src/factor"))
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
(defun perl-project-includes ()
  "Return list of -I flags to pass to perl."
  (eproject-assert-type 'perl)
  (list (concat (eproject-root) "/lib")))
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

;; Clojrue
(load-library "clojure-config")
;;; Slime
(setq slime-lisp-implementations
      '(
        (sbcl ("/Users/james/bin/sbcl" "--core" "/Users/james/lib/sbcl/sbcl.core") :coding-system utf-8-unix)
        (clojure ("clj" "--emacs") :init swank-clojure-init))
      )
(setq slime-backend (concat emacs-root "modes/slime/swank-loader.lisp"))
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

(add-to-list 'slime-lisp-implementations
      '(clojure ("clj" "--emacs") :init swank-clojure-init))
      
;; CSS
(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)

;; Ruby
(setq inferior-ruby-first-prompt-pattern "^>>")

;; flymake
(defun my-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line))

;; C
(c-add-style "kernel"
             '("gnu"
               (c-basic-offset . 4)))