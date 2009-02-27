;; Some things that I'm working on here...

(defun james/org-todo-this-week ()
  (interactive)
  (save-excursion
    (save-selected-window
      (let ((agenda-str
             (with-output-to-string
                 (org-batch-agenda "a" org-agenda-include-diary nil))))
        (message (replace-regexp-in-string "^\\([^ ]+.*?$\\)" "" agenda-str))
        ))))

(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                  ((not prefix) "%d.%m.%Y")
                  ((equal prefix '(4)) "%Y-%m-%d")
                  ((equal prefix '(16)) "%A, %d %B %Y")))
        (system-time-locale "en_CA"))
    (insert (format-time-string format))))

(defun write-new-blog ()
  (interactive)
  (gblogger-new-entry "http://www.blogger.com/feeds/36560580/posts/default"))

(defmacro set-local-variable (variable value)
  `(set (make-local-variable ,variable) ,value))

(load-library "email") ;; Some email-stuff I'm working on

;; (defun factor-get-effect ()
;;   "Get the stack effect for the factor word at point"
;;   (interactive)
;;   (save-match-data
;;     (let ((word (word-at-point)))
;;       (if word
;;           (let ((effect (save-excursion (progn (factor-see)
;;                                                (switch-to-buffer "*factor*")
;;                                                (goto-char (point-max))
;;                                                (search-backward "( scratchpad )" (point-min) t 2)
;;                                                (next-line) (beginning-of-line)
;;                                                (prog1 (buffer-substring (point) (progn (end-of-line) (point)))
;;                                                  (goto-char (point-max)))))))
;;             (message effect))))))

(defun wikify-link (start end)
  "Turn the word in region into a link to the wikipedia article of the same name

Example: Foo bar => <a href=\"http://en.wikipedia.org/wiki/Foo_bar>Foo bar</a>
"
  (interactive "r")
  (let ((word (copy-region-as-kill start end))
	(tmp nil))
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (insert "<a href=\"http://en.wikipedia.org/wiki/")
      (setq tmp (point))
      (yank)
      (insert "\">")
      (replace-string " " "_" nil tmp (point))
      (goto-char (point-max))
      (insert "</a>"))))

(defun totd ()
  (interactive)
  (with-output-to-temp-buffer "*Tip of the day*"
    (let* ((commands (loop for s being the symbols
                           when (commandp s) collect s))
           (command (nth (random (length commands)) commands)))
      (princ
       (concat "Your tip for the day is:\n"
               "========================\n\n"
               (describe-function command)
               "\n\nInvoke with:\n\n"
               (with-temp-buffer
                 (where-is command t)
                 (buffer-string)))))))

(defvar *user-name* "James Cash")

(defun sign-revision ()
  "Insert my name and the current date in a comment for a
revision"
  (interactive)
  (save-excursion
    (comment-dwim 2)
    (insert (format "Modified by %s on " *user-name*))
    (insert (format-time-string "%a %Y-%m-%d - %l:%M %p")
    ))
  )

(defun insert-date ()
  "Insert the date at point"
  (interactive)
  (insert (format-time-string "%d %b %Y - %l:%M %p")))

(defun mathify-region (start end)
  "Insert <math> tags around region (for use with muse-mode)"
  (interactive "r")
  (save-excursion
    (goto-char start)
    (insert "<math>")
    (goto-char (+ 6 end))
    (insert "</math>")
    ))

(defun increment-number-at-point (&optional amount)
  "Increment the number under point by `amount'"
  (interactive "p")
  (let ((num (number-at-point)))
    (when (numberp num)
      (let ((newnum (+ num amount))
         (p (point)))
    (save-excursion
      (skip-chars-backward "-.0123456789")
      (delete-region (point) (+ (point) (length (number-to-string num))))
      (insert (number-to-string newnum)))
    (goto-char p)))))

(defun decrement-number-at-point (&optional amount)
  (interactive "p")
  "Decrement the number under point by `amount'"
  (increment-number-at-point (- (abs amount))))

(defun zap-to-char-back (arg char)
  "Kill back to and including ARG'th occurrence of CHAR.
Case is ignored if `case-fold-search' is non-nil in the current
buffer. Error if CHAR not found."
  (interactive "p\ncZap to char: ")
  (if (char-table-p translation-table-for-input)
      (setq char (or (aref translation-table-for-input char) char)))
  (kill-region (point) (progn
			 (search-backward (char-to-string char) nil nil arg)
			 (point))))


;; (defun cli-escape (str)
;;   "Replace special shell characters in STR (e.g. ' ' with '\ ')"
;;   (reduce #'(lambda (xs x) (concatenate 'string xs x)) 
;; 	  (loop for c in (string-to-list str) collect (if (equalp (string c) "'")
;; 							  "\\'"
;; 							(string c)))
;; 	  ))

(defun open-word-file (file)
  "Opens a Microsoft Word file via catdoc"
  (interactive "fFile: ")
  (find-file (concatenate 'string file ".txt"))
  (call-process-shell-command (concatenate 'string "catdoc \"" file "\"") nil t)
  (beginning-of-buffer)
  )

;;
;; Never understood why Emacs doesn't have this function.
;;
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
	  (message "A buffer named '%s' already exists!" new-name)
        (progn (rename-file name new-name 1)
	       (rename-buffer new-name)
	       (set-visited-file-name new-name)
	       (set-buffer-modified-p nil))))))

;;
;; Never understood why Emacs doesn't have this function, either.
;;
(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR." (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
	  (if (string-match dir "\\(?:/\\|\\\\)$")
	      (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn (copy-file filename newname 1)
	     (delete-file filename)
	     (set-visited-file-name newname)
	     (set-buffer-modified-p nil)
	     t))))

(defun unicode-symbol (name)
  "Translate a symbolic name for a Unicode character -- e.g., LEFT-ARROW
  or GREATER-THAN into an actual Unicode character code. "
  (decode-char 'ucs (case name
		      ;; arrows
		      ('left-arrow 8592)
		      ('up-arrow 8593)
		      ('right-arrow 8594)
              ('down-arrow 8595)
  
		      ;; boxes
		      ('double-vertical-bar #X2551)
                        
		      ;; relational operators
		      ('equal #X003d)
		      ('not-equal #X2260)
		      ('identical #X2261)
		      ('not-identical #X2262)
		      ('less-than #X003c)
		      ('greater-than #X003e)
		      ('less-than-or-equal-to #X2264)
		      ('greater-than-or-equal-to #X2265)
  
		      ;; logical operators
		      ('logical-and #X2227)
		      ('logical-or #X2228)
		      ('logical-neg #X00AC)
  
		      ;; misc
		      ('nil #X2205)
		      ('horizontal-ellipsis #X2026)
              ('double-exclamation #X203C)
		      ('prime #X2032)
		      ('double-prime #X2033)
		      ('for-all #X2200)
		      ('there-exists #X2203)
		      ('element-of #X2208)
  
		      ;; mathematical operators
		      ('square-root #X221A)
		      ('squared #X00B2)
		      ('cubed #X00B3)
  
		      ;; letters
		      ('lambda #X03BB)
		      ('alpha #X03B1)
		      ('beta #X03B2)
		      ('gamma #X03B3)
		      ('delta #X03B4)
		      ('Delta #X2206)
		      )))

(defun substitute-pattern-with-unicode (pattern symbol)
  "Add a font lock hook to replace the matched part of PATTERN with the 
  Unicode symbol SYMBOL looked up with UNICODE-SYMBOL."
  (interactive)
  (font-lock-add-keywords
   nil `((,pattern (0 (progn (compose-region (match-beginning 1) (match-end 1)
					     ,(unicode-symbol symbol))
			     nil))))))
  
(defun substitute-patterns-with-unicode (patterns)
  "Call SUBSTITUTE-PATTERN-WITH-UNICODE repeatedly."
  (mapcar #'(lambda (x)
	      (substitute-pattern-with-unicode (car x)
					       (cdr x)))
	  patterns))

