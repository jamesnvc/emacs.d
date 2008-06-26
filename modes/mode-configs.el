;; Various useful modes

;; Need to be set before org.el is loaded
(setq org-return-follows-link t
      org-tab-follows-link t)

(require 'cc-mode)
(require 'coq)
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
;; (require 'ido)
(require 'inf-ruby)
(require 'inferior-coq)
(require 'lua-mode)
(require 'mmm-mode)
(require 'muse-mode)
(require 'muse-docbook)
(require 'muse-html)
(require 'muse-latex)
(require 'muse-latex2png)
(require 'muse-project)
(require 'muse-texinfo)
(load-library "rng-auto")
(require 'nxml-mode)
(require 'paredit)
(require 'php-mode)
(autoload 'python-mode "python-mode" "Python mode" t)
(require 'ipython)
(require 'remember)
(require 'ruby-electric)
(require 'ruby-mode)
(require 'smalltalk-mode)
(require 'stumpwm-mode)
(require 'tuareg)

(load-library "auto-modes")
(load-library "d-mode")
(load-library "haskell-configs")
;; (load-library "icicles")
(load-library "light-symbol-mode")
;; (load-library "muse-configs")
(load-library "org")
(load-library "org-config")
(load-library "quack")
(load-library "scheme-configs")
(load-library "factor.el")

(autoload 'js2-mode "js2" nil t)

(load-library "cedet")
(autoload 'jde-mode "jde" nil t)

(display-battery-mode 1)
(setq battery-update-interval 30)

(require 'vc-git)
(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
(require 'git)
(autoload 'git-blame-mode "git-blame" "Minor mode for incremental blame for Git." t)

;;mode-compile
;; (autoload 'mode-compile "mode-compile" "Command to compile current buffer file based on the major mode" t)
;; (autoload 'mode-compile-kill "mode-compile" "Command to kill a compilation launched by `mode-compile'" t)

(setq forth-program-name "gforth")

;; Flyspell

;; (add-hook 'text-mode-hook 'flyspell-mode-on)

;; (ido-mode t)

;; Javascript
(defalias 'javascript-mode 'js2-mode)

;; Perl
(defalias 'perl-mode 'cperl-mode)

(setq cperl-hairy t)
(setq cperl-electric-keywords t)
(defun my-cperl-eldoc-documentation-function ()
  "Return meaningful doc string for `eldoc-mode'."
  (car
   (let ((cperl-message-on-help-error nil))
     (cperl-get-help))))
(add-hook 'cperl-mode-hook
	  (lambda ()
	    (set (make-local-variable 'eldoc-documentation-function)
		 'my-cperl-eldoc-documentation-function)))
(add-hook 'cperl-mode-hook (lambda () (eldoc-mode t)))

;; XML and HTML
(defalias 'xml-mode 'nxml-mode)
(defalias 'html-mode 'nxml-mode)

(require 'flyspell)
(setq flyspell-prog-text-faces (append '(nxml-text-face) flyspell-prog-text-faces))
(add-hook 'nxml-mode-hook (lambda () (rng-validate-mode t)))

;; Erlang
(setq erlang-root-dir "/usr/lib/erlang")
(distel-setup)
;; Some Erlang customizations
(add-hook 'erlang-mode-hook
	  (lambda ()
	    ;; when starting an Erlang shell in Emacs, default in the node name
	    (setq inferior-erlang-machine-options '("-sname" "emacs"))))
;; For debugging
(setq fsm-use-debug-buffer t)

;; Ruby
(add-hook 'ruby-mode-hook 'ruby-electric-mode)

;; Latex
;; (if (equal (emacs-type) 'emacs-window) (require 'yatex))
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'yatex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'pretty-greek)

;; Eshell
(add-hook 'eshell-mode-hook
	  '(lambda ()
	    (define-key eshell-mode-map "\C-a" 'eshell-bol)))

;; Lisp
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(add-hook 'lisp-mode-hook 'pretty-greek)
(add-hook 'lisp-mode-hook (lambda () (paredit-mode t)))
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode t)))
(add-hook 'emacs-lisp-mode-hook 'pretty-greek)
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(if (file-exists-p "/usr/share/doc/hyperspec/")
    (setq common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/"))
(dolist (hook '(lisp-mode-hook
		slime-repl-mode-hook))
  (add-hook hook #'(lambda nil (cldoc-mode 1))))
(require 'info-look)
(info-lookup-add-help
 :mode 'lisp-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))
;;; Slime
(setq slime-backend "/home/james/src/clbuild/.swank-loader.lisp")
(setq slime-net-coding-system 'utf-8-unix)
(setq slime-complete-symbol*-fancy t)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(load "/home/james/src/clbuild/source/slime/slime")
(setq inferior-lisp-program "/home/james/src/clbuild/clbuild lisp")
(setq lisp-indent-function 'common-lisp-indent-function)
(setq slime-complete-symbol 'slime-fuzzy-complete-symbol)
(slime-setup '(slime-fancy slime-tramp slime-banner slime-asdf))

(autoload 'cl-lookup "cl-lookup" "View the documentation on ENTRY from the Common Lisp HyperSpec, et al.")
;;; Paredit
(autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)
(dolist (hook '(lisp-mode-hook
                slime-repl-mode-hook))
  (add-hook hook #'(lambda nil (paredit-mode 1))))

(define-key paredit-mode-map [?\)] 'paredit-close-parenthesis)
(define-key paredit-mode-map [(meta ?\))] 'paredit-close-parenthesis-and-newline)
;;; Redshank
(autoload 'redshank-mode "redshank" "Minor mode for editing and refactoring (Common) Lisp code." t)
(autoload 'turn-on-redshank-mode "redshank" "Turn on Redshank mode.  Please see function `redshank-mode'." t)
(add-hook 'lisp-mode-hook 'turn-on-redshank-mode)


;; CSS
(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)

;; Factor
(add-hook 'factor-mode-hook
          (lambda ()
            (set (make-local-variable 'eldoc-documentation-function)
                 'factor-get-effect)))
;; flymake
(defun my-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line))

;; C
;; (add-hook 'c-mode-common-hook 'flymake-mode)

;; Other
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'mail-mode-hook 'flyspell-mode)
