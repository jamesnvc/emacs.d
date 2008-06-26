;;; xgit-log.el --- git interface for dvc: mode for git log style output

;; Copyright (C) 2006-2007 by all contributors

;; Author: Stefan Reichoer, <stefan@xsteve.at>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; The git interface for dvc: a mode to handle git log style output

;;; History:

;;

;;; Code:

(require 'dvc-revlist)

(defstruct (xgit-revision-st)
  hash
  message
  author
  commit
  author-date
  commit-date
  merge
  )

;; copied and adapted from bzr-log-parse
(defun xgit-log-parse (log-buffer location &optional remote missing)
  "Parse the output of git log."
  (dvc-trace "xgit-log-parse. location=%S" location)
  (goto-char (point-min))
  (let ((root location)
        (intro-string)) ;; not used currently, but who knows
    (when missing ;; skip the first status output
      (re-search-forward (concat "^commit " xgit-hash-regexp "\n"))
      (beginning-of-line)
      (setq intro-string (buffer-substring-no-properties (point-min) (point)))
      (with-current-buffer log-buffer
        (let ((buffer-read-only nil))
          (insert intro-string))))
    (dvc-trace-current-line)
    (while (> (point-max) (point))
      (dvc-trace "while")
      (dvc-trace-current-line)
      (let ((elem (make-xgit-revision-st)))
        ;; As comments, with ";; |" as prefix is an example of output
        ;; of git log --pretty=fuller, with the corresponding parser
        ;; code below.
        ;; |commit c576304d512df18fa30b91bb3ac15478d5d4dfb1
        (re-search-forward (concat "^commit \\(" xgit-hash-regexp
                                   "\\)\n"))
        (setf (xgit-revision-st-hash elem) (match-string 1))
        (dvc-trace "commit %S" (xgit-revision-st-hash elem))
        ;; |Merge: f34f2b0... b13ef49...
        ;; |Author:     Junio C Hamano <gitster@pobox.com>
        ;; |AuthorDate: Wed Aug 15 21:38:38 2007 -0700
        ;; |Commit:     Junio C Hamano <gitster@pobox.com>
        ;; |CommitDate: Wed Aug 15 21:38:38 2007 -0700
        (while (looking-at "^\\([^ \t\n]+\\): +\\([^ ].*\\)$")
          (cond ((string= (match-string 1) "Author")
                 (setf (xgit-revision-st-author elem)
                       (match-string-no-properties 2)))
                ((string= (match-string 1) "Commit")
                 (setf (xgit-revision-st-commit elem)
                       (match-string-no-properties 2)))
                ((string= (match-string 1) "AuthorDate")
                 (setf (xgit-revision-st-author-date elem)
                       (match-string-no-properties 2)))
                ((string= (match-string 1) "CommitDate")
                 (setf (xgit-revision-st-commit-date elem)
                       (match-string-no-properties 2)))
                ((string= (match-string 1) "Merge")
                 (setf (xgit-revision-st-merge elem)
                       (match-string-no-properties 2))))
          (forward-line 1))
        ;; |
        ;; |    Merge branch 'maint' to sync with 1.5.2.5
        ;; |
        ;; |    * maint:
        ;; |      GIT 1.5.2.5
        ;; |      git-add -u paths... now works from subdirectory
        ;; |      Fix "git add -u" data corruption.
        ;; |
        ;; |
        (forward-line 1)
        (let ((start-point (point)))
          (re-search-forward "^$")
          ;; final blank line, or end of buffer.
          (beginning-of-line)
          (setf (xgit-revision-st-message elem)
                (buffer-substring-no-properties
                 start-point (point))))
        (forward-line 1)
        ;; elem now contains the revision structure.
        (with-current-buffer log-buffer
          (ewoc-enter-last
           dvc-revlist-cookie
           `(entry-patch
             ,(make-dvc-revlist-entry-patch
               :dvc 'xgit
               :struct elem
               :rev-id `(xgit (revision ,(xgit-revision-st-hash
                                          elem))))))
          (goto-char (point-min))
          (dvc-revision-prev))))))

