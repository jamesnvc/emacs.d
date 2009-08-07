(defconst use-backup-dir t)

(require 'auto-complete)
(require 'appt)
(require 'bbdb)
(require 'browse-kill-ring)
(require 'cldoc)
(require 'color-theme)
(require 'doc-view)
(require 'epa) ;; GPG integeration!
(epa-file-enable)
(require 'emacs-goodies-el)
;; (require 'eproject)
(require 'ffap)
(require 'highlight-parentheses)
(require 'hippie-exp)
(require 'htmlize)
(require 'jit-lock)
(require 'ledger)
(require 'notify)
(require 'planner)
(require 'pabbrev)
(require 'ibuffer)
(require 'ibuf-ext)
(require 'printing)
(require 'snippet)
(require 'smart-snippet)
(require 'smex)
(require 'vm)
(require 'message)
(require 'w3m)
(require 'webjump)

(load-library "snippet-expands")
(load-library "fuzzy-match")

(setq split-width-threshold 400)

(setq jit-lock-stealth-time 1)

(setq safe-local-variable-values
      (quote ((auto-recompile . t)
              (outline-minor-mode . t)
              auto-recompile outline-minor-mode)))

(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;;; eproject
;; (define-project-type perl (generic)
;;   (or (look-for "Makefile.PL") (look-for "Build.PL"))
;;   :relevant-files ("\\.pm$" "\\.t$" "\\.pl$" "\\.PL$"))

;; (define-project-type lisp (generic)
;;   (eproject--scan-parents-for file
;;                               (lambda (directory)
;;                                 (let ((dname (file-name-nondirectory directory)))
;;                                   (file-exists-p (format "%s/%s.asd" directory dname)))))
;;   :relevant-files ("\\.lisp$" "\\.asd$"))

;; Google cal/reader/etc interface
(load-library "g")
(setq g-user-email "james.nvc@gmail.com")
(gcal-emacs-calendar-setup)
(setq g-html-handler 'w3m-buffer)

(require 'ecb)

;; Twitter
(autoload 'twitter-get-friends-timeline "twitter" nil t)
(autoload 'twitter-status-edit "twitter" nil t)
(add-hook 'twitter-status-edit-mode-hook 'longlines-mode)

;; Org stuff (popup reminders)
(setq appt-time-msg-list nil)
(org-agenda-to-appt)


(defadvice  org-agenda-redo (after org-agenda-redo-add-appts)
  "Pressing `r' on the agenda will also add appointments."
  (progn
    (setq appt-time-msg-list nil)
    (org-agenda-to-appt)))

(ad-activate 'org-agenda-redo)
(progn
  (appt-activate 1)
  (setq appt-display-format 'window)
  (setq appt-disp-window-function (function my-appt-disp-window))
  (defun my-appt-disp-window (min-to-app new-time msg)
    (call-process "/home/james/bin/popup.py" nil 0 nil min-to-app msg new-time)))

;; Webjumps
(setq webjump-sites
      (append '(
                ("Reddit Search" .
                 [simple-query "www.reddit.com" "http://www.reddit.com/search?q=" ""])
                ("Google Image Search" .
                 [simple-query "images.google.com" "images.google.com/images?hl=en&q=" ""])
                ("Flickr Search" .
                 [simple-query "www.flickr.com" "flickr.com/search/?q=" ""])
                )
              webjump-sample-sites))
;; BBDB
(bbdb-initialize 'gnus 'message 'sendmail 'vm 'w3)
(require 'bbdb-human-names)
(require 'bbdb-wl)
(bbdb-wl-setup)
;; enable pop-ups
(setq bbdb-use-pop-up t)
;; auto collection
(setq bbdb/mail-auto-create-p t)
;; exceptional folders against auto collection
(setq bbdb-wl-ignore-folder-regexp "^@")
(setq signature-use-bbdb t)
(setq bbdb-north-american-phone-numbers-p t)
;; shows the name of bbdb in the summary :-)
(setq wl-summary-from-function 'bbdb-wl-from-func)
;; automatically add mailing list fields
(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)
(setq bbdb-auto-notes-alist '(("X-ML-Name" (".*$" ML 0))))

(load-library "wicked") ;; Stuff from wicked cool emacs for bbdb

(setenv "PYTHONPATH" "$HOME/Programming/python")

(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat emacs-root "utilities/yasnippet-read-only/snippets"))

(setq planner-project "MyPlans")
(setq muse-project-alist
      '(("MyPlans"
         ("~/plans"
          :default "index"
          :major-mode planner-mode
          :visit-link planner-visit-link))))

;;; Wanderlust mail stuff
(load-library "wanderlust-conf")

(require 'emacs-goodies-el)

(iswitchb-mode t)
(setq iswitchb-prompt-newbuffer nil)

;;; Ido or Icicles?  While Icicles is apparently much more featurefull, I cannot abide the way it
;;; mangles tramp...maybe if I can it working properly...
;;; Ido
(load-file (concat emacs-root "utilities/ido.el"))
(ido-mode t)
(setq ido-enable-flex-matching t)
(ido-everywhere t)
(setq ido-use-filename-at-point t)

;; Icicles
;; (load-library "icy-configs")

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
(setq-default fill-column 78)
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
      '(yas/hippie-try-expand
        try-expand-dabbrev
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
      (list anything-c-source-buffers+
            anything-c-source-locate
            anything-c-source-recentf   
            anything-c-source-org-headline
            anything-c-source-info-pages
            anything-c-source-man-pages
            anything-c-source-buffer-not-found))

;; Load stuff from M-x customize from a different file, to keep .emacs cleaner
(setq custom-file (concat emacs-root "custom/custom.el"))
(load custom-file 'noerror)

;; Set colours, overriding custom-set-faces
(load-library "colourizing")
(color-theme-jamesnvc)

;; (require 'shell-config)