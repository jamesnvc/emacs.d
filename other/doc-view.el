;;; doc-view.el --- View PDF/PostScript/DVI files in Emacs

;; Copyright (C) 2007 Tassilo Horn
;;
;; Author: Tassilo Horn <tassilo@member.fsf.org>
;; Homepage: http://www.tsdh.de
;; Version: <2007-08-22 Wed 21:43>

;; This  program is free  software; you  can redistribute  it and/or  modify it
;; under the terms  of the GNU General Public License as  published by the Free
;; Software  Foundation;  either version  3,  or  (at  your option)  any  later
;; version.
;;
;; This program is distributed in the  hope that it will be useful, but WITHOUT
;; ANY  WARRANTY;  without even  the  implied  warranty  of MERCHANTABILITY  or
;; FITNESS FOR  A PARTICULAR PURPOSE.  See  the GNU General  Public License for
;; more details.
;;
;; You should have received a copy of the GNU General Public License along with
;; this program; if not, write to  the Free Software Foundation, Inc., 675 Mass
;; Ave, Cambridge, MA 02139, USA.

;;; Requirements:

;; I tested in on GNU Emacs 22, but maybe it works with older emacsen or
;; XEmacs, too.  You need ImageMagick's convert tool.

;;; Commentary:

;; DocView is a  document viewer for Emacs.  It converts PDF,  PS and DVI files
;; to a set  of PNG files, one PNG  for each page, and displays  the PNG images
;; inside  an Emacs buffer.   This buffer  uses `doc-view-mode'  which provides
;; convenient key bindings for browsing the document.
;;
;; To use it simply do
;;
;;     M-x doc-view RET
;;
;; and you'll be queried for a document to open.
;;
;; Since  conversion may take  some time  all the  PNG images  are cached  in a
;; subdirectory of `doc-view-cache-directory' and  reused when you want to view
;; that  file again.   This  reusing can  be  omitted if  you  provide a  prefx
;; argument    to   `doc-view'.     To    delete   all    cached   files    use
;; `doc-view-clear-cache'.  To open the cache  with dired, so that you can tidy
;; it out use `doc-view-dired-cache'.

;;; Code:

(require 'dired)

(defgroup doc-view
  nil
  "In-buffer viewer for PDF, PostScript and DVI files.")

(defcustom doc-view-converter-program "convert"
  "Program to convert doc files to png."
  :type '(file)
  :group 'doc-view)

(defcustom doc-view-cache-directory "/tmp/doc-view"
  "The base directory, where the PNG imoges will be saved."
  :type '(directory)
  :group 'doc-view)

(defcustom doc-view-display-size 114
  "The DPI your screen supports.
This value determinate how big the resulting PNG images are.  If
the value is too small, reading might become hard.  If it's too
big, the images won't fit into an Emacs buffer.  Fiddle with it!"
  :type '(integer)
  :group 'doc-view)

(defcustom doc-view-display-margin 5
  "The width of the margin put around the page's image."
  :type '(integer)
  :group 'doc-view)

(defvar doc-view-current-files nil
  "Only used internally.")

(defvar doc-view-current-page nil
  "Only used internally.")

(defvar doc-view-current-dir nil
  "Only used internally.")

(defvar doc-view-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-v") 'doc-view-next-page)
    (define-key map (kbd "M-v") 'doc-view-previous-page)
    (define-key map (kbd "M-<") 'doc-view-first-page)
    (define-key map (kbd "M->") 'doc-view-last-page)
    (define-key map (kbd "g")   'doc-view-goto-page)
    (define-key map (kbd "k")   'doc-view-kill-buffer)
    (define-key map (kbd "q")   'bury-buffer)
    (suppress-keymap map)
    map)
  "Keymap used by `doc-view-mode'.")

(defun doc-view-kill-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun doc-view-goto-page (arg)
  "View the page given by ARG.
DocView numbers pages starting with zero!"
  (interactive "nPage: ")
  (doc-view-display-image (nth arg doc-view-current-files))
  (setq doc-view-current-page arg))

