;; Stuff from sacha chua's blog: <http://sachachua.com>


;; BBDB + completion stuff
 (defun sacha/org-bbdb-get (path)
   "Return BBDB record for PATH."
   (car (bbdb-search (bbdb-records) path path path)))

 (defun sacha/org-bbdb-export (path desc format)
   "Create the export version of a BBDB link specified by PATH or DESC.
 If exporting to HTML, it will be linked to the person's blog,
 www, or web address. If exporting to LaTeX FORMAT the link will be
 italicised. In all other cases, it is left unchanged."
     (cond
      ((eq format 'html)
       (let* ((record
             (sacha/org-bbdb-get path))
            url)
       (setq url (and record
                      (or (bbdb-record-getprop record 'blog)
                          (bbdb-record-getprop record 'www)
                          (bbdb-record-getprop record 'web))))
       (if url
           (format "<a href=\"%s\">%s</a>"
                   url (or desc path))
         (format "<em>%s</em>"
                 (or desc path)))))
      ((eq format 'latex) (format "\\textit{%s}" (or desc path)))
      (t (or desc path))))

 (defadvice org-bbdb-export (around sacha activate)
   "Override org-bbdb-export."
   (setq ad-return-value (sacha/org-bbdb-export path desc format)))

 ;;;_+ Hippie expansion for BBDB; map M-/ to hippie-expand for most fun
 (add-to-list 'hippie-expand-try-functions-list 'sacha/try-expand-bbdb-annotation)
 (defun sacha/try-expand-bbdb-annotation (old)
   "Expand from BBDB. If OLD is non-nil, cycle through other possibilities."
   (unless old
     ;; First time, so search through BBDB records for the name
     (he-init-string (he-dabbrev-beg) (point))
     (when (> (length he-search-string) 0)
       (setq he-expand-list nil)
       (mapcar
        (lambda (item)
        (let ((name (bbdb-record-name item)))
          (when name
            (setq he-expand-list
                  (cons (org-make-link-string
                       (org-make-link "bbdb:" name)
                       name)
                        he-expand-list)))))
        (bbdb-search (bbdb-records)
                     he-search-string
                     he-search-string
                     he-search-string
                     nil nil))))
   (while (and he-expand-list
               (or (not (car he-expand-list))
                   (he-string-member (car he-expand-list) he-tried-table t)))
     (setq he-expand-list (cdr he-expand-list)))
   (if (null he-expand-list)
       (progn
         (if old (he-reset-string))
         nil)
     (progn
       (he-substitute-string (car he-expand-list) t)
       (setq he-expand-list (cdr he-expand-list))
       t)))


(defun sacha/org-show-load ()
  "Show my unscheduled time and free time for the day."
  (interactive)
  (let ((time (sacha/org-calculate-free-time
               ;; today
               (calendar-gregorian-from-absolute (time-to-days (current-time)))
               ;; now
               (let* ((now (decode-time))
                      (cur-hour (nth 2 now))
                      (cur-min (nth 1 now)))
                 (+ (* cur-hour 60) cur-min))
               ;; until the last time in my time grid
               (let ((last (car (last (elt org-agenda-time-grid 2)))))
                 (+ (* (/ last 100) 60) (% last 100))))))
    (message "%.1f%% load: %d minutes to be scheduled, %d minutes free, %d minutes gap\n"
             (/ (car time) (* .01 (cdr time)))
             (car time)
             (cdr time)
             (- (cdr time) (car time)))))

(defun sacha/org-agenda-load (match)
  "Can be included in `org-agenda-custom-commands'."
  (let ((inhibit-read-only t)
        (time (sacha/org-calculate-free-time
               ;; today
               (calendar-gregorian-from-absolute org-starting-day)
               ;; now if today, else start of day
               (if (= org-starting-day
                      (time-to-days (current-time)))
                   (let* ((now (decode-time))
                          (cur-hour (nth 2 now))
                          (cur-min (nth 1 now)))
                     (+ (* cur-hour 60) cur-min))
                 (let ((start (car (elt org-agenda-time-grid 2))))
                   (+ (* (/ start 100) 60) (% start 100))))
                 ;; until the last time in my time grid
               (let ((last (car (last (elt org-agenda-time-grid 2)))))
                 (+ (* (/ last 100) 60) (% last 100))))))
    (goto-char (point-max))
    (insert (format
             "%.1f%% load: %d minutes to be scheduled, %d minutes free, %d minutes gap\n"
             (/ (car time) (* .01 (cdr time)))
             (car time)
             (cdr time)
             (- (cdr time) (car time))))))

(defun sacha/org-calculate-free-time (date start-time end-of-day)
  "Return a cons cell of the form (TASK-TIME . FREE-TIME) for DATE, given START-TIME and END-OF-DAY.
DATE is a list of the form (MONTH DAY YEAR).
START-TIME and END-OF-DAY are the number of minutes past midnight."
  (save-window-excursion
  (let ((files org-agenda-files)
        (total-unscheduled 0)
        (total-gap 0)
        file
        rtn
        rtnall
        entry
        (last-timestamp start-time)
        scheduled-entries)
    (while (setq file (car files))
      (catch 'nextfile
        (org-check-agenda-file file)
        (setq rtn (org-agenda-get-day-entries file date :scheduled :timestamp))
        (setq rtnall (append rtnall rtn)))
      (setq files (cdr files)))
    ;; For each item on the list
    (while (setq entry (car rtnall))
      (let ((time (get-text-property 1 'time entry)))
        (cond
         ((and time (string-match "\\([^-]+\\)-\\([^-]+\\)" time))
          (setq scheduled-entries (cons (cons
                                         (save-match-data (appt-convert-time (match-string 1 time)))
                                         (save-match-data (appt-convert-time (match-string 2 time))))
                                        scheduled-entries)))
         ((and time
               (string-match "\\([^-]+\\)\\.+" time)
               (string-match "^[A-Z]+ \\(\\[#[A-Z]\\]\\)? \\([0-9]+\\)" (get-text-property 1 'txt entry)))
          (setq scheduled-entries
                (let ((start (and (string-match "\\([^-]+\\)\\.+" time)
                                 (appt-convert-time (match-string 1 time)))))
                  (cons (cons start
                              (and (string-match "^[A-Z]+ \\(\\[#[A-Z]\\]\\)? \\([0-9]+\\) " (get-text-property 1 'txt entry))
                                   (+ start (string-to-number (match-string 2 (get-text-property 1 'txt entry))))))
                        scheduled-entries))))
         ((string-match "^[A-Z]+ \\([0-9]+\\)" (get-text-property 1 'txt entry))
          (setq total-unscheduled (+ (string-to-number
                                      (match-string 1 (get-text-property 1 'txt entry)))
                                     total-unscheduled)))))
      (setq rtnall (cdr rtnall)))
    ;; Sort the scheduled entries by time
    (setq scheduled-entries (sort scheduled-entries (lambda (a b) (< (car a) (car b)))))

    (while scheduled-entries
      (let ((start (car (car scheduled-entries)))
            (end (cdr (car scheduled-entries))))
      (cond
       ;; are we in the middle of this timeslot?
       ((and (>= last-timestamp start)
             (< = last-timestamp end))
        ;; move timestamp later, no change to time
        (setq last-timestamp end))
       ;; are we completely before this timeslot?
       ((< last-timestamp start)
        ;; add gap to total, skip to the end
        (setq total-gap (+ (- start last-timestamp) total-gap))
        (setq last-timestamp end)))
      (setq scheduled-entries (cdr scheduled-entries))))
    (if (< last-timestamp end-of-day)
        (setq total-gap (+ (- end-of-day last-timestamp) total-gap)))
    (cons total-unscheduled total-gap))))

(defun sacha/bbdb-insert-birthdates ()
  "Insert a list of birthdates, sorted by month.
For best effect, dates should be of the form yyyy.mm.dd."
  (insert
   (with-temp-buffer
     (mapcar
      (lambda (rec)
        (when (bbdb-record-getprop rec 'birthdate)
          (insert
           (if (string-match "..\\...$" (bbdb-record-getprop rec 'birthdate))
               (match-string 0 (bbdb-record-getprop rec 'birthdate))
             (bbdb-record-getprop rec 'birthdate))
           " | "
           (planner-make-link
            (concat "bbdb://"
                    (planner-replace-regexp-in-string
                     " " "." (bbdb-record-name rec)))
            (bbdb-record-name rec))
           "\n")))
      (bbdb-records))
     (sort-lines nil (point-min) (point-max))
     (buffer-string)))
  nil)

(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))

(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))

(defun sacha/isearch-yank-current-word ()
  "Pull current word from buffer into search string."
  (interactive)
  (save-excursion
    (skip-syntax-backward "w_")
    (isearch-yank-internal
     (lambda ()
       (skip-syntax-forward "w_")
       (point)))))

(defun sacha/search-word-backward ()
  "Find the previous occurrence of the current word."
  (interactive)
  (let ((cur (point)))
    (skip-syntax-backward "w_")
    (goto-char
     (if (re-search-backward (concat "\\_<" (current-word) "\\_>") nil t)
	 (match-beginning 0)
         cur))))

(defun sacha/search-word-forward ()
  "Find the next occurrance of the current word."
  (interactive)
  (let ((cur (point)))
    (skip-syntax-forward "w_")
    (goto-char
     (if (re-search-forward (concat "\\_<" (current-word) "\\_>") nil t)
	 (match-beginning 0)
       cur))))
