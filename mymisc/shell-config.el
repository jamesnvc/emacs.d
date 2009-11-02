(require 'cl)
(require 'term)

(defconst sw-ssh "ssh -q -o StrictHostKeyChecking=no")
(defconst sw-shell-font "-*-courier new-*-r-*-*-18-*-*-*-*-*-iso8859-1")

(defvar sw-frame nil)
(defvar sw-buffers nil)

(defvar sw-open-in-new-frame nil)
(defvar sw-remove-dead-terms t)

(defun sw-shell-get-process (buffer-name)
  (let ((buffer (get-buffer (concat "*" buffer-name "*"))))
    (and (buffer-live-p buffer) (get-buffer-process buffer))))

(defun sw-get-process-if-live (buffer-name)
  (let ((proc (sw-shell-get-process buffer-name)))
    (and (processp proc)
         (equal (process-status proc) 'run)
         proc)))

(defun sw-kill-buffer-if-no-process (buffer-name)
  (let* ((buffer (get-buffer (concat "*" buffer-name "*")))
         (proc (sw-get-process-if-live buffer-name)))
    (when (and (not proc) (buffer-live-p buffer)) (kill-buffer buffer))))

(defalias 'sw-shell-exists-p 'sw-get-process-if-live)

(defun sw-basic-shell (buffer-name)
  (sw-kill-buffer-if-no-process buffer-name)
  ;; If there is a process running, leave it, otherwise
  ;; create the new buffer
  (if (sw-shell-exists-p buffer-name)
      (message "Buffer already exists")
    (ansi-term "bash" buffer-name))
  (switch-to-buffer (concat "*" buffer-name "*")))

(defun sw-shell/commands (buffer-name &rest commands)
  (sw-basic-shell buffer-name)
  (let ((proc (sw-shell-get-process buffer-name)))
    (dolist (cmd commands)
      (term-simple-send proc cmd))))

(defun sw-standard-shell (buffer-name)
  (if (sw-shell-exists-p buffer-name)
      (switch-to-buffer (concat "*" buffer-name "*"))
    (sw-shell/commands buffer-name
                       "exec bash -l"
                       "su -")))

(defun sw-server-login (host &optional buffer-name)
  (setq buffer-name (or buffer-name host))
  (if (sw-shell-exists-p buffer-name)
      (switch-to-buffer (concat "*" buffer-name "*"))
    (sw-shell/commands buffer-name
                       (concat sw-ssh " " host)
                       "exec bash -l"
                       "su -")))

(defun sw-set-display ()
  (interactive)
  (set-background-color "black")
  (set-foreground-color "orange")
  (set-frame-font sw-shell-font))

(defun sw-set-keymap ()
  (term-set-escape-char ?\C-z)
  (define-key term-raw-map "\C-c" 'term-interrupt-subjob)
  (define-key term-raw-map "\C-y" 'yank)
  (define-key term-raw-map (kbd "\M-x") 'execute-extended-command)
  (define-key term-raw-map "\e" 'term-send-raw)
  (define-key term-raw-map (kbd "") 'scroll-down)
  (define-key term-raw-map (kbd "") 'scroll-up))

(sw-set-keymap)

;; Functions to get the mouse working more-or-less as I like it

(defun sw-mouse-paste-clipboard (click arg)
  (interactive "e\nP")
  (let ((proc (get-buffer-process (current-buffer))))
    (term-send-string proc (current-kill 0)))
  (setq deactivate-mark t))

(defun sw-mouse-copy-region-to-clipboard (click)
  (interactive "e")
  (mouse-set-region click)
  (let ((transient-mark-mode nil))
    (copy-region-as-kill (region-beginning) (region-end))))

(define-key term-raw-map
  [drag-mouse-1]
  'sw-mouse-copy-region-to-clipboard)

(define-key term-raw-map [mouse-3] 'sw-mouse-paste-clipboard)

(defun sw-read-buffer-name ()
  (when sw-remove-dead-terms
    ;; Remove dead terms before offering them to the user
    (setq sw-buffers (delete-if-not 'sw-shell-exists-p sw-buffers)))
  (let ((buffer-name
         (ido-completing-read
          "Choose buffer name: "
          sw-buffers)))

    (if (stringp buffer-name)
        buffer-name
      (error "Invalid buffer name"))))

(defun sw-get-buffer-proc ()
  (sw-get-process-if-live (sw-read-buffer-name)))

(defun sw-select-frame ()
  (if (not sw-open-in-new-frame)
      (sw-set-display)
    (unless (frame-live-p sw-frame)
      (setq sw-frame (make-frame))
      (select-frame-set-input-focus sw-frame)
      (sw-set-display))
    (select-frame-set-input-focus sw-frame)))

(defun sw-choose-buffer (&optional buffer-name)
  (sw-select-frame)

  (unless (stringp buffer-name)
    (setq buffer-name (sw-read-buffer-name)))

  (unless (sw-shell-exists-p buffer-name)
    (sw-kill-buffer-if-no-process buffer-name)
    (setq sw-buffers (delete buffer-name sw-buffers)))

  (let ((already-existed t))
    (if (member buffer-name sw-buffers)
        (switch-to-buffer (concat "*" buffer-name "*"))
      (setq already-existed nil)
      (push buffer-name sw-buffers))

    (list buffer-name already-existed)))

(defun sw-open-shell (&optional buffer-name)
  (interactive)
  (multiple-value-bind (buffer-name already-existed)
      (sw-choose-buffer buffer-name)
    (unless already-existed
      (sw-standard-shell buffer-name))))

(defun sw-open-remote-shell (&optional buffer-name server-name)
  (interactive)
  (multiple-value-bind (buffer-name already-existed)
      (sw-choose-buffer buffer-name)
    (unless already-existed
      (unless (stringp server-name)
        (setq server-name (read-string "Server: " buffer-name)))
      (sw-server-login server-name buffer-name))))

(provide 'shell-config)
