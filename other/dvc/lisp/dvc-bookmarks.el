;;; dvc-bookmarks.el --- The bookmark system for DVC

;; Copyright (C) 2006-2008 by all contributors

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

;; This file provides a hierachical bookmark system for DVC

;;; History:

;;

;;; Code:
(require 'dvc-core)
(require 'dvc-state)
(require 'ewoc)

;; this were the settings used for tla
;; ;; Generated file. Do not edit!!!
;; (setq
;; tla-bookmarks-alist
;; '(("dvc"
;;   (local-tree "/home/srei/work/tla/xtla")
;;   (location "stefan@xsteve.at--public-2005" "dvc" "dev" "0" nil)
;;   (timestamp . "Wed Apr 27 10:45:31 2005"))
;;  ("emacs-muse"
;;   (local-tree "/home/srei/work/tla/emacs-muse")
;;   (location "mwolson@gnu.org--2006" "muse" "main" "1.0" nil)
;;   (timestamp . "Fri Dec 10 07:05:56 2004"))))

;; what I want to have:
;; hierachical tree of bookmarks
;; support for different dvc's
;; short name for working copy/branch
;; local-tree
;; timestamp => bookmark-creation-date?
;; different colors
;; optional: dvc: xhg, bzr,...
;; bookmark editing via C-k, C-y (just like in gnus)

;; saved under ~/.dvc/bookmarks.el

;; a data structure for testing purposes
(defvar dvc-bookmark-alist
  '(("hg"
     (local-tree "~/work/hg/hg"))
    ("work-stuff"
     (children
      ("home-dir"
       (local-tree "~/"))
      ("another-dir"
       (local-tree "~/work")))))
  "The bookmarks used for dvc")
;;(pp-to-string dvc-bookmark-alist)

(defvar dvc-bookmarks-file-name "dvc-bookmarks.el" "The file that holds the dvc bookmarks")