(defun pretty-greek ()
  (let ((greek '("alpha" "beta" "gamma" "delta" "epsilon" "zeta" "eta" "theta" "iota" "kappa" "lambda" "mu" "nu" "xi" "omicron" "pi" "rho" "sigma_final" "sigma" "tau" "upsilon" "phi" "chi" "psi" "omega")))
    (loop for word in greek
          for code = 97 then (+ 1 code)
          do  (let ((greek-char (make-char 'greek-iso8859-7 code))) 
                (font-lock-add-keywords nil
                                        `((,(concatenate 'string "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[a-zA-Z]")
                                           (0 (progn (decompose-region (match-beginning 2) (match-end 2))
                                                     nil)))))
                (font-lock-add-keywords nil 
                                        `((,(concatenate 'string "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[^a-zA-Z]")
                                           (0 (progn (compose-region (match-beginning 2) (match-end 2)
                                                                     ,greek-char)
                                                     nil)))))))))

(defun lispdoc ()
  "Searches lispdoc.com for SYMBOL, which is by default the symbol
currently under the curser"
  (interactive)
  (let* ((word-at-point (word-at-point))
         (symbol-at-point (symbol-at-point))
         (default (symbol-name symbol-at-point))
         (inp (read-from-minibuffer
               (if (or word-at-point symbol-at-point)
                   (concat "Symbol (default " default "): ")
		 "Symbol (no default): "))))
    (if (and (string= inp "") (not word-at-point) (not
						   symbol-at-point))
        (message "you didn't enter a symbol!")
      (let ((search-type (read-from-minibuffer
			  "full-text (f) or basic (b) search (default b)? ")))
	(browse-url (concat "http://lispdoc.com?q="
			    (if (string= inp "")
				default
			      inp)
			    "&search="
			    (if (string-equal search-type "f")
				"full+text+search"
			      "basic+search")))))))

(defvar point-stack nil)

(defun point-stack-push-back ()
  "Push the current location onto the bottom of the stack"
  (interactive)
  (message "Location marked.")
  (setq point-stack (append point-stack (list (list (current-buffer) (point)))))
  )

(defun point-stack-push ()
  "Push current location and buffer info onto stack."
  (interactive)
  (message "Location marked.")
  (setq point-stack (cons (list (current-buffer) (point)) point-stack)))

(defun point-stack-pop ()
  "Pop a location off the stack and move to buffer"
  (interactive)
  (if (null point-stack)
      (message "Stack is empty.")
    (switch-to-buffer (caar point-stack))
    (goto-char (cadar point-stack))
    (setq point-stack (cdr point-stack))))

;; (defun previous-window ()
;;   "Go the the previous active window"
;;   (interactive)
;;   (other-window -1))

(defun mb-str-to-unibyte-char (s)
  "Translate first multibyte char in s to internal unibyte representation."
  (multibyte-char-to-unibyte (string-to-char s)))

(defun remap-keyboard (mapping)
  "Setup keyboard translate table using a list of pairwise key-mappings."
  (mapcar
   (lambda (mb-string-pair)
     (apply #'keyboard-translate
	    (mapcar #'mb-str-to-unibyte-char mb-string-pair)))
   mapping))

(add-hook 'scheme-mode-hook
	  (lambda ()
	    (define-key scheme-mode-map (kbd "C-c h")
	      '(lambda ()
		 (interactive)
		 (ignore-errors
		   (let ((symbol (thing-at-point 'symbol)))
		     (info "(r5rs)")
		     (Info-index symbol)))))))

(defun vi-open-next-line (arg)
  "Move to the next line (like vi) and then opens a line."
  (interactive "p")
  (let ((col (current-column)))
    (end-of-line)
    (open-line arg)
    (next-line 1)
    (indent-according-to-mode)))
;;     (beginning-of-line)
;;     (forward-char col)))

(defun kill-syntax-forward ()
  "Kill characters with syntax at point."
  (interactive)
  (kill-region (point)
               (progn (skip-syntax-forward (string (char-syntax (char-after))))
                      (point))))

(defun kill-syntax-backward ()
  "Kill characters with syntax at point."
  (interactive)
  (kill-region (point)
               (progn (skip-syntax-backward (string (char-syntax (char-before))))
                      (point))))

(defun move-line (n)
   "Move the current line up or down by N lines."
   (interactive "p")
   (let ((col (current-column))
         start
         end)
     (beginning-of-line)
     (setq start (point))
     (end-of-line)
     (forward-char)
     (setq end (point))
     (let ((line-text (delete-and-extract-region start end)))
       (forward-line n)
       (insert line-text)
       ;; restore point to original column in moved line
       (forward-line -1)
       (forward-char col))))

(defun move-line-up (n)
   "Move the current line up by N lines."
   (interactive "p")
   (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
   "Move the current line down by N lines."
   (interactive "p")
   (move-line (if (null n) 1 n)))

(defun char-count-buffer ()
  "Gives the number of non-space characters in the buffer"
  (interactive)
  (save-excursion
    (goto-char (point-min)) ;; eqv (beginning-of-buffer)
    (let ((char-count 0))
      (while (not (eobp))
	(unless (looking-at "[ \t\r\n]")
	  (incf char-count))
	(forward-char 1))
      (message "%d chars in buffer" char-count))))

(defun count-words-buffer ()
  "Gives the number of words in the buffer"
  (interactive)
  (message "%d words in buffer" (how-many "\\w+" (point-min) (point-max))))

(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")
  (let ((count (how-many "\\w+" beginning end)))
    (cond ((zerop count)
           (message
            "Region does not have any words."))
          ((= 1 count)
           (message
            "Region has 1 word."))
          (t
           (message
            "Region has %d words." count)))))

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun scheme-include-file (file-name)
  "Include a Scheme file FILE-NAME into the inferior Scheme process."
  (interactive (comint-get-source "Include Scheme file: " scheme-prev-l/c-dir/file
				  scheme-source-modes t)) ; t because `include'
                                                          ; needs an exact name
  (comint-check-source file-name) ; Check to see if buffer needs saved.
  (setq scheme-prev-l/c-dir/file (cons (file-name-directory    file-name)
				       (file-name-nondirectory file-name)))
  (comint-send-string (scheme-proc) (concat "(include \""
					    file-name
					    "\"\)\n")))


(defun smalltalk-subclass-template (class-name inherits) 
  (interactive
   (list (read-string "Subclass: " (smalltalk-backward-find-class-name))
	 (read-string "Inherits from: " "Object")))
  (insert (format "%s subclass: #%s" inherits class-name)) (newline-and-indent)
  (insert "instanceVariableNames: '")
  (save-excursion
    (insert "'") (newline-and-indent)
    (insert "classVariableNames: ''") (newline-and-indent)
    (insert "poolDictionaries: ''") (newline-and-indent)
    (insert "category: nil !\n\n")))

(defun copy-line (arg)
  "Adds the line the point is on to the kill-ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(provide 'mymisc)