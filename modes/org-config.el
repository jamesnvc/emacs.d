(add-hook 'remember-mode-hook 'org-remember-apply-template)

;; (setq org-remember-templates
;;       '(("Todo"  ?t "** TODO %?\n  %u" "todo.org"  "Tasks")
;;         ("Notes" ?n "* %u %?"         "notes.org" "Notes")
;;         ("Appts" ?a "** APPT %?\n   %^T\n%i\n" "todo.org" "Appointments")
;;         ("Book"  ?b "*** TODO %?\n  %u" "todo.org" "Books"))
;;       )
;; "\n* %^{Book Title} %t :READING: \n%[l:/booktemp.txt]\n"

;; (setq org-link-abbrev-alist
;;       '(("wiki" . "http://en.wikipedia.org/wiki/")))

(setq org-agenda-include-diary t)

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation))

;;; Make a remember pop-up window
;; http://metajack.im/2008/12/30/gtd-capture-with-emacs-orgmode/
(defadvice remember-finalize (after delete-remember-frame activate)
  "Advise remember-finalize to close the frame if it is the remember frame"
  (if (equal "*Remember*" (frame-parameter nil 'name))
    (delete-frame)))

(defadvice remember-destroy (after delete-remember-frame activate)
  "Advise remember-destroy to close the frame if it is the remember frame"
  (if (equal "*Remember Popup*" (frame-parameter nil 'name))
    (delete-frame)))

;; make the frame contain a single window. by default org-remember
;; splits the window.
(add-hook 'remember-mode-hook  'delete-other-windows)

(defun make-remember-frame ()
  "Create a new frame and run org-remember"
  (interactive)
  (make-frame '((name . "*Remember Popup*") (width . 80) (height . 10)))
  (select-frame-by-name "*Remember Popup*")
  (org-remember))