(defvar dvc-bookmarks-show-partners t
"If non-nil, display partners.
Must be non-nil for some featurs of dvc-bookmarks to work.")

(defvar dvc-bookmarks-loaded nil "Whether `dvc-bookmark-alist' has been loaded from `dvc-bookmarks-file-name'.")
(defvar dvc-bookmarks-cookie nil "The ewoc cookie for the *dvc-bookmarks* buffer.")

(defvar dvc-bookmarks-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map dvc-keyvec-help 'describe-mode)
    (define-key map dvc-keyvec-quit 'dvc-buffer-quit)
    (define-key map [return] 'dvc-bookmarks-goto)
    (define-key map "\C-x\C-f" 'dvc-bookmarks-find-file-in-tree)
    (define-key map "\C-m"   'dvc-bookmarks-goto)
    (define-key map "g"      'dvc-bookmarks)
    (define-key map "h"      'dvc-buffer-pop-to-partner-buffer)
    (define-key map "j"      'dvc-bookmarks-jump)
    (define-key map "n"      'dvc-bookmarks-next)
    (define-key map "p"      'dvc-bookmarks-previous)
    (define-key map "a"      'dvc-bookmarks-add)
    (define-key map "\C-y"   'dvc-bookmarks-yank)
    (define-key map "\C-k"   'dvc-bookmarks-kill)
    (define-key map "s"      'dvc-bookmarks-status)
    (define-key map "c"      'dvc-bookmarks-log-edit)
    (define-key map "l"      'dvc-bookmarks-changelog)
    (define-key map "L"      'dvc-bookmarks-log)
    (define-key map "Mm"     'dvc-bookmarks-missing)
    (define-key map "Mf"     'dvc-bookmarks-pull)
    (define-key map "Mx"     'dvc-bookmarks-merge)
    (define-key map "."      'dvc-bookmarks-show-info-at-point)
    (define-key map "\C-x\C-s" 'dvc-bookmarks-save)
    (define-key map "Ap"     'dvc-bookmarks-add-partner)
    (define-key map "Rp"     'dvc-bookmarks-remove-partner)
    (define-key map "Tp"     'dvc-bookmarks-toggle-partner-visibility)
    (define-key map "An"     'dvc-bookmarks-add-nickname)
    map)
  "Keymap used in `dvc-bookmarks-mode'.")

(easy-menu-define dvc-bookmarks-mode-menu dvc-bookmarks-mode-map
  "`dvc-bookmarks-mode' menu"
  `("dvc-bookmarks"
    ["Go to working copy" dvc-bookmarks-goto t]
    ["DVC status" dvc-bookmarks-status t]
    ["DVC changelog" dvc-bookmarks-changelog t]
    ["DVC log" dvc-bookmarks-log t]
    ["DVC missing" dvc-bookmarks-missing t]
    ["DVC pull" dvc-bookmarks-pull t]
    ["DVC merge" dvc-bookmarks-merge t]
   "--"
    ["Add new bookmark" dvc-bookmarks-add t]
    ["Add partner" dvc-bookmarks-add-partner t]
    ["Remove partner" dvc-bookmarks-remove-partner t]
    ["Add/edit partner Nickname" dvc-bookmarks-add-nickname t]
    "--"
    ("Toggle visibility"
     ["Partners"    dvc-bookmarks-toggle-partner-visibility
      :style toggle :selected dvc-bookmarks-show-partners])
   "--"
    ["Save bookmarks" dvc-bookmarks-save t]
     ))

(defun dvc-bookmarks-printer (elem)
  (let ((entry (car elem))
        (indent (cadr elem))
        (partners (and dvc-bookmarks-show-partners (dvc-bookmarks-get-partners (nth 2 elem))))
        (nick-name))
    ;;(dvc-trace "dvc-bookmarks-printer - elem: %S, partners: %S" elem partners)
    (insert (format "%s%s" (make-string indent ? ) entry))
    (when partners
      (dolist (p partners)
        (setq nick-name (dvc-bookmarks-partner-nickname (nth 2 elem) p))
        (insert (format "\n%sPartner %s%s"
                        (make-string (+ 2 indent) ? )
                        p
                        (if nick-name (format "  [%s]" nick-name) "")))))))

(defun dvc-bookmarks-add-to-cookie (elem indent &optional node)
  (let ((curr (or node (ewoc-locate dvc-bookmarks-cookie)))
        (data (list (car elem) indent elem))
        (enter-function (if (eq (dvc-line-number-at-pos) 1) 'ewoc-enter-before 'ewoc-enter-after)))
    (cond ((assoc 'children elem)
           (setq node
                 (if curr
                     (apply enter-function (list dvc-bookmarks-cookie curr data))
                   (let ((n (ewoc-enter-last dvc-bookmarks-cookie data)))
                     (forward-line 1)
                     n)))
           (dolist (child (reverse (cdr (assoc 'children elem))))
             (dvc-bookmarks-add-to-cookie child (+ indent 2) node)))
          (t
           (if curr
               (apply enter-function (list dvc-bookmarks-cookie curr data))
             (ewoc-enter-last dvc-bookmarks-cookie data))))
    (forward-line 1)))

;;;###autoload
(defun dvc-bookmarks (&optional arg)
  "Display the *dvc-bookmarks* buffer.
With prefix argument ARG, reload the bookmarks file from disk."
  (interactive "P")
  (dvc-bookmarks-load-from-file arg)
  (dvc-switch-to-buffer (get-buffer-create "*dvc-bookmarks*"))
  (let ((cur-pos (point)))
    (toggle-read-only 0)
    (erase-buffer)
    (set (make-local-variable 'dvc-bookmarks-cookie)
         (ewoc-create (dvc-ewoc-create-api-select
                       #'dvc-bookmarks-printer)))
    (put 'dvc-bookmarks-cookie 'permanent-local t)
    (dolist (entry dvc-bookmark-alist)
      (dvc-bookmarks-add-to-cookie entry 0))
    (if (eq major-mode 'dvc-bookmarks-mode)
        (goto-char cur-pos)
      (goto-char (point-min))))
  (dvc-bookmarks-mode))

(defun dvc-bookmarks-mode ()
  "Mode to display DVC bookmarks.

\\{dvc-bookmarks-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (use-local-map dvc-bookmarks-mode-map)
  (setq major-mode 'dvc-bookmarks-mode)
  (setq mode-name "dvc-bookmarks")
  (toggle-read-only 1))

(defun dvc-bookmarks-show-info-at-point ()
  (interactive)
  (message "%S" (dvc-bookmarks-current-data)))

(defun dvc-bookmarks-current-data ()
  (nth 2 (ewoc-data (ewoc-locate dvc-bookmarks-cookie))))

(defun dvc-bookmarks-current-value (key)
  (cadr (assoc key (cdr (dvc-bookmarks-current-data)))))

(defun dvc-bookmarks-add (bookmark-name bookmark-local-dir)
  "Add a DVC bookmark"
  (interactive
   (let* ((bmk-name (read-string "DVC bookmark name: "))
          (bmk-loc (dvc-read-directory-name (format "Set DVC bookmark %s in directory: " bmk-name))))
     (list bmk-name bmk-loc)))
  (let* ((elem (list bookmark-name (list 'local-tree bookmark-local-dir)))
         (data (list (car elem) 0 elem)))
    (dvc-bookmarks)
    (add-to-list 'dvc-bookmark-alist elem t)
    (ewoc-enter-last dvc-bookmarks-cookie data)))

(defun dvc-bookmarks-next ()
  (interactive)
  (forward-line 1))

(defun dvc-bookmarks-previous ()
  (interactive)
  (forward-line -1))

(defun dvc-bookmarks-goto ()
  (interactive)
  (let ((local-tree (dvc-bookmarks-current-value 'local-tree)))
    (if local-tree
        (find-file local-tree)
      (message "No local-tree defined for this bookmark entry."))))

(defun dvc-bookmarks-find-file-in-tree ()
  (interactive)
  (let ((local-tree (dvc-bookmarks-current-value 'local-tree)))
    (if local-tree
        (let ((default-directory (file-name-as-directory local-tree)))
          (find-file (read-file-name "Find file in bookmarked tree: ")))
      (message "No local-tree defined for this bookmark entry."))))

(defun dvc-bookmarks-status ()
  (interactive)
  (let ((local-tree (dvc-bookmarks-current-value 'local-tree)))
    (if local-tree
        (dvc-status local-tree)
      (message "No local-tree defined for this bookmark entry."))))

(defun dvc-bookmarks-log-edit ()
  (interactive)
  (let ((local-tree (dvc-bookmarks-current-value 'local-tree)))
    (if local-tree
        (let ((default-directory local-tree))
          (dvc-log-edit))
      (message "No local-tree defined for this bookmark entry."))))

(defun dvc-bookmarks-changelog ()
  (interactive)
  (let ((local-tree (dvc-bookmarks-current-value 'local-tree)))
    (if local-tree
        (let ((default-directory local-tree))
          (dvc-changelog))
      (message "No local-tree defined for this bookmark entry."))))

(defun dvc-bookmarks-log ()
  (interactive)
  (let ((local-tree (dvc-bookmarks-current-value 'local-tree)))
    (if local-tree
        (let ((default-directory local-tree))
          (dvc-log))
      (message "No local-tree defined for this bookmark entry."))))

(defun dvc-bookmarks-missing ()
  (interactive)
  (let ((local-tree (dvc-bookmarks-current-value 'local-tree)))
    (if local-tree
        (let ((default-directory local-tree))
          (dvc-missing (dvc-bookmarks-partner-at-point)))
      (message "No local-tree defined for this bookmark entry."))))

(defun dvc-bookmarks-pull ()
  (interactive)
  (let ((local-tree (dvc-bookmarks-current-value 'local-tree)))
    (if local-tree
        (let ((default-directory local-tree))
          (dvc-pull))
      (message "No local-tree defined for this bookmark entry."))))

(defvar dvc-bookmarks-merge-template "Merged from %s: ")
(defun dvc-bookmarks-merge ()
  "Merge from partner at point into current bookmark."
  (interactive)
  (let ((local-tree (dvc-bookmarks-current-value 'local-tree)))
    (if local-tree
        (let ((default-directory local-tree)
              (partner (dvc-bookmarks-partner-at-point))
              (nickname (dvc-bookmarks-nickname-at-point)))
          (setq dvc-memorized-log-header (when nickname (format dvc-bookmarks-merge-template nickname)))
          (setq dvc-memorized-log-message nil)
          (message (if nickname
                       (format "Merging from %s, using URL %s" nickname partner)
                     (format "Merging from %s" partner)))
          (dvc-merge partner))
      (message "No local-tree defined for this bookmark entry."))))

(defun dvc-bookmarks-yank ()
  (interactive)
  (let ((indent (save-excursion (if (eq (line-beginning-position) (line-end-position))
                                    0
                                  (forward-line 1) (nth 1 (ewoc-data (ewoc-locate dvc-bookmarks-cookie)))))))
    (dvc-bookmarks-add-to-cookie dvc-bookmarks-tmp-yank-item indent)))

(defvar dvc-bookmarks-tmp-yank-item '("hg" (local-tree "~/work/hg/hg")))
(defun dvc-bookmarks-kill ()
  (interactive)
  (setq dvc-bookmarks-tmp-yank-item (dvc-bookmarks-current-data))
  (let ((buffer-read-only nil))
    (dvc-ewoc-delete dvc-bookmarks-cookie (ewoc-locate dvc-bookmarks-cookie))))

(defun dvc-bookmarks-save ()
  "Save `dvc-bookmark-alist' to the file `dvc-bookmarks-file-name'."
  (interactive)
  (dvc-save-state '(dvc-bookmark-alist)
                  (dvc-config-file-full-path dvc-bookmarks-file-name t)
                  t))

(defun dvc-bookmarks-load-from-file (&optional force)
  "Load bookmarks from the file `dvc-bookmarks-file-name'.

If FORCE is non-nil, reload the file even if it was loaded before."
  (when (or force (not dvc-bookmarks-loaded))
    (dvc-load-state (dvc-config-file-full-path
                     dvc-bookmarks-file-name t))
    (setq dvc-bookmarks-loaded t)))


(defun dvc-bookmark-name-1 (entry &optional parent-name)
  (cond ((assoc 'children entry)
         (let ((names))
           (dolist (child (cdr (assoc 'children entry)))
             (add-to-list 'names (car (dvc-bookmark-name-1 child (car entry)))))
           names))
        (t
         (list (concat (if parent-name (concat  parent-name "/") "") (car entry))))))

(defun dvc-bookmark-names ()
  "Return a list with all dvc bookmark names."
  (let ((names))
    (dolist (entry dvc-bookmark-alist)
      (setq names (append names (dvc-bookmark-name-1 entry))))
    names))

(defun dvc-bookmark-goto-name (name)
  (let ((cur-pos (point))
        (name-list (split-string name "/"))
        (prefix ""))
    (goto-char (point-min))
    (dolist (name name-list)
      (setq name (concat prefix name))
      (setq prefix (concat "  " prefix))
      (search-forward name))
    (beginning-of-line-text)))

(defun dvc-bookmarks-jump ()
  (interactive)
  (dvc-bookmark-goto-name (dvc-completing-read "Jump to dvc bookmark: "
                                               (dvc-bookmark-names))))

(defun dvc-bookmarks-get-partners (&optional entry-data)
  (unless entry-data
    (setq entry-data (dvc-bookmarks-current-data)))
  (delete nil (mapcar '(lambda (e) (when (and (listp e) (eq (car e) 'partner)) (cadr e)))
                      entry-data)))

(defun dvc-bookmarks-add-partner ()
  (interactive)
  (let* ((cur-data (dvc-bookmarks-current-data))
         (partner-url (read-string (format "Add partner to '%s': " (car cur-data)))))
    (if (not (member partner-url (dvc-bookmarks-get-partners)))
        (progn
          (setcdr cur-data (append (cdr cur-data) (list (list 'partner partner-url))))
          (dvc-trace "dvc-bookmarks-add-partner %s" cur-data))
      (message "%s is already a partner for %s" partner-url (car cur-data)))))

(defun dvc-bookmarks-remove-partner ()
  (interactive)
  (let* ((cur-data (dvc-bookmarks-current-data))
         (partner-to-remove (dvc-completing-read
                             (format "Remove partner from %s: " (car cur-data))
                             (dvc-bookmarks-get-partners))))
    (delete (list 'partner partner-to-remove) cur-data)))

(defun dvc-bookmarks-toggle-partner-visibility ()
  (interactive)
  (setq dvc-bookmarks-show-partners (not dvc-bookmarks-show-partners))
  (dvc-bookmarks))

(defun dvc-bookmarks-partner-nickname (bookmark-entry partner-url)
  ;;(message "dvc-bookmarks-partner-nickname %S %s" bookmark-entry partner-url)
  (let ((nick-name))
    (dolist (e bookmark-entry)
      (when (and (listp e) (eq (car e) 'partner))
        (when (string= partner-url (cadr e))
          (when (eq (length e) 3)
            (setq nick-name (nth 2 e))))))
    nick-name))


(defun dvc-bookmarks-partner-at-point ()
  (save-excursion
    (let ((partner-url))
      (goto-char (line-beginning-position))
      (when (looking-at "  Partner \\(.+?\\)\\(  \\[.+\\)?$")
        (setq partner-url (match-string 1)))
      partner-url)))

(defun dvc-bookmarks-nickname-at-point ()
  (save-excursion
    (let ((nickname))
      (goto-char (line-beginning-position))
      (when (looking-at "  Partner \\(.+?\\)  \\[\\(.+\\)?\\]$")
        (setq nickname (match-string 2)))
      nickname)))

(defun dvc-bookmarks-add-nickname ()
  (interactive)
  ;;(message "dvc-bookmarks-add-nickname %S" (dvc-bookmarks-current-data))
  (let ((partner-at-point (dvc-bookmarks-partner-at-point)))
    (dolist (e (dvc-bookmarks-current-data))
      (when (and (listp e) (eq (car e) 'partner))
        (when (string= partner-at-point (cadr e))
          (if (= (length e) 2)
              (setcdr (nthcdr 1 e) (cons (read-string (format "Nickname for %s: " partner-at-point)) nil)) ;;(add-to-list 'e "Nickname" t)
            (setcar (nthcdr 2 e) (read-string (format "Nickname for %s: " partner-at-point) (nth 2 e))))
          (message "Added nickname %s to the partner %s" (nth 2 e) partner-at-point))))))

;; (dvc-bookmarks-load-from-file t)

(provide 'dvc-bookmarks)
;;; dvc-bookmarks.el ends here
