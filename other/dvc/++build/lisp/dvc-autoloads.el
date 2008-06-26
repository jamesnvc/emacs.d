;;; dvc-autoloads.el --- automatically extracted custom dependencies and autoload
;;
;;; Code:

(put 'dvc 'custom-loads '(bzr dvc-annotate dvc-defs bzr-submit dvc-config dvc-core dvc-log dvc-buffers dvc-state xgit-core tla-defs))
(put 'tla-bookmarks 'custom-loads '(tla-defs))
(put 'xtla 'custom-loads '(tla-defs tla))
(put 'tla-revisions 'custom-loads '(dvc-revlist tla-defs))
(put 'dvc-file-actions 'custom-loads '(dvc-defs tla-defs))
(put 'dvc-faces 'custom-loads '(dvc-defs tla-defs))
(put 'tla-faces 'custom-loads '(tla-defs tla-browse))
(put 'tools 'custom-loads '(dvc-defs))
(put 'tla-merge 'custom-loads '(tla-defs))
(put 'dvc-internal 'custom-loads '(dvc-buffers dvc-defs))
(put 'dvc-xgit 'custom-loads '(xgit-gnus xgit-core xgit-log xgit))
(put 'dvc-bzr-submit 'custom-loads '(bzr-submit))
(put 'tla-hooks 'custom-loads '(tla-defs))
(put 'dvc-state 'custom-loads '(dvc-state))
(put 'dvc-git 'custom-loads '(xgit))
(put 'tla-bindings 'custom-loads '(dvc-ui tla-defs))
(put 'dvc-tips 'custom-loads '(dvc-defs dvc-tips))
;; These are for handling :version.  We need to have a minimum of
;; information so `customize-changed-options' could do its job.

;; For groups we set `custom-version', `group-documentation' and
;; `custom-tag' (which are shown in the customize buffer), so we
;; don't have to load the file containing the group.

;; `custom-versions-load-alist' is an alist that has as car a version
;; number and as elts the files that have variables or faces that
;; contain that version. These files should be loaded before showing
;; the customization buffer that `customize-changed-options'
;; generates.

;; This macro is used so we don't modify the information about
;; variables and groups if it's already set. (We don't know when
;; cus-load.el is going to be loaded and at that time some of the
;; files might be loaded and some others might not).
(defmacro custom-put-if-not (symbol propname value)
  `(unless (get ,symbol ,propname)
     (put ,symbol ,propname ,value)))


;; Code to insert at the beginning of dvc-autoloads.el
(require 'dvc-core)
(eval-when-compile
  (require 'dvc-unified)
  (require 'dvc-utils)
  )


;;;### (autoloads (baz-annotate baz-status-goto baz-branch) "baz"
;;;;;;  "../../lisp/baz.el" (18329 28854))
;;; Generated autoloads from ../../lisp/baz.el

(defvar baz-tla-only-commands '(tla-tag) "\
List of commands available only with tla.")

(defun baz-make-alias-for-tla-commands nil "\
Creates baz- aliases for tla- commands.

For each commands beginning with \"tla-\", except the ones in
`baz-tla-only-list', create the corresponding \"baz-\" alias.

Most functions in tla*.el are prefixed with tla-, but this allows you to
type M-x baz-whatever RET instead. Some functions are available only
with baz. They're prefixed with baz- and have no alias." (interactive) (dolist (tla-cmd (apropos-internal "^tla-" (quote commandp))) (unless (member tla-cmd baz-tla-only-commands) (let* ((tla-cmd-post (substring (symbol-name tla-cmd) 4)) (baz-cmd (intern (concat "baz-" tla-cmd-post)))) (unless (or (fboundp baz-cmd) (string-match "^dvc" tla-cmd-post)) (defalias baz-cmd tla-cmd))))))

(baz-make-alias-for-tla-commands)

(eval-after-load "tla" '(progn (defalias 'baz--name-construct 'tla--name-construct) (baz-make-alias-for-tla-commands)))

(autoload 'baz-branch "baz" "\
Create a tag from SOURCE-REVISION to TAG-VERSION.
Run baz branch.
If SYNCHRONOUSLY is non-nil, the process for tagging runs synchronously.
Else it runs asynchronously.

\(fn SOURCE-REVISION TAG-VERSION &optional CACHEREV SYNCHRONOUSLY)" t nil)

(autoload 'baz-status-goto "baz" "\
Switch to status buffer or run `baz-dvc-status'.

\(fn &optional ROOT AGAINST)" t nil)

(defalias 'baz-merge 'tla-star-merge)

(autoload 'baz-annotate "baz" "\
Run \"baz annotate\" on FILE.

Shows the result in a buffer, and create an annotation table for the
annotated file's buffer. This allows you to run `baz-trace-line' and
`baz-trace-line-show-log'.

\(fn FILE)" t nil)

;;;***

;;;### (autoloads nil "baz-dvc" "../../lisp/baz-dvc.el" (18329 28854))
;;; Generated autoloads from ../../lisp/baz-dvc.el

(dvc-register-dvc 'baz "Bazaar 1")

(defalias 'baz-dvc-command-version 'baz-command-version)

;;;***

;;;### (autoloads (bzr-revision-get-last-revision bzr-resolved bzr-dvc-rename
;;;;;;  bzr-dvc-remove-files bzr-dvc-revert-files bzr-dvc-add-files
;;;;;;  bzr-add bzr-inventory bzr-dvc-diff bzr-diff-against bzr-update
;;;;;;  bzr-merge bzr-push bzr-pull) "bzr" "../../lisp/bzr.el" (18329
;;;;;;  28854))
;;; Generated autoloads from ../../lisp/bzr.el

(autoload 'bzr-pull "bzr" "\
Run bzr pull.

\(fn &optional REPO-PATH)" t nil)

(autoload 'bzr-push "bzr" "\
Run bzr push.
When called with a prefix argument, add the --remember option

\(fn &optional REPO-PATH)" t nil)

(autoload 'bzr-merge "bzr" "\
Run bzr merge.

\(fn &optional REPO-PATH)" t nil)

(autoload 'bzr-update "bzr" "\
Run bzr update.

\(fn &optional PATH)" t nil)

(autoload 'bzr-diff-against "bzr" "\
Run \"bzr diff\" against a particular revision.

Same as `bzr-dvc-diff', but the interactive prompt is different.

\(fn AGAINST &optional PATH DONT-SWITCH)" t nil)

(autoload 'bzr-dvc-diff "bzr" "\
Run \"bzr diff\".

AGAINST must be a DVC revision id ('bzr number, last:N,
revid:foobar, ...).

TODO: DONT-SWITCH is currently ignored.

\(fn &optional AGAINST PATH DONT-SWITCH)" t nil)

(autoload 'bzr-inventory "bzr" "\
Run \"bzr inventory\".

\(fn)" t nil)

(autoload 'bzr-add "bzr" "\
Adds FILE to the repository.

\(fn FILE)" t nil)

(autoload 'bzr-dvc-add-files "bzr" "\
Run bzr add.

\(fn &rest FILES)" nil nil)

(autoload 'bzr-dvc-revert-files "bzr" "\
Run bzr revert.

\(fn &rest FILES)" nil nil)

(autoload 'bzr-dvc-remove-files "bzr" "\
Run bzr remove.

\(fn &rest FILES)" nil nil)

(autoload 'bzr-dvc-rename "bzr" "\
Run bzr rename.

\(fn FROM TO &optional AFTER)" t nil)

(autoload 'bzr-resolved "bzr" "\
Command to delete .rej file after conflicts resolution.
Asks confirmation if the file still has diff3 markers.
Then, run \"bzr resolve\".

TODO: should share some code with `tla-resolved'.

\(fn FILE)" t nil)

(autoload 'bzr-revision-get-last-revision "bzr" "\
Insert the content of FILE in LAST-REVISION, in current buffer.

LAST-REVISION looks like
\(\"root\" NUM)

\(fn FILE LAST-REVISION)" nil nil)

;;;***

;;;### (autoloads (bzr-default-global-argument bzr-prepare-environment
;;;;;;  bzr-tree-id bzr-tree-root) "bzr-core" "../../lisp/bzr-core.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/bzr-core.el

(autoload 'bzr-tree-root "bzr-core" "\
Return the tree root for LOCATION, nil if not in a local tree.
Computation is done from withing Emacs, by looking at a .bzr/
directory in a parent buffer of LOCATION.  This is therefore very
fast.

If NO-ERROR is non-nil, don't raise an error if LOCATION is not a
bzr-managed tree (but return nil).

\(fn &optional LOCATION NO-ERROR INTERACTIVE)" t nil)

(autoload 'bzr-tree-id "bzr-core" "\
Call \"bzr log -r 1\" to get the tree-id.
Does anyone know of a better way to get this info?

\(fn)" t nil)

(autoload 'bzr-prepare-environment "bzr-core" "\
Prepare the environment to run bzr.

\(fn ENV)" nil nil)

(autoload 'bzr-default-global-argument "bzr-core" "\
Disable aliases.

\(fn)" nil nil)

;;;***

;;;### (autoloads (bzr-dvc-name-construct bzr-dvc-search-file-in-diff)
;;;;;;  "bzr-dvc" "../../lisp/bzr-dvc.el" (18329 28854))
;;; Generated autoloads from ../../lisp/bzr-dvc.el

(dvc-register-dvc 'bzr "Bazaar 2")

(defalias 'bzr-dvc-inventory 'bzr-inventory)

(defalias 'bzr-dvc-missing 'bzr-missing)

(defalias 'bzr-dvc-pull 'bzr-pull)

(defalias 'bzr-dvc-merge 'bzr-merge)

(defalias 'bzr-dvc-submit-patch 'bzr-submit-patch)

(defalias 'bzr-dvc-add 'bzr-add)

(defalias 'bzr-dvc-log-edit-done 'bzr-log-edit-done)

(autoload 'bzr-dvc-search-file-in-diff "bzr-dvc" "\
Not documented

\(fn FILE)" nil nil)

(autoload 'bzr-dvc-name-construct "bzr-dvc" "\
Not documented

\(fn BACK-END-REVISION)" nil nil)

(defvar bzr-log-edit-file-name ".tmp-bzr-log-edit.txt" "\
The filename, used to store the log message before commiting.
Usually that file is placed in the tree-root of the working tree.")

(defalias 'bzr-dvc-command-version 'bzr-command-version)

;;;***

;;;### (autoloads (bzr-missing bzr-changelog bzr-log-remote bzr-log)
;;;;;;  "bzr-revision" "../../lisp/bzr-revision.el" (18329 28854))
;;; Generated autoloads from ../../lisp/bzr-revision.el

(autoload 'bzr-log "bzr-revision" "\
Run bzr log for PATH and show only the first line of the log message.
LAST-N revisions are shown (default dvc-log-last-n). Note that the
LAST-N restriction is applied first, so if both PATH and LAST-N are
specified, fewer than LAST-N revisions may be shown.

\(fn PATH LAST-N)" t nil)

(autoload 'bzr-log-remote "bzr-revision" "\
Run bzr log against a remote location.

\(fn LOCATION)" t nil)

(autoload 'bzr-changelog "bzr-revision" "\
Run bzr log and show the full log message.

\(fn &optional PATH)" t nil)

(autoload 'bzr-missing "bzr-revision" "\
Run bzr missing.

\(fn &optional OTHER)" t nil)

;;;***

;;;### (autoloads (bzr-submit-patch bzr-prepare-patch-submission)
;;;;;;  "bzr-submit" "../../lisp/bzr-submit.el" (18329 28854))
;;; Generated autoloads from ../../lisp/bzr-submit.el

(autoload 'bzr-prepare-patch-submission "bzr-submit" "\
Submit a patch to a bzr working copy (at BZR-TREE-ROOT) via email.
With this feature it is not necessary to branch a bzr archive.
You simply edit your checked out copy from your project and call this function.
The function will create a patch as a .diff file (based on PATCH-BASE-NAME)
and send it to the given email address EMAIL.
VERSION-STRING should indicate the version of bzr that the patch applies to.
DESCRIPTION is a brief descsription of the patch.
SUBJECT is the subject for the email message.
PROMPT-FILES indicates whether to prompt for the files to include in
the patch.
For an example, how to use this function see: `bzr-submit-patch'.

\(fn BZR-TREE-ROOT PATCH-BASE-NAME EMAIL VERSION-STRING &optional DESCRIPTION SUBJECT PROMPT-FILES)" t nil)

(autoload 'bzr-submit-patch "bzr-submit" "\
Submit a patch for the current bzr project.
With this feature it is not necessary to tag an arch archive.
You simply edit your checked out copy and call this function.
The function will create a patch as *.tar.gz file and prepare a buffer to
send the patch via email.

The variable `bzr-submit-patch-mapping' allows to specify the
target email address and the base name of the sent tarball.

After the user has sent the message, `bzr-submit-patch-done' is called.

\(fn)" t nil)

;;;***

;;;### (autoloads (dvc-about) "dvc-about" "../../lisp/dvc-about.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-about.el

(autoload 'dvc-about "dvc-about" "\
Displays a welcome message.

\(fn)" t nil)

;;;***

;;;### (autoloads (dvc-bookmarks) "dvc-bookmarks" "../../lisp/dvc-bookmarks.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-bookmarks.el

(autoload 'dvc-bookmarks "dvc-bookmarks" "\
Display the *dvc-bookmarks* buffer.
With prefix argument ARG, reload the bookmarks file from disk.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (dvc-submit-bug-report) "dvc-bug" "../../lisp/dvc-bug.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-bug.el

(autoload 'dvc-submit-bug-report "dvc-bug" "\
Submit a bug report, with pertinent information to the dvc-dev list.

\(fn)" t nil)

;;;***

;;;### (autoloads (dvc-current-file-list) "dvc-core" "../../lisp/dvc-core.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-core.el

(autoload 'dvc-current-file-list "dvc-core" "\
Return a list of currently active files.
When in dired mode, return the marked files or the file under point.
In a DVC mode, return `dvc-buffer-marked-file-list' if non-nil;
otherwise the result depends on SELECTION-MODE:
* When 'nil-if-none-marked, return nil.
* When 'all-if-none-marked, return all files.
* Otherwise return result of calling `dvc-get-file-info-at-point'.

\(fn &optional SELECTION-MODE)" nil nil)

;;;***

;;;### (autoloads (dvc-dvc-file-diff dvc-file-ediff) "dvc-diff" "../../lisp/dvc-diff.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-diff.el

(autoload 'dvc-file-ediff "dvc-diff" "\
Run ediff of FILE (default current buffer file) against last revision.

\(fn FILE)" t nil)

(autoload 'dvc-dvc-file-diff "dvc-diff" "\
Default for back-end-specific file diff. View changes in FILE
between BASE (default last-revision) and MODIFIED (default
workspace version).

\(fn FILE &optional BASE MODIFIED DONT-SWITCH)" nil nil)

;;;***

;;;### (autoloads (dvc-insinuate-gnus) "dvc-gnus" "../../lisp/dvc-gnus.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-gnus.el

(autoload 'dvc-insinuate-gnus "dvc-gnus" "\
Insinuate Gnus for each registered DVC back-end.

Runs (<backend>-insinuate-gnus) for each registered back-end having
this function.

Additionally the following key binding is defined for the gnus summary mode map:
K t l `dvc-gnus-article-extract-log-message'
K t v `dvc-gnus-article-view-patch'
K t m `dvc-gnus-article-view-missing'
K t a `dvc-gnus-article-apply-patch'

\(fn)" t nil)

;;;***

;;;### (autoloads (dvc-add-log-entry dvc-dvc-log-edit dvc-log-edit-mode)
;;;;;;  "dvc-log" "../../lisp/dvc-log.el" (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-log.el

(autoload 'dvc-log-edit-mode "dvc-log" "\
Major Mode to edit DVC log messages.
Commands:
\\{dvc-log-edit-mode-map}

\(fn)" t nil)

(autoload 'dvc-dvc-log-edit "dvc-log" "\
Edit the log file for tree ROOT before a commit.

OTHER_FRAME if non-nil puts log edit buffer in a separate frame.
NO-INIT if non-nil suppresses initialization of the buffer if one
is reused.

\(fn ROOT OTHER-FRAME NO-INIT)" nil nil)

(autoload 'dvc-add-log-entry "dvc-log" "\
Add new ChangeLog style entry to the current DVC log-edit buffer.
If OTHER-FRAME xor `dvc-log-edit-other-frame' is non-nil,
show log-edit buffer in other frame.

\(fn &optional OTHER-FRAME)" t nil)

;;;***

;;;### (autoloads (dvc-call dvc-apply) "dvc-register" "../../lisp/dvc-register.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-register.el

(autoload 'dvc-apply "dvc-register" "\
Apply ARGS to the `dvc-current-active-dvc' concated with POSTFIX.

\(fn POSTFIX &rest ARGS)" nil nil)

(autoload 'dvc-call "dvc-register" "\
Call the function specified by concatenating `dvc-current-active-dvc' and
POSTFIX, with arguments ARGS.

\(fn POSTFIX &rest ARGS)" nil nil)

;;;***

;;;### (autoloads (dvc-tips-popup) "dvc-tips" "../../lisp/dvc-tips.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-tips.el

(autoload 'dvc-tips-popup "dvc-tips" "\
Pop up a buffer with a tip message.

Don't use this function from Xtla. Use `dvc-tips-popup-maybe'
instead.

\(fn &optional DIRECTION NOSWITCH)" t nil)

;;;***

;;;### (autoloads (dvc-enable-prefix-key dvc-prefix-key) "dvc-ui"
;;;;;;  "../../lisp/dvc-ui.el" (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-ui.el

(eval-and-compile (require 'easymenu))

(defvar dvc-key-help 63)

(defvar dvc-key-diff 61)

(defvar dvc-key-status 115)

(defvar dvc-key-show-bookmark 98)

(defvar dvc-key-file-diff 100)

(defvar dvc-key-tree-lint 108)

(defvar dvc-key-logs 76)

(defvar dvc-key-ediff 101)

(defvar dvc-key-log-entry 97)

(defvar dvc-key-inventory 105)

(defvar dvc-key-kill-ring-prefix 119)

(defvar dvc-key-commit 99)

(defvar dvc-key-update 117)

(defvar dvc-key-missing 109)

(defvar dvc-key-buffer-prefix 66)

(defvar dvc-key-file-prefix 102)

(defun dvc-key-group (prefix &rest keys) (apply 'vector prefix keys))

(defun dvc-prefix-file (&rest keys) (dvc-key-group dvc-key-file-prefix keys))

(defun dvc-prefix-kill-ring (&rest keys) (dvc-key-group dvc-key-kill-ring-prefix keys))

(defun dvc-prefix-buffer (&rest keys) (dvc-key-group dvc-key-buffer-prefix keys))

(defvar dvc-keyvec-help (vector dvc-key-help))

(defvar dvc-keyvec-ediff (vector dvc-key-ediff))

(defvar dvc-keyvec-tree-lint (vector dvc-key-tree-lint))

(defvar dvc-keyvec-logs (vector dvc-key-logs))

(defvar dvc-keyvec-log-entry (vector dvc-key-log-entry))

(defvar dvc-keyvec-diff (vector dvc-key-diff))

(defvar dvc-keyvec-status (vector dvc-key-status))

(defvar dvc-keyvec-file-diff (vector dvc-key-file-diff))

(defvar dvc-keyvec-file-diff (vector dvc-key-file-diff))

(defvar dvc-keyvec-commit (vector dvc-key-commit))

(defvar dvc-keyvec-update (vector dvc-key-update))

(defvar dvc-keyvec-missing (vector dvc-key-missing))

(defvar dvc-keyvec-inventory (vector dvc-key-inventory))

(defvar dvc-keyvec-show-bookmark (vector dvc-key-show-bookmark))

(defvar dvc-global-keymap (let ((map (make-sparse-keymap))) (define-key map [85] 'tla-undo) (define-key map [82] 'tla-redo) (define-key map [112] 'dvc-submit-patch) (define-key map dvc-keyvec-log-entry 'dvc-add-log-entry) (define-key map [65] 'tla-archives) (define-key map dvc-keyvec-file-diff 'dvc-file-diff) (define-key map dvc-keyvec-ediff 'dvc-file-ediff) (define-key map [111] 'tla-file-view-original) (define-key map dvc-keyvec-diff 'dvc-diff) (define-key map dvc-keyvec-status 'dvc-status) (define-key map dvc-keyvec-commit 'dvc-log-edit) (define-key map [116] 'tla-tag-insert) (define-key map dvc-keyvec-inventory 'dvc-inventory) (define-key map [114] 'tla-tree-revisions) (define-key map dvc-keyvec-logs 'dvc-log) (define-key map [108] 'dvc-changelog) (define-key map [(meta 108)] 'tla-tree-lint) (define-key map dvc-keyvec-update 'dvc-update) (define-key map [109] 'dvc-missing) (define-key map [77] 'dvc-merge) (define-key map dvc-keyvec-show-bookmark 'dvc-bookmarks) (define-key map dvc-keyvec-help 'tla-help) (define-key map (dvc-prefix-file 97) 'dvc-add-files) (define-key map (dvc-prefix-file 68) 'dvc-remove-files) (define-key map (dvc-prefix-file 82) 'dvc-revert-files) (define-key map (dvc-prefix-file 77) 'dvc-rename) (define-key map (dvc-prefix-file 88) 'dvc-purge-files) (define-key map (dvc-prefix-buffer dvc-key-diff) 'tla-changes-goto) (define-key map (dvc-prefix-buffer dvc-key-status) 'baz-status-goto) (define-key map (dvc-prefix-buffer dvc-key-inventory) 'tla-inventory-goto) (define-key map (dvc-prefix-buffer dvc-key-tree-lint) 'tla-tree-lint-goto) (define-key map (dvc-prefix-buffer 114) 'tla-tree-revisions-goto) (define-key map (dvc-prefix-kill-ring 97) 'tla-save-archive-to-kill-ring) (define-key map (dvc-prefix-kill-ring 118) 'tla-save-version-to-kill-ring) (define-key map (dvc-prefix-kill-ring 114) 'tla-save-revision-to-kill-ring) map) "\
Global keymap used by DVC.")

(defvar dvc-prefix-key [(control x) 86] "\
Prefix key for the DVC commands in the global keymap.

If you wish to disable the prefix key, set this variable to nil.")

(custom-autoload 'dvc-prefix-key "dvc-ui" nil)

(autoload 'dvc-enable-prefix-key "dvc-ui" "\
Install the DVC prefix key globally.

\(fn)" t nil)

(dvc-enable-prefix-key)

(add-hook 'after-init-hook 'dvc-enable-prefix-key t)

(define-key ctl-x-4-map [84] 'dvc-add-log-entry)

(easy-menu-add-item (and (boundp 'menu-bar-tools-menu) (dvc-do-in-gnu-emacs menu-bar-tools-menu)) (dvc-do-in-xemacs '("Tools")) '("DVC" ["Browse Archives" tla-archives t] ["Show Bookmarks" tla-bookmarks t] ["Start New Project" tla-start-project t] "---" "Tree Commands:" ["View Diff" dvc-diff t] ["View Status" dvc-status t] ["View Inventory" tla-inventory t] ["View Tree Lint" tla-tree-lint t] ["Show Tree Revisions" tla-tree-revisions t] ["Edit Commit Log" dvc-log-edit t] "---" "File Commands:" ["Insert Arch Tag" tla-tag-insert t] ["Add Log Entry" dvc-add-log-entry t] ["View File Diff" tla-file-diff t] ["View File Ediff" tla-file-ediff t] ["View Original" tla-file-view-original t] ["View Conflicts" tla-view-conflicts t] "---" ("Goto Buffer" ["View Changes" tla-changes-goto t] ["View Status" baz-status-goto t] ["View Inventory" tla-inventory-goto t] ["View Tree Lint" tla-tree-lint-goto t] ["Show Tree Revisions" tla-tree-revisions-goto t]) ("Quick Configuration" ["Three Way Merge" tla-toggle-three-way-merge :style toggle :selected tla-three-way-merge] ["Show Ancestor in Conflicts" tla-toggle-show-ancestor :style toggle :selected tla-show-ancestor] ["Non Recursive Inventory" tla-toggle-non-recursive-inventory :style toggle :selected tla-non-recursive-inventory] ["Use --skip-present" tla-toggle-use-skip-present-option :style toggle :selected tla-use-skip-present-option])) "PCL-CVS")

;;;***

;;;### (autoloads (dvc-ignore-file-extensions-in-dir dvc-ignore-file-extensions
;;;;;;  dvc-log-edit dvc-tree-root dvc-command-version dvc-log dvc-status
;;;;;;  dvc-diff define-dvc-unified-command dvc-remove-files dvc-revert-files
;;;;;;  dvc-add-files) "dvc-unified" "../../lisp/dvc-unified.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-unified.el

(autoload 'dvc-add-files "dvc-unified" "\
Add FILES to the currently active dvc. FILES is a list of
strings including path from root; interactive defaults
to (dvc-current-file-list).

\(fn &rest FILES)" t nil)

(autoload 'dvc-revert-files "dvc-unified" "\
Revert FILES for the currently active dvc.

\(fn &rest FILES)" t nil)

(autoload 'dvc-remove-files "dvc-unified" "\
Remove FILES for the currently active dvc.

\(fn &rest FILES)" t nil)

(autoload 'define-dvc-unified-command "dvc-unified" "\
Define a DVC unified command.  &optional arguments are permitted, but
not &rest.

\(fn NAME ARGS COMMENT &optional INTERACTIVE)" nil (quote macro))

(autoload 'dvc-diff "dvc-unified" "\
Display the changes from BASE-REV to the local tree in PATH.
BASE-REV (a revision-id) defaults to base revision of the
tree. Use `dvc-delta' for differencing two revisions.
PATH defaults to `default-directory'.
The new buffer is always displayed; if DONT-SWITCH is nil, select it.

\(fn &optional BASE-REV PATH DONT-SWITCH)" t nil)

(define-dvc-unified-command dvc-delta (base modified &optional dont-switch) "Display from revision BASE to MODIFIED.\n\nBASE and MODIFIED must be revision ID.\n\nThe new buffer is always displayed; if DONT-SWITCH is nil, select it.")

(define-dvc-unified-command dvc-file-diff (file &optional base modified dont-switch) "Display the changes in FILE (default current buffer file)\nbetween BASE (default last-revision) and MODIFIED (default\nworkspace version).\nIf DONT-SWITCH is non-nil, just show the diff buffer, don't select it." (interactive (list buffer-file-name)))

(autoload 'dvc-status "dvc-unified" "\
Display the status in optional PATH tree.

\(fn &optional PATH)" t nil)

(autoload 'dvc-log "dvc-unified" "\
Display the brief log for PATH (a file-name; default current
buffer file name; nil means entire tree), LAST-N entries (default
`dvc-log-last-n'; all if nil). LAST-N may be specified
interactively. Use `dvc-changelog' for the full log.

\(fn &optional PATH LAST-N)" t nil)

(define-dvc-unified-command dvc-changelog (&optional arg) "Display the full changelog in this tree for the actual dvc.\nUse `dvc-log' for the brief log." (interactive))

(define-dvc-unified-command dvc-add (file) "Adds FILE to the repository." (interactive))

(autoload 'dvc-command-version "dvc-unified" "\
Returns and/or shows the version identity string of backend command.

\(fn)" t nil)

(autoload 'dvc-tree-root "dvc-unified" "\
Get the tree root for PATH or the current `default-directory'.

When called interactively, print a message including the tree root and
the current active back-end.

\(fn &optional PATH NO-ERROR)" t nil)

(autoload 'dvc-log-edit "dvc-unified" "\
Edit the log before commiting. Optional OTHER_FRAME (default
user prefix) puts log edit buffer in a separate frame. Optional
NO-INIT if non-nil suppresses initialization of buffer if one is
reused.
`default-directory' must be the tree root.

\(fn &optional OTHER-FRAME NO-INIT)" t nil)

(define-dvc-unified-command dvc-log-edit-done (&optional arg) "Commit and close the log buffer.  Optional ARG is back-end specific." (interactive (list current-prefix-arg)))

(define-dvc-unified-command dvc-edit-ignore-files nil "Edit the ignored file list." (interactive))

(define-dvc-unified-command dvc-ignore-files (file-list) "Ignore the marked files." (interactive (list (dvc-current-file-list))))

(autoload 'dvc-ignore-file-extensions "dvc-unified" "\
Ignore the file extensions of the marked files, in all
directories of the workspace.

\(fn FILE-LIST)" t nil)

(autoload 'dvc-ignore-file-extensions-in-dir "dvc-unified" "\
Ignore the file extensions of the marked files, only in the
directories containing the files, and recursively below them.

\(fn FILE-LIST)" t nil)

(define-dvc-unified-command dvc-missing (&optional other) "Show revisions missing from the local workspace, relative to OTHER.\nOTHER defaults to the head revision of the current branch; for\nsome back-ends, it may also be a remote repository." (interactive))

(define-dvc-unified-command dvc-inventory nil "Show the inventory for this working copy." (interactive))

(define-dvc-unified-command dvc-save-diff (file) "Store the diff from the working copy against the repository in a file." (interactive (list (read-file-name "Save the diff to: "))))

(define-dvc-unified-command dvc-update nil "Update this working copy." (interactive))

(define-dvc-unified-command dvc-pull nil "Pull changes from the remote source to the working copy or\nlocal database, as appropriate for the current back-end." (interactive))

(define-dvc-unified-command dvc-merge (&optional other) "Merge with OTHER.\nIf OTHER is nil, merge heads in current database, or merge from\nremembered database.\nIf OTHER is a string, it identifies a (local or remote) database or\nbranch to merge into the current database, branch, or workspace." (interactive))

(define-dvc-unified-command dvc-submit-patch nil "Submit a patch for the current project under DVC control." (interactive))

(define-dvc-unified-command dvc-send-commit-notification nil "Send a commit notification for the changeset at point." (interactive))

;;;***

;;;### (autoloads (dvc-reload dvc-trace) "dvc-utils" "../../lisp/dvc-utils.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/dvc-utils.el

(defmacro dvc-do-in-gnu-emacs (&rest body) "\
Execute BODY if in GNU/Emacs." (unless (featurep (quote xemacs)) (\` (progn (\,@ body)))))

(defmacro dvc-do-in-xemacs (&rest body) "\
Execute BODY if in XEmacs." (when (featurep (quote xemacs)) (\` (progn (\,@ body)))))

(autoload 'dvc-trace "dvc-utils" "\
Display the trace message MSG.
Same as `message' if `dvc-debug' is non-nil.
Does nothing otherwise.  Please use it for your debug messages.

\(fn &rest MSG)" nil nil)

(autoload 'dvc-reload "dvc-utils" "\
Reload DVC (usually for debugging purpose).

With prefix arg, prompts for the DIRECTORY in which DVC should be
loaded.  Useful to switch from one branch to the other.

If a Makefile is present in the directory where DVC is to be loaded,
run \"make\".

\(fn &optional DIRECTORY)" t nil)

;;;***

;;;### (autoloads (tla-submit-patch-done tla-prepare-patch-submission
;;;;;;  tla-insert-location tla-tree-lint tla-ediff-add-log-entry
;;;;;;  tla-tag-regenerate tla-tag-insert tla-tag-string tla-inventory-file-mode
;;;;;;  tla-revlog-any tla-log-edit-mode tla-revlog tla-file-has-conflict-p
;;;;;;  tla-dvc-add-files tla-get tla-missing tla-revisions tla-tree-revisions
;;;;;;  tla-tree-revisions-goto tla-make-archive tla-register-archive
;;;;;;  tla-archives tla-bookmarks tla-tag tla-export tla-switch
;;;;;;  tla-star-merge tla-id-tagging-method tla-my-revision-library
;;;;;;  tla-tree-id tla-my-id tla-tree-version tla-help tla-logs
;;;;;;  tla-changelog tla-rm tla-start-project tla-commit tla-revision-get-last-revision
;;;;;;  tla-file-view-original tla-file-ediff tla-view-conflicts
;;;;;;  tla-resolved tla-file-diff tla-file-ediff-against tla-apply-changeset
;;;;;;  tla-get-changeset tla-delta tla-changes-last-revision tla-changes-against
;;;;;;  tla-update tla-changes tla-edit-log tla-inventory) "tla"
;;;;;;  "../../lisp/tla.el" (18329 28854))
;;; Generated autoloads from ../../lisp/tla.el

(autoload 'tla-inventory "tla" "\
Show a tla inventory at DIRECTORY.
When called with a prefix arg, pop to the inventory buffer.
DIRECTORY defaults to the current one when within an arch managed tree,
unless prefix argument ARG is non-nil.

\(fn &optional DIRECTORY ARG)" t nil)

(autoload 'tla-edit-log "tla" "\
Edit the tla log file.

With an optional prefix argument INSERT-CHANGELOG, insert the last
group of entries from the ChangeLog file.  SOURCE-BUFFER, if non-nil,
is the buffer from which the function was called.  It is used to get
the list of marked files, and potentially run a selected file commit.

\(fn &optional INSERT-CHANGELOG SOURCE-BUFFER OTHER-FRAME)" t nil)

(autoload 'tla-changes "tla" "\
Run \"tla changes\".

When called without a prefix argument: show the detailed diffs also.
When called with a prefix argument SUMMARY: do not show detailed
diffs. When AGAINST is non-nil, use it as comparison tree.

DONT-SWITCH is necessary for DVC, but currently ignored.

\(fn &optional SUMMARY AGAINST DONT-SWITCH)" t nil)

(autoload 'tla-update "tla" "\
Run tla update in TREE.

Also runs update recursively for subdirectories.
After running update, execute HANDLE (function taking no argument).

\(fn TREE &optional HANDLE RECURSIVE)" t nil)

(autoload 'tla-changes-against "tla" "\
Wrapper for `tla-changes'.

When called interactively, SUMMARY is the prefix arg, and AGAINST is
read from the user.

\(fn &optional SUMMARY AGAINST)" t nil)

(autoload 'tla-changes-last-revision "tla" "\
Run `tla-changes' against the last but one revision.

The idea is that running this command just after a commit should be
equivalent to running `tla-changes' just before the commit.

SUMMARY is passed to `tla-changes'.

\(fn &optional SUMMARY)" t nil)

(autoload 'tla-delta "tla" "\
Run tla delta BASE MODIFIED.
If DIRECTORY is a non-empty string, the delta is stored to it.
If DIRECTORY is ask, a symbol, ask the name of directory.
If DIRECTORY is nil or an empty string, just show the delta using --diffs.

\(fn BASE MODIFIED &optional DIRECTORY DONT-SWITCH)" t nil)

(autoload 'tla-get-changeset "tla" "\
Gets the changeset corresponding to REVISION.

When JUSTSHOW is non-nil (no prefix arg), just show the diff.
Otherwise, store changeset in DESTINATION.
If WITHOUT-DIFF is non-nil, don't use the --diff option to show the
changeset.

\(fn REVISION JUSTSHOW &optional DESTINATION WITHOUT-DIFF)" t nil)

(autoload 'tla-apply-changeset "tla" "\
Call \"tla apply-changeset\".

CHANGESET is the changeset to apply, TARGET is the directory in which
to apply the changeset. If REVERSE is non-nil, apply the changeset in
reverse.

\(fn CHANGESET TARGET &optional REVERSE)" t nil)

(autoload 'tla-file-ediff-against "tla" "\
View changes in FILE between BASE and MODIFIED using ediff.

\(fn FILE &optional BASE)" t nil)

(autoload 'tla-file-diff "tla" "\
Run \"tla file-diff\" on file FILE.

In interactive mode, the file is the current buffer's file.
If REVISION is specified, it must be a string representing a revision
name, and the file will be diffed according to this revision.

\(fn FILE &optional BASE MODIFIED DONT-SWITCH)" t nil)

(autoload 'tla-resolved "tla" "\
Command to delete .rej file after conflicts resolution.
Asks confirmation if the file still has diff3 markers.

If \"resolved\" command is available, also run it.

\(fn FILE)" t nil)

(autoload 'tla-view-conflicts "tla" "\
*** WARNING: semi-deprecated function.
Use this function if you like, but M-x smerge-mode RET is actually
better for the same task ****

Graphical view of conflicts after tla star-merge --three-way. The
buffer given as an argument must be the content of a file with
conflicts markers like.

    <<<<<<< TREE
    my text
    =======
    his text
    >>>>>>> MERGE-SOURCE

Priority is given to your file by default. (This means all conflicts
will be rejected if you do nothing).

\(fn BUFFER)" t nil)

(autoload 'tla-file-ediff "tla" "\
Interactive view of differences in FILE with ediff.

Changes are computed since last commit (or REVISION if specified).

\(fn FILE &optional REVISION)" t nil)

(autoload 'tla-file-view-original "tla" "\
Get the last-committed version of FILE in a buffer.

If REVISION is specified, it must be a cons representing the revision
for which to get the original.

\(fn FILE &optional REVISION)" t nil)

(autoload 'tla-revision-get-last-revision "tla" "\
Insert the content of FILE in LAST-REVISION, in current buffer.

LAST-REVISION looks like
\(\"path\" NUM).

\(fn FILE LAST-REVISION)" nil nil)

(autoload 'tla-commit "tla" "\
Run tla commit.

Optional argument HANDLER is the process handler for the commit
command. `nil' or a symbol(`seal' or `fix') is acceptable as
VERSION-FLAG.
When the commit finishes successful, `tla-commit-done-hook' is called.

\(fn &optional HANDLER VERSION-FLAG SUMMARY-LINE)" t nil)

(autoload 'tla-start-project "tla" "\
Start a new project.
Prompts for the root directory of the project and the fully
qualified version name to use.  Sets up and imports the tree and
displays an inventory buffer to allow the project's files to be
added and committed.
If ARCHIVE is given, use it when reading version.
Return a cons pair: its car is the new version name string, and
its cdr is imported location.
If SYNCHRONOUSLY is non-nil, run \"tla import\" synchronously.
Else run it asynchronously.

\(fn &optional ARCHIVE SYNCHRONOUSLY)" t nil)

(autoload 'tla-rm "tla" "\
Call tla rm on file FILE.  Prompts for confirmation before.

\(fn FILE)" nil nil)

(autoload 'tla-changelog "tla" "\
Run \"tla changelog\".

display the result in an improved ChangeLog mode.
If NAME is given, name is passed to \"tla changelog\"
as the place where changelog is got.

\(fn &optional NAME)" t nil)

(autoload 'tla-logs "tla" "\
Run tla logs.

\(fn)" t nil)

(autoload 'tla-help "tla" "\
Run tla COMMAND -H.

\(fn COMMAND)" t nil)

(autoload 'tla-tree-version "tla" "\
Equivalent of tla tree-version (but implemented in pure elisp).

Optional argument LOCATION is the directory in which the command must
be ran.  If NO-ERROR is non-nil, don't raise errors if ran outside an
arch managed tree.

\(fn &optional LOCATION NO-ERROR)" t nil)

(autoload 'tla-my-id "tla" "\
Run tla my-id.

When called without a prefix argument ARG, just print the my-id from
tla and return it.  If MY-ID is not set yet, return an empty string.
When called with a prefix argument, ask for a new my-id.

The my-id should have the following format:

Your id is recorded in various archives and log messages as you use
arch.  It must consist entirely of printable characters and fit on one
line.  By convention, it should have the form of an email address, as
in this example:

Jane Hacker <jane.hacker@gnu.org>

\(fn &optional ARG MY-ID)" t nil)

(autoload 'tla-tree-id "tla" "\
Call either 'baz tree-id' or 'tla logs -f -r' to get the tree-id.

\(fn)" t nil)

(autoload 'tla-my-revision-library "tla" "\
Run tla my-revision-library.

When called without a prefix argument ARG, just print the
my-revision-library from tla.  When called with a prefix argument, ask
for a new my-revision-library.

my-revision-library specifies a path, where the revision library is
stored to speed up tla.  For example ~/tmp/arch-lib.

You can configure the parameters for the library via
`tla-library-config'.

\(fn &optional ARG)" t nil)

(autoload 'tla-id-tagging-method "tla" "\
View (and return) or change the id-tagging method.
When called without prefix argument ARG: show the actual tagging method.
When called with prefix argument ARG: Ask the user for the new tagging method.

\(fn ARG)" t nil)

(autoload 'tla-star-merge "tla" "\
Star merge from version/revision FROM to local tree TO-TREE.

\(fn FROM &optional TO-TREE)" t nil)

(autoload 'tla-switch "tla" "\
Run tla switch to VERSION in TREE.

After running update, execute HANDLE (function taking no argument).

\(fn TREE VERSION &optional HANDLE)" t nil)

(autoload 'tla-export "tla" "\
Run tla export to export REVISION to DIR.

\(fn REVISION DIR)" t nil)

(autoload 'tla-tag "tla" "\
Create a tag from SOURCE-REVISION to TAG-VERSION.
Run tla tag --setup.
If SYNCHRONOUSLY is non-nil, the process for tagging runs synchronously.
Else it runs asynchronously.

\(fn SOURCE-REVISION TAG-VERSION &optional CACHEREV SYNCHRONOUSLY)" t nil)

(autoload 'tla-bookmarks "tla" "\
Display xtla bookmarks in a buffer.
With prefix argument ARG, reload the bookmarks file from disk.

\(fn &optional ARG)" t nil)

(autoload 'tla-archives "tla" "\
Start the archive browser.

\(fn)" t nil)

(autoload 'tla-register-archive "tla" "\
Call `tla--register-archive' interactively and `tla-archives' on success.

\(fn)" t nil)

(autoload 'tla-make-archive "tla" "\
Call `tla--make-archive' interactively  then call `tla-archives'.

\(fn)" t nil)

(autoload 'tla-tree-revisions-goto "tla" "\
Goto tree revisions buffer or call `tla-tree-revisions'.

\(fn ROOT)" t nil)

(autoload 'tla-tree-revisions "tla" "\
Call `tla-revisions' in the current tree.

\(fn ROOT)" t nil)

(autoload 'tla-revisions "tla" "\
List the revisions of ARCHIVE/CATEGORY--BRANCH--VERSION.

UNUSED is left here to keep the position of FROM-REVLIB

\(fn ARCHIVE CATEGORY BRANCH VERSION &optional UNUSED FROM-REVLIB)" t nil)

(autoload 'tla-missing "tla" "\
Search in directory LOCAL-TREE for missing patches from LOCATION.
If the current buffers default directory is in an arch managed tree use that
one unless called with a prefix arg.  In all other cases prompt for the local
tree and the location.

\(fn LOCAL-TREE LOCATION)" t nil)

(autoload 'tla-get "tla" "\
Run tla get in DIRECTORY.
If RUN-DIRED-P is non-nil, display the new tree in dired.
ARCHIVE, CATEGORY, BRANCH, VERSION and REVISION make up the revision to be
fetched.
If SYNCHRONOUSLY is non-nil, run the process synchronously.
Else, run the process asynchronously.

\(fn DIRECTORY RUN-DIRED-P ARCHIVE CATEGORY BRANCH &optional VERSION REVISION SYNCHRONOUSLY)" t nil)

(autoload 'tla-dvc-add-files "tla" "\
Run tla add.

\(fn &rest FILES)" nil nil)

(autoload 'tla-file-has-conflict-p "tla" "\
Return non-nil if FILE-NAME has conflicts.

\(fn FILE-NAME)" nil nil)

(autoload 'tla-revlog "tla" "\
Show the log for REVISION-SPEC.

\(fn REVISION-SPEC)" t nil)

(add-to-list 'auto-mode-alist '("\\+\\+log\\." . tla-log-edit-mode))

(autoload 'tla-log-edit-mode "tla" "\
Major Mode to edit xtla log messages.
Commands:
\\{tla-log-edit-mode-map}

\(fn)" t nil)

(autoload 'tla-revlog-any "tla" "\
Show the log entry for REVISION (a string).

\(fn REVISION)" t nil)

(autoload 'tla-inventory-file-mode "tla" "\
Major mode to edit tla inventory files (=tagging-method, .arch-inventory).

\(fn)" t nil)

(autoload 'tla-tag-string "tla" "\
Return a suitable string for an arch-tag.
Actually calls `tla-tag-function', which defaults to `tla-tag-uuid' to generate
string (and possibly add a comment-end after).

Interactively, you should call `tla-tag-insert', but this function can
be usefull to write template files.

\(fn)" nil nil)

(autoload 'tla-tag-insert "tla" "\
Insert a unique arch-tag in the current file.
Actually calls `tla-tag-function', which defaults to `tla-tag-uuid' to generate
string (and possibly add a comment-end after)

\(fn)" t nil)

(autoload 'tla-tag-regenerate "tla" "\
Find an arch tag in the current buffer and regenerates it.
This means changing the ID of the file, which will usually be done after
copying a file in the same tree to avoid duplicates ID.

Raises an error when multiple tags are found or when no tag is found.

\(fn)" t nil)

(autoload 'tla-ediff-add-log-entry "tla" "\
Add a log entry.

\(fn)" t nil)

(autoload 'tla-tree-lint "tla" "\
Run tla tree-lint in directory ROOT.

\(fn ROOT)" t nil)

(autoload 'tla-insert-location "tla" "\
Prompts an archive location and insert it on the current point location.

\(fn)" t nil)

(autoload 'tla-prepare-patch-submission "tla" "\
Submit a patch to a tla working copy (at TLA-TREE-ROOT) via email.
With this feature it is not necessary to tag an tla archive.
You simply edit your checked out copy from your project and call this function.
The function will create a patch as *.tar.gz file (based on TARBALL-BASE-NAME)
and send it to the given email address EMAIL.
VERSION-STRING should indicate the version of tla that the patch applies to.
DESCRIPTION is a brief descsription of the patch.
SUBJECT is the subject for the email message.
For an example, how to use this function see: `tla-submit-patch'.

\(fn TLA-TREE-ROOT TARBALL-BASE-NAME EMAIL VERSION-STRING &optional DESCRIPTION SUBJECT)" t nil)

(autoload 'tla-submit-patch-done "tla" "\
Clean up after sending a patch via mail.
That function is usually called via `message-sent-hook'. Its purpose is to revert
the sent changes or to delete sent changeset tarball (see: `tla-patch-sent-action'.

\(fn)" nil nil)

;;;***

;;;### (autoloads (tla-bconfig-mode) "tla-bconfig" "../../lisp/tla-bconfig.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/tla-bconfig.el

(autoload 'tla-bconfig-mode "tla-bconfig" "\
Major mode to edit GNU arch's build config files.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.arch$" . tla-bconfig-mode))

;;;***

;;;### (autoloads (tla-browse) "tla-browse" "../../lisp/tla-browse.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/tla-browse.el

(autoload 'tla-browse "tla-browse" "\
Browse registered archives as trees within one buffer.
You can specify the node should be opened by alist,
INITIAL-OPEN-LIST.  If APPEND is nil, the nodes not in
INITIAL-OPEN-LIST are made closed.  If non-nil, the nodes
already opened are kept open.

\(fn &optional INITIAL-OPEN-LIST APPEND)" t nil)

;;;***

;;;### (autoloads (tla-make-name-regexp tla-tree-root) "tla-core"
;;;;;;  "../../lisp/tla-core.el" (18329 28854))
;;; Generated autoloads from ../../lisp/tla-core.el

(autoload 'tla-tree-root "tla-core" "\
Return the tree root for LOCATION, nil if not in a local tree.
Computation is done from withing Emacs, by looking at an {arch}
directory in a parent buffer of LOCATION.  This is therefore very
fast.

If LOCATION is nil, the tree root is returned, and it is
guaranteed to end in a \"/\" character.

If NO-ERROR is non-nil, don't raise an error if LOCATION is not an
arch managed tree (but return nil).

\(fn &optional LOCATION NO-ERROR INTERACTIVE)" t nil)

(autoload 'tla-make-name-regexp "tla-core" "\
Make a regexp for an Arch name (archive, category, ...).

LEVEL can be 0 (archive), 1 (category), 2 (branch), 3 (version)
or 4 (revision).

If SLASH-MANDATORY is non-nil, the '/' after the archive name is
mandatory. (allows to distinguish between Arch archives and emails.

If EXACT is non-nil, match exactly LEVEL.

\(fn LEVEL SLASH-MANDATORY EXACT)" nil nil)

;;;***

;;;### (autoloads (tla-toggle-non-recursive-inventory tla-toggle-show-ancestor
;;;;;;  tla-toggle-three-way-merge tla-use-skip-present-option tla-non-recursive-inventory
;;;;;;  tla-show-ancestor tla-three-way-merge xtla) "tla-defs" "../../lisp/tla-defs.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/tla-defs.el

(eval-and-compile (require 'easymenu) (require 'dvc-core))

(let ((loads (get 'xtla 'custom-loads))) (if (member '"tla-defs" loads) nil (put 'xtla 'custom-loads (cons '"tla-defs" loads))))

(defvar tla-three-way-merge t "\
*If non-nil, merge operations are invoked with --three-way.
\(or without --two-way for branches of arch in which --three-way is the
default).")

(custom-autoload 'tla-three-way-merge "tla-defs" t)

(defvar tla-show-ancestor nil "\
*If non-nil, merge operations are invoked with --show-ancestor.

With this option, conflicts markers will include TREE, MERGE-SOURCE,
and ancestor versions. `smerge-ediff' allows you to view the ancestor
with `ediff-show-ancestor' (usually bound to `/').

Unfortunately, this will also report more conflicts: Conflicts will be
reported even when TREE and MERGE-SOURCE are identical, if they differ
from ANCESTOR.")

(custom-autoload 'tla-show-ancestor "tla-defs" t)

(defvar tla-non-recursive-inventory t "\
*If non-nil, inventory is run with --no-recursion (if available).")

(custom-autoload 'tla-non-recursive-inventory "tla-defs" t)

(defvar tla-use-skip-present-option nil "\
*If non-nil, use --skip-present with commands that allow it.")

(custom-autoload 'tla-use-skip-present-option "tla-defs" t)

(autoload 'tla-toggle-three-way-merge "tla-defs" "\
Toggle the value of `tla-three-way-merge'.

\(fn)" t nil)

(autoload 'tla-toggle-show-ancestor "tla-defs" "\
Toggle the value of `tla-show-ancestor'.

\(fn)" t nil)

(autoload 'tla-toggle-non-recursive-inventory "tla-defs" "\
Toggle the value of `tla-toggle-non-recursive-inventory'.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("/\\(=tagging-method\\|\\.arch-inventory\\)$" . tla-inventory-file-mode))

;;;***

;;;### (autoloads nil "tla-dvc" "../../lisp/tla-dvc.el" (18329 28854))
;;; Generated autoloads from ../../lisp/tla-dvc.el

(dvc-register-dvc 'tla "GNU Arch")

(defalias 'tla-dvc-command-version 'tla-command-version)

(defalias 'tla-dvc-file-has-conflict-p 'tla-file-has-conflict-p)

;;;***

;;;### (autoloads (tla-insinuate-gnus) "tla-gnus" "../../lisp/tla-gnus.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/tla-gnus.el

(autoload 'tla-insinuate-gnus "tla-gnus" "\
Integrate the tla backend of DVC into Gnus.
Add the `tla-submit-patch-done' function to the
`message-sent-hook'.

The archives/categories/branches/version/revision names are buttonized
in the *Article* buffers.

\(fn)" t nil)

;;;***

;;;### (autoloads (tla-tests-run tla-tests-batch) "tla-tests" "../../lisp/tla-tests.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/tla-tests.el

(autoload 'tla-tests-batch "tla-tests" "\
Run all the available test-cases in batch mode.

\(fn)" t nil)

(autoload 'tla-tests-run "tla-tests" "\
Run the testcase TEST.

Switch HOME to the test directory, clear the log buffer, call the
function TEST, and check that the list of tla commands ran by calling
TEST is the same as the one expected, stored in
`tla-tests-command-alist'

\(fn TEST)" t nil)

;;;***

;;;### (autoloads (xdarcs-dvc-remove-files xdarcs-dvc-revert-files
;;;;;;  xdarcs-revision-get-last-revision xdarcs-dvc-diff xdarcs-pull
;;;;;;  xdarcs-missing xdarcs-whatsnew xdarcs-dvc-add-files) "xdarcs"
;;;;;;  "../../lisp/xdarcs.el" (18329 28854))
;;; Generated autoloads from ../../lisp/xdarcs.el

(autoload 'xdarcs-dvc-add-files "xdarcs" "\
Run darcs add.

\(fn &rest FILES)" nil nil)

(autoload 'xdarcs-whatsnew "xdarcs" "\
Run darcs whatsnew.

\(fn &optional PATH)" t nil)

(autoload 'xdarcs-missing "xdarcs" "\
Run 'darcs pull --dry-run -s -v' to see what's missing

\(fn)" t nil)

(autoload 'xdarcs-pull "xdarcs" "\
Run darcs pull --all

\(fn)" t nil)

(autoload 'xdarcs-dvc-diff "xdarcs" "\
Not documented

\(fn &optional AGAINST PATH DONT-SWITCH)" t nil)

(autoload 'xdarcs-revision-get-last-revision "xdarcs" "\
Insert the content of FILE in LAST-REVISION, in current buffer.

LAST-REVISION looks like
\(\"path\" NUM)

\(fn FILE LAST-REVISION)" nil nil)

(autoload 'xdarcs-dvc-revert-files "xdarcs" "\
Run darcs revert.

\(fn &rest FILES)" nil nil)

(autoload 'xdarcs-dvc-remove-files "xdarcs" "\
Run darcs remove.

\(fn &rest FILES)" nil nil)

;;;***

;;;### (autoloads (xdarcs-tree-root) "xdarcs-core" "../../lisp/xdarcs-core.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xdarcs-core.el

(autoload 'xdarcs-tree-root "xdarcs-core" "\
Return the tree root for LOCATION, nil if not in a local tree.
Computation is done from withing Emacs, by looking at an _darcs/
directory in a parent buffer of LOCATION.  This is therefore very
fast.

If NO-ERROR is non-nil, don't raise an error if LOCATION is not a
git managed tree (but return nil).

\(fn &optional LOCATION NO-ERROR INTERACTIVE)" nil nil)

;;;***

;;;### (autoloads nil "xdarcs-dvc" "../../lisp/xdarcs-dvc.el" (18329
;;;;;;  28854))
;;; Generated autoloads from ../../lisp/xdarcs-dvc.el

(dvc-register-dvc 'xdarcs "Darcs")

(defalias 'xdarcs-dvc-tree-root 'xdarcs-tree-root)

(defalias 'xdarcs-dvc-command-version 'xdarcs-command-version)

(defalias 'xdarcs-dvc-status 'xdarcs-whatsnew)

(defalias 'xdarcs-dvc-missing 'xdarcs-missing)

(defalias 'xdarcs-dvc-pull 'xdarcs-pull)

;;;***

;;;### (autoloads (xgit-revision-get-last-revision xgit-apply-mbox
;;;;;;  xgit-dvc-revert-files xgit-revert-file xgit-diff-head xgit-diff-index
;;;;;;  xgit-diff-cached xgit-dvc-diff xgit-addremove xgit-add-all-files
;;;;;;  xgit-dvc-remove-files xgit-remove xgit-dvc-add-files xgit-add
;;;;;;  xgit-clone xgit-init) "xgit" "../../lisp/xgit.el" (18329
;;;;;;  28854))
;;; Generated autoloads from ../../lisp/xgit.el

(autoload 'xgit-init "xgit" "\
Run git init.

\(fn &optional DIR)" t nil)

(autoload 'xgit-clone "xgit" "\
Run git clone.

\(fn SRC)" t nil)

(autoload 'xgit-add "xgit" "\
Add FILE to the current git project.

\(fn FILE)" t nil)

(autoload 'xgit-dvc-add-files "xgit" "\
Run git add.

\(fn &rest FILES)" nil nil)

(autoload 'xgit-remove "xgit" "\
Remove FILE from the current git project.
If FORCE is non-nil, then remove the file even if it has
uncommitted changes.

\(fn FILE &optional FORCE)" t nil)

(autoload 'xgit-dvc-remove-files "xgit" "\
Run git rm.

\(fn &rest FILES)" nil nil)

(autoload 'xgit-add-all-files "xgit" "\
Run 'git add .' to add all files in the current directory tree to git.

Normally run 'git add -n .' to simulate the operation to see
which files will be added.

Only when called with a prefix argument, add the files.

\(fn ARG)" t nil)

(autoload 'xgit-addremove "xgit" "\
Add all new files to the index, remove all deleted files from
the index, and add all changed files to the index.

This is done only for files in the current directory tree.

\(fn)" t nil)

(autoload 'xgit-dvc-diff "xgit" "\
Not documented

\(fn &optional AGAINST-REV PATH DONT-SWITCH)" t nil)

(autoload 'xgit-diff-cached "xgit" "\
Call \"git diff --cached\".

\(fn &optional AGAINST-REV PATH DONT-SWITCH)" t nil)

(autoload 'xgit-diff-index "xgit" "\
Call \"git diff\" (diff between tree and index).

\(fn &optional AGAINST-REV PATH DONT-SWITCH)" t nil)

(autoload 'xgit-diff-head "xgit" "\
Call \"git diff HEAD\".

\(fn &optional PATH DONT-SWITCH)" t nil)

(autoload 'xgit-revert-file "xgit" "\
Revert uncommitted changes made to FILE in the current branch.

\(fn FILE)" t nil)

(autoload 'xgit-dvc-revert-files "xgit" "\
Revert uncommitted changes made to FILES in the current branch.

\(fn &rest FILES)" nil nil)

(autoload 'xgit-apply-mbox "xgit" "\
Run git am to apply the contents of MBOX as one or more patches.

\(fn MBOX &optional FORCE)" t nil)

(autoload 'xgit-revision-get-last-revision "xgit" "\
Insert the content of FILE in LAST-REVISION, in current buffer.

LAST-REVISION looks like
\(\"path\" NUM)

\(fn FILE LAST-REVISION)" nil nil)

;;;***

;;;### (autoloads (xgit-prepare-environment xgit-tree-root) "xgit-core"
;;;;;;  "../../lisp/xgit-core.el" (18329 28854))
;;; Generated autoloads from ../../lisp/xgit-core.el

(autoload 'xgit-tree-root "xgit-core" "\
Return the tree root for LOCATION, nil if not in a local tree.
Computation is done from withing Emacs, by looking at an .git/
directory in a parent buffer of LOCATION.  This is therefore very
fast.

If NO-ERROR is non-nil, don't raise an error if LOCATION is not a
git managed tree (but return nil).

\(fn &optional LOCATION NO-ERROR INTERACTIVE)" nil nil)

(autoload 'xgit-prepare-environment "xgit-core" "\
Prepare the environment to run git.

\(fn ENV)" nil nil)

;;;***

;;;### (autoloads (xgit-dvc-log) "xgit-dvc" "../../lisp/xgit-dvc.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xgit-dvc.el

(dvc-register-dvc 'xgit "git")

(defalias 'xgit-dvc-tree-root 'xgit-tree-root)

(defalias 'xgit-dvc-command-version 'xgit-command-version)

(autoload 'xgit-dvc-log "xgit-dvc" "\
Shows the changelog in the current git tree.
ARG is passed as prefix argument

\(fn ARG LAST-N)" nil nil)

;;;***

;;;### (autoloads (xgit-insinuate-gnus) "xgit-gnus" "../../lisp/xgit-gnus.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xgit-gnus.el

(autoload 'xgit-insinuate-gnus "xgit-gnus" "\
Integrate Xgit into Gnus.
The following keybindings are installed for gnus-summary:
K t s `xgit-gnus-article-view-status-for-apply-patch'
K t v `xgit-gnus-article-view-patch'

The following keybindings are ignored:
K t l

\(fn)" t nil)

;;;***

;;;### (autoloads (xgit-log) "xgit-log" "../../lisp/xgit-log.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xgit-log.el

(autoload 'xgit-log "xgit-log" "\
Run git log for DIR.
DIR is a directory controlled by Git/Cogito.
CNT is max number of log to print.  If not specified, uses xgit-log-max-count.
LOG-REGEXP is regexp to filter logs by matching commit logs.
DIFF-MATCH is string to filter logs by matching commit diffs.
REV is revision to show.
FILE is filename in repostory to filter logs by matching filename.

\(fn DIR CNT &key LOG-REGEXP DIFF-MATCH REV FILE SINCE)" t nil)

;;;***

;;;### (autoloads (xhg-missing xhg-revision-get-last-revision xhg-update
;;;;;;  xhg-undo xhg-import xhg-export xhg-view xhg-annotate xhg-tags
;;;;;;  xhg-paths xhg-showconfig xhg-verify xhg-identify xhg-parents
;;;;;;  xhg-heads xhg-tip xhg-merge xhg-incoming xhg-clone xhg-pull
;;;;;;  xhg-dvc-diff xhg-log xhg-add-all-files xhg-forget xhg-dvc-rename
;;;;;;  xhg-addremove xhg-dvc-remove-files xhg-dvc-revert-files xhg-dvc-add-files
;;;;;;  xhg-init) "xhg" "../../lisp/xhg.el" (18329 28854))
;;; Generated autoloads from ../../lisp/xhg.el

(autoload 'xhg-init "xhg" "\
Run hg init.

\(fn &optional DIR)" t nil)

(autoload 'xhg-dvc-add-files "xhg" "\
Run hg add.

\(fn &rest FILES)" nil nil)

(autoload 'xhg-dvc-revert-files "xhg" "\
Run hg revert.

\(fn &rest FILES)" nil nil)

(autoload 'xhg-dvc-remove-files "xhg" "\
Run hg remove.

\(fn &rest FILES)" nil nil)

(autoload 'xhg-addremove "xhg" "\
Run hg addremove.

\(fn)" t nil)

(autoload 'xhg-dvc-rename "xhg" "\
Run hg rename.

\(fn FROM TO &optional AFTER FORCE)" t nil)

(autoload 'xhg-forget "xhg" "\
Run hg forget.

\(fn &rest FILES)" t nil)

(autoload 'xhg-add-all-files "xhg" "\
Run 'hg add' to add all files to mercurial.
Normally run 'hg add -n' to simulate the operation to see which files will be added.
Only when called with a prefix argument, add the files.

\(fn ARG)" t nil)

(autoload 'xhg-log "xhg" "\
Run hg log.
When run interactively, the prefix argument decides, which parameters are queried from the user.
C-u      : Show patches also, use all revisions
C-u C-u  : Show patches also, ask for revisions
positive : Don't show patches, ask for revisions.
negative : Don't show patches, limit to n revisions.

\(fn &optional R1 R2 SHOW-PATCH FILE)" t nil)

(autoload 'xhg-dvc-diff "xhg" "\
Run hg diff.
If DONT-SWITCH, don't switch to the diff buffer

\(fn &optional BASE-REV PATH DONT-SWITCH)" t nil)

(autoload 'xhg-pull "xhg" "\
Run hg pull.

\(fn SRC &optional UPDATE-AFTER-PULL)" t nil)

(autoload 'xhg-clone "xhg" "\
Run hg clone.

\(fn SRC &optional DEST NOUPDATE REV PULL)" t nil)

(autoload 'xhg-incoming "xhg" "\
Run hg incoming.

\(fn &optional SRC SHOW-PATCH NO-MERGES)" t nil)

(autoload 'xhg-merge "xhg" "\
Run hg merge.

\(fn &optional REVISION)" t nil)

(autoload 'xhg-tip "xhg" "\
Run hg tip.

\(fn)" t nil)

(autoload 'xhg-heads "xhg" "\
Run hg heads.

\(fn)" t nil)

(autoload 'xhg-parents "xhg" "\
Run hg parents.

\(fn)" t nil)

(autoload 'xhg-identify "xhg" "\
Run hg identify.

\(fn)" t nil)

(autoload 'xhg-verify "xhg" "\
Run hg verify.

\(fn)" t nil)

(autoload 'xhg-showconfig "xhg" "\
Run hg showconfig.

\(fn)" t nil)

(autoload 'xhg-paths "xhg" "\
Run hg paths.
When called interactive, display them in an *xhg-info* buffer.
Otherwise the return value depends on TYPE:
'alias:    Return only alias names
'path:     Return only the paths
'both      Return the aliases and the paths in a flat list
otherwise: Return a list of two element sublists containing alias, path

\(fn &optional TYPE)" t nil)

(autoload 'xhg-tags "xhg" "\
Run hg tags.

\(fn)" t nil)

(autoload 'xhg-annotate "xhg" "\
Run hg annotate.

\(fn)" t nil)

(autoload 'xhg-view "xhg" "\
Run hg view.

\(fn)" t nil)

(autoload 'xhg-export "xhg" "\
Run hg export.
`xhg-export-git-style-patches' determines, if git style patches are created.

\(fn REV FNAME)" t nil)

(autoload 'xhg-import "xhg" "\
Run hg import.

\(fn PATCH-FILE-NAME &optional FORCE)" t nil)

(autoload 'xhg-undo "xhg" "\
Run hg undo.

\(fn)" t nil)

(autoload 'xhg-update "xhg" "\
Run hg update.

\(fn)" t nil)

(autoload 'xhg-revision-get-last-revision "xhg" "\
Insert the content of FILE in LAST-REVISION, in current buffer.

LAST-REVISION looks like
\(\"path\" NUM)

\(fn FILE LAST-REVISION)" nil nil)

(autoload 'xhg-missing "xhg" "\
Shows the logs of the new arrived changesets after a pull and before an update.

\(fn)" t nil)

;;;***

;;;### (autoloads (xhg-tree-root) "xhg-core" "../../lisp/xhg-core.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xhg-core.el

(autoload 'xhg-tree-root "xhg-core" "\
Return the tree root for LOCATION, nil if not in a local tree.
Computation is done from withing Emacs, by looking at an .hg/
directory in a parent buffer of LOCATION.  This is therefore very
fast.

If NO-ERROR is non-nil, don't raise an error if LOCATION is not a
mercurial managed tree (but return nil).

\(fn &optional LOCATION NO-ERROR INTERACTIVE)" nil nil)

;;;***

;;;### (autoloads nil "xhg-dvc" "../../lisp/xhg-dvc.el" (18329 28854))
;;; Generated autoloads from ../../lisp/xhg-dvc.el

(dvc-register-dvc 'xhg "Mercurial")

(defalias 'xhg-dvc-tree-root 'xhg-tree-root)

(defalias 'xhg-dvc-merge 'xhg-merge)

(defalias 'xhg-dvc-save-diff 'xhg-save-diff)

(defalias 'xhg-dvc-command-version 'xhg-command-version)

;;;***

;;;### (autoloads (xhg-insinuate-gnus) "xhg-gnus" "../../lisp/xhg-gnus.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xhg-gnus.el

(autoload 'xhg-insinuate-gnus "xhg-gnus" "\
Integrate Xhg into Gnus.
The following keybindings are installed for gnus-summary:
K t s `xhg-gnus-article-view-status-for-import-patch'

\(fn)" t nil)

;;;***

;;;### (autoloads (xhg-mq-show-stack xhg-mq-export-via-mail xhg-qheader
;;;;;;  xhg-qprev xhg-qnext xhg-qtop xhg-qversion xhg-qrename xhg-qdelete
;;;;;;  xhg-qdiff xhg-qseries xhg-qunapplied xhg-qapplied xhg-qpush
;;;;;;  xhg-qpop xhg-qrefresh xhg-qnew xhg-qinit) "xhg-mq" "../../lisp/xhg-mq.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xhg-mq.el

(autoload 'xhg-qinit "xhg-mq" "\
Run hg qinit.
When called without a prefix argument run hg qinit -c, otherwise hg qinit.

\(fn &optional DIR QINIT-SWITCH)" t nil)

(autoload 'xhg-qnew "xhg-mq" "\
Run hg qnew.
Asks for the patch name and an optional commit description.
If the commit description is not empty, run hg qnew -m \"commit description\"
When called with a prefix argument run hg qnew -f.

\(fn PATCH-NAME &optional COMMIT-DESCRIPTION FORCE)" t nil)

(autoload 'xhg-qrefresh "xhg-mq" "\
Run hg qrefresh.

\(fn)" t nil)

(autoload 'xhg-qpop "xhg-mq" "\
Run hg qpop.
When called with a prefix argument run hg qpop -a.

\(fn &optional ALL)" t nil)

(autoload 'xhg-qpush "xhg-mq" "\
Run hg qpush.
When called with a prefix argument run hg qpush -a.

\(fn &optional ALL)" t nil)

(autoload 'xhg-qapplied "xhg-mq" "\
Run hg qapplied.

\(fn)" t nil)

(autoload 'xhg-qunapplied "xhg-mq" "\
Run hg qunapplied.

\(fn)" t nil)

(autoload 'xhg-qseries "xhg-mq" "\
Run hg qseries.

\(fn)" t nil)

(autoload 'xhg-qdiff "xhg-mq" "\
Run hg qdiff.

\(fn &optional FILE)" t nil)

(autoload 'xhg-qdelete "xhg-mq" "\
Run hg qdelete

\(fn PATCH)" t nil)

(autoload 'xhg-qrename "xhg-mq" "\
Run hg qrename

\(fn FROM TO)" t nil)

(autoload 'xhg-qversion "xhg-mq" "\
Run hg qversion.

\(fn)" t nil)

(autoload 'xhg-qtop "xhg-mq" "\
Run hg qtop.

\(fn)" t nil)

(autoload 'xhg-qnext "xhg-mq" "\
Run hg qnext.

\(fn)" t nil)

(autoload 'xhg-qprev "xhg-mq" "\
Run hg qprev.

\(fn)" t nil)

(autoload 'xhg-qheader "xhg-mq" "\
Run hg qheader.

\(fn PATCH)" t nil)

(autoload 'xhg-mq-export-via-mail "xhg-mq" "\
Prepare an email that contains a mq patch.
`xhg-submit-patch-mapping' is honored for the destination email address and the project name
that is used in the generated email.

\(fn PATCH)" t nil)

(autoload 'xhg-mq-show-stack "xhg-mq" "\
Show the mq stack.

\(fn)" t nil)

;;;***

;;;### (autoloads (xhg-dvc-log) "xhg-revision" "../../lisp/xhg-revision.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xhg-revision.el

(autoload 'xhg-dvc-log "xhg-revision" "\
Show a dvc formatted log for xhg.

\(fn PATH LAST-N)" t nil)

;;;***

;;;### (autoloads (xmtn-dvc-revision-nth-ancestor xmtn-revision-get-file-revision
;;;;;;  xmtn-revision-get-last-revision xmtn-revision-get-previous-revision
;;;;;;  xmtn-dvc-revert-files xmtn-dvc-pull xmtn-dvc-merge xmtn-dvc-update
;;;;;;  xmtn-send-enter-to-subprocess xmtn-dvc-rename xmtn-dvc-remove-files
;;;;;;  xmtn-dvc-add xmtn-dvc-add-files xmtn-dvc-backend-ignore-file-extensions-in-dir
;;;;;;  xmtn-dvc-backend-ignore-file-extensions xmtn-dvc-ignore-files
;;;;;;  xmtn-dvc-edit-ignore-files xmtn-dvc-name-construct xmtn-dvc-revision-direct-ancestor
;;;;;;  xmtn-dvc-status xmtn-dvc-command-version xmtn-dvc-delta xmtn-dvc-diff
;;;;;;  xmtn-dvc-search-file-in-diff xmtn-show-base-revision xmtn-dvc-log-edit-done
;;;;;;  xmtn-dvc-log-edit xmtn-dvc-log-edit-file-name-func) "xmtn-dvc"
;;;;;;  "../../lisp/xmtn-dvc.el" (18329 28854))
;;; Generated autoloads from ../../lisp/xmtn-dvc.el

(dvc-register-dvc 'xmtn "monotone")

(autoload 'xmtn-dvc-log-edit-file-name-func "xmtn-dvc" "\
Not documented

\(fn &optional ROOT)" nil nil)

(autoload 'xmtn-dvc-log-edit "xmtn-dvc" "\
Not documented

\(fn ROOT OTHER-FRAME NO-INIT)" nil nil)

(autoload 'xmtn-dvc-log-edit-done "xmtn-dvc" "\
Not documented

\(fn)" nil nil)

(autoload 'xmtn-show-base-revision "xmtn-dvc" "\
Show the base revision of the current monotone tree in the minibuffer.

\(fn)" t nil)

(autoload 'xmtn-dvc-search-file-in-diff "xmtn-dvc" "\
Not documented

\(fn FILE)" nil nil)

(autoload 'xmtn-dvc-diff "xmtn-dvc" "\
Not documented

\(fn &optional BASE-REV PATH DONT-SWITCH)" nil nil)

(autoload 'xmtn-dvc-delta "xmtn-dvc" "\
Not documented

\(fn FROM-REVISION-ID TO-REVISION-ID &optional DONT-SWITCH)" nil nil)

(autoload 'xmtn-dvc-command-version "xmtn-dvc" "\
Not documented

\(fn)" nil nil)

(autoload 'xmtn-dvc-status "xmtn-dvc" "\
Display status of monotone tree at `default-directory'.

\(fn)" nil nil)

(autoload 'xmtn-dvc-revision-direct-ancestor "xmtn-dvc" "\
Not documented

\(fn REVISION-ID)" nil nil)

(autoload 'xmtn-dvc-name-construct "xmtn-dvc" "\
Not documented

\(fn BACKEND-REVISION)" nil nil)

(autoload 'xmtn-dvc-edit-ignore-files "xmtn-dvc" "\
Not documented

\(fn)" nil nil)

(autoload 'xmtn-dvc-ignore-files "xmtn-dvc" "\
Not documented

\(fn FILE-NAMES)" nil nil)

(autoload 'xmtn-dvc-backend-ignore-file-extensions "xmtn-dvc" "\
Not documented

\(fn EXTENSIONS)" nil nil)

(autoload 'xmtn-dvc-backend-ignore-file-extensions-in-dir "xmtn-dvc" "\
Not documented

\(fn FILE-LIST)" nil nil)

(autoload 'xmtn-dvc-add-files "xmtn-dvc" "\
Not documented

\(fn &rest FILES)" nil nil)

(autoload 'xmtn-dvc-add "xmtn-dvc" "\
Not documented

\(fn FILE)" nil nil)

(autoload 'xmtn-dvc-remove-files "xmtn-dvc" "\
Not documented

\(fn &rest FILES)" nil nil)

(autoload 'xmtn-dvc-rename "xmtn-dvc" "\
Not documented

\(fn FROM-NAME TO-NAME BOOKKEEP-ONLY)" nil nil)

(autoload 'xmtn-send-enter-to-subprocess "xmtn-dvc" "\
Send an \"enter\" keystroke to a monotone subprocess.

To be used in an xmtn process buffer.  Useful when monotone
spawns an external merger and asks you to hit enter when
finished.

\(fn)" t nil)

(autoload 'xmtn-dvc-update "xmtn-dvc" "\
Not documented

\(fn)" nil nil)

(autoload 'xmtn-dvc-merge "xmtn-dvc" "\
Not documented

\(fn &optional OTHER)" nil nil)

(autoload 'xmtn-dvc-pull "xmtn-dvc" "\
Implement `dvc-pull' for xmtn.

\(fn)" nil nil)

(autoload 'xmtn-dvc-revert-files "xmtn-dvc" "\
Not documented

\(fn &rest FILE-NAMES)" nil nil)

(autoload 'xmtn-revision-get-previous-revision "xmtn-dvc" "\
Not documented

\(fn FILE REVISION-ID)" nil nil)

(autoload 'xmtn-revision-get-last-revision "xmtn-dvc" "\
Not documented

\(fn FILE STUFF)" nil nil)

(autoload 'xmtn-revision-get-file-revision "xmtn-dvc" "\
Not documented

\(fn FILE STUFF)" nil nil)

(autoload 'xmtn-dvc-revision-nth-ancestor "xmtn-dvc" "\
Not documented

\(fn &rest ARGS)" nil nil)

;;;***

;;;### (autoloads (xmtn-match--test) "xmtn-match" "../../lisp/xmtn-match.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xmtn-match.el

(autoload 'xmtn-match--test "xmtn-match" "\
Not documented

\(fn XMTN--THUNK)" nil nil)

;;;***

;;;### (autoloads (xmtn-tree-root) "xmtn-minimal" "../../lisp/xmtn-minimal.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xmtn-minimal.el

(autoload 'xmtn-tree-root "xmtn-minimal" "\
Not documented

\(fn &optional LOCATION NO-ERROR)" nil nil)

;;;***

;;;### (autoloads (xmtn-dvc-revlog-get-revision xmtn-view-revlist-for-selector
;;;;;;  xmtn-list-revisions-modifying-file xmtn-view-heads-revlist
;;;;;;  xmtn-dvc-missing xmtn-dvc-changelog xmtn-log xmtn-dvc-log
;;;;;;  xmtn-revision-list-entry-patch-printer xmtn-revision-refresh-maybe)
;;;;;;  "xmtn-revlist" "../../lisp/xmtn-revlist.el" (18329 28854))
;;; Generated autoloads from ../../lisp/xmtn-revlist.el

(autoload 'xmtn-revision-refresh-maybe "xmtn-revlist" "\
Not documented

\(fn)" nil nil)

(autoload 'xmtn-revision-list-entry-patch-printer "xmtn-revlist" "\
Not documented

\(fn PATCH)" nil nil)

(autoload 'xmtn-dvc-log "xmtn-revlist" "\
Not documented

\(fn PATH LAST-N)" nil nil)

(autoload 'xmtn-log "xmtn-revlist" "\
Not documented

\(fn &optional PATH LAST-N)" t nil)

(autoload 'xmtn-dvc-changelog "xmtn-revlist" "\
Not documented

\(fn &optional PATH)" nil nil)

(autoload 'xmtn-dvc-missing "xmtn-revlist" "\
Not documented

\(fn &optional OTHER)" nil nil)

(autoload 'xmtn-view-heads-revlist "xmtn-revlist" "\
Display a revlist buffer showing the heads of the current branch.

\(fn)" t nil)

(autoload 'xmtn-list-revisions-modifying-file "xmtn-revlist" "\
Display a revlist buffer showing the revisions that modify FILE.

Only ancestors of revision LAST-BACKEND-ID will be considered.
FILE is a file name in revision LAST-BACKEND-ID, which defaults
to the base revision of the current tree.

\(fn FILE &optional LAST-BACKEND-ID FIRST-LINE-ONLY-P LAST-N)" t nil)

(autoload 'xmtn-view-revlist-for-selector "xmtn-revlist" "\
Display a revlist buffer showing the revisions matching SELECTOR.

\(fn SELECTOR)" t nil)

(autoload 'xmtn-dvc-revlog-get-revision "xmtn-revlist" "\
Not documented

\(fn REVISION-ID)" nil nil)

;;;***

;;;### (autoloads (xmtn-check-command-version) "xmtn-run" "../../lisp/xmtn-run.el"
;;;;;;  (18329 28854))
;;; Generated autoloads from ../../lisp/xmtn-run.el

(autoload 'xmtn-check-command-version "xmtn-run" "\
Check and display the version identifier of the mtn command.

This command resets xmtn's command version cache.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../lisp/bzr-revlog.el" "../../lisp/dvc-annotate.el"
;;;;;;  "../../lisp/dvc-be.el" "../../lisp/dvc-buffers.el" "../../lisp/dvc-build.el"
;;;;;;  "../../lisp/dvc-cmenu.el" "../../lisp/dvc-config.el" "../../lisp/dvc-defs.el"
;;;;;;  "../../lisp/dvc-emacs.el" "../../lisp/dvc-fileinfo.el" "../../lisp/dvc-lisp.el"
;;;;;;  "../../lisp/dvc-preload.el" "../../lisp/dvc-revlist.el" "../../lisp/dvc-revlog.el"
;;;;;;  "../../lisp/dvc-state.el" "../../lisp/dvc-xemacs.el" "../../lisp/tla-autoconf.el"
;;;;;;  "../../lisp/xgit-annotate.el" "../../lisp/xgit-revision.el"
;;;;;;  "../../lisp/xhg-be.el" "../../lisp/xhg-log.el" "../../lisp/xmtn-automate.el"
;;;;;;  "../../lisp/xmtn-base.el" "../../lisp/xmtn-basic-io.el" "../../lisp/xmtn-compat.el"
;;;;;;  "../../lisp/xmtn-ids.el") (18329 29466 422244))

;;;***

(provide 'dvc-autoloads)

;;; Local Variables:
;;; version-control: never
;;; no-update-autoloads: t
;;; End:
;;; dvc-autoloads.el ends here
