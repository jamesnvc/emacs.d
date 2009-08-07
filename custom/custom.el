;;; --------------------------------------------------------------------------------
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(Info-additional-directory-list (quote ("/usr/local/info" "/home/james/doc/info" "/home/james/doc/info/perl-5.6-info/info/")))
 '(Man-width t)
 '(abbrev-mode nil)
 '(bbdb-continental-zip-regexp "^\\s *[A-Z0-9]\\{3,3\\} *[A-Z0-9]\\{3,3\\}")
 '(bbdb-default-area-code nil)
 '(bbdb-default-country "Canada")
 '(bbdb-lastname-prefixes (quote ("von" "Von" "de" "De" "dos" "Dos")))
 '(bbdb-legal-zip-codes (quote ("^$" "^[ 	
]*[0-9][0-9]?[0-9]?[0-9]?[0-9]?[0-9]?[ 	
]*$" "^[ 	
]*\\([0-9][0-9][0-9][0-9][0-9]\\)[ 	
]*-?[ 	
]*\\([0-9][0-9][0-9][0-9]?\\)[ 	
]*$" "^[ 	
]*\\([A-Za-z0-9]+\\)[ 	
]+\\([A-Za-z0-9]+\\)[ 	
]*$" "^[ 	
]*\\([A-Z]+\\)[ 	
]*-?[ 	
]*\\([0-9]+ ?[A-Z]*\\)[ 	
]*$" "^[ 	
]*\\([A-Z]+\\)[ 	
]*-?[ 	
]*\\([0-9]+\\)[ 	
]+\\([0-9]+\\)[ 	
]*$" "^\\s *[A-Z0-9]\\{3,3\\} *[A-Z0-9]\\{3,3\\}")))
 '(bbdb-send-mail-style (quote vm))
 '(c-syntactic-indentation t)
 '(calendar-bahai-all-holidays-flag t)
 '(calendar-christian-all-holidays-flag t)
 '(calendar-hebrew-all-holidays-flag t)
 '(calendar-islamic-all-holidays-flag t)
 '(calendar-latitude 43.4)
 '(calendar-location-name "Toronto, ON")
 '(calendar-longitude -79.2)
 '(calendar-mark-diary-entries-flag t)
 '(calendar-today-marker (quote calendar-today))
 '(calendar-view-diary-initially-flag t)
 '(calendar-view-holidays-initially-flag nil)
 '(case-fold-search t)
 '(clean-buffer-list-kill-never-buffer-names (quote ("*scratch*" "*Messages*" "*server*" ".emacs" "mode-configs.el" "dotemacs" "customizations.el" "keys.el")))
 '(confirm-kill-emacs (quote y-or-n-p))
 '(cperl-clobber-lisp-bindings (quote null))
 '(current-language-environment "UTF-8")
 '(dabbrev-case-distinction nil)
 '(dabbrev-case-fold-search nil)
 '(debug-on-error t)
 '(debug-on-quit nil)
 '(default-input-method "rfc1345")
 '(describe-char-unidata-list (quote (name general-category decimal-digit-value digit-value numeric-value iso-10646-comment)))
 '(desktop-clear-preserve-buffers (quote ("\\*scratch\\*" "\\*Messages\\*" "\\*server\\*" "\\*tramp/.+\\*" "\\*w3m\\*\\(?:<.*?>\\)?" "\\*info\\*")))
 '(desktop-save t)
 '(desktop-save-mode t nil (desktop))
 '(ecb-options-version "2.33beta2")
 '(enable-recursive-minibuffers t)
 '(erc-input-line-position -1)
 '(erc-nick "jamesnvc")
 '(erc-user-full-name "James Cash")
 '(eshell-glob-case-insensitive t)
 '(eshell-load-hook (quote ((lambda nil (setenv "JAVA_HOME" "/usr/lib/jvm/java-6-sun")))))
 '(factor-binary "~/src/factor/factor")
 '(factor-image "~/src/factor/factor.image")
 '(flymake-buildfile-dirs (quote ("~/" "." ".." "../.." "../../.." "../../../.." "../../../../.." "../../../../../.." "../../../../../../.." "../../../../../../../.." "../../../../../../../../.." "../../../../../../../../../.." "../../../../../../../../../../..")))
 '(flyspell-default-dictionary nil)
 '(flyspell-use-meta-tab nil)
 '(fortune-dir "~/misc/fortunes/")
 '(fortune-file "/home/james/misc/fortunes/lambda.txt")
 '(ftp-program "sftp")
 '(fuel-help-bookmarks (quote (("html.templates.chloe" "html.templates.chloe" vocab))))
 '(fuel-listener-factor-binary "~/src/factor/factor")
 '(fuel-listener-factor-image "~/src/factor/factor.image")
 '(g-xslt-debug nil)
 '(gblogger-user-email "james.nvc@gmail.com")
 '(global-font-lock-mode t nil (font-lock))
 '(global-semantic-tag-folding-mode t nil (semantic-util-modes))
 '(haskell-font-lock-symbols t)
 '(haskell-ghci-program-args (quote ("-fglasgow-exts")))
 '(indent-tabs-mode nil)
 '(ipython-command "ipython -cl -pylab")
 '(ispell-local-dictionary nil)
 '(jde-jdk (quote ("1.5")))
 '(jde-jdk-registry (quote (("1.6" . "/usr/lib/jvm/java-6-sun") ("1.5" . "/usr/lib/jvm/java-1.5.0-sun"))))
 '(jit-lock-stealth-nice 0.5)
 '(jit-lock-stealth-time 3)
 '(js2-highlight-level 3)
 '(midnight-mode t nil (midnight))
 '(mumamo-major-modes (quote ((asp-js-mode javascript-mode) (asp-vb-mode visual-basic-mode) (javascript-mode javascript-mode js2-mode ecmascript-mode))))
 '(muse-latex2png-scale-factor 1.2)
 '(muse-latex2png-template "\\documentclass{article}
