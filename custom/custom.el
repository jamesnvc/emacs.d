;;; --------------------------------------------------------------------------------
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(Info-additional-directory-list (quote ("/usr/local/info" "/Users/james/doc/info")))
 '(LaTeX-command "/usr/texbin/xelatex")
 '(Man-width t)
 '(TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^\\(?:a5\\(?:comb\\|paper\\)\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^\\(?:a5\\(?:comb\\|paper\\)\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)xdvi %dS %d") ("^pdf$" "." "open %o %(outpage)") ("^html?$" "." "netscape %o"))))
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
 '(ecb-options-version "2.40")
 '(enable-recursive-minibuffers t)
 '(epg-gpg-program "/usr/local/bin/gpg")
 '(erc-input-line-position -1)
 '(erc-nick "jamesnvc")
 '(erc-user-full-name "James Cash")
 '(eshell-glob-case-insensitive t)
 '(eshell-load-hook (quote ((lambda nil (setenv "JAVA_HOME" "/usr/lib/jvm/java-6-sun")))))
 '(factor-binary "~/src/factor/factor")
 '(factor-image "~/src/factor/factor.image")
 '(flymake-buildfile-dirs (quote ("~/" "." ".." "../.." "../../.." "../../../.." "../../../../.." "../../../../../.." "../../../../../../.." "../../../../../../../.." \.\.\.)))
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
 '(jde-ant-enable-find t)
 '(jde-ant-read-buildfile t)
 '(jde-ant-read-target t)
 '(jde-jdk (quote ("1.6")))
 '(jde-jdk-registry (quote (("1.6" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.6") ("1.5" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.5"))))
 '(jde-make-program "/usr/bin/ant")
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
 '(org-agenda-files (quote ("~/Documents/org/todo.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-text-search-extra-files (quote (agenda-archives)))
 '(org-deadline-warning-days 14)
 '(org-default-notes-file "~/notes.org")
 '(org-export-html-style "")
 '(org-export-htmlize-output-type (quote css))
 '(org-export-htmlized-org-css-url "/Users/james/emacs.d/org-html-export.css")
 '(org-export-latex-classes (quote (("article" "\\documentclass[11pt]{article}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{amsfonts}
\\usepackage{enumerate}
\\usepackage{fontspec}
\\usepackage{xunicode}
\\usepackage{xltxtra}" ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}")) ("report" "\\documentclass[11pt]{report}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("book" "\\documentclass[11pt]{book}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{amssymb}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))))
 '(org-export-latex-listings t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-hide-leading-stars t)
 '(org-latex-to-pdf-process (quote ("xelatex -interaction nonstopmode %s" "xelatex -interaction nonstopmode %s")))
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
 '(python-python-command "python2.5")
 '(quack-default-program "gsi")
 '(quack-manuals (quote ((r6rs "R6RS" "http://www.r6rs.org/" nil) (r5rs "R5RS" "http://www.schemers.org/Documents/Standards/R5RS/HTML/" nil) (bigloo "Bigloo" "http://www-sop.inria.fr/mimosa/fp/Bigloo/doc/bigloo.html" nil) (chez "Chez Scheme User's Guide" "http://www.scheme.com/csug/index.html" nil) (chicken "Chicken User's Manual" "http://www.call-with-current-continuation.org/manual/manual.html" nil) (gambit "Gambit-C documentation (local)" "file://home/james/doc/gambit-c.html" nil) (gauche "Gauche Reference Manual" "http://www.shiro.dreamhost.com/scheme/gauche/man/gauche-refe.html" nil) (mitgnu-ref "MIT/GNU Scheme Reference" "http://www.gnu.org/software/mit-scheme/documentation/scheme.html" nil) (mitgnu-user "MIT/GNU Scheme User's Manual" "http://www.gnu.org/software/mit-scheme/documentation/user.html" nil) (mitgnu-sos "MIT/GNU Scheme SOS Reference Manual" "http://www.gnu.org/software/mit-scheme/documentation/sos.html" nil))))
 '(quack-pltish-keywords-to-fontify (quote ("and" "begin" "begin0" "c-declare" "c-lambda" "case" "case-lambda" "class" "class*" "class*/names")))
 '(quack-pretty-lambda-p t)
 '(quack-programs (quote ("gsi" "/usr/local/Gambit-C/bin/gsi" "bigloo" "csi" "csi -hygienic" "gambit" "gosh" "gsi " "gsi ~~/syntax-case -" "gsi ~~/syntax-case.-" \.\.\.)))
 '(quack-remap-find-file-bindings-p nil)
 '(quack-smart-open-paren-p nil)
 '(recentf-max-saved-items 500)
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 '(safe-local-variable-values (quote ((jde-ant-buildfile . "/Users/james/Programming/java/gwt-mac-1.7.0/CollabTasks/build.xml") (jde-ant-buildfile . ~/Programming/java/gwt-mac-1\.7\.0/CollabTasks/build\.xml) (auto-recompile . t) (outline-minor-mode . t) auto-recompile outline-minor-mode)))
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
 '(tags-table-list (quote ("/Users/james/Documents/School/engSci/year3/Semester 2/ECE353/svn/trunk")))
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
 '(w3m-command "/opt/local/bin/w3m")
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
 '(org-column ((t (:inherit default :stipple nil :background "grey30" :foreground "white" :inverse-video nil \.\.\.))))
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

