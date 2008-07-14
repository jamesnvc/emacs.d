;; Global Keyonfigs

;; Other keys
(global-set-key [up] 'increment-number-at-point)
(global-set-key [down] 'decrement-number-at-point)
(global-set-key [XF86Back] 'next-buffer) ;; Thinkpad <- key
(global-set-key [XF86Forward] 'previous-buffer) ;; Thinknpad -> key
(global-set-key [(S XF86Forward)] 'winring-next-configuration)
(global-set-key [(S XF86Back)] 'winring-prev-configuration)

;; F keys
(global-set-key [f3] 'eshell)
(global-set-key [f4] 'replace-regexp)
(global-set-key [f9] 'slime-selector)
(global-set-key (kbd "<f8> t") 'planner-create-task-from-buffer)
;; (global-set-key [f21] 'next-buffer) ;; Thinkpad <- key
;; (global-set-key [f22] 'previous-buffer) ;; Thinknpad -> key
;; Super
(global-set-key (kbd "s-h") 'help-command)
(global-set-key (kbd "s-SPC") 'hippie-expand)

;; Shift
(global-set-key [(shift up)] (lambda (&optional n) (interactive "p") (scroll-down (or n 1))))
(global-set-key [(shift down)] (lambda (&optional n) (interactive "p") (scroll-up (or n 1))))

;; Meta
(global-set-key (kbd "M-#") 'calc-dispatch)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-G") 'what-line)
(global-set-key (kbd "M-d") 'kill-syntax-forward)
(global-unset-key (kbd "M-k"))
(global-set-key (kbd "M-k .") 'kill-sentence)
(global-set-key (kbd "M-k ;") 'kill-comment)
(global-set-key (kbd "M-k }") 'kill-paragraph)
(global-set-key (kbd "M-n") 'other-window)
(global-set-key (kbd "M-p") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "M-r") 'isearch-backward)
(global-set-key (kbd "M-s") 'isearch-forward)
(global-set-key (kbd "M-Z") 'zap-to-char-back)
(global-set-key [(meta down)] 'move-line-down)
(global-set-key [(meta up)] 'move-line-up)

;; C-
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)
(global-set-key (kbd "C-o") 'vi-open-next-line)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-w") 'kill-syntax-backward)
(global-set-key [C-tab] 'ibuffer)

;; C-c
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "C-c N") 'winring-new-configuration)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c e") 'eval-and-replace)
(global-set-key (kbd "C-c g") 'gnus)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c o")  'occur)
(global-set-key (kbd "C-c w")  'woman)
;; (global-set-key (kbd "C-c m") 'vm) ;; I don't really use this anymore

;; C-x
(global-set-key (kbd "C-x b") 'iswitchb-buffer)
(global-set-key (kbd "C-x c") 'delete-trailing-whitespace)
(global-set-key (kbd "C-x C-p") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-i") 'imenu)
(global-set-key (kbd "C-x C-k") 'kill-region)
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-x C-n") 'other-window)
;; (global-set-key (kbd "C-x h") 'help-command)
(global-set-key (kbd "C-x m") 'execute-extended-command)
(global-set-key (kbd "C-x r RET") 'register-to-point) ; Use in conjunction with C-x r SPC (point-to-register)
(global-set-key (kbd "C-x /") 'point-to-register)
(global-set-key (kbd "C-x ?") 'register-to-point)

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
(define-key w3m-mode-map (kbd "C-S-n") 'w3m-goto-new-session-url)
(define-key w3m-mode-map [(control XF86Back)] 'w3m-previous-buffer)
(define-key w3m-mode-map [(control XF86Forward)] 'w3m-next-buffer)

;; Perl
(define-key cperl-mode-map (kbd "C-j") 'newline-and-indent)
;; (define-key perl-mode-map (kbd "C-h") 'backward-delete-char-untabify)
;; (define-key cperl-mode-map (kbd "C-h") 'backward-delete-char-untabify)

;; Factor
(defun maybe-insert-defn (arg)
  (interactive "p")
  (let ((pnt (point))
        b-o-l)
    (save-excursion
      (setq b-o-l (progn (beginning-of-line) (point))))
    (if (= b-o-l pnt)
        (progn
          (insert ":  (  --  )")
          (beginning-of-line)
          (forward-char 2))
        (self-insert-command (or arg 1)))))
(define-key factor-mode-map (kbd ":") 'maybe-insert-defn)

;; Miscelaneous
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
(define-key muse-mode-map (kbd "C-c C-m") 'mathify-region)
(define-key org-mode-map [C-tab] 'ibuffer)
(define-key dired-mode-map (kbd "e") 'wdired-change-to-wdired-mode)
(define-key nxml-mode-map (kbd "C-c C-w") 'wikify-link)
(define-key icicle-mode-map (kbd "M-e") 'icicle-keep-only-past-inputs)
;; (define-key gnus-group-mode-map (kbd "vo") (lambda () (interactive) (shell-command "offlineimap&" "*offlineimap*" nil)))
(define-key bbdb-mode-map "z" 'wicked/bbdb-ping-bbdb-record)

;; Miscellaneous key-related configs
(defalias 'qrr 'query-replace-regexp)