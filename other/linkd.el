;;; linkd.el --- make hypertext with active links in any buffer
;;                     
;; Copyright (C) 2007  David O'Toole

;; Author: David O'Toole <dto@gnu.org>
;; Additional code by Eduardo Ochs <eduardoochs@gmail.com>
;; Keywords: hypermedia
;; Version: $Id: linkd.el,v 1.63 2007/05/19 00:16:17 dto Exp dto $
;; Package-Version: 0.8
;; Website: http://dto.freeshell.org/notebook/

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

;; This file is not part of GNU Emacs. 

;;; Commentary: 

;; (@* "Overview")
;; 
;; Linkd-mode is a system for the automatic recognition and
;; processing of certain S-expressions, called ``links'', embedded in
;; plain text files.  These links may be activated (or ``followed'')
;; by invoking certain interactive functions while point is on the
;; link. The links may also be interpreted as marking up the
;; surrounding text. Different types of links have different behaviors
;; when followed, and may have different interpretations as markup.
;;
;; With linkd-mode, the user may: 
;; \begin{enumerate}
;; \item Embed hyperlinks to files, webpages, or documentation into 
;; any type of text file in any major mode. 
;; \item Delimit and name regions of text called ``blocks'' in these text files. 
;; See (@> "Stars")
;; \item Extract and send such blocks to other programs for processing.
;; See (@> "Processing blocks")
;; \item Identify and mark locations and concepts in source code, via ``tags.''
;; See (@> "Tags")
;; \item Embed active data objects called ``datablocks''into text files.
;; See (@> "Datablocks")
;; \item Convert lisp source code listings into LaTeX for publication.
;; See (@> "Literate programming")
;; \item Define new link behaviors easily and simply.
;; \end{enumerate}
;; For detailed instructions on using linkd-mode, the reader may refer
;; to the online
;; manual.\footnote{http://dto.freeshell.org/notebook/Linkd.html}

;;; Code:

;; (@* "Required libraries")
;;
;; I use some idioms from Common Lisp, and a feature of Emacs that
;; makes it easier to define minor modes.

(require 'cl)
(require 'easy-mmode)

;; (@* "Recognizing links")
;; 
;; In working with Emacs' font-lock code to obtain automatic
;; recognition of a construct, one typically uses a regular expression
;; to match the construct. But recall that we are looking to match
;; S-expressions, which cannot be matched by any regular
;; expression. To overcome this difficulty, we can supply font-lock
;; with a function to perform the search, instead of a regular
;; expression. If this function uses the system's built-in Lisp
;; reader, we can then match proper S-expressions.
;;
;; Below is a function that Emacs' font-locking can use to find and
;; highlight links. See (@> "Fontlocking") below.

(defun linkd-match (limit)
  "Attempt to read link sexp between point and LIMIT, returning
non-nil if a link is found. Sets the match-data appropriately."
   (let ((sexp nil))
     (when (search-forward (concat "(" "@") limit t)
       (backward-char 2))
     (let ((begin-point (point)))
       (condition-case nil
	   (setf sexp (read (current-buffer)))
	 ((error nil)))
       (when (string-match "@.*" (symbol-name (car-safe sexp)))
	 (let ((begin-marker (make-marker))
	       (end-marker (make-marker)))
	   (set-marker begin-marker begin-point)
	   (set-marker end-marker (point))
	   (set-match-data (list begin-marker end-marker)))
	 t))))
		      
;; We will sometimes also make use of a regexp to find links.

(defvar linkd-generic-regexp (concat "\(" "@" "[^)]*\)"))

;; Next we have a function to extract link data from plain
;; text. Notice that it determines the presence of a link by searching
;; for a text property called {\it linkd}, instead of using the
;; regular expression given above. This is because of the way link
;; rendering works.  When the activation of linkd-mode triggers
;; fontification of a buffer containing links, the links are
;; matched by the font-locking code, and marked with the {\it
;; linkd} text property at that time. Then all the other functions
;; that deal with links can use the {\it linkd} text property, which
;; is simpler than using regexps throughout.
;;  See (@> "Rendering links with overlays") 
;; and (@> "Fontlocking").

(defun linkd-link-at-point ()
  "Get the link around point and return it as a sexp, or nil if
not found."
  (if (get-char-property (point) 'linkd)
      (save-excursion
	(read (current-buffer)))))
    
;; (@* "Following links")
;;
;; Recall that each link is an S-expression. When this S-expression is
;; evaluated, the result is a property list whose keys represent
;; possible user actions, whereas the values are functions to be
;; invoked when the corresponding key is chosen. So to follow a link,
;; we evaluate the link S-expression and invoke the function
;; corresponding to the property {\tt :follow} in the resulting
;; property list.
;;
;; As the results of following a link will often change the currently
;; displayed buffer, we remember which is the current buffer before
;; switching, and provide a function {\tt linkd-back} to return to the
;; old buffer.
  
(defvar linkd-previous-buffer nil "Last buffer being shown.")

(defvar linkd-previous-point nil "Value of point before link following.")

(defun linkd-follow (sexp)
  "Follow the link represented by SEXP."
  (let* ((plist (eval sexp))
	 (follower (plist-get plist :follow)))
    (when follower
      ;; 
      ;; save current spot so that we can go back if needed
      (setq linkd-previous-buffer (current-buffer))
      (setq linkd-previous-point (point))
      (funcall follower))))
  
(defun linkd-back ()
  "Return to the buffer being viewed before the last link was followed."
  (interactive)
  (when linkd-previous-buffer 
    (switch-to-buffer linkd-previous-buffer)
    (goto-char linkd-previous-point)))

(defun linkd-follow-at-point ()
  "Follow the link at point."
  (interactive)
  (linkd-follow (linkd-link-at-point)))

(defun linkd-follow-mouse (event)
  "Follow the clicked link."
  (interactive "e")
  (when event
    (let ((pos (posn-point (car (cdr event)))))
      (goto-char pos)
      (linkd-follow (linkd-link-at-point)))))

;; (@* "Navigating links")
;;
;; Instead of manually positioning point on each link, we can navigate
;; directly between links. The following interactive functions jump
;; from link to link.

(defun linkd-next-link ()
  "Move point to the next link, if any."
  (interactive)
  (forward-char 1)
  (let ((inhibit-point-motion-hooks nil))
    ;;
    ;; get out of the current overlay if needed
    (when (get-char-property (point) 'linkd)
      (while (and (not (eobp))
		  (get-char-property (point) 'linkd))
	(goto-char (min (next-overlay-change (point))
			(next-single-char-property-change (point) 'linkd)))))
    ;;
    ;; now find the next linkd overlay
    (while (and (not (eobp))
		(not (get-char-property (point) 'linkd)))
      (goto-char (min (next-overlay-change (point))
		      (next-single-char-property-change (point) 'linkd))))))

(defun linkd-previous-link ()
  "Move point to the previous link, if any."
  (interactive)
  (let ((inhibit-point-motion-hooks nil))
    ;;
    ;; get out of the current overlay if needed
    (when (get-char-property (point) 'linkd)
      (while (and (not (bobp))
		  (get-char-property (point) 'linkd))
	(goto-char (max (previous-overlay-change (point))
			(previous-single-char-property-change (point) 'linkd)))))
    ;;
    ;; now find the previous linkd overlay
    (while (and (not (bobp))
		(not (get-char-property (point) 'linkd)))
      (goto-char (max (previous-overlay-change (point))
		      (previous-single-char-property-change (point) 'linkd))))))
  
;; (@* "Inserting and editing links interactively")
;;
;; It is not necessary to type the links manually. With these
;; functions, the user may create and edit links interactively.

(defun linkd-insert-single-arg-link (type-string argument)
  (insert (if (not (string= "" argument))
	    (format (concat "(" "@%s %S)") type-string argument)
	    (format (concat "(" "@%s)") type-string))))

(defun linkd-insert-tag (tag-name)
  (interactive "sTag name: ")
  (linkd-insert-single-arg-link ">" tag-name)) 

(defun linkd-insert-star (star-name)
  (interactive "sStar name: ")
  (linkd-insert-single-arg-link "*" star-name)) 

(defun linkd-insert-wiki (wiki-name)
  (interactive "sWiki page: ")
  (linkd-insert-single-arg-link "!" wiki-name))

(defun linkd-insert-lisp (sexp)
  (interactive "xLisp expression: ")
  (linkd-insert-single-arg-link "L" sexp))

(defvar linkd-insertion-schemes '(("file" :file-name :to :display)
				  ("man" :page :to :display)
				  ("info" :file-name :node :to :display)
				  ("url" :file-name :display)))

(defun linkd-insert-link (&optional type current-values)
  (interactive)
  (let* ((type (or type (completing-read "Link type: " linkd-insertion-schemes)))
	 (keys (cdr (assoc type linkd-insertion-schemes)))
	 (key (car keys))
	 (link-args nil))
    (while key
      ;;
      ;; read an argument value
      (let ((value (read-from-minibuffer (format "%S " key)
					 (plist-get current-values key))))
	(when (not (string= "" value))
	  (setq link-args (plist-put link-args key value))))
      ;;
      ;; next
      (setq keys (cdr keys))
      (setq key (car keys)))
    ;;
    ;; format and insert the link
    (insert (format (concat "(" "@%s %s)")
		    type
		    (mapconcat (lambda (sexp)
				 (format "%S" sexp))
			       link-args
			       " ")))))

(defun linkd-edit-link-at-point ()
  (interactive)
  (let ((link (linkd-link-at-point)))
    (when link
      (if (keywordp (car (cdr link)))
	  ;;
	  ;; it's a general link
	  (save-excursion	
	    (linkd-insert-link 
	     ;; drop the @ sign
	     (substring (format "%S" (car link)) 1)
	     (cdr link)))
	;;
	;; it's a single-arg link
	(let ((new-value (read-from-minibuffer "New value: " (car (cdr link)))))
	  (insert (format "%S" (list (car link) new-value)))))
      ;;
      ;; now erase old link
      (re-search-backward linkd-generic-regexp)
      (delete-region (match-beginning 0) (match-end 0)))))

;; (@* "Rendering links with overlays")
;;
;; Emacs' overlays allow us to render a link onscreen in ways that make
;; the meaning of the link clearer. We can do this by hiding the somewhat
;; ugly link syntax, color-coding the text, and optionally by
;; displaying graphical icons to help in determining the type of link.
;;
;; This is one of the trickiest parts of linkd-mode, as the use of
;; overlays requires attention to detail in order for things to work
;; right.
;;
;; First some preliminary definitions.

(defvar linkd-default-bullet-string ">>>")

(defun linkd-insert (string)
  (insert (substring-no-properties string)))

;; We may also attach keybindings to an overlay, so that the
;; keybindings are in effect whenever point is within the overlay.
;; For rapid navigation, we will eventually attach some quick
;; single-character commands to the links, using the following keymap: 

(defvar linkd-overlay-map nil)
(when (null linkd-overlay-map)
  (setq linkd-overlay-map (make-sparse-keymap))
  (define-key linkd-overlay-map (kbd "RET") 'linkd-follow-at-point)
  (define-key linkd-overlay-map (kbd "[") 'linkd-previous-link)
  (define-key linkd-overlay-map (kbd "]") 'linkd-next-link))

;; The following utility function is our standard way of applying
;; linkd-style overlays to the text of a link.

(defun linkd-overlay (beg end display-text 
			  &optional display-face 
			  bullet-text bullet-face bullet-icon)
  (let ((overlay (make-overlay beg end)))
    (overlay-put overlay 
		 'display 
		 (propertize display-text 
			     'face 
			     (or display-face linkd-generic-name-face)))
    ;;
    ;; mark the overlay so that we can find it later
    ;;
    (overlay-put overlay 'linkd t)
    ;;
    ;; add speed-navigation keys
    (overlay-put overlay 'keymap linkd-overlay-map)
    ;; 
    ;; add a bullet, if any
    (when bullet-text
      (let* ((face (if (and bullet-icon linkd-use-icons)
		       linkd-icon-face
		     bullet-face))
	     (b1 (if face
		     (propertize bullet-text 'face face)
		   bullet-text))
	     (b2 (if (and bullet-icon linkd-use-icons)
		     (propertize b1 'display `(image :file ,bullet-icon
						     :type xpm
						     :ascent center))
		   b1)))
	(overlay-put overlay 'before-string (concat b2 " "))))
    ;;
    (overlay-put overlay 'evaporate t)
    ;;
    ;; defontify if the user edits the text
    (overlay-put overlay 'modification-hooks 
		 (list (lambda (ov foo beg end &rest ignore)
			 (delete-overlay ov)
			 (remove-text-properties (point-at-bol) (point-at-eol)
						 (list 'fontified nil
						       'linkd-fontified nil
						       'linkd nil)))))))

;; (@* "Decorating links with graphical icons")					     
;;
;; I have drawn a set of 16x16 icons for use with linkd-mode. When the
;; icon feature is enabled, an appropriate icon is displayed to the
;; left of the link.
;;
;; The icons may be downloaded from http://dto.freeshell.org/packages/linkd-icons.tar.gz

(defvar linkd-use-icons nil 
"When non-nil, icons are displayed for links instead of text bullets.")

(defvar linkd-icons-directory "~/.linkd-icons" 
"Directory where linkd's icons are kept.")

(defun linkd-icon (icon-name)
  (concat (file-name-as-directory linkd-icons-directory) "linkd-" icon-name ".xpm"))

(defun linkd-file-icon (file-name)
  "Choose an appropriate icon for FILE-NAME based on the name or extension.
Returns the file-name to the icon image file."
  (let* ((dir (file-name-as-directory linkd-icons-directory))
	 (icon (concat dir "linkd-file-" (file-name-extension file-name) ".xpm")))
    (if (file-exists-p icon)
	icon
      (concat dir "linkd-file-generic.xpm"))))

;; (@* "Stars")
;; 
;; Stars delimit (and optionally name) blocks of text. A block of text
;; is the region between one star and the next. We may think of blocks
;; as dividing a text file into sections.

(defun @* (&optional star-name)
  `(:follow
    (lambda ()
      (linkd-find-next-tag-or-star ,star-name))
    :render
    (lambda (beg end)
      (linkd-overlay beg end 
		     ,(if star-name 
			 star-name
		       " ") ;; leave a space so that fontified link doesn't disappear
		     ',(if star-name
			   linkd-star-name-face
			 'default)
		     "*" linkd-star-face ,(linkd-icon "star")))))

;; (@* "Tags")
;;
;; Tags may be used to navigate within source code. As the concepts
;; expressed in a program naturally relate to one another, one may
;; mark those parts of a program that relate to a given concept with a
;; special link called a {\it tag} which names the concept.
;;
;; Following a tag link navigates to the next tag (or star) with the
;; same name, cycling to the beginning of the buffer when the end is
;; reached. So one may think of following tag links as tracing a
;; concept through different parts of a program by jumping between
;; related pieces of code.

(defun linkd-find-next-tag-or-star (name)
  (let* ((regexp (concat "\(\@\\(\*\\|>\\) \"" name))
	 (found-position 
	  (save-excursion
	    (goto-char (point-at-eol))
	    (if (re-search-forward regexp nil t)
		(match-beginning 0)
	      ;;
	      ;; start over at the beginning of the buffer
	      (goto-char (point-min))
	      (when (re-search-forward regexp nil t)
		(match-beginning 0))))))
    (when found-position
      (goto-char found-position))))
  
(defun @> (tag-name)
  `(:follow
    (lambda ()
      (linkd-find-next-tag-or-star ,tag-name))
    :render
    (lambda (beg end)
      (linkd-overlay beg end ,tag-name linkd-tag-name-face
		     ">" linkd-tag-face ,(linkd-icon "tag")))))

;; (@* "Processing blocks")
;;
;; Sometimes we wish to divide a text file into sections using stars,
;; and then selectively process certain of those blocks of
;; text---perhaps with an external program. We can use this facility
;; to experiment with such external programs or to develop interactive
;; scripts. For example, we can send a block of shell-script commands
;; to a shell window for immediate execution.
;;
;; The operation to be performed is determined by the value of the
;; buffer-local variable ``linkd-process-block-function.'' This may
;; be set to an appropriate value in a file's Local Variables section. 

(defvar linkd-star-search-string (concat "\(" "\@\*"))

(defun linkd-block-around-point () 
  "Return the block around point as a string."
  (interactive)
  (let ((beg (save-excursion 
	       (search-backward linkd-star-search-string)
	       (beginning-of-line)
	       (point)))
	(end (save-excursion
	       (search-forward linkd-star-search-string)
	       (point))))
    (buffer-substring-no-properties beg end)))

(defvar linkd-block-file-name "~/.linkd-block" 
"File where temporary block text is stored for processing by
external programs.")

(defun linkd-write-block-to-file (block-text)
  "Write the BLOCK-TEXT to the file named by linkd-block-file-name."
  (interactive)
  (with-temp-buffer 
    (insert block-text)
    (write-file linkd-block-file-name)))

(defvar linkd-process-block-function nil 
"This function is called with the contents of the block around
point as a string whenever (linkd-process-block) is called. You
can set this in the Local Variables section of a file.")

(make-variable-buffer-local 'linkd-process-block-function)

(defun linkd-process-block ()
  (interactive)
  (funcall linkd-process-block-function (linkd-block-around-point)))
	       
(defvar linkd-shell-buffer-name "*linkd shell*")

(defun linkd-send-block-to-shell (block-text)
  (interactive)
  (when (not (get-buffer-window linkd-shell-buffer-name))
    ;;
    ;; create shell if needed, but not in current window
    (save-window-excursion (shell linkd-shell-buffer-name))
    (display-buffer linkd-shell-buffer-name))
  ;;
  (linkd-write-block-to-file block-text)
  (save-selected-window
    (select-window (get-buffer-window linkd-shell-buffer-name))
    (end-of-buffer)
    ;;
    ;; make the shell source the temp file
    (insert (concat ". " linkd-block-file-name))
    (call-interactively (key-binding "\r"))))

;; (@* "Datablocks")
;;
;; ``Datablocks'' are embedded objects of a user-defined type.  A
;; datablock consists of a {\it type symbol} followed by a printed
;; representation of a lisp object called the {\it embedded object.}
;; The type symbol is a symbol whose function-value determines the
;; appearance and behavior of the region of the buffer containing the
;; embedded object. By convention, a type symbol's name begins with a caret. 
;;
;; When a datablock is {\it activated}, the embedded object is read
;; from the buffer and fed to the type symbol's function. This
;; function may temporarily replace the region with an interactive
;; representation of the embedded object, which may then be
;; manipulated by the user. The behavior of this representation may be
;; effected by various uses of Emacs' text properties.
;;
;; When a datablock is {\it deactivated}, the interface is replaced
;; with a plain-text representation of the new embedded object. One
;; can arrange for the automatic activation and deactivation of
;; datablocks, particularly upon saving and loading files that contain
;; them. 
;;
;; Firstly, datablocks must be activated on a per-file basis via a
;; Local Variables section in the file.

(defun linkd-use-datablocks nil "When non-nil, use datablocks in
the current buffer.")

(make-variable-buffer-local 'linkd-use-datablocks)

;; Now we need a function to extract the embedded object at point. 

(defun linkd-datablock-object-at-point ()
  (get-text-property (point) 'linkd-datablock-object))

;; A function to insert a template datablock. This is what you use to
;; create new datablocks with specified contents.

(defun linkd-insert-datablock-template (&optional object)
  "Insert a new datablock with OBJECT as the printed contents."
      (insert (format "(^begin ^cell)\n%S\n(^end)" object)))

;; This function governs the interaction of linkd-mode's datablock
;; system with the ``modules'' that implement various types of
;; embedded objects. First the type symbol and embedded object are
;; read in from the text. The function value of the module's type
;; symbol is obtained, and the embedded object is fed to the function
;; in order to activate or deactivate the datablock as needed. The
;; function is also passed some markers that delimit the region to
;; which the module should confine its rendering activity.

(defun linkd-activate-datablock (action)
  "When ACTION is :begin, activate the current datablock. When
ACTION is :end, deactivate the datablock."
  (interactive)
  (when (search-forward (concat "(^" "begin ") nil t)
    ;;
    ;; first read in the datablock 
    (let* ((type-symbol (read (current-buffer)))
	   (datablock-begin (match-beginning 0))
	   (datablock-object (progn (forward-line)
				   (read (current-buffer))))
	   (datablock-end (progn (search-forward "(^end)")
				 (match-end 0)))
	   (activate (symbol-function type-symbol)))
      (goto-char datablock-begin)
      (case action
	(:begin 
	 ;;
	 ;; insert markers; datablock display happens in between them
	 (let* ((inhibit-read-only t)
		(beg (make-marker))
		(end (make-marker)))
	   (set-marker beg (save-excursion
			     (goto-char datablock-begin)
			     (point-at-eol)))
	   (set-marker end (save-excursion
			     (goto-char datablock-end)
			     (point-at-bol)))
	   ;;
	   ;; make the delimiters invisible
	   (add-text-properties datablock-begin beg
				'(invisible t))
	   (add-text-properties end datablock-end
				'(invisible t))
	   ;;
	   ;; start the datablock going, tell it what region it is to manage
	   (let ((object (funcall activate :begin datablock-object beg end)))
	     (when (null object)
	       (error "Null object."))
	     ;;
	     ;; save datablock details for later lookup
	     (add-text-properties beg end (list 'linkd-datablock-object 
						object)))
	   ;;
	   ;; move into the region
	   (goto-char (+ 1 datablock-begin))
	   (message "%S" (linkd-datablock-object-at-point)))
	;;
	;; stop managing the region and write the sexp back
	(:end 
	 (forward-line)
	 (let ((object (funcall activate :end datablock-object))
	       (inhibit-read-only t)
	       (inhibit-point-motion-hooks t))
	   (delete-region datablock-begin datablock-end)
	   (insert (format (concat "(^" "begin %S)\n%S\n(^end)") type-symbol object))))))))

(defun linkd-begin-datablock ()
  (linkd-activate-datablock :begin))

(defun linkd-end-datablock ()
  (linkd-activate-datablock :end))

(defun linkd-escape-datablock ()
  (interactive) 
  (search-backward (concat "(" "^begin "))
  (forward-line -1))

(defvar linkd-datablocks-activated nil "When non-nil, datablocks
are activated.")

(make-variable-buffer-local 'linkd-datablocks-activated)

(defun linkd-activate-all-datablocks ()
  (interactive)
  (when (and linkd-use-datablocks (not linkd-datablocks-activated))
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
	(linkd-begin-datablock)
	(forward-line))
      (setf linkd-datablocks-activated t))))
  
(defun linkd-deactivate-all-datablocks ()
  (interactive)
  (when (and linkd-use-datablocks linkd-datablocks-activated)
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
	(linkd-end-datablock)
	(forward-line))
      (setf linkd-datablocks-activated nil))))

;; (@* "Exporting to other formats")
;;
;; Linkd supports export to LaTeX and HTML. What follows are some
;; functions and variables basic to the export process.

(defvar linkd-export-heading-regexp (concat "(" "@\\* \"\\([^\"]*\\)\")")
  "Regexp to match section headings in the buffer.")

(defvar linkd-export-commentary-regexp "^;;" "Regexp to match commentary lines in a buffer."))

(defvar linkd-export-link-regexp (concat "(" "@" ".*)$") "Regexp
to match links.  Of course no regexp can correctly regcognize
matched parentheses. But our links are always on a single line,
so we can sort of make it work.")

(defvar linkd-export-formats '(("html" . linkd-html-export)
			      ("tex" . linkd-latex-export)))

(defun linkd-export (export-function output-file-name)
  "Export the current-buffer using EXPORT-FUNCTION and write
  output to OUTPUT-FILE-NAME. EXPORT-FUNCTION should convert to
  the output format, do any required postprocessing, and return
  the buffer with the ouput."
  (with-current-buffer (funcall export-function)
    (write-file (expand-file-name output-file-name))))

(defun linkd-export-default ()
  "Export the current buffer with default settings to all available formats."
  (interactive)
  (dolist (format linkd-export-formats)
    (let* ((extension (car format))
	   (output-file (concat (buffer-file-name) "." extension))
	   (export-function (cdr format)))
      (linkd-export export-function output-file))))

;; (@* "Exporting to LaTeX")
;; 
;; This section contains routines to transform our Lisp source code
;; files into beautiful LaTeX documents in (roughly) the style of
;; Donald Knuth's "Literate Programming." To take advantage of this
;; feature, the source code to be transformed should contain
;; alternating regions of commentary and code, with appropriate star
;; headings to group these regions into document sections. The
;; interactive function {\tt linkd-latex-render} transforms the
;; source code in a temporary buffer and writes the result to a
;; corresponding LaTeX file. Where tags appear in commentary, they are
;; prettified in the LaTeX output.
;; 
;; The purist may object that ``true'' literate programming requires a
;; tool capable of re-sequencing code fragments and performing macro
;; expansion, neither of which are implemented here. In response to
;; this objection I would point out the following: {\it (i)} there is
;; little need for re-sequencing in a language like Lisp, where
;; declarations may be ordered more or less as one pleases; {\it (ii)}
;; Lisp already has a powerful macro expansion facility; and {\it
;; (iii)} there is no reason why a system that deviates somewhat from
;; the traditionally accepted definition of ``literate programming''
;; should not still contribute to the writing of better programs.
;;
;;  The {\tt fancyvrb} package is required.

(defvar linkd-latex-in-verbatim nil)

(defun linkd-latex-begin-verbatim ()	
  (setf linkd-latex-in-verbatim t)
  (insert (concat "\\" "begin{Verbatim}[fontsize=\\small]\n")))

(defun linkd-latex-end-verbatim ()	
  (setf linkd-latex-in-verbatim nil)
  (insert (concat "\\" "end{Verbatim}\n")))

(defun linkd-latex-do-section (title)
  (insert (format "\\section{%s}\n" title)))

(defun linkd-latex-toggle-verbatim ()
  (if linkd-latex-in-verbatim
      (linkd-latex-end-verbatim)
    (linkd-latex-begin-verbatim)))

(defun linkd-latex-export ()
  "Render a buffer as a LaTeX book chapter."
  (interactive)
  (let* ((output-buffer (get-buffer-create "*linkd-litprog*"))
	 (source-buffer (current-buffer)))
    (with-current-buffer output-buffer
      (let ((linkd-use-datablocks nil))
	;;
	;; clean up any previous output
	(delete-region (point-min) (point-max))
	;;
	;; make a copy of the source
	(insert-buffer-substring-no-properties source-buffer)
	;;
	;; delete everything before first heading
	(goto-char (point-min))
	(re-search-forward linkd-export-heading-regexp)
	(previous-line)
	(end-of-line)
	(delete-region (point-min) (point))
	;;
	;; now process each block in turn.
	(while (and (not (eobp)) 
		    (re-search-forward linkd-export-heading-regexp nil nil))
	  (let ((title (match-string 1)))
	    (delete-region (point-at-bol) (point-at-eol))
	    (linkd-latex-do-section title)
	    (forward-line)
	    (block processing
	      (while (not (eobp))
		(cond 
		 ;;
		 ;; heading
		 ((string-match linkd-export-heading-regexp 
				(buffer-substring (point-at-bol) (point-at-eol)))
		  (when linkd-latex-in-verbatim
		    (linkd-latex-end-verbatim))
		  (return-from processing))
		 ;;
		 ;; commentary 
		 ((looking-at linkd-export-commentary-regexp)
		  ;; get rid of comment delimiter
		  (delete-region (match-beginning 0) (match-end 0))
		  (when linkd-latex-in-verbatim
		    (linkd-latex-end-verbatim)))
		 ;; 
		 ;; code
		 (t
		  (when (null linkd-latex-in-verbatim)
		    (linkd-latex-begin-verbatim))))
		(forward-line 1)))
	    ;;
	    ;; close verbatim environment if needed
	    (when linkd-latex-in-verbatim
	      (linkd-latex-end-verbatim))))
	;;
	;; now render linkd's tags nicely
	(let ((tag-regexp "\(\@> \"\\(.*\\)\")"))
	  (goto-char (point-min))
	  (while (and (not (eobp))
		      (re-search-forward tag-regexp nil t))
	    (replace-match (format "$\\\\Rightarrow ${\\\\bf %s}" (match-string 1)))))
	(current-buffer)))))

;; (@* "Exporting to HTML")
;;
;; This functionality is built on top of Hrvoje Niksic's
;; htmlizer. http://fly.srk.fer.hr/~hniksic/emacs/htmlize.el}

(defun linkd-html-export ()
  "Convert the current buffer to HTML using htmlize.el and some
extra rules. Return the buffer."
  (require 'htmlize)
  (let* ((source-buffer (current-buffer))
	 (output-buffer (htmlize-buffer source-buffer)))
    ;;
    ;; now postprocess it
    (with-current-buffer output-buffer 
      (goto-char (point-min))
      (let ((star-regexp (concat "<span class=\"linkd-generic\">(" "@" "\\* \"\\(.*\\)\")</span>"))
	    (sexp-regexp (concat "<span class=\"linkd-generic\">(" "@" "[^ ].* \"\\(.*\\)\")</span>")))
	(while (re-search-forward star-regexp nil t)
	  (replace-match (concat "<img src=\"/images/linkd-star.xpm.png\"> "
				 "<span style=\"color: #ffff00; background-color: #698b22;\">\\1</span>")))))
      ;;
    ;; return the buffer
    output-buffer))
  
;; (@* "Links to files")
;;
;; As Emacs deals in text files, one of the most common uses for a
;; link is in navigating from one file to another. The following
;; declarations define such ``file links''. (Note how the function {\tt
;; @file} returns the type of property list discussed in (@> "Following links")
;; 
;; One may also associate a Lisp function with each type of file, and
;; arrange that the function be used to open the file (instead of
;; visiting it within Emacs with the ordinary {\tt find-file.})

(defvar linkd-file-handler-alist nil 
"Association list mapping file extensions to functions that open 
such files for the user. Each value should be a function of
one argument (the file name).")

(defun @file (&rest p)
  (let ((file-name (plist-get p :file-name))
	(to (plist-get p :to))
	(display (plist-get p :display)))
    `(:follow
      (lambda ()
	(let ((handler (cdr (assoc (file-name-extension ,file-name)
				   linkd-file-handler-alist))))
	  (if handler
	      (funcall handler ,file-name)
	    ;; default action is find-file
	    (find-file ,file-name)
	    (when ,to
	      (beginning-of-buffer)
	      (search-forward ,to)))))
      :render
      (lambda (beg end)
	(linkd-overlay beg end ,(or display 
				    (concat file-name (if to 
							  (concat " : " to)
							"")))
		       nil linkd-default-bullet-string nil 
		       ,(linkd-file-icon file-name))))))

;; (@* "Other link types")
;;
;; Here are more examples of link type definitions. These link types
;; navigate to UNIX manual pages, GNU Info documentation, and to
;; webpages. 

(defun @man (&rest p)
  (let ((page (plist-get p :page))
	(to (plist-get p :to))
	(display (plist-get p :display)))
    `(:follow
      (lambda ()
	(man ,page)
	(when ,to
	  (beginning-of-buffer)
	  (search-forward ,to)))
      :render
      (lambda (beg end)
	(linkd-overlay beg end ,(or display 
				    (concat page " manual" (if to 
							       (concat " : " to)
							     "")))
		       nil linkd-default-bullet-string nil ,(linkd-icon "man"))))))

(defun @info (&rest p)
  (let ((file (plist-get p :file-name))
	(node (plist-get p :node))
	(to (plist-get p :to))
	(display (plist-get p :display)))
    `(:follow
      (lambda ()
	(info (concat "(" ,file ")" ,node)) 
	(when ,to
	  (beginning-of-buffer)
	  (search-forward ,to)))
      :render
      (lambda (beg end)
	(linkd-overlay beg end ,(or display 
				    (concat file " manual" (if to
							       (concat " : " to)
							     "")))
		       linkd-generic-name-face linkd-default-bullet-string 
		       nil ,(linkd-icon "info"))))))

(defun @url (&rest p)
  (let ((file-name (plist-get p :file-name))
	(display (plist-get p :display)))
    `(:follow
      (lambda ()
	(browse-url ,file-name))
      :render
      (lambda (beg end)
	(linkd-overlay beg end ,(or display file-name)
		       linkd-generic-name-face 
		       linkd-default-bullet-string nil ,(linkd-icon "url"))))))

;; (@* "Lisp links")

(defun @L (sexp)
    `(:follow
      (lambda ()
	(message "%S" (eval ,sexp)))
      :render
      (lambda (beg end)
	(linkd-overlay beg end ,(format "%S" sexp)
		       linkd-command-face 
		       linkd-default-bullet-string nil ,(linkd-icon "url")))))

;; (@* "Wiki features")
;;
;; When using emacs, one builds up a library of text files. You can
;; turn this collection into a hypertext wiki by inserting ``wiki
;; links'' from one file to another. Wiki names {\tt LookLikeThis.}
;; 

(defvar linkd-wiki-extensions (list "linkd" "org" "el")
"List of string extensions to try when looking for a given wiki
page.")

(defvar linkd-wiki-directory "~/linkd-wiki" 
"Default directory to look for wiki pages in.")

(defun linkd-wiki-find-page (page-name)
  (interactive "s")
  (let ((page-file (block testing
		     (dolist (extension linkd-wiki-extensions)
		       (let ((test-filename (concat (file-name-as-directory 
						     linkd-wiki-directory)
						    page-name 
						    "." extension)))
			 (if (file-exists-p test-filename)
			     (return-from testing test-filename)
			   (return-from testing nil)))))))
    (if page-file
	(find-file page-file)
      ;;
      ;; otherwise, query the user which file extension to create
      (let ((ext (completing-read "Create wiki page with extension: "
				  linkd-wiki-extensions)))
	(find-file (concat (file-name-as-directory linkd-wiki-directory)
			   page-name "." ext))))))
		   
(defun @! (page) 
  `(:follow
    (lambda ()
      (linkd-wiki-find-page ,page))
    :render
    (lambda (beg end) 
      (linkd-overlay beg end ,page linkd-wiki-face))))
 
;; (@* "Minor mode for linkd") 
;;
;; When linkd minor mode is active, links are displayed using
;; overlays, and keybindings are available for common linkd
;; functions. The keybindings are in accord with the convention for
;; minor-modes: a Control-C followed by one of a set of reserved
;; punctuation characters.

(defvar linkd-map nil)
(when (null linkd-map)
  (setq linkd-map (make-sparse-keymap))
  (define-key linkd-map (kbd "C-c *") 'linkd-process-block)
  (define-key linkd-map (kbd "C-c [") 'linkd-previous-link)
  (define-key linkd-map (kbd "C-c ]") 'linkd-next-link)
  (define-key linkd-map (kbd "C-c '") 'linkd-follow-at-point)
  (define-key linkd-map (kbd "C-c , b") 'linkd-back)
  (define-key linkd-map (kbd "C-c , ,") 'linkd-insert-link)
  (define-key linkd-map (kbd "C-c , t") 'linkd-insert-tag)
  (define-key linkd-map (kbd "C-c , s") 'linkd-insert-star)
  (define-key linkd-map (kbd "C-c , w") 'linkd-insert-wiki)
  (define-key linkd-map (kbd "C-c , l") 'linkd-insert-lisp)
  (define-key linkd-map (kbd "C-c , e") 'linkd-edit-link-at-point)
  (define-key linkd-map (kbd "C-c , x") 'linkd-escape-datablock))

(define-minor-mode linkd-mode
  "Make hypertext with active links in any buffer."
  nil 
  :lighter " Linkd"
  :keymap linkd-map
  (if linkd-mode
      (linkd-enable)
    (linkd-disable)))

(defun linkd-enable ()
  (add-hook 'before-save-hook 'linkd-deactivate-all-datablocks :append :local)
  (add-hook 'after-save-hook 'linkd-activate-all-datablocks :append :local)
  (linkd-do-font-lock 'font-lock-add-keywords)
  (font-lock-fontify-buffer))

(defun linkd-disable ()
  ;;
  ;; remove hooks
  (remove-hook 'before-save-hook 'linkd-deactivate-all-datablocks)
  (remove-hook 'after-save-hook 'linkd-activate-all-datablocks)
  ;;
  ;; remove all linkd's overlays
  (mapcar (lambda (overlay)
	    (when (get-text-property (overlay-start overlay)
				     'linkd-fontified)
	      (delete-overlay overlay)))
	  (overlays-in (point-min) (point-max)))
  ;;
  ;; remove font-lock rules, textprops, and then refontify the buffer
  (linkd-do-font-lock 'font-lock-remove-keywords)
  (remove-text-properties (point-min) (point-max) '(linkd-fontified))
  (font-lock-fontify-buffer))

;; (@* "Fontlocking")
;;
;; Each link type may execute arbitrary code to render itself. In the
;; typical case, we use {\tt (linkd-overlay)} to render the link using
;; overlays and possibly icons. See also (@> "Rendering links with overlays").
;;
;; The following function invokes a link's rendering code.

(defun linkd-render-link (beg end)
  (when (not (get-text-property beg 'linkd-fontified))
    (save-excursion
      (goto-char beg)
      (add-text-properties beg (+ beg 1) (list 'linkd-fontified t))		  
      (let* ((sexp (read (current-buffer)))
	     (plist (eval sexp))
	     (renderer (plist-get plist :render)))
	(when (null renderer) (error "No renderer for link."))
	(funcall renderer beg end)))))

;; Now we must interface with the Emacs font-locking system. The
;; following function can be configured to add, or remove,
;; font-locking rules that cause linkd's links to be fontified.

(defun linkd-do-font-lock (add-or-remove)
  (funcall add-or-remove nil 
	   `((linkd-match
	      0
	      (let ((beg (match-beginning 0))
		    (end (match-end 0)))
		(linkd-render-link beg end)
		linkd-generic-face)
	      prepend))))		 	      

;; (@* "Faces")
;;
;; Here are default face declarations for the various link styles.

(defface linkd-generic-face '((t (:foreground "yellow")))
  "Face for linkd links.")

(defvar linkd-generic-face 'linkd-generic-face)

(defface linkd-generic-name-face '((t (:foreground "yellow")))
  "Face for linkd links.")

(defvar linkd-generic-name-face 'linkd-generic-name-face)

(defface linkd-star-face
'((t (:foreground "yellow" :background "red" :underline nil)))
  "Face for star delimiters.")

(defvar linkd-star-face 'linkd-star-face)

(defface linkd-star-name-face
'((t (:foreground "yellow" :background "red" :underline "yellow")))
  "Face for star names.")

(defvar linkd-star-name-face 'linkd-star-name-face)

(defface linkd-tag-face
'((t (:foreground "yellow" :background "forestgreen")))
  "Face for tags.")

(defvar linkd-tag-face 'linkd-tag-face)

(defface linkd-tag-name-face
'((t (:foreground "yellow" :background "blue" :underline "yellow")))
  "Face for tag names.")

(defvar linkd-tag-name-face 'linkd-tag-name-face)

(defface linkd-icon-face '((t (:underline nil)))
  "Face for icons.")

(defvar linkd-icon-face 'linkd-icon-face)

(defface linkd-wiki-face
'((t (:foreground "cyan" :underline "yellow")))
  "Face for camel case wiki links.")

(defvar linkd-wiki-face 'linkd-wiki-face)

(defface linkd-command-face
'((t (:foreground "red" :background "blue")))
  "Face for command links.")

(defvar linkd-command-face 'linkd-command-face)

;; (@* "Versioning and postamble")

(defun linkd-version ()
  (interactive)
  (message "$Id: linkd.el,v 1.63 2007/05/19 00:16:17 dto Exp dto $"))

(provide 'linkd)
;;; linkd.el ends here
