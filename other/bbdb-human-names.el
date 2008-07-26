;;;; bbdb-human-names.el
;;; Time-stamp: <2007-12-17 20:06:06 jcgs>

(provide 'bbdb-human-names)

(defun merge-human-names (a b)
  "Merge the people names A and B."
  (let ((other-a nil) (surname-a nil)
	(other-b nil) (surname-b nil))
    (when (string-match "\\([^ ]+\\) \\([-a-z]+\\)" a)
      (setq other-a (substring a 0 (match-end 1))
	    surname-a (substring a (match-beginning 2))))
    (when (string-match "\\([^ ]+\\) \\([-a-z]+\\)" b)
      (setq other-b (substring b 0 (match-end 1))
	    surname-b (substring b (match-beginning 2))))
    (if (and (stringp surname-a)
	     (stringp surname-b)
	     (string= surname-a surname-b))
	(concat other-a " and " other-b " " surname-a)
      (concat a " and " b))))

(defun merged-people-list (people name-field-index match-field-index
				  &rest other-collect-indices)
  "Merge PEOPLE with names NAME-FIELD-INDEX, where MATCH-FIELD-INDEX are equal.

PEOPLE is an array of people, where each person is represented by
an array, in which the element at NAME-FIELD-INDEX is their name,
and the element at MATCH-FIELD-INDEX is something by which to try
to combine the entries -- for example, their postal address.

This function can thus be used to take a list of people living at
various addresses, and bunch them together by address.

The name of each \"person\" resulting from this is either the
name of an individual, or a concatenated name \"A and B\" with
some intelligent handling of surnames (last parts of names).

Remaining OTHER-COLLECT-INDICES are array indices to merge as
best it can."
  (if (< (length people) 2)
      people
    (let* ((first-person (car people))
	   (first-person-key (aref first-person match-field-index))
	   (matches (remove-if-not
		     (function
		      (lambda (second-person)
			(equal (aref second-person match-field-index)
			       first-person-key)))
		     (cdr people))))
      (when matches
	(dolist (match matches)
	  (message "Merging %S and %S" first-person match)
	  (aset first-person 0
		(merge-human-names (aref first-person name-field-index)
				   (aref match name-field-index)))
	  (dolist (other-index other-collect-indices)
	    (let ((person-attribute (aref first-person other-index))
		  (match-attribute (aref match other-index)))
	      (message "Merging %d: %S, %S"
		       other-index person-attribute match-attribute)
	      (cond
	       ((null match-attribute)
		nil)
	       ((and (consp person-attribute)
		     (consp match-attribute))
		(aset first-person other-index
		      (append person-attribute match-attribute)))
	       ((and (stringp person-attribute)
		     (stringp match-attribute))
		(aset first-person other-index
		      (concat person-attribute ", " match-attribute)))))))
	(rplacd people
		(delete-if
		 (function
		  (lambda (second-person)
		    (equal (aref second-person match-field-index)
			   first-person-key)))
		 (cdr people))))
      (cons first-person
	    (apply 'merged-people-list
		   (cdr people)
		   name-field-index
		   match-field-index
		   other-collect-indices)))))

(defun bbdb-record-title-and-name (record)
  "Get the name and title from the record."
  (let ((name (bbdb-record-name record))
	(ordination (bbdb-record-getprop record 'ordination))
	(graduate (bbdb-record-getprop record 'graduate))
	(order (bbdb-record-getprop record 'order)))
    (when (and graduate (string-match "\\(PhD\\)\\|\\(Dr\\)\\|\\(Mb\\)" graduate))
      (setq name (concat "Dr " name)))
    (when (and ordination (string-match "rev" ordination))
      (setq name (concat "Revd " name)))
    (when (and (stringp order) (not (string-match " " order)))
      (setq name (concat name " " order)))
    name))

(defun surname< (a b)
  "Return whether the surname of A sorts before that of B."
  (let ((surname-a (if (string-match "\\([^ ]+\\)$" a)
		       (substring a (match-beginning 1))
		     a))
	(surname-b (if (string-match "\\([^ ]+\\)$" b)
		       (substring b (match-beginning 1))
		     b)))
    (string< surname-a surname-b)))

;;; end of bbdb-human-names.el