\\usepackage{fullpage}
\\usepackage{amssymb}
\\usepackage[usenames]{color}
\\usepackage{amsmath}
\\usepackage{latexsym}
\\usepackage[mathscr]{eucal}
%preamble%
\\pagestyle{empty}
\\begin{document}
{%code%}
\\end{document}
")
 '(nxhtml-minor-mode-modes (quote (nxhtml-mode nxml-mode html-mode sgml-mode xml-mode php-mode css-mode java-mode image-mode dired-mode)))
 '(nxhtml-skip-welcome t)
 '(nxml-outline-child-indent 8)
 '(nxml-slash-auto-complete-flag t)
 '(org-agenda-custom-commands (quote (("d" todo #("DELEGATED" 0 9 (face org-warning)) nil) ("c" todo #("DONE|DEFERRED|CANCELLED" 0 23 (face org-warning)) nil) ("w" todo #("WAITING" 0 7 (face org-warning)) nil) ("W" agenda "" ((org-agenda-ndays 21))) ("A" agenda "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]"))) (org-agenda-ndays 1) (org-agenda-overriding-header "Today's Priority #A tasks: "))) ("u" agenda #("TODO" 0 4 (face org-warning)) ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote scheduled) (quote deadline) (quote regexp) "<[^>
]+>"))) (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-text-search-extra-files (quote (agenda-archives)))
 '(org-deadline-warning-days 14)
 '(org-default-notes-file "~/notes.org")
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-link-abbrev-alist (quote (("wiki" . "http://en.wikipedia.org/wiki/"))))
 '(org-link-mailto-program (quote (browse-url "mailto:%a?subject=%s")))
 '(org-log-done t)
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 2))))
 '(org-remember-store-without-prompt t)
 '(org-remember-templates (quote (("Todo" 116 "** TODO %?
  %u" "todo.org" "Tasks" nil) ("Notes" 110 "* %u %?" "notes.org" "Notes" nil) ("Appts" 97 "** APPT %?
   %^T
%i
" "todo.org" "Appointments" nil) ("Book" 98 "*** TODO %?
  %u" "todo.org" "Books" nil) ("Payment" 112 "%t 
