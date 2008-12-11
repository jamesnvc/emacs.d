(defconst use-backup-dir t)

(require 'bbdb)
(require 'browse-kill-ring)
(require 'cldoc)
(require 'color-theme)
(require 'doc-view)
(require 'epa) ;; GPG integeration!
(epa-file-enable)
(require 'emacs-goodies-el)
(require 'ffap)
(require 'highlight-parentheses)
(require 'hippie-exp)
(require 'htmlize)
(require 'planner)
(require 'pabbrev)
(require 'ibuffer)
(require 'ibuf-ext)
(require 'printing)
(require 'snippet)
(require 'smart-snippet)
(require 'vm)
(require 'message)
(require 'w3m)

(load-library "snippet-expands")
(load-library "fuzzy-match")

(setq split-width-threshold 400)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(load-library "g")
(setq g-user-email "james.nvc@gmail.com")
(setq g-html-handler 'w3m-buffer)

;; BBDB
(bbdb-initialize 'gnus 'message 'sendmail 'vm 'w3)
(require 'bbdb-human-names)

(load-library "wicked") ;; Stuff from wicked cool emacs for bbdb

(setenv "PYTHONPATH" "$HOME/Programming/python")

(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat emacs-root "utilities/yasnippet-0.5.3/snippets"))

(setenv "PYMACS_PYTHON" "python2.5")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(setq planner-project "MyPlans")
(setq muse-project-alist
      '(("MyPlans"
	 ("~/plans" ;; Or wherever you want your planner files to be
	  :default "index"
	  :major-mode planner-mode
	  :visit-link planner-visit-link))))

(require 'emacs-goodies-el)

;; Set colours
(color-theme-clarity)
(set-background-color "grey6")
(set-foreground-color "white")

(iswitchb-mode t)
(setq iswitchb-prompt-newbuffer nil)

;; Ido
(load-file (concat emacs-root "utilities/ido.el"))
(ido-mode t)
(setq ido-enable-flex-matching t)

(load "dired-x")
(prefer-coding-system 'utf-8)
(add-to-list 'auto-coding-alist '("." . utf-8))
(server-start)
(setq server-window nil)
(display-time)
(column-number-mode t)

(global-hl-line-mode 1)
(set-face-background 'hl-line "#111")

(setq visible-bell t)
(set-language-environment 'UTF-8)
(set-default-coding-systems             'utf-8)
(setq file-name-coding-system           'utf-8)
(setq default-bufnfer-file-coding-system 'utf-8)
(setq coding-system-for-write           'utf-8)
(set-keyboard-coding-system             'utf-8)
(set-terminal-coding-system             'utf-8)
(set-clipboard-coding-system            'utf-8)
(set-selection-coding-system            'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq desktop-save 'if-exists)
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))
(setq dired-recursive-deletes 'top)
(setq w3m-use-tab t)
(setq inhibit-startup-message t)
(setq set-mark-command-repeat-pop t)
(setq delete-auto-save-files t)
(setq-default fill-column 100)
(setq-default ispell-program-name "aspell")
(setq case-fold-search nil)
(setq compilation-window-height 10)
(setq compilation-scroll-output t)
(setq next-line-add-newlines nil)
(setq woman-manpath (quote ("/usr/man
MANDATORY_MANPATH" "/usr/X11R6/man
MANDATORY_MANPATH" "/usr/share/man" "/usr/local/man")))
(setq view-diary-entries-initially t)
(setq vm-mutable-frames nil)
(setq vm-raise-frame-at-startup nil)
(setq tramp-ftp-method "sftp")
(setq browse-url-browser-function 'w3m-browse-url)
(fset 'yes-or-no-p 'y-or-n-p)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill))
(setq tags-file-name "/home/james/Programming/TAGS")
(setq backup-directory-alist (quote ((".*" . "~/backup/temp/")))
      version-control t                ; Use version numbers for backups
      kept-new-versions 3             ; Number of newest versions to keep
      kept-old-versions 2              ; Number of oldest versions to keep
      delete-old-versions t            ; Ask to delete excess backup versions?
      backup-by-copying-when-linked t); Copy linked files, don't rename.

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(global-font-lock-mode 1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


;; show char name, used by C-u C-x =
(let ((x "~/emacs.d/mymisc/UnicodeData.txt"))
  (when (file-exists-p x)
    (setq describe-char-unicodedata-file x)
))

(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position)
 	   (line-beginning-position 2)))))

(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position)
 	   (line-beginning-position 2)))))

;; default groups for ibuffer
(setq ibuffer-saved-filter-groups
      '(("default"
	 ("Misc" (name . "^\\*.*\\*$"))
	 ("Emacs" (or
		   (mode . emacs-lisp-mode)
		   (name . "^\\*scratch\\*$")
		   (name . "^\\*Messages\\*$")))
	 ("w3m" (mode . w3m-mode))
	 ("Haskell" (mode . haskell-mode))
	 ("Scheme" (mode . scheme-mode))
	 ("Lisp" (mode . lisp-mode))
	 ("Erlang" (mode . erlang-mode))
	 ("Ruby" (mode . ruby-mode))
	 ("C" (or (mode . c-mode)
		  (mode . c++-mode)))
	 ("Org" (or (mode . org-mode)
		    (mode . muse-mode)))

	 ("Dired" (mode . dired-mode))
	 )))


;; Reverse the order of the groups
(defadvice ibuffer-generate-filter-groups (after reverse-ibuffer-groups () activate)
  (setq ad-return-value (nreverse ad-return-value)))

(load-library "skeletons")

(define-auto-insert '("\\.factor\\'" . "Factor module") 'factor-skeleton)

(require 'winring)
(setq winring-show-names t)
(setq winring-prompt-on-create 'nil)

(winring-initialize)
(winring-new-configuration)
(winring-prev-configuration)

(setq x-select-enable-clipboard t)
(load-library "sacha")

(require 'filecache)
(require 'anything)
(require 'anything-config)
(setq anything-sources
      (list anything-c-source-buffers
            anything-c-source-file-name-history
            anything-c-source-info-pages
            anything-c-source-man-pages
	    anything-c-source-file-cache
            anything-c-source-emacs-commands))