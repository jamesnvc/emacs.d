;;; Mode hooks

;; Cedet hooks
;;; Cedet
;; Key definitions used in hooks
(defun my-cedet-hook ()
  (semantic-stickyfunc-mode -1)
  
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)

  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  
  (local-set-key (kbd "C-c -") 'semantic-tag-folding-fold-block)
  (local-set-key (kbd "C-c +") 'semantic-tag-folding-show-block)
  
  )

(defun my-c-mode-cedet-hook ()
 ;; (local-set-key "." 'semantic-complete-self-insert)
 ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key (kbd "C-c t") 'eassist-switch-h-cpp)
  (local-set-key (kbd "C-c C-t") 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)
  )
(defun my-semantic-hook ()
;; (semantic-tag-folding-mode 1)
  (imenu-add-to-menubar "TAGS")
 )

;;(add-hook 'semantic-init-hooks 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'lisp-mode-hook 'my-cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'my-cedet-hook)
;; (add-hook 'erlang-mode-hook 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)
;; hooks, specific for semantic
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;; Org hooks
(add-hook 'org-mode-hook 'org-mode-reftex-setup)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; Rainbow hooks
(add-hook 'sass-mode-hook 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)

;; Asm
(add-hook 'asm-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

;; Python
;; (add-hook 'python-mode-hook 'ropemacs-mode)
;; turn off yas for python, since we really want tab to indent (use hippie-expand for yas)
(add-hook 'python-mode-hook 'yas/minor-mode-off)
(add-hook 'python-mode-hook (lambda ()
                              (font-lock-add-keywords nil
                               '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))
;; Flyspell
;; (add-hook 'text-mode-hook 'flyspell-mode-on)

;; Forth
(add-hook 'forth-mode-hook (function (lambda ()
                             (setq forth-indent-level 4)
                             (setq forth-minor-indent-level 2)
                             (setq forth-hilight-level 3))))

;; Javascript
(add-hook 'javascript-mode-hook 'javascript-custom-setup)

(add-hook 'js2-mode-hook 'yas/minor-mode-on)

;; Perl
(add-hook 'cperl-mode-hook
	  (lambda ()
	    (set (make-local-variable 'eldoc-documentation-function)
		 'my-cperl-eldoc-documentation-function)))
(add-hook 'cperl-mode-hook (lambda () (eldoc-mode t)))
(add-hook 'perl-project-file-visit-hook
          (lambda ()
            (ignore-errors
              (stylish-repl-eval-perl
               (format "use lib '%s'" (car (perl-project-includes)))))))

;; XML
(add-hook 'nxml-mode-hook (lambda () (rng-validate-mode t)))

;; Erlang
(add-hook 'erlang-mode-hook
	  (lambda ()
	    ;; when starting an Erlang shell in Emacs, default in the node name
	    (setq inferior-erlang-machine-options '("-sname" "emacs"))))


;; Ruby
(add-hook 'ruby-mode-hook 'ruby-electric-mode)
(add-hook 'ruby-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

;; Latex
(add-hook 'latex-mode-hook (lambda () (flyspell-mode 1)))
(add-hook 'yatex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'pretty-greek)
(add-hook 'latex-mode-hook 'reftex-mode)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; Eshell
(add-hook 'eshell-mode-hook
	  '(lambda ()
	    (define-key eshell-mode-map "\C-a" 'eshell-bol)))

;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode t)))
(add-hook 'emacs-lisp-mode-hook 'pretty-greek)
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'yas/minor-mode-on)

;; Lisp
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(add-hook 'lisp-mode-hook 'pretty-greek)
(add-hook 'lisp-mode-hook (lambda () (paredit-mode t)))
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(dolist (hook '(lisp-mode-hook slime-repl-mode-hook))
  (add-hook hook #'(lambda () (cldoc-mode 1)))
  (add-hook hook #'(lambda () (paredit-mode 1))))
;; (add-hook 'lisp-mode-hook 'turn-on-redshank-mode)


;; Clojure
(add-hook 'clojure-mode-hook 'paredit-mode)

;; Factor
(add-hook 'factor-mode-hook 'yas/minor-mode-on)
(add-hook 'factor-mode-hook (lambda () (setf tab-width 4)))
(add-hook 'factor-mode-hook (lambda () (setf tags-file-name (concat src-root "factor/misc/ETAGS"))))


;; C
;; (add-hook 'c-mode-common-hook 'flymake-mode)
(add-hook 'c-mode-common-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))
(add-hook 'c-mode-common-hook (lambda () (c-set-style "kernel")))

;; Other
;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'mail-mode-hook 'flyspell-mode)

;;; Utility hooks
;; SuperCite
(add-hook 'mail-citation-hook 'sc-cite-original)

;; BBDB
(add-hook 'mail-setup-hook 'bbdb-insinuate-sendmail)
(add-hook 'bbdb-create-hook 'bbdb-creation-date-hook)
(add-hook 'bbdb-change-hook 'bbdb-timestamp-hook)
(add-hook 'bbdb-after-change-hook (lambda (&rest ignore) (bbdb-resort-database) (bbdb-save-db)))

(add-hook 'diary-display-hook 'fancy-diary-display)

(add-hook 'after-save-hook
          '(lambda ()
             (progn
               (and (save-excursion
                      (save-restriction
                        (widen)
                        (goto-char (point-min))
                        (save-match-data
                          (looking-at "^#!"))))
                    (shell-command (concat "chmod u+x " buffer-file-name))
                    (message (concat "Saved as script: " buffer-file-name))))))

;; ibuffer, I like my buffers to be grouped
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups
             "default")))

(add-hook 'find-file-hook 'auto-insert)

(remove-hook 'senator-minor-mode-hook 'senator-hippie-expand-hook)