;;; xmtn-revlist.el --- Interactive display of revision histories for monotone

;; Copyright (C) 2006, 2007 Christian M. Ohler

;; Author: Christian M. Ohler
;; Keywords: tools

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this file; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
;; Boston, MA  02110-1301  USA.

;;; Commentary:

;; This file is part of xmtn and implements an interactive display of
;; revision histories.

;;; Code:

;;; There are some notes on the design of xmtn in
;;; docs/xmtn-readme.txt.

(eval-and-compile
  (require 'cl)
  (require 'dvc-unified)
  (require 'dvc-revlist)
  (require 'xmtn-ids)
  (require 'xmtn-basic-io)
  (require 'xmtn-automate)
  (require 'xmtn-match)
  (require 'xmtn-dvc))


(defvar xmtn--revlist-*info-generator-fn* nil)
"Buffer-local variable pointing to a function that generates a
list of revisions to display in a revlist buffer. Called with one
arg; root. Result is of the form:
    (branch
     (header-lines)
     (footer-lines)
     (revisions))"
(make-variable-buffer-local 'xmtn--revlist-*info-generator-fn*)

(defvar xmtn--revlist-*merge-destination-branch* nil)
(make-variable-buffer-local 'xmtn--revlist-*merge-destination-branch*)

(defun xmtn--escape-branch-name-for-selector (branch-name)
  ;; FIXME.  The monotone manual refers to "shell wildcards" but
  ;; doesn't define what they are, or how to escape them.  So just a
  ;; heuristic here.
  (assert (not (position ?* branch-name)))
  (assert (not (position ?? branch-name)))
  (assert (not (position ?\\ branch-name)))
  (assert (not (position ?{ branch-name)))
  (assert (not (position ?} branch-name)))
  (assert (not (position ?[ branch-name)))
  (assert (not (position ?] branch-name)))
  branch-name)

(defstruct (xmtn--revlist-entry (:constructor xmtn--make-revlist-entry))
  revision-hash-id
  branches
  authors
  dates
  changelogs
  tags
  parent-hash-ids
  child-hash-ids)

;;;###autoload
(defun xmtn-revision-refresh-maybe ()
  ;; This is called to notify us whenever `dvc-revisions-shows-date',
  ;; `dvc-revisions-shows-creator' or `dvc-revisions-shows-summary'
  ;; change.
  ;;
  ;; There is nothing we need to do in response to this, though.
  nil)

;;;###autoload
(defun xmtn-revision-list-entry-patch-printer (patch)
  (let ((entry (dvc-revlist-entry-patch-struct patch)))
    (assert (typep entry 'xmtn--revlist-entry))
    (insert (format " %s %s%s\n"
                    (if (dvc-revlist-entry-patch-marked patch) "*" " ")
                    (xmtn--revlist-entry-revision-hash-id entry)
                    (let ((head-p
                           (endp (xmtn--revlist-entry-child-hash-ids entry)))
                          (root-p
                           (endp (xmtn--revlist-entry-parent-hash-ids entry))))
                      (cond ((and head-p root-p) " (head, root)")
                            (head-p " (head)")
                            (root-p " (root)")
                            (t "")))))
    (dolist (tag (xmtn--revlist-entry-tags entry))
      (insert (format "   Tag: %s\n" tag)))
    (let ((authors (xmtn--revlist-entry-authors entry))
          (dates (xmtn--revlist-entry-dates entry))
          (changelogs (xmtn--revlist-entry-changelogs entry)))
      (let ((len (max (length authors) (length dates) (length changelogs))))
        (macrolet ((fillf (x)
                     `(setq ,x (append ,x (make-list (- len (length ,x)) nil)))))
          (fillf authors)
          (fillf dates)
          (fillf changelogs))
        (assert (eql (length authors) len)
                (eql (length dates) len)
                (eql (length changelogs) len)))
    (loop
       ;; FIXME: Matching the k-th author cert with the k-th date cert
       ;; and the k-th changelog cert, like we do here, is unlikely to
       ;; be correct in general.  That the relationship between date,
       ;; message and author of a commit is lost appears to be a
       ;; limitation of monotone's current design.
       for author in authors
       for date in dates
       for changelog in changelogs
       do
       (cond ((and dvc-revisions-shows-date dvc-revisions-shows-creator)
              (insert (format "   %s  %s\n"
                              (or date "date unknown")
                              (or author "author unknown"))))
             (dvc-revisions-shows-date
              (insert (format "   %s\n" (or date "date unknown"))))
             (dvc-revisions-shows-creator
              (insert (format "   %s\n" (or author "author unknown"))))
             (t (progn)))
       (when dvc-revisions-shows-summary
         (if (null changelog)
             (insert (format "   No changelog"))
           (let ((lines (split-string changelog "\n")))
             (dolist (line (if dvc-revlist-brief
                               (and lines (list (first lines)))
                             lines))
               (insert (format "     %s\n" line))))))))))

(defun xmtn--revlist-setup-ewoc (root ewoc header footer revision-hash-ids last-n)
  (assert (every (lambda (x) (typep x 'xmtn--hash-id)) revision-hash-ids))
  (ewoc-set-hf ewoc header footer)
  (ewoc-filter ewoc (lambda (x) nil))   ; Clear it.
  (xmtn-automate-with-session (session root)
    (setq revision-hash-ids (xmtn--toposort root revision-hash-ids))
    (if last-n
        (let ((len (length revision-hash-ids)))
          (if (> len last-n)
              (setq revision-hash-ids (nthcdr (- len last-n) revision-hash-ids)))))
    (setq revision-hash-ids (coerce revision-hash-ids 'vector))
    (xmtn--dotimes-with-progress-reporter (i (length revision-hash-ids))
      (case (length revision-hash-ids)
        (1 "Setting up revlist buffer (1 revision)...")
        (t (format "Setting up revlist buffer (%s revisions)..."
                   (length revision-hash-ids))))
      ;; Maybe also show parents and children?  (Could add toggle
      ;; commands to show/hide these.)
      (lexical-let ((rev (aref revision-hash-ids i))
                    (branches (list))
                    (authors (list))
                    (dates (list))
                    (changelogs (list))
                    (tags (list)))
        (xmtn--map-parsed-certs
         root rev
         (lambda (key signature name value trusted)
           (declare (ignore key))
           (unless (not trusted)
             (cond ((equal name "author")
                    (push value authors))
                   ((equal name "date")
                    (push value dates))
                   ((equal name "changelog")
                    (push value changelogs))
                   ((equal name "branch")
                    (push value branches))
                   ((equal name "tag")
                    (push value tags))
                   (t
                    (progn))))))
        (setq authors (nreverse authors)
              dates (nreverse dates)
              changelogs (nreverse changelogs)
              branches (nreverse branches)
              tags (nreverse tags))
        (let ((parent-hash-ids
               (xmtn-automate-simple-command-output-lines root `("parents"
                                                                 ,rev)))
              (child-hash-ids
               (xmtn-automate-simple-command-output-lines root `("children"
                                                                 ,rev))))
          (xmtn--assert-optional (every #'stringp authors))
          (xmtn--assert-optional (every #'stringp dates))
          (xmtn--assert-optional (every #'stringp changelogs))
          (xmtn--assert-optional (every #'stringp branches))
          (xmtn--assert-optional (every #'stringp tags))
          (xmtn--assert-optional (every #'xmtn--hash-id-p parent-hash-ids))
          (xmtn--assert-optional (every #'xmtn--hash-id-p child-hash-ids))
          (ewoc-enter-last ewoc
                           ;; Creating a list `(entry-patch
                           ;; ,instance-of-dvc-revlist-entry-patch) seems
                           ;; to be part of DVC's API.
                           `(entry-patch
                             ,(make-dvc-revlist-entry-patch
                               :dvc 'xmtn
                               :rev-id `(xmtn (revision ,rev))
                               :struct (xmtn--make-revlist-entry
                                        :revision-hash-id rev
                                        :branches branches
                                        :authors authors
                                        :dates dates
                                        :changelogs changelogs
                                        :tags tags
                                        :parent-hash-ids parent-hash-ids
                                        :child-hash-ids child-hash-ids))))))))
  nil)

(defun xmtn-revision-st-message (entry)
  (mapconcat #'identity (xmtn--revlist-entry-changelogs entry) "\n"))

(defun xmtn--revlist-refresh ()
  (let ((root default-directory))
    (destructuring-bind (merge-destination-branch
                         header-lines footer-lines revision-hash-ids)
        (funcall xmtn--revlist-*info-generator-fn* root)
      (setq xmtn--revlist-*merge-destination-branch* merge-destination-branch)
      (let ((ewoc dvc-revlist-cookie))
        (xmtn--revlist-setup-ewoc root ewoc
                                  (with-temp-buffer
                                    (dolist (line header-lines)
                                      (if (null line)
                                          (insert ?\n)
                                        (insert line ?\n)))
                                    (when header-lines (insert ?\n))
                                    (buffer-string))
                                  (with-temp-buffer
                                    (when footer-lines (insert ?\n))
                                    (dolist (line footer-lines)
                                      (if (null line)
                                          (insert ?\n)
                                        (insert line ?\n)))
                                    (buffer-string))
                                  revision-hash-ids
                                  dvc-revlist-last-n)
        (if (null (ewoc-nth ewoc 0))
            (goto-char (point-max))
          (ewoc-goto-node ewoc (ewoc-nth ewoc 0))))))
  nil)

(defun xmtn--setup-revlist (root info-generator-fn first-line-only-p last-n)
  ;; Adapted from `dvc-build-revision-list'.
  (xmtn-automate-with-session (nil root)
    (let ((buffer (dvc-revlist-create-buffer
                   'xmtn 'log root 'xmtn--revlist-refresh first-line-only-p last-n)))
      (with-current-buffer buffer
        (dvc-revlist-mode)
        (setq xmtn--revlist-*info-generator-fn* info-generator-fn)
        (xmtn--revlist-refresh))
      (xmtn--display-buffer-maybe buffer nil)))
  nil)

;;;###autoload
(defun xmtn-dvc-log (path last-n)
  ;; path may be nil or a file. The front-end ensures that
  ;; 'default-directory' is set to a tree root.
  (xmtn--log-helper default-directory path t last-n))

;;;###autoload
(defun xmtn-log (&optional path last-n)
  ;; This could be generated by dvc-back-end-wrappers, but xhg, xgit
  ;; versions of dvc-log are too different.
  (interactive)
  (let ((dvc-temp-current-active-dvc 'xmtn))
    (if (interactive-p)
        (call-interactively 'dvc-log)
      (funcall 'dvc-log path last-n))))

;;;###autoload
(defun xmtn-dvc-changelog (&optional path)
  (xmtn--log-helper (dvc-tree-root) path nil nil))

(defun xmtn--log-helper (root path first-line-only-p last-n)
  (if path
      (xmtn-list-revisions-modifying-file path nil first-line-only-p last-n)
    (xmtn--setup-revlist
     root
     (lambda (root)
       (xmtn-automate-with-session
        (nil root)
        (let ((branch (xmtn--tree-default-branch root)))
          (list branch
                (list
                 (if last-n
                     (format "Log for branch %s (last %d entries):" branch last-n)
                   (format "Log for branch %s (all entries):" branch)))
                '()
                (xmtn--expand-selector
                 root
                 ;; This restriction to current branch is completely
                 ;; arbitrary.
                 (concat
                  "b:"
                  (xmtn--escape-branch-name-for-selector
                   branch)))))))
     first-line-only-p
     last-n)))

(defun xmtn--revlist--missing-get-info (root branch new-revision-hash-ids)
  (xmtn-automate-with-session (nil root)
    (let* ((base-revision-hash-id (xmtn--get-base-revision-hash-id root))
           (difference
            ;; Allowing multiple new-revision-hash-ids looked like a
            ;; neat idea at first, because I misremembered
            ;; ancestry_difference as taking multiple new-revision
            ;; arguments.  Now it has gotten way out of hand.
            (delete-duplicates
             (xmtn--toposort
              root
              (mapcan
               (lambda (new-revision-hash-id)
                 (xmtn-automate-simple-command-output-lines
                  root
                  `("ancestry_difference"
                    ,new-revision-hash-id ,base-revision-hash-id)))
               new-revision-hash-ids)))))
      (list
       branch
       `(,(format "Tree %s" root)
         ,(format "Branch %s" branch)
         ,(format            "Base revision   %s" base-revision-hash-id)
         ,@(mapcar (lambda (hash-id)
                     (format "Target revision %s" hash-id))
                   new-revision-hash-ids)
         nil
         ,(let ((target-rev-string (if (eql (length new-revision-hash-ids) 1)
                                       "revision"
                                     "revisions")))
            (case (length difference)
              (0 (format
                  "No ancestors of target %s that are not in base revision"
                  target-rev-string))
              (1 (format
                  "1 revision in target %s that is not in base revision:"
                  target-rev-string))
              (t (format
                  "%s revisions in target %s that are not in base revision:"
                  (length difference)
                  target-rev-string)))))
       '()
       difference))))

;;;###autoload
(defun xmtn-dvc-missing (&optional other)
  ;; `other', if non-nil, designates a remote repository (see bzr); mtn doesn't support that.
  (let ((root (dvc-tree-root)))
    (xmtn--setup-revlist
     root
     (lambda (root)
       (xmtn-automate-with-session (nil root)
         (let* ((branch (xmtn--tree-default-branch root))
                (heads (xmtn--heads root branch)))
           (xmtn--revlist--missing-get-info root branch heads))))
     ;; Passing nil as first-line-only-p, last-n is arbitrary here.
     nil nil))
  nil)

;;;###autoload
(defun xmtn-view-heads-revlist ()
  "Display a revlist buffer showing the heads of the current branch."
  (interactive)
  (let ((root (dvc-tree-root)))
    (xmtn--setup-revlist
     root
     (lambda (root)
       (xmtn-automate-with-session (nil root)
         (let* ((branch (xmtn--tree-default-branch root))
                (head-revision-hash-ids (xmtn--heads root branch))
                (head-count (length head-revision-hash-ids)))
           (list
            branch
            (list (format "Tree %s" root)
                  (format "Branch %s" branch)
                  (case head-count
                    (0 "No head revisions (branch empty (or circular ;))")
                    (1 "1 head revision:")
                    (t (format "%s head revisions: " head-count))))
            '()
            head-revision-hash-ids))))
     ;; Passing nil as first-line-only-p, last-n is arbitrary here.
     nil nil))
  nil)

;;;###autoload
;; This function doesn't quite offer the interface I really want: From
;; the resulting revlist buffer, there's no way to request a diff
;; restricted to the file in question.  But it's still handy.
(defun xmtn-list-revisions-modifying-file (file &optional last-backend-id first-line-only-p last-n)
  "Display a revlist buffer showing the revisions that modify FILE.

Only ancestors of revision LAST-BACKEND-ID will be considered.
FILE is a file name in revision LAST-BACKEND-ID, which defaults
to the base revision of the current tree."
  (interactive "FList revisions modifying file: ")
  (let* ((root (dvc-tree-root))
         (normalized-file (xmtn--normalize-file-name root file)))
    (unless last-backend-id
      (setq last-backend-id `(last-revision ,root 1)))
    (lexical-let ((last-backend-id last-backend-id)
                  (file file))
      (xmtn--setup-revlist
       root
       (lambda (root)
         (xmtn-automate-with-session (nil root)
           (let ((branch (xmtn--tree-default-branch root))
                 (revision-hash-ids
                  (mapcar #'first
                          (xmtn--get-content-changed-closure
                           root last-backend-id normalized-file))))
             (list
              branch
              (list
               (if last-n
                   (format "Log for %s (last %d entries)" file last-n)
                 (format "Log for %s" file)))
              '()
              revision-hash-ids))))
       first-line-only-p
       last-n))))

(defvar xmtn--*selector-history* nil)

;;;###autoload
(defun xmtn-view-revlist-for-selector (selector)
  "Display a revlist buffer showing the revisions matching SELECTOR."
  (interactive (list (read-string "View revlist for selector: "
                                  nil
                                  'xmtn--*selector-history*
                                  nil)))
  (check-type selector string)
  (let ((root (dvc-tree-root)))
    (lexical-let ((selector selector))
      (xmtn--setup-revlist
       root
       (lambda (root)
         (xmtn-automate-with-session (nil root)
           (let* ((branch (xmtn--tree-default-branch root))
                  (revision-hash-ids (xmtn--expand-selector root selector))
                  (count (length revision-hash-ids)))
             (list
              branch
              (list (format "Tree %s" root)
                    (format "Default branch %s" branch)
                    (if (with-syntax-table (standard-syntax-table)
                          (string-match "\\`\\s *\\'" selector))
                        "Blank selector"
                      (format "Selector %s" selector))
                    (case count
                      (0 "No revisions matching selector")
                      (1 "1 revision matching selector:")
                      (t (format "%s revisions matching selector: "
                                 count))))
              '()
              revision-hash-ids))))
       ;; Passing nil as first-line-only-p is arbitrary here.
       nil
       ;; FIXME: it might be useful to specify last-n here
       nil)))
  nil)

;; This generates the output shown when the user hits RET on a
;; revision in the revlist buffer.
;;;###autoload
(defun xmtn-dvc-revlog-get-revision (revision-id)
  (let ((root (dvc-tree-root)))
    (xmtn-automate-with-session (nil root)
      (let ((backend-id (xmtn--resolve-revision-id root revision-id)))
        (xmtn-match backend-id
          ((local-tree $path) (error "Not implemented"))
          ((revision $revision-hash-id)
           (with-output-to-string
             (flet ((write-line (format &rest args)
                      (princ (apply #'format format args))
                      (terpri)))
               (write-line "Revision %s" revision-hash-id)
               ;; FIXME: It would be good to sort the standard certs
               ;; like author, date, branch, tag and changelog into
               ;; some canonical order and format changelog specially
               ;; since it usually spans multiple lines.
               (xmtn--map-parsed-certs
                root revision-hash-id
                (lambda (key signature name value trusted)
                  (declare (ignore key))
                  (if (not trusted)
                      (write-line "Untrusted cert, name=%s" name)
                    (write-line "%s: %s" name value))))))))))))


(defun xmtn-revlist-explicit-merge ()
  "Run mtn explicit_merge on the two marked revisions.

To be invoked from an xmtn revlist buffer."
  (interactive)
  (let ((entries (dvc-revision-marked-revisions))
        (root (dvc-tree-root)))
    (unless (eql (length entries) 2)
      (error "Precisely 2 revisions must be marked for merge, not %s"
             (length entries)))
    (let ((hash-ids (mapcar #'xmtn--revlist-entry-revision-hash-id entries))
          (destination-branch-name xmtn--revlist-*merge-destination-branch*))
      ;; FIXME: Does it make any difference which one we choose as
      ;; "left" and which one we choose as "right"?  (If it does, we
      ;; should also make their selection in the UI asymmetrical: For
      ;; example, require precisely one marked revision and use the
      ;; one at point as the other.)
      (destructuring-bind (left right) hash-ids
        (unless (yes-or-no-p
                 (format "Merge revisions %s and %s onto branch %s? "
                         left right destination-branch-name))
          (error "Aborted merge"))
        (xmtn--do-explicit-merge root left right destination-branch-name))))
  nil)

(defun xmtn-revlist-update ()
  "Update current tree to the revision at point.

To be invoked from an xmtn revlist buffer."
  (interactive)
  (let* ((root (dvc-tree-root))
         (entry (dvc-revlist-current-patch-struct))
         (target-hash-id (xmtn--revlist-entry-revision-hash-id entry)))
    (xmtn--update-after-confirmation root target-hash-id)))

;; Being able to conveniently disapprove whole batches of revisions
;; is going to be a lot of fun.
(defun xmtn-revlist-disapprove ()
  "Disapprove the marked revisions, or the revision at point if none marked.

To be invoked from an xmtn revlist buffer."
  (interactive)
  (let* ((root (dvc-tree-root))
         (entries (or (dvc-revision-marked-revisions)
                      (list (dvc-revlist-current-patch-struct))))
         (hash-ids (map 'vector #'xmtn--revlist-entry-revision-hash-id entries))
         (description (case (length hash-ids)
                        (0 (xmtn--assert-nil))
                        (1 (format "revision %s" (elt hash-ids 0)))
                        (t (format "%s revisions" (length hash-ids))))))
    (assert (every #'xmtn--hash-id-p hash-ids))
    (unless (yes-or-no-p (format "Disapprove %s? " description))
      (error "Aborted disapprove"))
    (xmtn--dotimes-with-progress-reporter (i (length hash-ids))
        (format "Disapproving %s..." description)
      (let ((hash-id (aref hash-ids i)))
        (funcall (xmtn--do-disapprove-future root hash-id))))))

(defun xmtn-revlist-missing-revisions ()
  "Show ancestry difference of selected revisions and base revision of tree.

Shows the revisions that are ancestors of the marked revisions
but not of the current base revision.  If no revisions are
marked, use revision at point.

To be invoked from an xmtn revlist buffer.  Brings up an xmtn revlist buffer."
  (interactive)
  (let ((root (dvc-tree-root)))
    (lexical-let ((new-revisions
                   (mapcar #'xmtn--revlist-entry-revision-hash-id
                           (or (dvc-revision-marked-revisions)
                               (list (dvc-revlist-current-patch-struct))))))
      (assert (every #'xmtn--hash-id-p new-revisions))
      (xmtn--setup-revlist
       root
       (lambda (root)
         (xmtn-automate-with-session (nil root)
           (let* ((branch (xmtn--tree-default-branch root)))
             (xmtn--revlist--missing-get-info root branch new-revisions))))
       ;; Passing nil as first-line-only-p and last-n is arbitrary here.
       nil nil)))
  nil)

(provide 'xmtn-revlist)

;;; xmtn-revlist.el ends here