(defun xgit-revision-list-entry-patch-printer (elem)
  (insert (if (dvc-revlist-entry-patch-marked elem)
              (concat " " dvc-mark " ") "   "))
  (let* ((struct (dvc-revlist-entry-patch-struct elem))
         (hash       (xgit-revision-st-hash struct))
         (commit (or (xgit-revision-st-commit struct) "?"))
         (author (or (xgit-revision-st-author struct) "?"))
         (commit-date (or (xgit-revision-st-commit-date struct) "?"))
         (author-date (or (xgit-revision-st-author-date struct) "?")))
    (insert (dvc-face-add "commit" 'dvc-header) " " hash "\n")
    (when dvc-revisions-shows-creator
      (insert "   " (dvc-face-add "Commit:" 'dvc-header) " " commit "\n")
      (unless (string= commit author)
        (insert "   " (dvc-face-add "Author:" 'dvc-header) " " author "\n")))
    (when dvc-revisions-shows-date
      (insert "   " (dvc-face-add "CommitDate:" 'dvc-header) " "
              commit-date "\n")
      (unless (string= commit-date author-date)
        (insert "   " (dvc-face-add "AuthorDate:" 'dvc-header) " "
                author-date "\n")))
    (when dvc-revisions-shows-summary
      (newline)
      (insert (replace-regexp-in-string
               "^" "  " ;; indent by 4 already in git output, plus 3
               ;; to leave room for mark.
               (or (xgit-revision-st-message struct) "?")))
      (newline)
    ))
  )

(defun xgit-revlog-get-revision (rev-id)
  (let ((rev (car (dvc-revision-get-data rev-id))))
    (dvc-run-dvc-sync 'xgit `("show" ,rev)
     :finished 'dvc-output-buffer-handler)))

(defun xgit-revlog-mode ()
  (interactive)
  (xgit-diff-mode))

(defun xgit-name-construct (revision)
  revision)


(defcustom xgit-log-max-count 400
  "Number of logs to print.  Specify negative value for all logs.
Limiting this to low number will shorten time for log retrieval
for large projects like Linux kernel on slow machines (Linux
kernel has >50000 logs).

See also `xgit-log-since'."
  :type 'integer
  :group 'dvc-xgit)

(defcustom xgit-log-since nil
  "Time duration for which the log should be displayed.

For example, \"1.month.ago\", \"last.week\", ...

Use nil if you don't want a limit.

See also `xgit-log-max-count'."
  :type '(choice (string :tag "Duration")
                 (const :tag "No limit" nil))
  :group 'dvc-xgit)

(defun xgit-log-grep (regexp)
  "Limit the log output to ones with log message that matches the specified pattern."
  (interactive "MGrep pattern for Commit Log: ")
  (xgit-log default-directory :log-regexp regexp))

(defun xgit-log-file (filename)
  "Limit the log output to ones that changes the specified file."
  (interactive "FFile name: ")
  (xgit-log default-directory :file filename))

(defun xgit-log-diff-grep (string)
  "Limit the logs that contain the change in given string."
  (interactive "MGrep pattern for Commit Diff: ")
  (xgit-log default-directory :diff-match string))

(defun xgit-log-revision (rev)
  "Show log for a given hash id."
  (interactive "MID: ")
  (xgit-log default-directory :cnt 1 :rev rev))


;; copied and adapted from bzr-log
;;;###autoload
(defun* xgit-log (dir cnt &key log-regexp diff-match rev file since)
  "Run git log for DIR.
DIR is a directory controlled by Git/Cogito.
CNT is max number of log to print.  If not specified, uses xgit-log-max-count.
LOG-REGEXP is regexp to filter logs by matching commit logs.
DIFF-MATCH is string to filter logs by matching commit diffs.
REV is revision to show.
FILE is filename in repostory to filter logs by matching filename."
  (interactive (list default-directory nil))
  (let* ((count (format "--max-count=%s" (or cnt xgit-log-max-count)))
         (since-date (or since xgit-log-since))
         (since (when since-date (format "--since=%s" since-date)))
         (grep  (when log-regexp (format "--grep=%s" log-regexp)))
         (diff  (when diff-match (format "-S%s" diff-match)))
         (fname (when file (file-relative-name file (xgit-tree-root dir))))
         (args  (list "log" "--pretty=fuller" count
                      since grep diff rev "--" fname)))
    (dvc-build-revision-list 'xgit 'log (or dir default-directory) args
                             'xgit-log-parse t nil nil
                             (dvc-capturing-lambda ()
                               (xgit-log (capture dir)
                                         (capture cnt)
                                         :log-regexp (capture log-regexp)
                                         :diff-match (capture diff-match)
                                         :rev (capture rev)
                                         :file (capture file)
                                         :since (capture since))))
    (goto-char (point-min))))


(provide 'xgit-log)
;;; xgit-log.el ends here
