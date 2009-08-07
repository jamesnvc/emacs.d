;; Global Keyconfigs

;; Other keys
(global-set-key [up] 'increment-number-at-point)
(global-set-key [down] 'decrement-number-at-point)
(global-set-key [XF86Back] 'next-buffer)
(global-set-key [XF86Forward] 'previous-buffer)
(global-set-key [(S XF86Forward)] 'winring-next-configuration)
(global-set-key [(S XF86Back)] 'winring-prev-configuration)

;; F keys
(global-set-key [f2] 'webjump)
(global-set-key [f3] 'eshell)
(global-set-key [f4] 'replace-regexp)
(global-set-key [f5]
                (lambda () (interactive) (yas/load-directory (concat emacs-root "utilities/yasnippet-read-only/snippets"))))
(global-set-key [f9] 'slime-selector)
(global-set-key [f10] 'run-clojure)
(global-set-key (kbd "<f7> t") 'planner-create-task-from-buffer)
(global-set-key (kbd "s-h") 'help-command)
(global-set-key (kbd "s-SPC") 'hippie-expand)

;; Shift
(global-set-key [(shift up)] (lambda (&optional n) (interactive "p") (scroll-down (or n 1))))
(global-set-key [(shift down)] (lambda (&optional n) (interactive "p") (scroll-up (or n 1))))

;; Meta
(global-set-key (kbd "M-#") 'calc-dispatch)
(global-set-key (kbd "M-+") 'count-words-region)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-G") 'what-line)
(global-set-key (kbd "M-d") 'kill-syntax-forward)
(global-unset-key (kbd "M-k"))
(global-set-key (kbd "M-k .") 'kill-sentence)
(global-set-key (kbd "M-k ;") 'kill-comment)
(global-set-key (kbd "M-k {") 'kill-paragraph)
(global-set-key (kbd "M-n") 'other-window)
(global-set-key (kbd "M-p") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "M-r") 'isearch-backward)
(global-set-key (kbd "M-s") 'isearch-forward)
(global-set-key [(shift menu)] 'anything)
(global-set-key (kbd "M-Z") 'zap-to-char-back)
(global-set-key [(meta down)] 'move-line-down)
(global-set-key [(meta up)] 'move-line-up)

;; C-
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)
(global-set-key (kbd "C-o") 'vi-open-next-line)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-w") 'kill-syntax-backward)
(global-set-key [C-tab] 'ibuffer)

;; C-c
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "C-c C-l") 'set-longlines-mode)
(global-set-key (kbd "C-c N") 'winring-new-configuration)
(global-set-key (kbd "C-c R") 'winring-rename-configuration)
(global-set-key (kbd "C-c J") 'winring-jump-to-configuration)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c e") 'eval-and-replace)
(global-set-key (kbd "C-c g") 'gnus)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c o")  'occur)
(global-set-key (kbd "C-c w")  'woman)
(global-set-key (kbd "C-c m") 'vm)
(global-set-key (kbd "C-c r") 'remember)
(global-set-key (kbd "C-c d") 'insert-date)
(global-set-key (kbd "C-c s") 'magit-status)


;; C-x
(global-set-key (kbd "C-x c") 'delete-trailing-whitespace)
(global-set-key (kbd "C-x C-p") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-i") 'imenu)
(global-set-key (kbd "C-x C-k") 'kill-region)
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-x C-n") 'other-window)
(global-set-key (kbd "C-x m") 'vm-compose-mail)
(global-set-key (kbd "C-x r RET") 'register-to-point) ; Use in conjunction with C-x r SPC (point-to-register)
(global-set-key (kbd "C-x /") 'point-to-register)
(global-set-key (kbd "C-x ?") 'register-to-point)

;; C-M-
(global-set-key (kbd "C-M-r") 'remember)

;; C-S-
(global-set-key (kbd "C-S-s") 'sacha/search-word-forward)
(global-set-key (kbd "C-S-r") 'sacha/search-word-backward)

;; Misc
(setq skeleton-pair t)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)


;; Mode-specific key configs

;; C/C++
(define-key c++-mode-map (kbd "C-c C-c") 'compile)
(define-key c++-mode-map (kbd "C-c C-n") 'next-error)
(define-key c++-mode-map (kbd "C-c C-p") 'previous-error)
(define-key c++-mode-map (kbd "C-c C-u") 'uncomment-region)
(define-key c-mode-map (kbd "C-c C-c") 'compile)
(define-key c-mode-map (kbd "C-c C-n") 'next-error)
(define-key c-mode-map (kbd "C-c C-p") 'previous-error)
(define-key c-mode-map (kbd "C-c C-u") 'uncomment-region)
(define-key c-mode-map (kbd "C-c C-v") 'my-flymake-show-next-error)
(define-key c++-mode-map (kbd "C-c C-v") 'my-flymake-show-next-error)

;; Java
(define-key java-mode-map (kbd "C-c C-v") 'my-flymake-show-next-error)

;; Lisp
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'comment-region)
(define-key lisp-interaction-mode-map (kbd "C-m") 'newline-and-indent)
(define-key lisp-interaction-mode-map (kbd "C-c C-e") 'eval-print-last-sexp)
(define-key lisp-mode-map (kbd "C-c l") 'lispdoc)
(define-key lisp-mode-map (kbd "C-s-SPC") 'slime-fuzzy-complete-symbol)
;;; SLIME
(define-key slime-mode-map (kbd "C-c ;") 'slime-insert-balanced-comments)
(define-key slime-mode-map (kbd "C-c M-;") 'slime-remove-balanced-comments)
(define-key slime-mode-map (kbd "C-c M-i") 'slime-fuzzy-complete-symbol)
(dolist (mode (list slime-mode-map lisp-mode-map))
  (define-key mode (kbd "C-c C-d h") 'cl-lookup))
;; Scheme
(define-key scheme-mode-map (kbd "C-c C-i") 'scheme-include-file)
(define-key scheme-mode-map (kbd "C-c i") 'scheme-include-file)

;; Smalltalk

(define-key smalltalk-mode-map (kbd "C-c t s") 'smalltalk-subclass-template)

;; w3m
(define-key w3m-mode-map (kbd "C-S-t") 'w3m-goto-new-session-url)
(define-key w3m-mode-map [(control XF86Back)] 'w3m-previous-buffer)
(define-key w3m-mode-map [(control XF86Forward)] 'w3m-next-buffer)
(define-key w3m-mode-map "," 'w3m-previous-buffer)
(define-key w3m-mode-map "." 'w3m-next-buffer)
(define-key w3m-mode-map "'" 'w3m-close-window)

;; Perl
(define-key cperl-mode-map (kbd "C-j") 'newline-and-indent)

;; Ruby
(define-key ruby-mode-map (kbd "C-c C-l") 'ruby-load-file)
(define-key ruby-mode-map (kbd "C-c C-z") 'switch-to-ruby)
(define-key ruby-mode-map (kbd "C-c C-r") 'ruby-send-region)
(define-key ruby-mode-map (kbd "C-c C-d") 'ruby-send-definition)

;; Factor
(define-key factor-mode-map [tab] 'yas/expand)

;; Org
(define-key org-mode-map (kbd "C-<up>") 'org-priority-up)
(define-key org-mode-map (kbd "C-<down>") 'org-priority-down)
(define-key org-mode-map [(shift up)] (lambda (&optional n) (interactive "p") (scroll-down (or n 1))))
(define-key org-mode-map [(shift down)] (lambda (&optional n) (interactive "p") (scroll-up (or n 1))))
(define-key mode-specific-map [?a] 'org-agenda)
(define-prefix-command 'org-todo-state-map)
(define-key org-mode-map (kbd "C-c x") 'org-todo-state-map)
(define-key org-todo-state-map "x" #'(lambda nil (interactive) (org-todo "CANCELLED")))
(define-key org-todo-state-map "d" #'(lambda nil (interactive) (org-todo "DONE")))
(define-key org-todo-state-map "f" #'(lambda nil (interactive) (org-todo "DEFERRED")))
(define-key org-todo-state-map "l" #'(lambda nil (interactive) (org-todo "DELEGATED")))
(define-key org-todo-state-map "s" #'(lambda nil (interactive) (org-todo "STARTED")))
(define-key org-todo-state-map "w" #'(lambda nil (interactive) (org-todo "WAITING")))
(define-key org-todo-state-map "a" #'(lambda nil (interactive) (org-todo "APPT")))

;; VM
(define-key vm-summary-mode-map (kbd "v") 'vm-visit-imap-folder)
(define-key vm-summary-mode-map (kbd "S") 'vm-save-and-expunge-folder)

;; Forth
(define-key forth-mode-map (kbd "C-h") 'backward-delete-char-untabify)
(define-key forth-mode-map (kbd "C-x C-n") 'other-window)
(define-key forth-mode-map (kbd "M-SPC") 'just-one-space)

;;; Smex
;; (global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-x") 'execute-extended-command)
(global-set-key [(menu)] 'execute-extended-command)
(global-set-key (kbd "M-X") 'anything)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)

;; Miscelaneous
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
(define-key muse-mode-map (kbd "C-c C-m") 'mathify-region)
(define-key org-mode-map [C-tab] 'ibuffer)
(define-key dired-mode-map (kbd "e") 'wdired-change-to-wdired-mode)
(define-key nxml-mode-map (kbd "C-c C-w") 'wikify-link)
(define-key bbdb-mode-map (kbd "z") 'wicked/bbdb-ping-bbdb-record)
(add-hook 'mail-setup-hook (lambda () (local-set-key "\t" 'bbdb-complete-name)) t)
(define-key isearch-mode-map (kbd "C-x") 'sacha/isearch-yank-current-word)
(define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)

;; Miscellaneous key-related configs
(defalias 'qrr 'query-replace-regexp)

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
