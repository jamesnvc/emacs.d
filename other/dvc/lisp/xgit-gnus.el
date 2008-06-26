;;; xgit-gnus.el --- dvc integration to gnus

;; Copyright (C) 2003-2007 by all contributors

;; Author: Michael Olson <mwolson@gnu.org>,
;;         Stefan Reichoer <stefan@xsteve.at>
;; Contributions from:
;;    Matthieu Moy <Matthieu.Moy@imag.fr>

;; DVC is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; DVC is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; gnus is optional. Load it at compile-time to avoid warnings.
(eval-when-compile
  (condition-case nil
      (progn
        (require 'gnus)
        (require 'gnus-art)
        (require 'gnus-sum))
    (error nil)))

;;;###autoload
(defun xgit-insinuate-gnus ()
  "Integrate Xgit into Gnus.
The following keybindings are installed for gnus-summary:
K t s `xgit-gnus-article-view-status-for-apply-patch'
K t v `xgit-gnus-article-view-patch'

The following keybindings are ignored:
K t l"
  (interactive)
  (dvc-gnus-initialize-keymap)
  (define-key gnus-summary-dvc-submap [?s]
    'xgit-gnus-article-view-status-for-apply-patch)
  (define-key gnus-summary-dvc-submap [?v]
    'xgit-gnus-article-view-patch)
  (define-key gnus-summary-dvc-submap [?l] 'ignore))

(defcustom xgit-apply-patch-mapping nil
  "*Working directories in which patches should be applied.

An alist of rules to map a regexp matching an email address to a
working directory.

This is used by the `xgit-gnus-apply-patch' function.
Example setting: '((\".*erc-discuss@gnu.org\" \"~/proj/emacs/erc/master\"))"
  :type '(repeat (list :tag "Rule"
                       (string :tag "Email address regexp")
                       (string :tag "Working directory")))
  :group 'dvc-xgit)

(defvar xgit-gnus-patch-from-user nil)

(defun xgit-gnus-article-apply-patch (n)
  "Apply the current article as a git patch.
N is the mime part given to us by DVC.

If N is negative, then force applying of the patch by doing a
3-way merge.

We ignore the use of N as a mime part, since git can extract
patches from the entire message."
  (interactive "p")
  (let ((force nil))
    (when (and (numberp n) (< n 0))
      (setq force t))
    (xgit-gnus-apply-patch force)))

(defun xgit-gnus-apply-patch (force)
  "Apply a git patch via gnus.  HANDLE should be the handle of the part."
  (let ((patch-file-name (concat (dvc-make-temp-name "gnus-xgit-apply-")
                                 ".patch"))
        (window-conf (current-window-configuration))
        (err-occurred nil)
        working-dir patch-buffer)
    (gnus-summary-show-article 'raw)
    (gnus-summary-select-article-buffer)
    (save-excursion
      (let ((require-final-newline nil)
            (coding-system-for-write mm-text-coding-system))
        (gnus-write-buffer patch-file-name))
      (goto-char (point-min))
      (re-search-forward "^To: " nil t)
      (dolist (m xgit-apply-patch-mapping)
        (when (looking-at (car m))
          (setq working-dir (dvc-uniquify-file-name (cadr m))))))
    (gnus-summary-show-article)
    (delete-other-windows)
    (dvc-buffer-push-previous-window-config)
    (find-file patch-file-name)
    (setq patch-buffer (current-buffer))
    (setq working-dir (dvc-read-directory-name "Apply git patch to: "
                                               nil nil t working-dir))
    (unwind-protect
        (progn
          (when working-dir
            (let ((default-directory working-dir))
              (xgit-apply-mbox patch-file-name force)))
          (set-window-configuration window-conf)
          (when (and working-dir
                     (y-or-n-p "Run git log in working directory? "))
            (xgit-log working-dir nil)
            (delete-other-windows)))
      ;; clean up temporary file
      (delete-file patch-file-name)
      (kill-buffer patch-buffer))))

(defvar xgit-gnus-status-window-configuration nil)
(defun xgit-gnus-article-view-status-for-apply-patch (n)
  "View the status for the repository, where MIME part N would be applied
as a git patch.

Use the same logic as in `xgit-gnus-article-apply-patch' to
guess the repository path via `xgit-apply-patch-mapping'."
  (interactive "p")
  (xgit-gnus-view-status-for-apply-patch)
  (set-window-configuration xgit-gnus-status-window-configuration))

(defun xgit-gnus-view-status-for-apply-patch ()
  "View the status for a repository before applying a git patch via gnus."
  (let ((window-conf (current-window-configuration))
        (working-dir))
    (gnus-summary-select-article-buffer)
    (save-excursion
      (goto-char (point-min))
      (re-search-forward "^To: " nil t)
      (dolist (m xgit-apply-patch-mapping)
        (when (looking-at (car m))
          (setq working-dir (dvc-uniquify-file-name (cadr m))))))
    (unless working-dir
      ;; when we find the directory in xgit-apply-patch-mapping don't
      ;; ask for confirmation
      (setq working-dir (dvc-read-directory-name
                         "View git repository status for: "
                         nil nil t working-dir)))
    (let ((default-directory working-dir))
      (xgit-dvc-status)
      (delete-other-windows)
      (setq xgit-gnus-status-window-configuration
            (current-window-configuration))
      (dvc-buffer-push-previous-window-config window-conf))))

(defun xgit-gnus-article-view-patch (n)
  "View the currently looked-at patch.

All this does is switch to the article and move to where the
patch begins."
  (interactive "p")
  (gnus-summary-select-article-buffer)
  (goto-char (point-min))
  (re-search-forward "^---$" nil t)
  (forward-line 1))

(provide 'xgit-gnus)
;;; xgit-gnus.el ends here
