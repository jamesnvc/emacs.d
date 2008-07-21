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
