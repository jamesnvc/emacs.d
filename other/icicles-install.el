;;; icicles-install.el -- Download the Icicles Package
;;                        and optionally byte-compile it.
;;
;; This file is NOT part of Emacs
;;
;; Filename: icicles-install.el
;; Description: Download the Icicles Package
;; Author: Anupam Sengupta
;; Maintainer: Anupam Sengupta
;; Copyright (C) 2007 Anupam Sengupta, all rights reserved.
;; Created: Wed May 24 14:05:13 2007
;; Version: 1.0
;; Last-Updated: Fri Jun  1 22:57:45 2007 (-25200 MST)
;;           By: Anupam Sengupta
;;
;; URL: http://www.emacswiki.org/cgi-bin/wiki/icicles-install.el
;; Compatibility: GNU Emacs 20.x, GNU Emacs 21.x, GNU Emacs 22.x
;;
;; Features that might be required by this library:
;;
;;   `base64', `cl', `ietf-drums', `mail-parse', `mail-prsvr', `mailcap',
;;   `mm-util', `qp', `rfc2045', `rfc2047', `rfc2231', `time-date', `timezone',
;;   `url', `url-cookie', `url-expand', `url-history', `url-methods',
;;   `url-parse', `url-privacy', `url-proxy', `url-util', `url-vars'.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change log:
;;
;; 2007/08/16 dadams
;;     Mention updating load-path in step 4. Thx to Lars Bjornfot.
;; 2007/06/09 dadams
;;     Corrected Tom Tromey's name and URL.
;; 2007/06/07 dadams
;;     Added icicles-doc1.el and icicles-doc2.el.
;;     Clarified that only files that have been byte-compiled are byte-compiled.
;; 2007/06/02 AnupamSengupta
;;     Created.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Commentary:
;;
;; Download the Icicles code library from http://www.emacswiki.org and
;; optionally byte-compile the downloaded versions of any files that
;; were previously byte-compiled.
;;

;; Acknowledgements:
;;
;; Code based largely on the package.el install implementation by Tom Tromey.
;;
;; See: http://tromey.com/elpa/package-install.el
;; See: http://www.emacswiki.org/cgi-bin/wiki/TomTromey
;;

