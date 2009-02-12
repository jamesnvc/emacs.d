;;; Mode hooks

;; Asm
(add-hook 'asm-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

;; Python
(add-hook 'python-mode-hook 'ropemacs-mode)

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

;; XML
(add-hook 'nxml-mode-hook (lambda () (rng-validate-mode t)))

;; Erlang
(add-hook 'erlang-mode-hook
	  (lambda ()
	    ;; when starting an Erlang shell in Emacs, default in the node name
	    (setq inferior-erlang-machine-options '("-sname" "emacs"))))


;; Ruby
(add-hook 'ruby-mode-hook 'ruby-electric-mode)


;; Latex
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'yatex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'pretty-greek)
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
(add-hook 'factor-mode-hook
          (lambda ()
            (set (make-local-variable 'eldoc-documentation-function)
                 'factor-get-effect)))
(add-hook 'factor-mode-hook 'yas/minor-mode-on)
(add-hook 'factor-mode-hook (lambda () (setf tab-width 4)))
(add-hook 'factor-mode-hook (lambda () (setf tags-file-name (concat src-root "factor/misc/ETAGS"))))


;; C
;; (add-hook 'c-mode-common-hook 'flymake-mode)
(add-hook 'c-mode-common-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))
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
