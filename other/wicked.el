(defadvice bbdb-read-new-record (after wicked activate)
  "Prompt for the birthdate as well."
  (bbdb-record-putprop ad-return-value 'birthdate
		       (bbdb-read-string "Birthdate (YYYY.MM.DD): ")))


(defun wicked/bbdb-find-people-with-addresses (&optional regexp records)
  "Filter the displayed BBDB records to those with addresses."
  (interactive "MRegexp: ")
  (let ((records (if current-prefix-arg (bbdb-records)
                     (or records bbdb-records (bbdb-records))))
        filtered
        cons next)
    (while records
      (when (and (bbdb-record-get-field-internal (if (arrayp (car records))
                                                     (car records)
                                                     (caar records)) 'address)
                 (or (null regexp)
                     (string= regexp "")
                     (delq nil
                           (mapcar
                            (lambda (address)
                              (string-match regexp (wicked/bbdb-address-string address)))
                            (bbdb-record-get-field-internal
                             (if (arrayp (car records))
                                 (car records)
                                 (caar records)) 'address)))))
        (setq filtered (cons (if (arrayp (car records))
                                 (car records)
                                 (caar records)) filtered)))
      (setq records (cdr records)))
    (bbdb-display-records (nreverse filtered))))

(defun wicked/bbdb-address-string (address)
  "Return ADDRESS as a string."
  (mapconcat
   'identity
   (delq nil
         (list
          (mapconcat 'identity (bbdb-address-streets address) ", ")
          (let ((s (bbdb-address-city address))) (and (not (string= s "")) s))
      (let ((s (bbdb-address-state address))) (and (not (string= s "")) s))
      (let ((s (bbdb-address-zip address))) (and (not (string= s "")) s))
      (let ((s (bbdb-address-country address))) (and (not (string= s "")) s))))
   ", "))

(defun wicked/bbdb-yank-addresses ()
  "Copy displayed addresses to the kill ring."
  (interactive)
  (kill-new
   (mapconcat
    (lambda (record)
      (concat
       (bbdb-record-name (car record)) "\n"
       (mapconcat
    (lambda (address)
      (concat (bbdb-address-location address) ": " (wicked/bbdb-address-string address)))
    (bbdb-record-get-field-internal (car record) 'address)
    "\n")))
    bbdb-records
    "\n\n")))

;; Inserting nicknames
(defvar wicked/gnus-nick-threshold 5 "*Number of people to stop greeting individually. Nil means always greet individually.")  ;; (1)
(defvar wicked/bbdb-hello-string "Hello, %s!" "Format string for hello. Example: \"Hello, %s!\"")
(defvar wicked/bbdb-hello-all-string "Hello, all!" "String for hello when there are many people. Example: \"Hello, all!\"")
(defvar wicked/bbdb-nick-field 'nick "Symbol name for nickname field in BBDB.")
(defvar wicked/bbdb-salutation-field 'hello "Symbol name for salutation field in BBDB.")

(defun wicked/gnus-add-nick-to-message ()
  "Inserts \"Hello, NICK!\" in messages based on the recipient's nick field."
  (interactive)
  (save-excursion
    (let* ((bbdb-get-addresses-headers ;; (2)
            (list (assoc 'recipients bbdb-get-addresses-headers)))
           (recipients (bbdb-get-addresses
                        nil
                        gnus-ignored-from-addresses
                        'gnus-fetch-field))
           recipient nicks rec net salutations)
      (goto-char (point-min))
      (when (re-search-forward "--text follows this line--" nil t)
        (forward-line 1)
        (if (and wicked/gnus-nick-threshold
                 (>= (length recipients) wicked/gnus-nick-threshold))
            (insert wicked/bbdb-hello-all-string "\n\n") ;; (3)
          (while recipients
            (setq recipient (car (cddr (car recipients))))
            (setq net (nth 1 recipient))
            (setq rec (car (bbdb-search (bbdb-records) nil nil net)))
            (cond
             ((null rec) ;; (4)
              (add-to-list 'nicks (car recipient)))
             ((bbdb-record-getprop rec wicked/bbdb-salutation-field) ;; (5)
              (add-to-list 'salutations
                           (bbdb-record-getprop rec wicked/bbdb-salutation-field)))
             ((bbdb-record-getprop rec wicked/bbdb-nick-field) ;; (6)
              (add-to-list 'nicks
                           (bbdb-record-getprop rec wicked/bbdb-nick-field)))
             (t (bbdb-record-name rec))) ;; (7)
            (setq recipients (cdr recipients))))
        (when nicks ;; (8)
          (insert (format wicked/bbdb-hello-string
                          (mapconcat 'identity (nreverse nicks) ", "))
                  " "))
        (when salutations ;; (9)
          (insert (mapconcat 'identity salutations " ")))
        (when (or nicks salutations)
          (insert "\n\n")))))
  (goto-char (point-min)))

(defadvice gnus-post-news (after wicked/bbdb activate)
  "Insert nicknames or custom salutations."
  (wicked/gnus-add-nick-to-message))

(defadvice gnus-msg-mail (after wicked/bbdb activate)
  "Insert nicknames or custom salutations."
  (wicked/gnus-add-nick-to-message))

(defadvice gnus-summary-reply (after wicked/bbdb activate)
  "Insert nicknames or custom salutations."
  (wicked/gnus-add-nick-to-message))

(defun wicked/bbdb-ping-bbdb-record (bbdb-record text &optional date regrind)
  "Adds a note for today to the current BBDB record.
Call with a prefix to specify date.
BBDB-RECORD is the record to modify (default: current).
TEXT is the note to add for DATE.
If REGRIND is non-nil, redisplay the BBDB record."
  (interactive (list (bbdb-current-record t)
                     (read-string "Notes: ")
                     ;; Reading date - more powerful with Planner, but we’ll make do if necessary
                     (if (featurep 'planner)
                         (if current-prefix-arg (planner-read-date) (planner-today))
                       (if current-prefix-arg
                           (read-string "Date (YYYY.MM.DD): ")
                         (format-time-string "%Y.%m.%d")))
                     t))
  (bbdb-record-putprop bbdb-record
                       'contact
                       (concat date ": " text "\n"
                               (or (bbdb-record-getprop bbdb-record 'contact))))
  (if regrind
      (save-excursion
        (set-buffer bbdb-buffer-name)
        (bbdb-redisplay-one-record bbdb-record)))
  nil)

(defvar wicked/w3m-fake-user-agents ;; (1)
  `(("w3m" . ,(concat "Emacs-w3m/" emacs-w3m-version " " w3m-version))
    ("ie6" . "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)")
    ("ff3" . "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1")
    ("ff2" . "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080208 Firefox/2.0.0.13")
    ("ie7" . "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727)")
    ("ie5.5" . "Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)")
    ("iphone" . "Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_0 like Mac OS X; en-us) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/5A347 Safari/525.20")
    ("safari" . "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_2; en-us) AppleWebKit/525.13 (KHTML, like Gecko) Version/3.1 Safari/525.13")
    ("google" . "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"))
  "*Associative list of user agent names and strings.")

 (defvar wicked/w3m-fake-user-agent-sites ;; (2)
   '(("^https?://www\\.useragentstring\\.com" . "ff2"))
   "*Associative list of regular expressions matching URLs and the agent keyword or value.
 The first matching entry will be used.")

 (defun wicked/w3m-set-user-agent (agent)
   "Set the user agent to AGENT based on `wicked/w3m-fake-user-agents'.
 If AGENT is not defined in `wicked/w3m-fake-user-agents', it is used as the user agent.
 If AGENT is empty, the default w3m user agent will be used."
   (interactive
    (list
     (completing-read "User-agent [w3m]: "
                    (mapcar 'car wicked/w3m-fake-user-agents)
                    nil nil nil nil "w3m"))) ;; (3)
   (if agent
       (progn
        (setq w3m-user-agent
              (or
               (and (string= agent "") (assoc "w3m" wicked/w3m-fake-user-agents)) ;; (4)
               (cdr (assoc agent wicked/w3m-fake-user-agents)) ;; (5)
               agent)) ;; (6)
        (setq w3m-add-user-agent t))
     (setq w3m-add-user-agent nil)))

 (defun wicked/w3m-reload-this-page-with-user-agent (agent)
   "Browse this page using AGENT based on `wicked/w3m-fake-user-agents'.
 If AGENT is not defined in `wicked/w3m-fake-user-agents', it is used as the user agent.
 If AGENT is empty, the default w3m user agent will be used."
   (interactive (list (completing-read "User-agent [w3m]: "
                    (mapcar 'car wicked/w3m-fake-user-agents)
                    nil nil nil nil "w3m")))
   (let ((w3m-user-agent w3m-user-agent)
       (w3m-add-user-agent w3m-add-user-agent))
     (wicked/w3m-set-user-agent agent) ;; (7)
     (w3m-reload-this-page)))

 (defadvice w3m-header-arguments (around wicked activate) ;; (8)
   "Check `wicked/w3m-fake-user-agent-sites' for fake user agent definitions."
   (let ((w3m-user-agent w3m-user-agent)
         (w3m-add-user-agent w3m-add-user-agent)
         (sites wicked/w3m-fake-user-agent-sites))
     (while sites
       (if (string-match (caar sites) (ad-get-arg 1))
         (progn
           (wicked/w3m-set-user-agent (cdar sites))
           (setq sites nil))
       (setq sites (cdr sites))))
     ad-do-it))

;; Emacs and w3m: Quick searches
;; http://sachachua.com/wp/2008/08/18/emacs-and-w3m-quick-searches/
(setq wicked/quick-search-alist
      '(("^g?:? +\\(.*\\)" . ;; Google Web
         "http://www.google.com/search?q=\\1")

        ("^g!:? +\\(.*\\)" . ;; Google Lucky
         "http://www.google.com/search?btnI=I%27m+Feeling+Lucky&q=\\1")

	("^dict:? +\\(.*\\)" . ;; Dictionary
	 "http://dictionary.reference.com/search?q=\\1")))

;; (require 'cl-seq)
;; (defadvice w3m-goto-url (before wicked activate)
;;   "Use the quick searches defined in `wicked/quick-search-alist'."
;;   (let* ((my-url (replace-regexp-in-string
;; 		  "^ *\\| *$" ""
;; 		  (replace-regexp-in-string "[ \t\n]+" " " (ad-get-arg 0))))
;; 	 (match (assoc-if
;; 		 (lambda (a) (string-match a my-url))
;; 		 wicked/quick-search-alist)))
;;     (if match
;; 	(ad-set-arg 0 (replace-regexp-in-string
;; 		       (car match) (cdr match) my-url)))))

;; (defadvice browse-url (before wicked activate)
;;   "Use the quick searches defined in `wicked/quick-search-alist'."
;;   (let* ((my-url (replace-regexp-in-string
;; 		  "^ *\\| *$" ""
;; 		  (replace-regexp-in-string "[ \t\n]+" " " (ad-get-arg 0))))
;; 	 (match (assoc-if
;; 		 (lambda (a) (string-match a my-url))
;; 		 wicked/quick-search-alist)))
;;     (if match
;; 	(ad-set-arg 0 (replace-regexp-in-string
;; 		       (car match) (cdr match) my-url)))))

;; (add-to-list 'wicked/quick-search-alist
;;           '("^ew:? *?\\(.*\\)" . ;; Emacs Wiki Search
;;             "http://www.emacswiki.org/cgi-bin/wiki?search=\\1"))

(defun wicked/toggle-w3m ()
  "Switch to a w3m buffer or return to the previous buffer."
  (interactive)
  (if (derived-mode-p 'w3m-mode)
      ;; Currently in a w3m buffer
      ;; Bury buffers until you reach a non-w3m one
      (while (derived-mode-p 'w3m-mode)
	(bury-buffer))
    ;; Not in w3m
    ;; Find the first w3m buffer
    (let ((list (buffer-list)))
      (while list
	(if (with-current-buffer (car list)
	      (derived-mode-p 'w3m-mode))
	    (progn
	      (switch-to-buffer (car list))
	      (setq list nil))
	  (setq list (cdr list))))
      (unless (derived-mode-p 'w3m-mode)
	(call-interactively 'w3m)))))