;; Usage:
;;
;; 1. Download this file to a convenient directory (e.g. ~/elisp)
;; 2. Add the following line in your .emacs file:
;;
;;      (load "~/<dirname>/icicles-install")
;;
;;    Adjust the directory name for your local download directory.
;;
;; 3. You need not restart Emacs. At end of the sexp, enter C-x C-e to load the
;;    file
;;
;; 4. Optional Step: You may want to customize the download directory (it
;;    defaults to "~/icicles") by running `customize-variable' on the
;;    `icicle-download-dir' variable. If you do this, be sure to also
;;    add the value of `icicle-download-dir' to variable `load-path'.
;;
;; 5. Run the command `icicle-download-wizard' from the mini-buffer:
;;      M-x icicle-download-wizard
;;

(require 'url nil t)                    ;If URL package is not present, will use
                                        ;wget instead

(eval-when-compile (require 'cl))       ;CL is needed for the dolist

;; Define the URL base from which the files should be downloaded.
;;
;;;###autoload
(defcustom icicle-archive-base
  "http://www.emacswiki.org/cgi-bin/wiki/download/"
  "*Base URL from which the Icicles files should be downloaded. This defaults to
the Emacs Wiki site."
  :type 'string :group 'Icicles-Miscellaneous)

;; Define the user directory to which the files should be downloaded to. This
;;defaults to ~/icicles
;;
;;;###autoload
(defcustom icicle-download-dir "~/icicles"
  "*Directory to which the Icicles files should be downloaded into."
  :type 'directory :group 'Icicles-Miscellaneous)

;; The List of files to download.
;;
;; The following files are optional, but provide additional functionality for
;; Icicles:
;;     1. icicles-menu.el
;;     2. icomplete+.el
;;     3. hexrgb.el
;;     4. synonyms.el
;;
;; The user may safely remove them from the download list without impacting core
;; Icicles functionality.
;;
;;;###autoload
(defcustom icicle-files-to-download-list
  (list
   "icicles.el"
   "icicles-doc1.el"
   "icicles-doc2.el"
   "icicles-cmd.el"
   "icicles-face.el"
   "icicles-fn.el"
   "icicles-mac.el"
   "icicles-mcmd.el"
   "icicles-mode.el"
   "icicles-opt.el"
   "icicles-var.el"
   "icicles-menu.el"
   "icomplete+.el"
   "hexrgb.el"
   "synonyms.el")
  "*The list of Icicles files to download.  The list needs to be modified if
additional files are added to the package.

The following files in the list are not strictly required - but
provide additional functionality to Icicles:
     1. icicles-menu.el
     2. icomplete+.el
     3. hexrgb.el
     4. synonyms.el

You may safely remove these files from the download list without impacting core
  Icicles functionality."
  :type '(repeat file) :group 'Icicles-Miscellaneous)

;; Downloads a file from the specified URL and returns the download buffer.
;;
;; Uses wget if the URL package is not available.
;;;###autoload
(defun icicle-download-file (url)                ; Define the download function
  "Download the file from the specified URL and return the download buffer."
  (if (fboundp 'url-retrieve-synchronously)
      ;; If available, Use URL to download.
      (let ((buffer (url-retrieve-synchronously url)))
        (save-excursion
          (set-buffer buffer)
          (goto-char (point-min))
          (re-search-forward "^$" nil 'move)
          (forward-char)
          (delete-region (point-min) (point))
          buffer))
    ;; Else use wget to download

    (with-current-buffer
        (get-buffer-create
         (generate-new-buffer-name " *Download*"))
      (shell-command (concat "wget -q -O- " url)
                     (current-buffer))
      (goto-char (point-min))
      (current-buffer))))

;; Download and save the file.
;;
;;;###autoload
(defun icicle-download-and-save-file (file-to-download)
  "*Download and save the file from the specified URL."
  (let ((pkg-buffer
         (icicle-download-file
          (concat icicle-archive-base file-to-download))))
    ;; Save the downloaded buffer contents in the file
    (save-excursion
      (set-buffer pkg-buffer)
      (setq buffer-file-name
            (concat (file-name-as-directory icicle-download-dir)
                    file-to-download))
      (save-buffer)
      (kill-buffer pkg-buffer)
      (message "Downloaded %s" file-to-download))))

;; Download all files in turn.
;;
;;;###autoload
(defun icicle-download-all-files ()
  "*Download all the files and save the files.  Also create the download
directory if it does not exist."

  (dolist (file-to-download icicle-files-to-download-list t)

    (icicle-download-and-save-file file-to-download)
    ;; Sleep to prevent overloading the site
    (sleep-for 2)))

;; Byte-compile all files in `icicle-download-dir' that have been byte-compiled.
;;
;;;###autoload
(defun icicle-byte-compile-downloaded-files ()
  "Byte-compile the downloaded lisp files."
  (byte-recompile-directory icicle-download-dir 0))

;; Wizard for downloading the files.
;;
;;;###autoload
(defun icicle-download-wizard ()
  "Runs the interactive wizard for downloading the icicle files."
  (interactive)
  (if (y-or-n-p "Download the Icicle files? ")
      (progn
        (make-directory icicle-download-dir t) ;Make Directory if not present.

        (icicle-download-all-files)
        (message "Icicles Download completed.")

        (if (y-or-n-p "Byte Compile the files? ")
            (icicle-byte-compile-downloaded-files)
          (message "Byte-compiled the Icicles files."))

        (if (y-or-n-p "Show the Icicle files? ")
            (dired-other-frame icicle-download-dir))

        (message "Icicles download complete."))

    (message "Icicles download cancelled.")))

(provide 'icicles-install)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Icicle-install ends here.
