(require 'comint)
(require 'compile)
(require 'io-mode)

;;;; for io
(defvar io-program-name "io"
  "*Program invoked by the run-io command")

(defvar inferior-io-first-prompt-pattern "^Io>"
  "first prompt regex pattern of io interpreter.")

(defvar inferior-io-prompt-pattern "^Io>"
  "prompt regex pattern of io interpreter.")

;;
;; mode variables
;;
(defvar inferior-io-mode-hook nil
  "*Hook for customising inferior-io mode.")
(defvar inferior-io-mode-map nil
  "*Mode map for inferior-io-mode")

(defconst inferior-io-error-regexp-alist
       '(("SyntaxError: compile error\n^\\([^\(].*\\):\\([1-9][0-9]*\\):" 1 2)
	 ("^\tfrom \\([^\(].*\\):\\([1-9][0-9]*\\)\\(:in `.*'\\)?$" 1 2)))

(cond ((not inferior-io-mode-map)
       (setq inferior-io-mode-map
	     (copy-keymap comint-mode-map))
;       (define-key inferior-io-mode-map "\M-\C-x" ;gnu convention
;	           'io-send-definition)
;       (define-key inferior-io-mode-map "\C-x\C-e" 'io-send-last-sexp)
       (define-key inferior-io-mode-map "\C-c\C-l" 'io-load-file)
))

(defun inf-io-keys ()
  "Set local key defs for inf-io in io-mode"
  (define-key io-mode-map "\M-\C-x" 'io-send-definition)
;  (define-key io-mode-map "\C-x\C-e" 'io-send-last-sexp)
  (define-key io-mode-map "\C-c\C-b" 'io-send-block)
  (define-key io-mode-map "\C-c\M-b" 'io-send-block-and-go)
  (define-key io-mode-map "\C-c\C-x" 'io-send-definition)
  (define-key io-mode-map "\C-c\M-x" 'io-send-definition-and-go)
  (define-key io-mode-map "\C-c\C-r" 'io-send-region)
  (define-key io-mode-map "\C-c\M-r" 'io-send-region-and-go)
  (define-key io-mode-map "\C-c\C-z" 'switch-to-io)
  (define-key io-mode-map "\C-c\C-l" 'io-load-file)
;  (define-key io-mode-map "\C-c\C-s" 'run-io)
)

(defvar io-buffer nil "current io process buffer.")

(defun inferior-io-mode ()
  "Major mode for interacting with an inferior io (io) process.

The following commands are available:
\\{inferior-io-mode-map}

A io process can be fired up with M-x run-io.

Customisation: Entry to this mode runs the hooks on comint-mode-hook and
inferior-io-mode-hook (in that order).

You can send text to the inferior io process from other buffers containing
Io source.
    switch-to-io switches the current buffer to the io process buffer.
    io-send-definition sends the current definition to the io process.
    io-send-region sends the current region to the io process.

    io-send-definition-and-go, io-send-region-and-go,
        switch to the io process buffer after sending their text.
For information on running multiple processes in multiple buffers, see
documentation for variable io-buffer.

Commands:
Return after the end of the process' output sends the text from the 
    end of process to point.
Return before the end of the process' output copies the sexp ending at point
    to the end of the process' output, and sends it.
Delete converts tabs to spaces as it moves back.
Tab indents for io; with argument, shifts rest
    of expression rigidly with the current line.
C-M-q does Tab on each line starting within following expression.
Paragraphs are separated only by blank lines.  # start comments.
If you accidentally suspend your process, use \\[comint-continue-subjob]
to continue it."
  (interactive)
  (comint-mode)
  ;; Customise in inferior-io-mode-hook
  ;(setq comint-prompt-regexp "^[^>\n]*>+ *")
  (setq comint-prompt-regexp inferior-io-prompt-pattern)
  ;;(scheme-mode-variables)
;;  (io-mode-variables)
  (setq major-mode 'inferior-io-mode)
  (setq mode-name "Inferior Io")
  (setq mode-line-process '(":%s"))
  (use-local-map inferior-io-mode-map)
  (setq comint-input-filter (function io-input-filter))
  (setq comint-get-old-input (function io-get-old-input))
  (compilation-shell-minor-mode t)
  (make-local-variable 'compilation-error-regexp-alist)
  (setq compilation-error-regexp-alist inferior-io-error-regexp-alist)
  (run-hooks 'inferior-io-mode-hook))

(defvar inferior-io-filter-regexp "\\`\\s *\\S ?\\S ?\\s *\\'"
  "*Input matching this regexp are not saved on the history list.
Defaults to a regexp ignoring all inputs of 0, 1, or 2 letters.")

(defun io-input-filter (str)
  "Don't save anything matching inferior-io-filter-regexp"
  (not (string-match inferior-io-filter-regexp str)))

;; adapted from replace-in-string in XEmacs (subr.el)
(defun remove-in-string (str regexp)
  "Remove all matches in STR for REGEXP and returns the new string."
  (let ((rtn-str "") (start 0) match prev-start)
    (while (setq match (string-match regexp str start))
      (setq prev-start start
	    start (match-end 0)
	    rtn-str (concat rtn-str (substring str prev-start match))))
    (concat rtn-str (substring str start))))

(defun io-get-old-input ()
  "Snarf the sexp ending at point"
  (save-excursion
    (let ((end (point)))
      (re-search-backward inferior-io-first-prompt-pattern)
      (remove-in-string (buffer-substring (point) end)
			inferior-io-prompt-pattern)
      )))

(defun io-args-to-list (string)
  (let ((where (string-match "[ \t]" string)))
    (cond ((null where) (list string))
	  ((not (= where 0))
	   (cons (substring string 0 where)
		 (io-args-to-list (substring string (+ 1 where)
						 (length string)))))
	  (t (let ((pos (string-match "[^ \t]" string)))
	       (if (null pos)
		   nil
		 (io-args-to-list (substring string pos
						 (length string)))))))))

(defun run-io (cmd)
  "Run an inferior Io process, input and output via buffer *io*.
If there is a process already running in `*io*', switch to that buffer.
With argument, allows you to edit the command line (default is value
of `io-program-name').  Runs the hooks `inferior-io-mode-hook'
\(after the `comint-mode-hook' is run).
\(Type \\[describe-mode] in the process buffer for a list of commands.)"

  (interactive (list (if current-prefix-arg
			 (read-string "Run Io: " io-program-name)
			 io-program-name)))
  (if (not (comint-check-proc "*io*"))
      (let ((cmdlist (io-args-to-list cmd)))
	(set-buffer (apply 'make-comint "io" (car cmdlist)
			   nil (cdr cmdlist)))
	(inferior-io-mode)))
  (setq io-program-name cmd)
  (setq io-buffer "*io*")
  (pop-to-buffer "*io*"))

(defconst io-send-terminator "--inf-io-%x-%d-%d-%d--"
  "Template for io here document terminator.
Must not contain io meta characters.")

(defconst io-eval-separator "")

(defun io-send-region (start end)
  "Send the current region to the inferior Io process."
  (interactive "r")
  (let (term (file (buffer-file-name)) line)
    (save-excursion
      (save-restriction
	(widen)
	(goto-char start)
	(setq line (+ start (forward-line (- start)) 1))
	(goto-char start)
	(while (progn
		 (setq term (apply 'format io-send-terminator (random) (current-time)))
		 (re-search-forward (concat "^" (regexp-quote term) "$") end t)))))
    ;; compilation-parse-errors parses from second line.
    (save-excursion
      (let ((m (process-mark (io-proc))))
	(set-buffer (marker-buffer m))
	(goto-char m)
	(insert io-eval-separator "\n")
	(set-marker m (point))))
    (comint-send-string (io-proc) (format "eval <<'%s', nil, %S, %d\n" term file line))
    (comint-send-region (io-proc) start end)
    (comint-send-string (io-proc) (concat "\n" term "\n"))))

(defun io-send-definition ()
  "Send the current definition to the inferior Io process."
  (interactive)
  (save-excursion
    (io-end-of-defun)
    (let ((end (point)))
      (io-beginning-of-defun)
      (io-send-region (point) end))))

;(defun io-send-last-sexp ()
;  "Send the previous sexp to the inferior Io process."
;  (interactive)
;  (io-send-region (save-excursion (backward-sexp) (point)) (point)))

(defun io-send-block ()
  "Send the current block to the inferior Io process."
  (interactive)
  (save-excursion
    (io-end-of-block)
    (end-of-line)
    (let ((end (point)))
      (io-beginning-of-block)
      (io-send-region (point) end))))

(defun switch-to-io (eob-p)
  "Switch to the io process buffer.
With argument, positions cursor at end of buffer."
  (interactive "P")
  (if (get-buffer io-buffer)
      (pop-to-buffer io-buffer)
      (error "No current process buffer. See variable io-buffer."))
  (cond (eob-p
	 (push-mark)
	 (goto-char (point-max)))))

(defun io-send-region-and-go (start end)
  "Send the current region to the inferior Io process.
Then switch to the process buffer."
  (interactive "r")
  (io-send-region start end)
  (switch-to-io t))

(defun io-send-definition-and-go ()
  "Send the current definition to the inferior Io. 
Then switch to the process buffer."
  (interactive)
  (io-send-definition)
  (switch-to-io t))

(defun io-send-block-and-go ()
  "Send the current block to the inferior Io. 
Then switch to the process buffer."
  (interactive)
  (io-send-block)
  (switch-to-io t))

(defvar io-source-modes '(io-mode)
  "*Used to determine if a buffer contains Io source code.
If it's loaded into a buffer that is in one of these major modes, it's
considered a io source file by io-load-file.
Used by these commands to determine defaults.")

(defvar io-prev-l/c-dir/file nil
  "Caches the last (directory . file) pair.
Caches the last pair used in the last io-load-file command.
Used for determining the default in the 
next one.")

(defun io-load-file (file-name)
  "Load a Io file into the inferior Io process."
  (interactive (comint-get-source "Load Io file: " io-prev-l/c-dir/file
				  io-source-modes t)) ; T because LOAD 
                                                          ; needs an exact name
  (comint-check-source file-name) ; Check to see if buffer needs saved.
  (setq io-prev-l/c-dir/file (cons (file-name-directory    file-name)
				       (file-name-nondirectory file-name)))
  (comint-send-string (io-proc) (concat "(load \""
					    file-name
					    "\"\)\n")))

(defun io-proc ()
  "Returns the current io process. See variable io-buffer."
  (let ((proc (get-buffer-process (if (eq major-mode 'inferior-io-mode)
				      (current-buffer)
				    io-buffer))))
    (or proc
	(error "No current process. See variable io-buffer"))))

;;; Do the user's customisation...

(defvar inf-io-load-hook nil
  "This hook is run when inf-io is loaded in.
This is a good place to put keybindings.")
	
(run-hooks 'inf-io-load-hook)

(provide 'inf-io)