(defun doc-view-next-page (arg)
  "Browse ARG pages forward."
  (interactive "p")
  (let ((page (+ doc-view-current-page arg)))
    (if (< page 0)
        (setq page 0)
      (when (>= page (length doc-view-current-files))
        (setq page (1- (length doc-view-current-files)))))
    (doc-view-goto-page page)))

(defun doc-view-previous-page (arg)
  "Browse ARG pages backward."
  (interactive "p")
  (doc-view-next-page (* -1 arg)))

(defun doc-view-first-page ()
  "View the first page."
  (interactive)
  (doc-view-goto-page 0))

(defun doc-view-last-page ()
  "View the last page."
  (interactive)
  (doc-view-goto-page (1- (length doc-view-current-files))))

(defun doc-view-file-name-to-directory-name (file)
  "Return the directory where the png files of FILE should be saved.

It'a a subdirectory of `doc-view-cache-directory'."
  (concat (directory-file-name doc-view-cache-directory)
          "/"
          (replace-regexp-in-string "/" "!" file)))

(defun doc-view-convert-file (file)
  "Convert FILE to a set of png files, one file per page.

Those files are saved in the directory given by
`doc-view-file-name-to-directory-name'.

Returns the converter process."
  (clear-image-cache)
  (let* ((dir (doc-view-file-name-to-directory-name file))
         (png-file (concat dir "/" "page.png")))
    (when (file-exists-p dir)
      (dired-delete-file dir 'always))
    (make-directory dir t)
    (start-process "doc-view-convert" "*doc-view conversion output*"
                   doc-view-converter-program
                   "-density"  (format "%d" doc-view-display-size)
                   file
                   "-strip" "-trim"
                   png-file)))

(defun doc-view-sort (a b)
  "Return non-nil if A should be sorted before B.
Predicate for sorting `doc-view-current-files'."
  (if (< (length a) (length b))
      t
    (if (> (length a) (length b))
        nil
      (string< a b))))

(define-derived-mode doc-view-mode nil "DocView"
  "Major mode in DocView buffers.

\\{doc-view-mode-map}"
  :group 'doc-view
  (setq buffer-read-only t)
  (make-local-variable 'doc-view-current-files)
  (make-local-variable 'doc-view-current-page))

(defun doc-view-display-image (file)
  "Display the given png FILE."
  (setq buffer-read-only nil)
  (erase-buffer)
  (let ((image (create-image file 'png nil
                             :margin doc-view-display-margin)))
    (insert-image image))
  (setq buffer-read-only t))

(defun doc-view-display (dir)
  "Start viewing the document whose pages are png files in DIR."
  (let ((buffer (generate-new-buffer "*DocView*")))
    (switch-to-buffer buffer)
    (doc-view-mode)
    (setq doc-view-current-files
          (sort (directory-files dir t "page-[0-9]+\\.png" t)
                'doc-view-sort))
    (doc-view-goto-page 0)))

(defun doc-view (no-cache)
  "Query for a document, convert it to png and start viewing it.
If this file is still in the cache, don't convert and use the
existing page files.  With prefix arg NO-CACHE, don't use the
cached files and convert anew."
  (interactive "P")
  (if (and (image-type-available-p 'png)
           (display-images-p))
      (let* ((file (expand-file-name
                    (read-file-name "File: " nil nil t)))
             (dir (doc-view-file-name-to-directory-name file)))
        (setq doc-view-current-dir dir)
        (if (and (file-exists-p dir)
                 (not no-cache))
            (progn
              (message "DocView: using cached files!")
              (doc-view-display dir))
          (message "DocView: starting conversion!")
          (set-process-sentinel (doc-view-convert-file file)
                                '(lambda (proc event)
                                   (message "DocView: finished conversion!")
                                   (doc-view-display doc-view-current-dir)))))
    (message "DocView: your emacs or display doesn't support png images.")))

(defun doc-view-clear-cache ()
  "Delete the whole cache (`doc-view-cache-directory')."
  (interactive)
  (dired-delete-file doc-view-cache-directory 'always)
  (make-directory doc-view-cache-directory))

(defun doc-view-dired-cache ()
  "Open `dired' for `doc-view-cache-directory'."
  (interactive)
  (dired doc-view-cache-directory))

(provide 'doc-view)

;;; doc-view.el ends here