" "ledger.dat" bottom nil))))
 '(org-return-follows-link t)
 '(org-reverse-note-order t)
 '(org-startup-folded (quote content))
 '(org-tab-follows-link t)
 '(org-todo-interpretation (quote type))
 '(org-todo-keyword-faces (quote (("TODO" :foreground "blue" :weight bold :underline t) ("STARTED" :foreground "pink") ("DONE" :foreground "green"))))
 '(org-todo-keywords (quote ("TODO" "STARTED" "WAITING" "DEFERRED" "DELEGATED" "CANCELLED" "APPT" "DONE")))
 '(org-use-fast-todo-selection t)
 '(power-macros-file "/home/james/emacs_stuff/other/macros-file.el")
 '(predictive-auto-learn t)
 '(predictive-dict-autosave nil)
 '(predictive-dict-autosave-on-kill-buffer nil)
 '(predictive-dict-autosave-on-mode-disable nil)
 '(preview-TeX-style-dir "/home/james/emacs.d/modes/auctex-11.85/preview/latex/preview.sty")
 '(py-default-interpreter (quote cpython))
 '(py-python-command "python2.5")
 '(python-mode-hook (quote (turn-on-eldoc-mode wisent-python-default-setup)))
 '(python-python-command "ipython2.5 -cl")
 '(quack-default-program "gsi")
 '(quack-manuals (quote ((r6rs "R6RS" "http://www.r6rs.org/" nil) (r5rs "R5RS" "http://www.schemers.org/Documents/Standards/R5RS/HTML/" nil) (bigloo "Bigloo" "http://www-sop.inria.fr/mimosa/fp/Bigloo/doc/bigloo.html" nil) (chez "Chez Scheme User's Guide" "http://www.scheme.com/csug/index.html" nil) (chicken "Chicken User's Manual" "http://www.call-with-current-continuation.org/manual/manual.html" nil) (gambit "Gambit-C documentation (local)" "file://home/james/doc/gambit-c.html" nil) (gauche "Gauche Reference Manual" "http://www.shiro.dreamhost.com/scheme/gauche/man/gauche-refe.html" nil) (mitgnu-ref "MIT/GNU Scheme Reference" "http://www.gnu.org/software/mit-scheme/documentation/scheme.html" nil) (mitgnu-user "MIT/GNU Scheme User's Manual" "http://www.gnu.org/software/mit-scheme/documentation/user.html" nil) (mitgnu-sos "MIT/GNU Scheme SOS Reference Manual" "http://www.gnu.org/software/mit-scheme/documentation/sos.html" nil) (plt-mzscheme "PLT MzScheme: Language Manual" plt t) (plt-mzlib "PLT MzLib: Libraries Manual" plt t) (plt-mred "PLT MrEd: Graphical Toolbox Manual" plt t) (plt-framework "PLT Framework: GUI Application Framework" plt t) (plt-drscheme "PLT DrScheme: Programming Environment Manual" plt nil) (plt-insidemz "PLT Inside PLT MzScheme" plt nil) (plt-tools "PLT Tools: DrScheme Extension Manual" plt nil) (plt-mzc "PLT mzc: MzScheme Compiler Manual" plt t) (plt-r5rs "PLT R5RS" plt t) (scsh "Scsh Reference Manual" "http://www.scsh.net/docu/html/man-Z-H-1.html" nil) (sisc "SISC for Seasoned Schemers" "http://sisc.sourceforge.net/manual/html/" nil) (htdp "How to Design Programs" "http://www.htdp.org/" nil) (htus "How to Use Scheme" "http://www.htus.org/" nil) (t-y-scheme "Teach Yourself Scheme in Fixnum Days" "http://www.ccs.neu.edu/home/dorai/t-y-scheme/t-y-scheme.html" nil) (tspl "Scheme Programming Language (Dybvig)" "http://www.scheme.com/tspl/" nil) (sicp "Structure and Interpretation of Computer Programs" "http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-4.html" nil) (slib "SLIB" "http://swissnet.ai.mit.edu/~jaffer/SLIB.html" nil) (faq "Scheme Frequently Asked Questions" "http://www.schemers.org/Documents/FAQ/" nil) (gambit-online "Gambit online (by chapter)" "http://www.iro.umontreal.ca/~gambit/doc/gambit-c_toc.html" nil))))
 '(quack-pltish-keywords-to-fontify (quote ("and" "begin" "begin0" "c-declare" "c-lambda" "case" "case-lambda" "class" "class*" "class*/names" "class100" "class100*" "compound-unit/sig" "cond" "cond-expand" "define" "define-class" "define-const-structure" "define-constant" "define-embedded" "define-entry-point" "define-external" "define-foreign-record" "define-foreign-type" "define-foreign-variable" "define-generic" "define-generic-procedure" "define-inline" "define-location" "define-macro" "define-method" "define-module" "define-opt" "define-public" "define-reader-ctor" "define-record" "define-record-printer" "define-record-type" "define-signature" "define-struct" "define-structure" "define-syntax" "define-syntax-set" "define-values" "define-values/invoke-unit/sig" "define/contract" "define/override" "define/private" "define/public" "delay" "do" "else" "exit-handler" "field" "if" "import" "inherit" "inherit-field" "init" "init-field" "init-rest" "instantiate" "interface" "lambda" "let" "let*" "let*-values" "let+" "let-syntax" "let-values" "let/ec" "letrec" "letrec-values" "letrec-syntax" "match-lambda" "match-lambda*" "match-let" "match-let*" "match-letrec" "match-define" "mixin" "module" "opt-lambda" "or" "override" "override*" "namespace-variable-bind/invoke-unit/sig" "parameterize" "private" "private*" "protect" "provide" "provide-signature-elements" "provide/contract" "public" "public*" "quasiquote" "quote" "receive" "rename" "require" "require-for-syntax" "send" "send*" "set!" "set!-values" "signature->symbols" "super-instantiate" "syntax-case" "syntax-case*" "syntax-error" "syntax-rules" "unit/sig" "unless" "unquote" "unquote-splicing" "when" "with-handlers" "with-method" "with-syntax" "not" "call/cc" "defadvice" "lets" "with" "def" "mac" "fn")))
 '(quack-pretty-lambda-p t)
 '(quack-programs (quote ("gsi" "/usr/local/Gambit-C/bin/gsi" "bigloo" "csi" "csi -hygienic" "gambit" "gosh" "gsi " "gsi ~~/syntax-case -" "gsi ~~/syntax-case.-" "gsi ~~/syntax-case.scm -" "gsi-script" "guile" "kawa" "mit-scheme" "mred -z" "mzscheme" "mzscheme -M errortrace" "petite" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(quack-remap-find-file-bindings-p nil)
 '(quack-smart-open-paren-p nil)
 '(recentf-max-saved-items 500)
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 '(save-place t nil (saveplace))
 '(scheme-mit-dialect nil)
 '(semantic-idle-scheduler-idle-time 3)
 '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
 '(server-window (quote switch-to-buffer-other-frame))
 '(shell-file-name "/bin/bash")
 '(show-paren-mode t)
 '(slime-complete-symbol-function (quote slime-fuzzy-complete-symbol))
 '(slime-enable-evaluate-in-emacs t)
 '(spell-command "aspell")
 '(standard-indent 4)
 '(swank-clojure-extra-classpaths (append (directory-files "/usr/lib/jvm/java-6-sun/jre/lib" t "jar$") (when (file-directory-p "~/.clojure") (directory-files "~/.clojure" t ".jar$"))))
 '(tab-always-indent t)
 '(tab-width 4)
 '(tags-table-list nil)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(thinks-extra-silliness t)
 '(thinks-from (quote bottom-diagonal))
 '(transient-mark-mode t)
 '(twit-user "jamesnvc")
 '(view-read-only nil)
 '(vm-folder-directory "~/Maildir")
 '(vm-primary-inbox "/var/mail/james")
 '(vm-subject-ignored-prefix "^\\(re: *\\)+")
 '(vm-summary-show-threads t)
 '(w3m-fill-column 120)
 '(w3m-search-engine-alist (quote (("yahoo" "http://search.yahoo.com/bin/search?p=%s" nil) ("yahoo-ja" "http://search.yahoo.co.jp/bin/search?p=%s" euc-japan) ("alc" "http://eow.alc.co.jp/%s/UTF-8/" utf-8) ("blog" "http://blogsearch.google.com/blogsearch?q=%s&oe=utf-8&ie=utf-8" utf-8) ("blog-en" "http://blogsearch.google.com/blogsearch?q=%s&hl=en&oe=utf-8&ie=utf-8" utf-8) ("google" "http://www.google.com/search?q=%s&ie=utf-8&oe=utf-8" utf-8) ("google-en" "http://www.google.com/search?q=%s&hl=en&ie=utf-8&oe=utf-8" utf-8) ("google news" "http://news.google.co.jp/news?hl=ja&ie=utf-8&q=%s&oe=utf-8" utf-8) ("google news-en" "http://news.google.com/news?hl=en&q=%s" nil) ("google groups" "http://groups.google.com/groups?q=%s" nil) ("All the Web" "http://www.alltheweb.com/search?web&_sb_lang=en&q=%s" nil) ("All the Web-ja" "http://www.alltheweb.com/search?web&_sb_lang=ja&cs=euc-jp&q=%s" euc-japan) ("technorati" "http://www.technorati.com/search/%s" utf-8) ("technorati-ja" "http://www.technorati.jp/search/search.html?query=%s&language=ja" utf-8) ("technorati-tag" "http://www.technorati.com/tag/%s" utf-8) ("goo-ja" "http://search.goo.ne.jp/web.jsp?MT=%s" euc-japan) ("excite-ja" "http://www.excite.co.jp/search.gw?target=combined&look=excite_jp&lang=jp&tsug=-1&csug=-1&search=%s" shift_jis) ("altavista" "http://altavista.com/sites/search/web?q=\"%s\"&kl=ja&search=Search" nil) ("rpmfind" "http://rpmfind.net/linux/rpm2html/search.php?query=%s" nil) ("debian-pkg" "http://packages.debian.org/cgi-bin/search_contents.pl?directories=yes&arch=i386&version=unstable&case=insensitive&word=%s" nil) ("debian-bts" "http://bugs.debian.org/cgi-bin/pkgreport.cgi?archive=yes&pkg=%s" nil) ("freebsd-users-jp" "http://home.jp.FreeBSD.org/cgi-bin/namazu.cgi?key=\"%s\"&whence=0&max=50&format=long&sort=score&dbname=FreeBSD-users-jp" euc-japan) ("iij-archie" "http://www.iij.ad.jp/cgi-bin/archieplexform?query=%s&type=Case+Insensitive+Substring+Match&order=host&server=archie1.iij.ad.jp&hits=95&nice=Nice" nil) ("waei" "http://dictionary.goo.ne.jp/search.php?MT=%s&kind=je" euc-japan) ("eiwa" "http://dictionary.goo.ne.jp/search.php?MT=%s&kind=ej" nil) ("kokugo" "http://dictionary.goo.ne.jp/search.php?MT=%s&kind=jn" euc-japan) ("eiei" "http://www.dictionary.com/cgi-bin/dict.pl?term=%s&r=67" nil) ("amazon" "http://www.amazon.com/exec/obidos/search-handle-form/250-7496892-7797857" iso-8859-1 "url=index=blended&field-keywords=%s") ("amazon-ja" "http://www.amazon.co.jp/gp/search?__mk_ja_JP=%%83J%%83%%5E%%83J%%83i&url=search-alias%%3Daps&field-keywords=%s" shift_jis) ("emacswiki" "http://www.emacswiki.org/cgi-bin/wiki?search=%s" nil) ("en.wikipedia" "http://en.wikipedia.org/wiki/Special:Search?search=%s" nil) ("de.wikipedia" "http://de.wikipedia.org/wiki/Spezial:Search?search=%s" utf-8) ("ja.wikipedia" "http://ja.wikipedia.org/wiki/Special:Search?search=%s" utf-8) ("msdn" "http://search.msdn.microsoft.com/search/default.aspx?query=%s" nil) ("freshmeat" "http://freshmeat.net/search/?q=%s&section=projects" nil) ("google-wikipedia" "http://www.google.com/search?source=ig&hl=en&rlz=&q=%s+site:Aen.wikipedia.org&meta=&btnI" utf-8))))
 '(w3m-uri-replace-alist (quote (("\\`gg:" w3m-search-uri-replace "google") ("\\`ggg:" w3m-search-uri-replace "google groups") ("\\`ya:" w3m-search-uri-replace "yahoo") ("\\`al:" w3m-search-uri-replace "altavista") ("\\`bts:" w3m-search-uri-replace "debian-bts") ("\\`dpkg:" w3m-search-uri-replace "debian-pkg") ("\\`archie:" w3m-search-uri-replace "iij-archie") ("\\`alc:" w3m-search-uri-replace "alc") ("\\`urn:ietf:rfc:\\([0-9]+\\)" w3m-pattern-uri-replace "http://www.ietf.org/rfc/rfc\\1.txt") ("\\`gw:" w3m-search-uri-replace "google-wikipedia"))))
 '(w3m-use-cookies t)
 '(w3m-use-mule-ucs t)
 '(woman-default-indent 7)
 '(woman-emulation (quote nroff))
 '(woman-fill-frame t)
 '(woman-preserve-ascii nil)
 '(woman-use-own-frame nil))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(eshell-prompt ((t (:foreground "Blue" :weight bold))))
 '(factor-font-lock-comment ((t (:foreground "light green"))))
 '(factor-font-lock-constructor ((t (:foreground "medium slate blue"))))
 '(factor-font-lock-parsing-word ((t (:foreground "dodger blue"))))
 '(factor-font-lock-stack-effect ((t (:foreground "light green"))))
 '(factor-font-lock-string ((t (:foreground "light blue"))))
 '(factor-font-lock-type-definition ((t (:foreground "light slate blue"))))
 '(factor-font-lock-vocabulary-name ((t (:foreground "SkyBlue3"))))
 '(flymake-errline ((((class color)) (:underline "OrangeRed"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))
 '(font-lock-builtin-face ((t (:foreground "SteelBlue"))))
 '(font-lock-comment-delimiter-face ((default (:inherit font-lock-comment-face)) (((class color) (min-colors 16)) (:foreground "Grey" :weight extra-light))))
 '(font-lock-comment-face ((t (:foreground "LightGreen"))))
 '(font-lock-doc-face ((t (:foreground "LightBlue"))))
 '(font-lock-function-name-face ((t (:foreground "DodgerBlue"))))
 '(font-lock-keyword-face ((t (:foreground "LightBlue"))))
 '(font-lock-negation-char-face ((t (:foreground "OrangeRed"))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face :foreground "medium purple"))))
 '(font-lock-string-face ((t (:foreground "LightBlue"))))
 '(font-lock-type-face ((t (:foreground "Violet"))))
 '(js2-comment-face ((t (:foreground "LightGreen"))))
 '(js2-keyword-face ((t (:foreground "LightBlue"))))
 '(org-agenda-column-dateline ((t (:inherit org-column :background "black"))))
 '(org-column ((t (:inherit default :stipple nil :background "grey30" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1.0 :width normal :foundry "microsoft" :family "Consolas"))))
 '(py-decorators-face ((t (:foreground "purple"))) t)
 '(quack-pltish-keyword-face ((t (:foreground "DodgerBlue" :weight semi-bold))))
 '(quack-pltish-paren-face ((((class color) (background dark)) (:foreground "#00AC00"))))
 '(quack-pltish-selfeval-face ((((class color) (background dark)) (:foreground "red1"))))
 '(show-paren-match ((((class color) (background dark)) (:background "SeaGreen4" :slant oblique :weight extra-bold))))
 '(twit-title-face ((t (:background "DeepSkyBlue3" :underline "SkyBlue"))))
 '(twit-zebra-1-face ((t (:background "gray50"))))
 '(twit-zebra-2-face ((t (:background "gray20")))))
;;; Commands added by calc-private-autoloads on Sat Jan 20 23:59:20 2007.
(autoload 'calc-dispatch	   "calc" "Calculator Options" t)
(autoload 'full-calc		   "calc" "Full-screen Calculator" t)
(autoload 'full-calc-keypad	   "calc" "Full-screen X Calculator" t)
(autoload 'calc-eval		   "calc" "Use Calculator from Lisp")
(autoload 'defmath		   "calc" nil t t)
(autoload 'calc			   "calc" "Calculator Mode" t)
(autoload 'quick-calc		   "calc" "Quick Calculator" t)
(autoload 'calc-keypad		   "calc" "X windows Calculator" t)
(autoload 'calc-embedded	   "calc" "Use Calc inside any buffer" t)
(autoload 'calc-embedded-activate  "calc" "Activate =>'s in buffer" t)
(autoload 'calc-grab-region	   "calc" "Grab region of Calc data" t)
(autoload 'calc-grab-rectangle	   "calc" "Grab rectangle of data" t)
(setq load-path (nconc load-path (list "~/emacs_stuff/calc-2.02f")))
(global-set-key "\e#" 'calc-dispatch)
;;; End of Calc autoloads.

;;; --------------------------------------------------------------------------------
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
