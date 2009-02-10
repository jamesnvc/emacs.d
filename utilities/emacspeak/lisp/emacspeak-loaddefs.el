;;;Auto generated

;;;### (autoloads (cd-tool) "cd-tool" "cd-tool.el" (18832 52324))
;;; Generated autoloads from cd-tool.el

(autoload 'cd-tool "cd-tool" "\
Front-end to CDTool.
Bind this function to a convenient key-
Emacspeak users automatically have
this bound to <DEL> in the emacspeak keymap.

Key     Action
---     ------

+       Next Track
-       Previous Track
SPC     Pause or Resume
e       Eject
=       Shuffle
i       CD Info
p       Play
s       Stop
t       track
c       clip
cap C   Save clip to disk

\(fn)" t nil)

;;;***

;;;### (autoloads (dtk-set-chunk-separator-syntax dtk-toggle-splitting-on-white-space
;;;;;;  tts-show-debug-buffer tts-restart dtk-select-server dtk-resume
;;;;;;  dtk-resume-should-toggle dtk-pause tts-speak-version dtk-reset-state
;;;;;;  dtk-toggle-punctuation-mode dtk-set-punctuations-to-some
;;;;;;  dtk-set-punctuations-to-all dtk-set-punctuations dtk-set-character-scale
;;;;;;  dtk-set-predefined-speech-rate dtk-set-rate ems-generate-switcher
;;;;;;  dtk-add-cleanup-pattern dtk-speak-nonprinting-chars dtk-use-tones
;;;;;;  dtk-cleanup-patterns dtk-startup-hook dtk-speech-rate-step
;;;;;;  dtk-speech-rate-base dtk-stop-immediately-while-typing tts-strip-octals)
;;;;;;  "dtk-speak" "dtk-speak.el" (18832 52324))
;;; Generated autoloads from dtk-speak.el

(defvar tts-strip-octals nil "\
Set to T to strip all octal chars before speaking.
Particularly useful for web browsing.")

(custom-autoload 'tts-strip-octals "dtk-speak" t)

(defvar dtk-stop-immediately-while-typing t "\
*Set it to nil if you dont want speech to flush as you
type.  You can use command
`dtk-toggle-stop-immediately-while-typing' bound to
\\[dtk-toggle-stop-immediately-while-typing] to toggle this setting.")

(custom-autoload 'dtk-stop-immediately-while-typing "dtk-speak" t)

(defvar dtk-speech-rate-base 50 "\
*Value of lowest tolerable speech rate.")

(custom-autoload 'dtk-speech-rate-base "dtk-speak" t)

(defvar dtk-speech-rate-step 50 "\
*Value of speech rate increment.
This determines step size used when setting speech rate via command
`dtk-set-predefined-speech-rate'.  Formula used is
dtk-speech-rate-base  +  dtk-speech-rate-step*level.")

(custom-autoload 'dtk-speech-rate-step "dtk-speak" t)

(defvar dtk-startup-hook nil "\
List of hooks to be run after starting up the speech server.
Set things like speech rate, punctuation mode etc in this
hook.")

(custom-autoload 'dtk-startup-hook "dtk-speak" t)

(defvar dtk-cleanup-patterns (list "." "_" "-" "=" "/" "+" "*" ":" ";" "%" "{" "}" "~" "$" ")" "#" "/\\" "<>") "\
List of repeating patterns to clean up.
You can use  command  `dtk-add-cleanup-pattern'
 bound to \\[dtk-add-cleanup-pattern]  to add more patterns.
Specify patterns that people use to decorate their ASCII files, and cause
untold pain to the speech synthesizer.

If more than 3 consecutive occurrences
of a specified pattern is found, the TTS engine replaces it
with a repeat count. ")

(custom-autoload 'dtk-cleanup-patterns "dtk-speak" t)

(defvar dtk-use-tones t "\
Allow tones to be turned off.")

(custom-autoload 'dtk-use-tones "dtk-speak" t)

(defvar dtk-speak-nonprinting-chars nil "\
*Option that specifies handling of non-printing chars.
Non nil value means non printing characters  should be
spoken as their octal value.
Set this to t to avoid a dectalk bug that makes the speech box die if
it seems some accented characters in certain contexts.")

(custom-autoload 'dtk-speak-nonprinting-chars "dtk-speak" t)

(defsubst dtk-stop nil "\
Stop speech now." (interactive) (declare (special dtk-speaker-process)) (dtk-interp-stop))

(autoload 'dtk-add-cleanup-pattern "dtk-speak" "\
Add this pattern to the list of repeating patterns that
are cleaned up.  Optional interactive prefix arg deletes
this pattern if previously added.  Cleaning up repeated
patterns results in emacspeak speaking the pattern followed
by a repeat count instead of speaking all the characters
making up the pattern.  Thus, by adding the repeating
pattern `.' (this is already added by default) emacspeak
will say ``aw fifteen dot'' when speaking the string
``...............'' instead of ``period period period period
''

\(fn &optional DELETE)" t nil)

(autoload 'ems-generate-switcher "dtk-speak" "\
Generate desired command to switch the specified state.

\(fn COMMAND SWITCH DOCUMENTATION)" nil nil)

(autoload 'dtk-set-rate "dtk-speak" "\
Set speaking RATE for the tts.
Interactive PREFIX arg means set   the global default value, and then set the
current local  value to the result.

\(fn RATE &optional PREFIX)" t nil)

(autoload 'dtk-set-predefined-speech-rate "dtk-speak" "\
Set speech rate to one of nine predefined levels.
Interactive PREFIX arg says to set the rate globally.
Formula used is:
rate = dtk-speech-rate-base + dtk-speech-rate-step * level.

\(fn &optional PREFIX)" t nil)

(autoload 'dtk-set-character-scale "dtk-speak" "\
Set scale FACTOR for   speech rate.
Speech rate is scaled by this factor
when speaking characters.
Interactive PREFIX arg means set   the global default value, and then set the
current local  value to the result.

\(fn FACTOR &optional PREFIX)" t nil)

(autoload 'dtk-set-punctuations "dtk-speak" "\
Set punctuation mode to MODE.
Possible values are `some', `all', or `none'.
Interactive PREFIX arg means set   the global default value, and then set the
current local  value to the result.

\(fn MODE &optional PREFIX)" t nil)

(autoload 'dtk-set-punctuations-to-all "dtk-speak" "\
Set punctuation  mode to all.
Interactive PREFIX arg sets punctuation mode globally.

\(fn &optional PREFIX)" t nil)

(autoload 'dtk-set-punctuations-to-some "dtk-speak" "\
Set punctuation  mode to some.
Interactive PREFIX arg sets punctuation mode globally.

\(fn &optional PREFIX)" t nil)

(autoload 'dtk-toggle-punctuation-mode "dtk-speak" "\
Toggle punctuation mode between \"some\" and \"all\".
Interactive PREFIX arg makes the new setting global.

\(fn &optional PREFIX)" t nil)

(autoload 'dtk-reset-state "dtk-speak" "\
Restore sanity to the Dectalk.
Typically used after the Dectalk has been power   cycled.

\(fn)" t nil)

(autoload 'tts-speak-version "dtk-speak" "\
Speak version.

\(fn)" t nil)

(autoload 'dtk-pause "dtk-speak" "\
Pause ongoing speech.
The speech can be resumed with command `dtk-resume'
normally bound to \\[dtk-resume].  Pausing speech is useful when one needs to
perform a few actions before continuing to read a large document.  Emacspeak
gives you speech feedback as usual once speech has been paused.  `dtk-resume'
continues the interrupted speech irrespective of the buffer
in which it is executed.
Optional PREFIX arg flushes any previously paused speech.

\(fn &optional PREFIX)" t nil)

(defvar dtk-resume-should-toggle t "\
*T means `dtk-resume' acts as a toggle.")

(custom-autoload 'dtk-resume-should-toggle "dtk-speak" t)

(autoload 'dtk-resume "dtk-speak" "\
Resume paused speech.
This command resumes  speech that has been suspended by executing
command `dtk-pause' bound to \\[dtk-pause].
If speech has not been paused,
and option `dtk-resume-should-toggle' is set,
 then this command will pause ongoing speech.

\(fn)" t nil)

(autoload 'dtk-select-server "dtk-speak" "\
Select a speech server interactively.
Argument PROGRAM specifies the speech server program.
When called  interactively, The selected server is started immediately. 

\(fn PROGRAM)" t nil)

(autoload 'tts-restart "dtk-speak" "\
Use this to nuke the currently running TTS server and restart it.

\(fn)" t nil)

(autoload 'tts-show-debug-buffer "dtk-speak" "\
Select TTS debugging buffer.

\(fn)" t nil)

(autoload 'dtk-toggle-splitting-on-white-space "dtk-speak" "\
Toggle splitting of speech on white space.
This affects the internal state of emacspeak that decides if we split
text purely by clause boundaries, or also include
whitespace.  By default, emacspeak sends a clause at a time
to the speech device.  This produces fluent speech for
normal use.  However in modes such as `shell-mode' and some
programming language modes, clause markers appear
infrequently, and this can result in large amounts of text
being sent to the speech device at once, making the system
unresponsive when asked to stop talking.  Splitting on white
space makes emacspeak's stop command responsive.  However,
when splitting on white space, the speech sounds choppy
since the synthesizer is getting a word at a time.

\(fn)" t nil)

(autoload 'dtk-set-chunk-separator-syntax "dtk-speak" "\
Interactively set how text is split in chunks.
See the Emacs documentation on syntax tables for details on how characters are
classified into various syntactic classes.
Argument S specifies the syntax class.

\(fn S)" t nil)

;;;***

;;;### (autoloads (emacspeak emacspeak-unibyte emacspeak-play-emacspeak-startup-icon
;;;;;;  emacspeak-setup-programming-mode emacspeak-media-player emacspeak-startup-hook)
;;;;;;  "emacspeak" "emacspeak.el" (18832 52324))
;;; Generated autoloads from emacspeak.el

(defvar emacspeak-startup-hook nil "\
Hook to run after starting emacspeak.")

(custom-autoload 'emacspeak-startup-hook "emacspeak" t)

(defvar emacspeak-media-player 'emacspeak-m-player "\
Default media player to use.
This is a Lisp function that takes a resource locator.")

(custom-autoload 'emacspeak-media-player "emacspeak" t)

(autoload 'emacspeak-setup-programming-mode "emacspeak" "\
Setup programming mode. Turns on audio indentation and
sets punctuation mode to all, activates the dictionary and turns on split caps.

\(fn)" nil nil)

(defvar emacspeak-play-emacspeak-startup-icon nil "\
If set to T, emacspeak plays its icon as it launches.")

(custom-autoload 'emacspeak-play-emacspeak-startup-icon "emacspeak" t)

(defvar emacspeak-unibyte nil "\
Emacspeak will force emacs to unibyte unless this
variable is set to nil.
To use emacspeak with emacs running in multibyte mode, this
variable should be set to nil *before*
emacspeak is compiled or started.")

(custom-autoload 'emacspeak-unibyte "emacspeak" t)

(autoload 'emacspeak "emacspeak" "\
Starts the Emacspeak speech subsystem.  Use emacs as you
normally would, emacspeak will provide you spoken feedback
as you work.  Emacspeak also provides commands for having
parts of the current buffer, the mode-line etc to be spoken.

If you are hearing this description as a result of pressing
\\[emacspeak-describe-emacspeak] you may want to press
\\[dtk-stop] to stop speech, and then use the arrow keys to
move around in the Help buffer to read the rest of this
description, which includes a summary of all emacspeak
keybindings.

All emacspeak commands use \\[emacspeak-prefix-command] as a
prefix key.  You can also set the state of the TTS engine  by
using \\[emacspeak-dtk-submap-command] as a prefix.  Here is
a summary of all emacspeak commands along with their
bindings.  You need to precede the keystrokes listed below
with \\[emacspeak-prefix-command].

Emacspeak also provides a fluent speech extension to the
emacs terminal emulator (eterm).  Note: You need to use the
term package that comes with emacs-19.29 and later.

\\{emacspeak-keymap}

See the online documentation for individual commands and
functions for details.   

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-speak-cue-errors emacspeak-speak-messages-pause)
;;;;;;  "emacspeak-advice" "emacspeak-advice.el" (18832 52324))
;;; Generated autoloads from emacspeak-advice.el

(defvar emacspeak-speak-messages-pause nil "\
* Option to make messages pause speech.
If t then all messages will pause ongoing speech if any
before the message is spoken.")

(custom-autoload 'emacspeak-speak-messages-pause "emacspeak-advice" t)

(defvar emacspeak-speak-cue-errors t "\
Specifies if error messages are cued.")

(custom-autoload 'emacspeak-speak-cue-errors "emacspeak-advice" t)

;;;***

;;;### (autoloads (emacspeak-alsaplayer-cd emacspeak-alsaplayer-find-and-add-to-queue
;;;;;;  emacspeak-alsaplayer-launch emacspeak-alsaplayer-media-directory
;;;;;;  emacspeak-alsaplayer-program emacspeak-alsaplayer-auditory-feedback)
;;;;;;  "emacspeak-alsaplayer" "emacspeak-alsaplayer.el" (18832 52324))
;;; Generated autoloads from emacspeak-alsaplayer.el

(define-prefix-command 'emacspeak-alsaplayer-prefix-command 'emacspeak-alsaplayer-mode-map)

(defvar emacspeak-alsaplayer-auditory-feedback t "\
Turn this on if you want spoken feedback and auditory icons from alsaplayer.")

(custom-autoload 'emacspeak-alsaplayer-auditory-feedback "emacspeak-alsaplayer" t)

(defvar emacspeak-alsaplayer-program "alsaplayer" "\
Alsaplayer executable.")

(custom-autoload 'emacspeak-alsaplayer-program "emacspeak-alsaplayer" t)

(defvar emacspeak-alsaplayer-media-directory (expand-file-name "~/mp3/") "\
Directory to look for media files.")

(custom-autoload 'emacspeak-alsaplayer-media-directory "emacspeak-alsaplayer" t)

(autoload 'emacspeak-alsaplayer-launch "emacspeak-alsaplayer" "\
Launch Alsaplayer.
user is placed in a buffer associated with the newly created
Alsaplayer session.

\(fn)" t nil)

(autoload 'emacspeak-alsaplayer-find-and-add-to-queue "emacspeak-alsaplayer" "\
Find  specified resource and add to queue.

\(fn PATTERN)" t nil)

(autoload 'emacspeak-alsaplayer-cd "emacspeak-alsaplayer" "\
Change default directory, and silence its pronounciation.

\(fn DIRECTORY)" t nil)

;;;***

;;;### (autoloads (emacspeak-amphetadesk-quick-add emacspeak-amphetadesk)
;;;;;;  "emacspeak-amphetadesk" "emacspeak-amphetadesk.el" (18832
;;;;;;  52324))
;;; Generated autoloads from emacspeak-amphetadesk.el

(autoload 'emacspeak-amphetadesk "emacspeak-amphetadesk" "\
Open amphetadesk.
Interactive prefix-arg use-opml opens the myChannels.opml file.

\(fn &optional USE-OPML)" t nil)

(autoload 'emacspeak-amphetadesk-quick-add "emacspeak-amphetadesk" "\
Quick add URL to Amphetadesk by prompting for URL.

\(fn URL)" t nil)

;;;***

;;;### (autoloads (emacspeak-aumix-volume-decrease emacspeak-aumix-volume-increase
;;;;;;  emacspeak-aumix-wave-decrease emacspeak-aumix-wave-increase
;;;;;;  emacspeak-aumix-reset emacspeak-aumix-reset-options emacspeak-alsactl-program
;;;;;;  emacspeak-aumix-settings-file emacspeak-aumix) "emacspeak-aumix"
;;;;;;  "emacspeak-aumix.el" (18832 52324))
;;; Generated autoloads from emacspeak-aumix.el

(let ((loads (get 'emacspeak-aumix 'custom-loads))) (if (member '"emacspeak-aumix" loads) nil (put 'emacspeak-aumix 'custom-loads (cons '"emacspeak-aumix" loads))))

(defvar emacspeak-aumix-settings-file (when (file-exists-p (expand-file-name ".aumixrc" emacspeak-resource-directory)) (expand-file-name ".aumixrc" emacspeak-resource-directory)) "\
*Name of file containing personal aumix settings.")

(custom-autoload 'emacspeak-aumix-settings-file "emacspeak-aumix" t)

(defvar emacspeak-alsactl-program "alsactl" "\
ALSA sound controller used to restore settings.")

(custom-autoload 'emacspeak-alsactl-program "emacspeak-aumix" t)

(defvar emacspeak-aumix-reset-options (format "-f %s -L 2>&1 >/dev/null" emacspeak-aumix-settings-file) "\
*Option to pass to aumix for resetting to default values.")

(custom-autoload 'emacspeak-aumix-reset-options "emacspeak-aumix" t)

(autoload 'emacspeak-aumix-reset "emacspeak-aumix" "\
Reset to default audio settings.

\(fn)" t nil)

(autoload 'emacspeak-aumix-wave-increase "emacspeak-aumix" "\
Increase volume of wave output. 

\(fn &optional GAIN)" t nil)

(autoload 'emacspeak-aumix-wave-decrease "emacspeak-aumix" "\
Decrease volume of wave output. 

\(fn &optional GAIN)" t nil)

(autoload 'emacspeak-aumix-volume-increase "emacspeak-aumix" "\
Increase overall volume. 

\(fn &optional GAIN)" t nil)

(autoload 'emacspeak-aumix-volume-decrease "emacspeak-aumix" "\
Decrease overall volume. 

\(fn &optional GAIN)" t nil)

;;;***

;;;### (autoloads (emacspeak-appt-repeat-announcement) "emacspeak-calendar"
;;;;;;  "emacspeak-calendar.el" (18832 52324))
;;; Generated autoloads from emacspeak-calendar.el

(autoload 'emacspeak-appt-repeat-announcement "emacspeak-calendar" "\
Speaks the most recently displayed appointment message if any.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-custom-goto-toolbar emacspeak-custom-goto-group)
;;;;;;  "emacspeak-custom" "emacspeak-custom.el" (18832 52324))
;;; Generated autoloads from emacspeak-custom.el

(autoload 'emacspeak-custom-goto-group "emacspeak-custom" "\
Jump to custom group when in a customization buffer.

\(fn)" t nil)

(autoload 'emacspeak-custom-goto-toolbar "emacspeak-custom" "\
Jump to custom toolbar when in a customization buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-daisy-next-line emacspeak-daisy-define-outline-pattern
;;;;;;  emacspeak-daisy-previous-line emacspeak-daisy-play-audio-under-point
;;;;;;  emacspeak-daisy-play-content-under-point emacspeak-daisy-mark-position-in-content-under-point
;;;;;;  emacspeak-daisy-save-bookmarks emacspeak-daisy-open-book
;;;;;;  emacspeak-daisy-stop-audio emacspeak-daisy-play-page-range)
;;;;;;  "emacspeak-daisy" "emacspeak-daisy.el" (18832 52324))
;;; Generated autoloads from emacspeak-daisy.el

(autoload 'emacspeak-daisy-play-page-range "emacspeak-daisy" "\
Play pages in specified page range.

\(fn START END)" t nil)

(autoload 'emacspeak-daisy-stop-audio "emacspeak-daisy" "\
Stop audio.

\(fn)" t nil)

(autoload 'emacspeak-daisy-open-book "emacspeak-daisy" "\
Open Digital Talking Book specified by navigation file filename.

This is the main entry point to the  Emacspeak Daisy reader.
Opening a Daisy navigation file (.ncx file) results in a
navigation buffer that can be used to browse and read the book.

\(fn FILENAME)" t nil)

(autoload 'emacspeak-daisy-save-bookmarks "emacspeak-daisy" "\
Save bookmarks for current book.

\(fn)" t nil)

(autoload 'emacspeak-daisy-mark-position-in-content-under-point "emacspeak-daisy" "\
Mark current position in displayed content.
No-op if content under point is not currently displayed.

\(fn)" t nil)

(autoload 'emacspeak-daisy-play-content-under-point "emacspeak-daisy" "\
Play SMIL content  under point.

\(fn)" t nil)

(autoload 'emacspeak-daisy-play-audio-under-point "emacspeak-daisy" "\
Play audio clip under point.

\(fn)" t nil)

(autoload 'emacspeak-daisy-previous-line "emacspeak-daisy" "\
Move to previous line.

\(fn)" t nil)

(autoload 'emacspeak-daisy-define-outline-pattern "emacspeak-daisy" "\
Define persistent outline regexp for this book.

\(fn REGEXP)" t nil)

(autoload 'emacspeak-daisy-next-line "emacspeak-daisy" "\
Move to next line.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-eterm-remote-term emacspeak-eterm-cache-remote-host
;;;;;;  emacspeak-eterm-record-window emacspeak-eterm) "emacspeak-eterm"
;;;;;;  "emacspeak-eterm.el" (18832 52324))
;;; Generated autoloads from emacspeak-eterm.el

(let ((loads (get 'emacspeak-eterm 'custom-loads))) (if (member '"emacspeak-eterm" loads) nil (put 'emacspeak-eterm 'custom-loads (cons '"emacspeak-eterm" loads))))

(autoload 'emacspeak-eterm-record-window "emacspeak-eterm" "\
Insert this window definition into the table of terminal windows.
Argument WINDOW-ID specifies the window.
Argument TOP-LEFT  specifies top-left of window.
Argument BOTTOM-RIGHT  specifies bottom right of window.
Optional argument RIGHT-STRETCH  specifies if the window stretches to the right.
Optional argument LEFT-STRETCH  specifies if the window stretches to the left.

\(fn WINDOW-ID TOP-LEFT BOTTOM-RIGHT &optional RIGHT-STRETCH LEFT-STRETCH)" nil nil)

(defvar emacspeak-eterm-remote-hosts-table (make-vector 127 0) "\
obarray used for completing hostnames when prompting for a remote
host. Hosts are added whenever a new hostname is encountered, and the
list of known hostnames is persisted in file named by
emacspeak-eterm-remote-hostnames")

(autoload 'emacspeak-eterm-cache-remote-host "emacspeak-eterm" "\
Add this hostname to cache of remote hostnames

\(fn HOST)" nil nil)

(autoload 'emacspeak-eterm-remote-term "emacspeak-eterm" "\
Start a terminal-emulator in a new buffer.

\(fn HOST)" t nil)

;;;***

;;;### (autoloads (emacspeak-filtertext-revert emacspeak-filtertext)
;;;;;;  "emacspeak-filtertext" "emacspeak-filtertext.el" (18832 52324))
;;; Generated autoloads from emacspeak-filtertext.el

(autoload 'emacspeak-filtertext "emacspeak-filtertext" "\
Copy over text in region to special filtertext buffer in
preparation for interactively filtering text. 

\(fn START END)" t nil)

(autoload 'emacspeak-filtertext-revert "emacspeak-filtertext" "\
Revert to original text.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-firevox emacspeak-firevox-websearch
;;;;;;  emacspeak-firevox-read-parent emacspeak-firevox-read-previous
;;;;;;  emacspeak-firevox-read-next) "emacspeak-firevox" "emacspeak-firevox.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-firevox.el

(autoload 'emacspeak-firevox-read-next "emacspeak-firevox" "\
Read next item on page.

\(fn)" t nil)

(autoload 'emacspeak-firevox-read-previous "emacspeak-firevox" "\
Read next item on page.

\(fn)" t nil)

(autoload 'emacspeak-firevox-read-parent "emacspeak-firevox" "\
Read parent node.

\(fn)" t nil)

(autoload 'emacspeak-firevox-websearch "emacspeak-firevox" "\
Perform Websearch via the Firefox URL bar.

\(fn QUERY)" t nil)

(autoload 'emacspeak-firevox "emacspeak-firevox" "\
Creates FireVox interaction.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-fix-commands-loaded-from) "emacspeak-fix-interactive"
;;;;;;  "emacspeak-fix-interactive.el" (18832 52324))
;;; Generated autoloads from emacspeak-fix-interactive.el

(autoload 'emacspeak-fix-commands-loaded-from "emacspeak-fix-interactive" "\
Fix all commands loaded from a specified module.

\(fn MODULE)" t nil)

;;;***

;;;### (autoloads (emacspeak-forms-find-file) "emacspeak-forms" "emacspeak-forms.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-forms.el

(autoload 'emacspeak-forms-find-file "emacspeak-forms" "\
Visit a forms file

\(fn FILENAME)" t nil)

;;;***

;;;### (autoloads (emacspeak-gridtext-apply emacspeak-gridtext-save
;;;;;;  emacspeak-gridtext-load) "emacspeak-gridtext" "emacspeak-gridtext.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-gridtext.el

(autoload 'emacspeak-gridtext-load "emacspeak-gridtext" "\
Load saved grid settings.

\(fn FILE)" t nil)

(autoload 'emacspeak-gridtext-save "emacspeak-gridtext" "\
Save out grid settings.

\(fn FILE)" t nil)

(autoload 'emacspeak-gridtext-apply "emacspeak-gridtext" "\
Apply grid to region.

\(fn START END GRID)" t nil)

;;;***

;;;### (autoloads (emacspeak-hide-speak-block-sans-prefix emacspeak-hide-or-expose-all-blocks
;;;;;;  emacspeak-hide-or-expose-block emacspeak-hide-all-blocks-in-buffer)
;;;;;;  "emacspeak-hide" "emacspeak-hide.el" (18832 52324))
;;; Generated autoloads from emacspeak-hide.el

(autoload 'emacspeak-hide-all-blocks-in-buffer "emacspeak-hide" "\
Hide all blocks in current buffer.

\(fn)" nil nil)

(autoload 'emacspeak-hide-or-expose-block "emacspeak-hide" "\
Hide or expose a block of text.
This command either hides or exposes a block of text
starting on the current line.  A block of text is defined as
a portion of the buffer in which all lines start with a
common PREFIX.  Optional interactive prefix arg causes all
blocks in current buffer to be hidden or exposed.

\(fn &optional PREFIX)" t nil)

(autoload 'emacspeak-hide-or-expose-all-blocks "emacspeak-hide" "\
Hide or expose all blocks in buffer.

\(fn)" t nil)

(autoload 'emacspeak-hide-speak-block-sans-prefix "emacspeak-hide" "\
Speaks current block after stripping its prefix.
If the current block is not hidden, it first hides it.
This is useful because as you locate blocks, you can invoke this
command to listen to the block,
and when you have heard enough navigate easily  to move past the block.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-imenu-goto-previous-index-position emacspeak-imenu-goto-next-index-position)
;;;;;;  "emacspeak-imenu" "emacspeak-imenu.el" (18832 52324))
;;; Generated autoloads from emacspeak-imenu.el

(autoload 'emacspeak-imenu-goto-next-index-position "emacspeak-imenu" "\
Goto the next index position in current buffer

\(fn)" t nil)

(autoload 'emacspeak-imenu-goto-previous-index-position "emacspeak-imenu" "\
Goto the previous index position in current buffer

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-info-wizard) "emacspeak-info" "emacspeak-info.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-info.el

(autoload 'emacspeak-info-wizard "emacspeak-info" "\
Read a node spec from the minibuffer and launch
Info-goto-node.
See documentation for command `Info-goto-node' for details on
node-spec.

\(fn NODE-SPEC)" t nil)

;;;***

;;;### (autoloads (emacspeak-jawbreaker) "emacspeak-jawbreaker" "emacspeak-jawbreaker.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-jawbreaker.el

(autoload 'emacspeak-jawbreaker "emacspeak-jawbreaker" "\
Opens JawBreaker game in Firefox.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-keymap-remove-emacspeak-edit-commands
;;;;;;  emacspeak-keymap-choose-new-emacspeak-prefix emacspeak-hyper-keys
;;;;;;  emacspeak-alt-keys emacspeak-super-keys emacspeak-personal-keys)
;;;;;;  "emacspeak-keymap" "emacspeak-keymap.el" (18832 52324))
;;; Generated autoloads from emacspeak-keymap.el

(defvar emacspeak-keymap nil "\
Primary keymap used by emacspeak. ")

(defvar emacspeak-personal-keys nil "\
*Specifies personal key bindings for the audio desktop.
Bindings specified here are available on prefix key C-e x
for example, if you bind
`s' to command emacspeak-emergency-tts-restart
then that command will be available on key C-e x s

The value of this variable is an association list. The car
of each element specifies a key sequence. The cdr specifies
an interactive command that the key sequence executes. To
enter a key with a modifier, type C-q followed by the
desired modified keystroke. For example, to enter C-s
\(Control s) as the key to be bound, type C-q C-s in the key
field in the customization buffer.  You can use the notation
\[f1], [f2], etc., to specify function keys. ")

(custom-autoload 'emacspeak-personal-keys "emacspeak-keymap" nil)

(defvar emacspeak-super-keys nil "\
*Specifies super key bindings for the audio desktop.
You can turn the right `windows menu' keys on your Linux PC keyboard into a `super' key
on Linux by having it emit the sequence `C-x@s'.

Bindings specified here are available on prefix key `super'
for example, if you bind
`s' to command emacspeak-emergency-tts-restart
then that command will be available on key `super  s'

The value of this variable is an association list. The car
of each element specifies a key sequence. The cdr specifies
an interactive command that the key sequence executes. To
enter a key with a modifier, type C-q followed by the
desired modified keystroke. For example, to enter C-s
\(Control s) as the key to be bound, type C-q C-s in the key
field in the customization buffer.  You can use the notation
\[f1], [f2], etc., to specify function keys. ")

(custom-autoload 'emacspeak-super-keys "emacspeak-keymap" nil)

(defvar emacspeak-alt-keys nil "\
*Specifies alt key bindings for the audio desktop.
You can turn the `Pause' key  on your Linux PC keyboard into a `alt' key
on Linux by having it emit the sequence `C-x@a'.

Bindings specified here are available on prefix key `alt'
\(not to be confused with alt==meta)
for example, if you bind
`s' to command emacspeak-emergency-tts-restart
then that command will be available on key `ALT  s'

The value of this variable is an association list. The car
of each element specifies a key sequence. The cdr specifies
an interactive command that the key sequence executes. To
enter a key with a modifier, type C-q followed by the
desired modified keystroke. For example, to enter C-s
\(Control s) as the key to be bound, type C-q C-s in the key
field in the customization buffer.  You can use the notation
\[f1], [f2], etc., to specify function keys. ")

(custom-autoload 'emacspeak-alt-keys "emacspeak-keymap" nil)

(defvar emacspeak-hyper-keys nil "\
*Specifies hyper key bindings for the audio desktop.
Emacs can use the `hyper' key as a modifier key.
You can turn the `windows' keys on your Linux PC keyboard into a `hyper' key
on Linux by having it emit the sequence `C-x@h'.

Bindings specified here are available on prefix key  `hyper'
for example, if you bind
`b' to command `bbdb '
then that command will be available on key `hyper b'.

The value of this variable is an association list. The car
of each element specifies a key sequence. The cdr specifies
an interactive command that the key sequence executes. To
enter a key with a modifier, type C-q followed by the
desired modified keystroke. For example, to enter C-s
\(Control s) as the key to be bound, type C-q C-s in the key
field in the customization buffer.  You can use the notation
\[f1], [f2], etc., to specify function keys. ")

(custom-autoload 'emacspeak-hyper-keys "emacspeak-keymap" nil)

(autoload 'emacspeak-keymap-choose-new-emacspeak-prefix "emacspeak-keymap" "\
Interactively select a new prefix key to use for all emacspeak
commands.  The default is to use `C-e'  This command
lets you switch the prefix to something else.  This is a useful thing
to do if you run emacspeak on a remote machine from inside a terminal
that is running inside a local emacspeak session.  You can have the
remote emacspeak use a different control key to give your fingers some
relief.

\(fn PREFIX-KEY)" t nil)

(autoload 'emacspeak-keymap-remove-emacspeak-edit-commands "emacspeak-keymap" "\
We define keys that invoke editting commands to be undefined

\(fn KEYMAP)" nil nil)

;;;***

;;;### (autoloads (emacspeak-m-player-youtube-player emacspeak-m-player-get-length
;;;;;;  emacspeak-m-player-volume-down emacspeak-m-player-volume-up
;;;;;;  emacspeak-m-player emacspeak-multimedia emacspeak-m-player)
;;;;;;  "emacspeak-m-player" "emacspeak-m-player.el" (18832 52324))
;;; Generated autoloads from emacspeak-m-player.el

(let ((loads (get 'emacspeak-m-player 'custom-loads))) (if (member '"emacspeak-m-player" loads) nil (put 'emacspeak-m-player 'custom-loads (cons '"emacspeak-m-player" loads))))

(autoload 'emacspeak-multimedia "emacspeak-m-player" "\
Start or control Emacspeak multimedia player.

\(fn)" t nil)

(defvar emacspeak-media-extensions (concat (regexp-opt (list ".wma" ".m4a" ".flac" ".ogg" ".mp3" ".MP3" ".mp4") 'parens) "$") "\
Extensions that match media files.")

(autoload 'emacspeak-m-player "emacspeak-m-player" "\
Play specified resource using m-player.
Optional prefix argument play-list interprets resource as a play-list.
Resource is a media resource or playlist containing media resources.
The player is placed in a buffer in emacspeak-m-player-mode.

\(fn RESOURCE &optional PLAY-LIST)" t nil)

(autoload 'emacspeak-m-player-volume-up "emacspeak-m-player" "\
Increase volume.

\(fn)" t nil)

(autoload 'emacspeak-m-player-volume-down "emacspeak-m-player" "\
Decrease volume.

\(fn)" t nil)

(autoload 'emacspeak-m-player-get-length "emacspeak-m-player" "\
Display length of track in seconds.

\(fn)" t nil)

(autoload 'emacspeak-m-player-youtube-player "emacspeak-m-player" "\
Use youtube-dl and mplayer to stream YouTube content.

\(fn URL)" t nil)

;;;***

;;;### (autoloads (emacspeak-madplay emacspeak-madplay-madplay-call-command
;;;;;;  emacspeak-madplay-madplay-command) "emacspeak-madplay" "emacspeak-madplay.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-madplay.el

(define-prefix-command 'emacspeak-madplay-prefix-command 'emacspeak-madplay-mode-map)

(autoload 'emacspeak-madplay-madplay-command "emacspeak-madplay" "\
Execute Madplay command.

\(fn CHAR)" t nil)

(autoload 'emacspeak-madplay-madplay-call-command "emacspeak-madplay" "\
Call appropriate madplay command.

\(fn)" t nil)

(autoload 'emacspeak-madplay "emacspeak-madplay" "\
Play specified resource using madplay.
Resource is an  MP3 file or directory containing mp3 files.
The player is placed in a buffer in emacspeak-madplay-mode.

\(fn RESOURCE)" t nil)

;;;***

;;;### (autoloads (emacspeak-moz-visit-previous-and-browse emacspeak-moz-browse-current
;;;;;;  emacspeak-moz-locate-and-browse emacspeak-moz-id-browse emacspeak-moz-filter-and-browse
;;;;;;  emacspeak-moz-right emacspeak-moz-left emacspeak-moz-down
;;;;;;  emacspeak-moz-up emacspeak-moz-visit-next-and-browse emacspeak-moz-refresh
;;;;;;  emacspeak-moz-search emacspeak-moz-inspect emacspeak-moz-jump
;;;;;;  emacspeak-moz-browser-back emacspeak-moz-browser-forward
;;;;;;  emacspeak-moz-goto-url-at-point emacspeak-moz-goto-url emacspeak-moz-close-tab-or-browser
;;;;;;  emacspeak-moz-eval-expression-and-browse emacspeak-moz-eval-expression-and-go
;;;;;;  emacspeak-moz-eval-expression) "emacspeak-moz" "emacspeak-moz.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-moz.el

(autoload 'emacspeak-moz-eval-expression "emacspeak-moz" "\
Send expression to Moz.

\(fn EXP)" t nil)

(autoload 'emacspeak-moz-eval-expression-and-go "emacspeak-moz" "\
Send expression to Moz and switch to it.

\(fn EXP)" t nil)

(autoload 'emacspeak-moz-eval-expression-and-browse "emacspeak-moz" "\
Send expression to Moz, get output, and browse it in Emacs.

\(fn EXP)" t nil)

(autoload 'emacspeak-moz-close-tab-or-browser "emacspeak-moz" "\
Close tab, or browser when one tab left.

\(fn)" t nil)

(autoload 'emacspeak-moz-goto-url "emacspeak-moz" "\
Make Firefox used by our repl Go to the specified URL.

\(fn URL)" t nil)

(autoload 'emacspeak-moz-goto-url-at-point "emacspeak-moz" "\
Make Firefox used by our repl Go to url under point.

\(fn)" t nil)

(autoload 'emacspeak-moz-browser-forward "emacspeak-moz" "\
Move forward in history.

\(fn)" t nil)

(autoload 'emacspeak-moz-browser-back "emacspeak-moz" "\
Move back in history.

\(fn)" t nil)

(autoload 'emacspeak-moz-jump "emacspeak-moz" "\
Jump to specified index in history.

\(fn INDEX)" t nil)

(autoload 'emacspeak-moz-inspect "emacspeak-moz" "\
Inspect specified object.

\(fn WHAT)" t nil)

(autoload 'emacspeak-moz-search "emacspeak-moz" "\
Search for pattern in current context.

\(fn PATTERN)" t nil)

(autoload 'emacspeak-moz-refresh "emacspeak-moz" "\
Reload document.

\(fn)" t nil)

(autoload 'emacspeak-moz-visit-next-and-browse "emacspeak-moz" "\
Asks visitor to go  forward and browses the result.

\(fn)" t nil)

(autoload 'emacspeak-moz-up "emacspeak-moz" "\
Go Up a level and browse.

\(fn)" t nil)

(autoload 'emacspeak-moz-down "emacspeak-moz" "\
Go Down a level and browse.

\(fn)" t nil)

(autoload 'emacspeak-moz-left "emacspeak-moz" "\
Go left and browse.

\(fn)" t nil)

(autoload 'emacspeak-moz-right "emacspeak-moz" "\
Go right and browse.

\(fn)" t nil)

(autoload 'emacspeak-moz-filter-and-browse "emacspeak-moz" "\
Browse document filtered by XPath filter.

\(fn XPATH)" t nil)

(autoload 'emacspeak-moz-id-browse "emacspeak-moz" "\
Browse node having specified id.

\(fn ID)" t nil)

(autoload 'emacspeak-moz-locate-and-browse "emacspeak-moz" "\
Browse document filtered by element locator.

\(fn ELEMENT)" t nil)

(autoload 'emacspeak-moz-browse-current "emacspeak-moz" "\
Browse current node.

\(fn)" t nil)

(autoload 'emacspeak-moz-visit-previous-and-browse "emacspeak-moz" "\
Asks visitor to go  backward and browses the result.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-ocr-set-compress-image-options emacspeak-ocr-set-scan-image-options
;;;;;;  emacspeak-ocr-read-current-page emacspeak-ocr-page emacspeak-ocr-backward-page
;;;;;;  emacspeak-ocr-forward-page emacspeak-ocr-open-working-directory
;;;;;;  emacspeak-ocr-scan-and-recognize emacspeak-ocr-recognize-image
;;;;;;  emacspeak-ocr-save-current-page emacspeak-ocr-write-document
;;;;;;  emacspeak-ocr-scan-photo emacspeak-ocr-scan-image emacspeak-ocr-name-document
;;;;;;  emacspeak-ocr emacspeak-ocr-customize) "emacspeak-ocr" "emacspeak-ocr.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-ocr.el

(autoload 'emacspeak-ocr-customize "emacspeak-ocr" "\
Customize OCR settings.

\(fn)" t nil)

(autoload 'emacspeak-ocr "emacspeak-ocr" "\
An OCR front-end for the Emacspeak desktop.  

Page image is acquired using tools from the SANE package.
The acquired image is run through the OCR engine if one is
available, and the results placed in a buffer that is
suitable for browsing the results.

For detailed help, invoke command emacspeak-ocr bound to
\\[emacspeak-ocr] to launch emacspeak-ocr-mode, and press
`?' to display mode-specific help for emacspeak-ocr-mode.

\(fn)" t nil)

(autoload 'emacspeak-ocr-name-document "emacspeak-ocr" "\
Name document being scanned in the current OCR buffer.
Pick a short but meaningful name.

\(fn NAME)" t nil)

(autoload 'emacspeak-ocr-scan-image "emacspeak-ocr" "\
Acquire page image.

\(fn)" t nil)

(autoload 'emacspeak-ocr-scan-photo "emacspeak-ocr" "\
Scan in a photograph.
The scanned image is converted to JPEG.

\(fn &optional METADATA)" t nil)

(autoload 'emacspeak-ocr-write-document "emacspeak-ocr" "\
Writes out recognized text from all pages in current document.

\(fn)" t nil)

(autoload 'emacspeak-ocr-save-current-page "emacspeak-ocr" "\
Writes out recognized text from current page
to an appropriately named file.

\(fn)" t nil)

(autoload 'emacspeak-ocr-recognize-image "emacspeak-ocr" "\
Run OCR engine on current image.
Prompts for image file if file corresponding to the expected
`current page' is not found.

\(fn)" t nil)

(autoload 'emacspeak-ocr-scan-and-recognize "emacspeak-ocr" "\
Scan in a page and run OCR engine on it.
Use this command once you've verified that the separate
steps of acquiring an image and running the OCR engine work
correctly by themselves.

\(fn)" t nil)

(autoload 'emacspeak-ocr-open-working-directory "emacspeak-ocr" "\
Launch dired on OCR working directory.

\(fn)" t nil)

(autoload 'emacspeak-ocr-forward-page "emacspeak-ocr" "\
Like forward page, but tracks page number of current document.

\(fn &optional COUNT-IGNORED)" t nil)

(autoload 'emacspeak-ocr-backward-page "emacspeak-ocr" "\
Like backward page, but tracks page number of current document.

\(fn &optional COUNT-IGNORED)" t nil)

(autoload 'emacspeak-ocr-page "emacspeak-ocr" "\
Move to specified page.

\(fn)" t nil)

(autoload 'emacspeak-ocr-read-current-page "emacspeak-ocr" "\
Speaks current page.

\(fn)" t nil)

(autoload 'emacspeak-ocr-set-scan-image-options "emacspeak-ocr" "\
Interactively update scan image options.
Prompts with current setting in the minibuffer.
Setting persists for current Emacs session.

\(fn SETTING)" t nil)

(autoload 'emacspeak-ocr-set-compress-image-options "emacspeak-ocr" "\
Interactively update  image compression options.
Prompts with current setting in the minibuffer.
Setting persists for current Emacs session.

\(fn SETTING)" t nil)

;;;***

;;;### (autoloads (emacspeak-org-popup-input) "emacspeak-org" "emacspeak-org.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-org.el

(autoload 'emacspeak-org-popup-input "emacspeak-org" "\
Pops up an org input area.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-personality-prepend emacspeak-personality-append)
;;;;;;  "emacspeak-personality" "emacspeak-personality.el" (18832
;;;;;;  52324))
;;; Generated autoloads from emacspeak-personality.el

(defsubst emacspeak-personality-put (start end personality object) "\
Apply personality to specified region, over-writing any current
personality settings." (when (and (integer-or-marker-p start) (integer-or-marker-p end) (not (= start end))) (let ((v (if (listp personality) (delete-duplicates personality :test (function eq)) personality))) (ems-modify-buffer-safely (ad-Orig-put-text-property start end (quote personality) v object)))))

(autoload 'emacspeak-personality-append "emacspeak-personality" "\
Append specified personality to text bounded by start and end.
Existing personality properties on the text range are preserved.

\(fn START END PERSONALITY &optional OBJECT)" nil nil)

(autoload 'emacspeak-personality-prepend "emacspeak-personality" "\
Prepend specified personality to text bounded by start and end.
Existing personality properties on the text range are preserved.

\(fn START END PERSONALITY &optional OBJECT)" nil nil)

;;;***

;;;### (autoloads (emacspeak-piglets-silence emacspeak-piglets-key
;;;;;;  emacspeak-piglets-keypress emacspeak-piglets-enter emacspeak-piglets-tab
;;;;;;  emacspeak-piglets-tts-init) "emacspeak-piglets" "emacspeak-piglets.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-piglets.el

(autoload 'emacspeak-piglets-tts-init "emacspeak-piglets" "\
Start TTS  engine for Piglets.

\(fn)" t nil)

(autoload 'emacspeak-piglets-tab "emacspeak-piglets" "\
Send TAB to Firefox.

\(fn)" t nil)

(autoload 'emacspeak-piglets-enter "emacspeak-piglets" "\
Send enter to Firefox.

\(fn)" t nil)

(autoload 'emacspeak-piglets-keypress "emacspeak-piglets" "\
Send keypress to Firefox.

\(fn C)" t nil)

(autoload 'emacspeak-piglets-key "emacspeak-piglets" "\
Send last keypress to Firefox.

\(fn)" t nil)

(autoload 'emacspeak-piglets-silence "emacspeak-piglets" "\
Stop speech output from FireVox.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-pronounce-dispatch emacspeak-pronounce-edit-pronunciations
;;;;;;  emacspeak-pronounce-refresh-pronunciations emacspeak-pronounce-toggle-use-of-dictionaries
;;;;;;  emacspeak-pronounce-define-pronunciation emacspeak-pronounce-define-template-pronunciation
;;;;;;  emacspeak-pronounce-define-local-pronunciation emacspeak-pronounce-clear-dictionaries
;;;;;;  emacspeak-pronounce-load-dictionaries emacspeak-pronounce-save-dictionaries)
;;;;;;  "emacspeak-pronounce" "emacspeak-pronounce.el" (18832 52324))
;;; Generated autoloads from emacspeak-pronounce.el

(autoload 'emacspeak-pronounce-save-dictionaries "emacspeak-pronounce" "\
Writes out the persistent emacspeak pronunciation dictionaries.

\(fn)" t nil)

(autoload 'emacspeak-pronounce-load-dictionaries "emacspeak-pronounce" "\
Load pronunciation dictionaries.
Optional argument FILENAME specifies the dictionary file.

\(fn &optional FILENAME)" t nil)

(autoload 'emacspeak-pronounce-clear-dictionaries "emacspeak-pronounce" "\
Clear all current pronunciation dictionaries.

\(fn)" t nil)

(defsubst emacspeak-pronounce-yank-word nil "\
Yank word at point into minibuffer." (interactive) (declare (special emacspeak-pronounce-yank-word-point emacspeak-pronounce-current-buffer)) (let ((string (save-excursion (set-buffer emacspeak-pronounce-current-buffer) (goto-char emacspeak-pronounce-yank-word-point) (buffer-substring-no-properties (point) (save-excursion (forward-word 1) (setq emacspeak-pronounce-yank-word-point (point))))))) (insert string) (dtk-speak string)))

(autoload 'emacspeak-pronounce-define-local-pronunciation "emacspeak-pronounce" "\
Define buffer local pronunciation.
Argument WORD specifies the word which should be pronounced as specified by PRONUNCIATION.

\(fn WORD PRONUNCIATION)" t nil)

(autoload 'emacspeak-pronounce-define-template-pronunciation "emacspeak-pronounce" "\
Interactively define template entries in the pronunciation dictionaries.
Default term to define is delimited by region.
First loads any persistent dictionaries if not already loaded.

\(fn)" t nil)

(autoload 'emacspeak-pronounce-define-pronunciation "emacspeak-pronounce" "\
Interactively define entries in the pronunciation dictionaries.
Default term to define is delimited by region.
First loads any persistent dictionaries if not already loaded.

\(fn)" t nil)

(autoload 'emacspeak-pronounce-toggle-use-of-dictionaries "emacspeak-pronounce" "\
Toggle use of pronunciation dictionaries in current buffer.
Pronunciations can be defined on a per file, per directory and/or per
mode basis.
Pronunciations are activated on a per buffer basis.
Turning on the use of pronunciation dictionaries results in emacspeak
composing a pronunciation table based on the currently defined
pronunciation dictionaries.
After this, the pronunciations will be applied whenever text in the
buffer is spoken.
Optional argument state can be used from Lisp programs to
explicitly turn pronunciations on or off.

\(fn &optional STATE)" t nil)

(autoload 'emacspeak-pronounce-refresh-pronunciations "emacspeak-pronounce" "\
Refresh pronunciation table for current buffer.
Activates pronunciation dictionaries if not already active.

\(fn)" t nil)

(autoload 'emacspeak-pronounce-edit-pronunciations "emacspeak-pronounce" "\
Prompt for and launch a pronunciation editor on the
specified pronunciation dictionary key.

\(fn KEY)" t nil)

(autoload 'emacspeak-pronounce-dispatch "emacspeak-pronounce" "\
Provides the user interface front-end to Emacspeak's pronunciation dictionaries.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-realaudio-browse emacspeak-realaudio
;;;;;;  emacspeak-realaudio-write-mp3-clip emacspeak-realaudio-mp3-clipper
;;;;;;  emacspeak-realaudio-set-end-mark emacspeak-realaudio-set-start-mark
;;;;;;  emacspeak-realaudio-get-current-time-in-seconds emacspeak-realaudio-process-sentinel
;;;;;;  emacspeak-realaudio-play) "emacspeak-realaudio" "emacspeak-realaudio.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-realaudio.el

(defvar emacspeak-realaudio-last-url nil "\
Records the last RealAudio resource we played")

(defvar emacspeak-realaudio-history nil "\
History list holding resources we played recently")

(defvar emacspeak-realaudio-shortcuts-directory (expand-file-name "realaudio/" emacspeak-directory) "\
*Directory where we keep realaudio shortcuts.
I typically keep .ram --RealAudio metafiles-- in this
directory.
Realaudio metafiles typically contain a single line that
specifies the actual location of the realaudio stream
--typically the .ra file.")

(autoload 'emacspeak-realaudio-play "emacspeak-realaudio" "\
Play a realaudio stream.  Uses files from your Realaudio
shortcuts directory for completion.  See documentation for
user configurable variable emacspeak-realaudio-shortcuts-directory. 

\(fn RESOURCE &optional PLAY-LIST)" t nil)

(autoload 'emacspeak-realaudio-process-sentinel "emacspeak-realaudio" "\
Cleanup after realaudio is done. 

\(fn PROCESS STATE)" nil nil)

(autoload 'emacspeak-realaudio-get-current-time-in-seconds "emacspeak-realaudio" "\
Return current time in seconds.

\(fn)" t nil)

(autoload 'emacspeak-realaudio-set-start-mark "emacspeak-realaudio" "\
Set start mark. Default is to set marker to current play time.
Mark is specified in seconds.

\(fn &optional MARK-TIME)" t nil)

(autoload 'emacspeak-realaudio-set-end-mark "emacspeak-realaudio" "\
Set end mark. Default is to set marker to current play time.
Mark is specified in seconds.

\(fn &optional MARK-TIME)" t nil)

(defvar emacspeak-realaudio-mp3-clipper "/usr/local/bin/qmp3cut" "\
Executable used to clip MP3 files.")

(custom-autoload 'emacspeak-realaudio-mp3-clipper "emacspeak-realaudio" t)

(autoload 'emacspeak-realaudio-write-mp3-clip "emacspeak-realaudio" "\
Writes specified clip from current mp3 stream.
Prompts for start and end times as well as file  to save the clippi

\(fn START END FILE)" t nil)

(autoload 'emacspeak-realaudio "emacspeak-realaudio" "\
Start or control streaming audio including MP3 and
realaudio.  If using `TRPlayer' as the player, accepts
trplayer control commands if a stream is already playing.
Otherwise, the playing stream is simply stopped.  If no
stream is playing, this command prompts for a realaudio
resource.  Realaudio resources can be specified either as a
Realaudio URL, the location of a local Realaudio file, or as
the name of a local Realaudio metafile. Realaudio resources
you have played in this session are available in the
minibuffer history.  The default is to play the resource you
played most recently. Emacspeak uses the contents of the
directory specified by variable
emacspeak-realaudio-shortcuts-directory to offer a set of
completions. Hit space to use this completion list.

If using TRPlayer, you can either give one-shot commands
using command emacspeak-realaudio available from anywhere on
the audio desktop as `\\[emacspeak-realaudio]'.
Alternatively, switch to buffer *realaudio* using
`\\[emacspeak-realaudio];' if you wish to issue many
navigation commands.  Note that buffer *realaudio* uses a
special major mode that provides the various navigation
commands via single keystrokes.

\(fn &optional IGNORED)" t nil)

(autoload 'emacspeak-realaudio-browse "emacspeak-realaudio" "\
Browse RAM file before playing the selected component.

\(fn RAMFILE &optional START-TIME)" t nil)

(defvar emacspeak-realaudio-trplayer-keys (list 112 116 115 101 108 105 60 62 46 44 48 57 91 93 123 125) "\
Keys accepted by TRPlayer.")

;;;***

;;;### (autoloads (emacspeak-remote-connect-to-server emacspeak-remote-ssh-to-server
;;;;;;  emacspeak-remote-home emacspeak-remote-quick-connect-to-server
;;;;;;  emacspeak-remote-use-ssh emacspeak-remote-edit-current-remote-hostname
;;;;;;  emacspeak-remote) "emacspeak-remote" "emacspeak-remote.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-remote.el

(let ((loads (get 'emacspeak-remote 'custom-loads))) (if (member '"emacspeak-remote" loads) nil (put 'emacspeak-remote 'custom-loads (cons '"emacspeak-remote" loads))))

(autoload 'emacspeak-remote-edit-current-remote-hostname "emacspeak-remote" "\
Interactively set up where we came from.
Value is persisted for use with ssh servers.

\(fn)" t nil)

(defvar emacspeak-remote-use-ssh nil "\
Set to T to use SSH remote servers.")

(custom-autoload 'emacspeak-remote-use-ssh "emacspeak-remote" t)

(autoload 'emacspeak-remote-quick-connect-to-server "emacspeak-remote" "\
Connect to remote server.
Does not prompt for host or port, but quietly uses the
guesses that appear as defaults when prompting.
Use this once you are sure the guesses are usually correct.

\(fn)" t nil)

(autoload 'emacspeak-remote-home "emacspeak-remote" "\
Open ssh session to where we came from.
Uses value returned by `emacspeak-remote-get-current-remote-hostname'.

\(fn)" t nil)

(autoload 'emacspeak-remote-ssh-to-server "emacspeak-remote" "\
Open ssh session to where we came from.

\(fn LOGIN HOST PORT)" t nil)

(autoload 'emacspeak-remote-connect-to-server "emacspeak-remote" "\
Connect to and start using remote speech server running on host host
and listening on port port.  Host is the hostname of the remote
server, typically the desktop machine.  Port is the tcp port that that
host is listening on for speech requests.

\(fn HOST PORT)" t nil)

;;;***

;;;### (autoloads nil "emacspeak-setup" "emacspeak-setup.el" (18832
;;;;;;  52324))
;;; Generated autoloads from emacspeak-setup.el

(defvar emacspeak-directory (expand-file-name "../" (file-name-directory load-file-name)) "\
Directory where emacspeak is installed. ")

(defvar emacspeak-lisp-directory (expand-file-name "lisp/" emacspeak-directory) "\
Directory where emacspeak lisp files are  installed. ")

(defvar emacspeak-sounds-directory (expand-file-name "sounds/" emacspeak-directory) "\
Directory containing auditory icons for Emacspeak.")

(defvar emacspeak-xslt-directory (expand-file-name "xsl/" emacspeak-directory) "\
Directory holding XSL transformations.")

(defvar emacspeak-etc-directory (expand-file-name "etc/" emacspeak-directory) "\
Directory containing miscellaneous files  for
  Emacspeak.")

(defvar emacspeak-servers-directory (expand-file-name "servers/" emacspeak-directory) "\
Directory containing speech servers  for
  Emacspeak.")

(defvar emacspeak-info-directory (expand-file-name "info/" emacspeak-directory) "\
Directory containing  Emacspeak info files.")

(defvar emacspeak-resource-directory (expand-file-name "~/.emacspeak/") "\
Directory where Emacspeak resource files such as
pronunciation dictionaries are stored. ")

(defvar emacspeak-readme-file (expand-file-name "README" emacspeak-directory) "\
README file from where we get SVN revision number.")

(defconst emacspeak-version (eval-when-compile (format "29.0 %s" (cond ((file-exists-p emacspeak-readme-file) (let ((buffer (find-file-noselect emacspeak-readme-file)) (revision nil)) (save-excursion (set-buffer buffer) (goto-char (point-min)) (setq revision (format "Revision %s" (or (nth 2 (split-string (buffer-substring-no-properties (line-beginning-position) (line-end-position)))) "unknown")))) (kill-buffer buffer) revision)) (t "")))) "\
Version number for Emacspeak.")

(defconst emacspeak-codename "AbleDog" "\
Code name of present release.")

;;;***

;;;### (autoloads (emacspeak-sounds-reset-sound emacspeak-set-auditory-icon-player
;;;;;;  emacspeak-toggle-auditory-icons emacspeak-auditory-icon emacspeak-serve-auditory-icon
;;;;;;  emacspeak-native-auditory-icon emacspeak-queue-auditory-icon
;;;;;;  emacspeak-sounds-select-theme emacspeak-play-program emacspeak-sounds-default-theme
;;;;;;  emacspeak-sounds-define-theme emacspeak-audio-setup) "emacspeak-sounds"
;;;;;;  "emacspeak-sounds.el" (18832 52324))
;;; Generated autoloads from emacspeak-sounds.el

(autoload 'emacspeak-audio-setup "emacspeak-sounds" "\
Call appropriate audio environment set command.

\(fn)" t nil)

(autoload 'emacspeak-sounds-define-theme "emacspeak-sounds" "\
Define a sounds theme for auditory icons. 

\(fn THEME-NAME FILE-EXT)" nil nil)

(defvar emacspeak-sounds-default-theme (expand-file-name "default-8k/" emacspeak-sounds-directory) "\
Default theme for auditory icons. ")

(custom-autoload 'emacspeak-sounds-default-theme "emacspeak-sounds" t)

(defvar emacspeak-play-program (cond ((getenv "EMACSPEAK_PLAY_PROGRAM") (getenv "EMACSPEAK_PLAY_PROGRAM")) ((file-exists-p "/usr/bin/aplay") "/usr/bin/aplay") ((file-exists-p "/usr/bin/play") "/usr/bin/play") ((file-exists-p "/usr/bin/audioplay") "/usr/bin/audioplay") ((file-exists-p "/usr/demo/SOUND/play") "/usr/demo/SOUND/play") (t (expand-file-name emacspeak-etc-directory "play"))) "\
Name of executable that plays sound files. ")

(custom-autoload 'emacspeak-play-program "emacspeak-sounds" t)

(autoload 'emacspeak-sounds-select-theme "emacspeak-sounds" "\
Select theme for auditory icons.

\(fn THEME)" t nil)

(defsubst emacspeak-get-sound-filename (sound-name) "\
Retrieve name of sound file that produces  auditory icon SOUND-NAME." (declare (special emacspeak-sounds-themes-table emacspeak-sounds-current-theme)) (let ((f (expand-file-name (format "%s%s" sound-name (emacspeak-sounds-theme-get-extension emacspeak-sounds-current-theme)) emacspeak-sounds-current-theme))) (if (file-exists-p f) f emacspeak-default-sound)))

(autoload 'emacspeak-queue-auditory-icon "emacspeak-sounds" "\
Queue auditory icon SOUND-NAME.

\(fn SOUND-NAME)" nil nil)

(autoload 'emacspeak-native-auditory-icon "emacspeak-sounds" "\
Play auditory icon using native Emacs player.

\(fn SOUND-NAME)" nil nil)

(autoload 'emacspeak-serve-auditory-icon "emacspeak-sounds" "\
Serve auditory icon SOUND-NAME.
Sound is served only if `emacspeak-use-auditory-icons' is true.
See command `emacspeak-toggle-auditory-icons' bound to \\[emacspeak-toggle-auditory-icons ].

\(fn SOUND-NAME)" nil nil)

(autoload 'emacspeak-auditory-icon "emacspeak-sounds" "\
Play an auditory ICON.

\(fn ICON)" nil nil)

(autoload 'emacspeak-toggle-auditory-icons "emacspeak-sounds" "\
Toggle use of auditory icons.
Optional interactive PREFIX arg toggles global value.

\(fn &optional PREFIX)" t nil)

(autoload 'emacspeak-set-auditory-icon-player "emacspeak-sounds" "\
Select  player used for producing auditory icons.
Recommended choices:

emacspeak-serve-auditory-icon for  the wave device.
emacspeak-queue-auditory-icon when using software TTS.

\(fn PLAYER)" t nil)

(autoload 'emacspeak-sounds-reset-sound "emacspeak-sounds" "\
Reload sound drivers.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-speak-load-directory-settings emacspeak-speak-message-at-time
;;;;;;  emacspeak-speak-and-skip-extent-upto-this-char emacspeak-speak-and-skip-extent-upto-char
;;;;;;  emacspeak-mark-backward-mark emacspeak-completions-move-to-completion-group
;;;;;;  emacspeak-switch-to-reference-buffer emacspeak-speak-spaces-at-point
;;;;;;  emacspeak-voicify-region emacspeak-voicify-rectangle emacspeak-speak-rectangle
;;;;;;  emacspeak-speak-sexp-interactively emacspeak-speak-word-interactively
;;;;;;  emacspeak-speak-page-interactively emacspeak-speak-paragraph-interactively
;;;;;;  emacspeak-speak-line-interactively emacspeak-speak-help-interactively
;;;;;;  emacspeak-speak-buffer-interactively emacspeak-speak-predefined-window
;;;;;;  emacspeak-owindow-speak-line emacspeak-owindow-previous-line
;;;;;;  emacspeak-owindow-next-line emacspeak-owindow-scroll-down
;;;;;;  emacspeak-owindow-scroll-up emacspeak-speak-previous-window
;;;;;;  emacspeak-speak-next-window emacspeak-speak-other-window
;;;;;;  emacspeak-speak-current-window emacspeak-speak-window-information
;;;;;;  emacspeak-speak-message-again emacspeak-speak-previous-field
;;;;;;  emacspeak-speak-comint-send-input emacspeak-completion-pick-completion
;;;;;;  emacspeak-speak-skim-buffer emacspeak-speak-skim-next-paragraph
;;;;;;  emacspeak-speak-skim-paragraph emacspeak-speak-browse-buffer
;;;;;;  emacspeak-speak-continuously emacspeak-execute-repeatedly
;;;;;;  emacspeak-speak-previous-face-chunk emacspeak-speak-next-face-chunk
;;;;;;  emacspeak-speak-this-face-chunk emacspeak-speak-previous-personality-chunk
;;;;;;  emacspeak-speak-next-personality-chunk emacspeak-speak-this-personality-chunk
;;;;;;  emacspeak-speak-current-mark emacspeak-dial-dtk emacspeak-zap-tts
;;;;;;  emacspeak-speak-current-kill emacspeak-speak-version emacspeak-speak-time
;;;;;;  emacspeak-speak-world-clock emacspeak-read-next-word emacspeak-read-previous-word
;;;;;;  emacspeak-read-next-line emacspeak-read-previous-line emacspeak-toggle-header-line
;;;;;;  emacspeak-use-header-line emacspeak-speak-buffer-filename
;;;;;;  emacspeak-speak-minor-mode-line emacspeak-get-current-completion
;;;;;;  emacspeak-speak-minibuffer emacspeak-speak-help emacspeak-speak-rest-of-buffer
;;;;;;  emacspeak-speak-front-of-buffer emacspeak-speak-other-buffer
;;;;;;  emacspeak-speak-buffer emacspeak-speak-paragraph emacspeak-speak-page
;;;;;;  emacspeak-speak-sexp emacspeak-speak-sentence emacspeak-speak-set-display-table
;;;;;;  emacspeak-speak-display-char emacspeak-speak-char emacspeak-speak-word
;;;;;;  emacspeak-speak-spell-current-word emacspeak-character-echo
;;;;;;  emacspeak-word-echo emacspeak-line-echo emacspeak-speak-embedded-url-pattern)
;;;;;;  "emacspeak-speak" "emacspeak-speak.el" (18832 52324))
;;; Generated autoloads from emacspeak-speak.el

(defvar emacspeak-speak-embedded-url-pattern "<http:.*>" "\
Pattern to recognize embedded URLs.")

(custom-autoload 'emacspeak-speak-embedded-url-pattern "emacspeak-speak" t)

(defvar emacspeak-line-echo nil "\
If t, then emacspeak echoes lines as you type.
You can use \\[emacspeak-toggle-line-echo] to set this
option.")

(custom-autoload 'emacspeak-line-echo "emacspeak-speak" t)

(defvar emacspeak-word-echo t "\
If t, then emacspeak echoes words as you type.
You can use \\[emacspeak-toggle-word-echo] to toggle this
option.")

(custom-autoload 'emacspeak-word-echo "emacspeak-speak" t)

(defvar emacspeak-character-echo t "\
If t, then emacspeak echoes characters  as you type.
You can
use \\[emacspeak-toggle-character-echo] to toggle this
setting.")

(custom-autoload 'emacspeak-character-echo "emacspeak-speak" t)
                         ;

(autoload 'emacspeak-speak-spell-current-word "emacspeak-speak" "\
Spell word at  point.

\(fn)" t nil)

(autoload 'emacspeak-speak-word "emacspeak-speak" "\
Speak current word.
With prefix ARG, speaks the rest of the word from point.
Negative prefix arg speaks from start of word to point.
If executed  on the same buffer position a second time, the word is
spelt instead of being spoken.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-char "emacspeak-speak" "\
Speak character under point.
Pronounces character phonetically unless  called with a PREFIX arg.

\(fn &optional PREFIX)" t nil)

(autoload 'emacspeak-speak-display-char "emacspeak-speak" "\
Display char under point using current speech display table.
Behavior is the same as command `emacspeak-speak-char'
bound to \\[emacspeak-speak-char]
for characters in the range 0--127.
Optional argument PREFIX  specifies that the character should be spoken phonetically.

\(fn &optional PREFIX)" t nil)

(autoload 'emacspeak-speak-set-display-table "emacspeak-speak" "\
Sets up buffer specific speech display table that controls how
special characters are spoken. Interactive prefix argument causes
setting to be global.

\(fn &optional PREFIX)" t nil)

(autoload 'emacspeak-speak-sentence "emacspeak-speak" "\
Speak current sentence.
With prefix ARG, speaks the rest of the sentence  from point.
Negative prefix arg speaks from start of sentence to point.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-sexp "emacspeak-speak" "\
Speak current sexp.
With prefix ARG, speaks the rest of the sexp  from point.
Negative prefix arg speaks from start of sexp to point.
If option  `voice-lock-mode' is on, then uses the personality.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-page "emacspeak-speak" "\
Speak a page.
With prefix ARG, speaks rest of current page.
Negative prefix arg will read from start of current page to point.
If option  `voice-lock-mode' is on, then it will use any defined personality.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-paragraph "emacspeak-speak" "\
Speak paragraph.
With prefix arg, speaks rest of current paragraph.
Negative prefix arg will read from start of current paragraph to point.
If voice-lock-mode is on, then it will use any defined personality. 

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-buffer "emacspeak-speak" "\
Speak current buffer  contents.
With prefix ARG, speaks the rest of the buffer from point.
Negative prefix arg speaks from start of buffer to point.
 If voice lock mode is on, the paragraphs in the buffer are
voice annotated first,  see command `emacspeak-speak-voice-annotate-paragraphs'.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-other-buffer "emacspeak-speak" "\
Speak specified buffer.
Useful to listen to a buffer without switching  contexts.

\(fn BUFFER)" t nil)

(autoload 'emacspeak-speak-front-of-buffer "emacspeak-speak" "\
Speak   the buffer from start to   point

\(fn)" t nil)

(autoload 'emacspeak-speak-rest-of-buffer "emacspeak-speak" "\
Speak remainder of the buffer starting at point

\(fn)" t nil)

(autoload 'emacspeak-speak-help "emacspeak-speak" "\
Speak help buffer if one present.
With prefix arg, speaks the rest of the buffer from point.
Negative prefix arg speaks from start of buffer to point.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-minibuffer "emacspeak-speak" "\
Speak the minibuffer contents
 With prefix arg, speaks the rest of the buffer from point.
Negative prefix arg speaks from start of buffer to point.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-get-current-completion "emacspeak-speak" "\
Return the completion string under point in the *Completions* buffer.

\(fn)" nil nil)

(autoload 'emacspeak-speak-minor-mode-line "emacspeak-speak" "\
Speak the minor mode-information.

\(fn)" t nil)

(autoload 'emacspeak-speak-buffer-filename "emacspeak-speak" "\
Speak name of file being visited in current buffer.
Speak default directory if invoked in a dired buffer,
or when the buffer is not visiting any file.
Interactive prefix arg `filename' speaks only the final path
component.
The result is put in the kill ring for convenience.

\(fn &optional FILENAME)" t nil)

(defvar emacspeak-use-header-line t "\
Use default header line defined  by Emacspeak for buffers that
dont customize the header.")

(custom-autoload 'emacspeak-use-header-line "emacspeak-speak" t)

(autoload 'emacspeak-toggle-header-line "emacspeak-speak" "\
Toggle Emacspeak's default header line.

\(fn)" t nil)

(autoload 'emacspeak-read-previous-line "emacspeak-speak" "\
Read previous line, specified by an offset, without moving.
Default is to read the previous line. 

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-read-next-line "emacspeak-speak" "\
Read next line, specified by an offset, without moving.
Default is to read the next line. 

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-read-previous-word "emacspeak-speak" "\
Read previous word, specified as a prefix arg, without moving.
Default is to read the previous word. 

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-read-next-word "emacspeak-speak" "\
Read next word, specified as a numeric  arg, without moving.
Default is to read the next word. 

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-world-clock "emacspeak-speak" "\
Display current date and time  for specified zone.
Optional second arg `set' sets the TZ environment variable as well.

\(fn ZONE &optional SET)" t nil)

(autoload 'emacspeak-speak-time "emacspeak-speak" "\
Speak the time.
Optional interactive prefix arg `C-u'invokes world clock.
Timezone is specified using minibuffer completion.
Second interactive prefix sets clock to new timezone.

\(fn &optional WORLD)" t nil)

(autoload 'emacspeak-speak-version "emacspeak-speak" "\
Announce version information for running emacspeak.

\(fn)" t nil)

(autoload 'emacspeak-speak-current-kill "emacspeak-speak" "\
Speak the current kill entry.
This is the text that will be yanked in by the next \\[yank].
Prefix numeric arg, COUNT, specifies that the text that will be yanked as a
result of a
\\[yank]  followed by count-1 \\[yank-pop]
be spoken.
 The kill number that is spoken says what numeric prefix arg to give
to command yank.

\(fn COUNT)" t nil)

(autoload 'emacspeak-zap-tts "emacspeak-speak" "\
Send this command to the TTS directly.

\(fn)" t nil)

(autoload 'emacspeak-dial-dtk "emacspeak-speak" "\
Prompt for and dial a phone NUMBER with the Dectalk.

\(fn NUMBER)" t nil)

(autoload 'emacspeak-speak-current-mark "emacspeak-speak" "\
Speak the line containing the mark.
With no argument, speaks the
line containing the mark--this is where `exchange-point-and-mark'
\\[exchange-point-and-mark] would jump.  Numeric prefix arg 'COUNT' speaks
line containing mark 'n' where 'n' is one less than the number of
times one has to jump using `set-mark-command' to get to this marked
position.  The location of the mark is indicated by an aural highlight
achieved by a change in voice personality.

\(fn COUNT)" t nil)

(autoload 'emacspeak-speak-this-personality-chunk "emacspeak-speak" "\
Speak chunk of text around point that has current
personality.

\(fn)" t nil)

(autoload 'emacspeak-speak-next-personality-chunk "emacspeak-speak" "\
Moves to the front of next chunk having current personality.
Speak that chunk after moving.

\(fn)" t nil)

(autoload 'emacspeak-speak-previous-personality-chunk "emacspeak-speak" "\
Moves to the front of previous chunk having current personality.
Speak that chunk after moving.

\(fn)" t nil)

(autoload 'emacspeak-speak-this-face-chunk "emacspeak-speak" "\
Speak chunk of text around point that has current face.

\(fn)" t nil)

(autoload 'emacspeak-speak-next-face-chunk "emacspeak-speak" "\
Moves to the front of next chunk having current face.
Speak that chunk after moving.

\(fn)" t nil)

(autoload 'emacspeak-speak-previous-face-chunk "emacspeak-speak" "\
Moves to the front of previous chunk having current face.
Speak that chunk after moving.

\(fn)" t nil)

(autoload 'emacspeak-execute-repeatedly "emacspeak-speak" "\
Execute COMMAND repeatedly.

\(fn COMMAND)" t nil)

(autoload 'emacspeak-speak-continuously "emacspeak-speak" "\
Speak a buffer continuously.
First prompts using the minibuffer for the kind of action to
perform after speaking each chunk.  E.G.  speak a line at a time
etc.  Speaking commences at current buffer position.  Pressing
\\[keyboard-quit] breaks out, leaving point on last chunk that
was spoken.  Any other key continues to speak the buffer.

\(fn)" t nil)

(autoload 'emacspeak-speak-browse-buffer "emacspeak-speak" "\
Browse current buffer.
Default is to speak chunk having current personality.
Interactive prefix arg `browse'  repeatedly browses  through
  chunks having same personality as the current text chunk.

\(fn &optional BROWSE)" t nil)

(autoload 'emacspeak-speak-skim-paragraph "emacspeak-speak" "\
Skim paragraph.
Skimming a paragraph results in the speech speeding up after
the first clause.
Speech is scaled by the value of dtk-speak-skim-scale

\(fn)" t nil)

(autoload 'emacspeak-speak-skim-next-paragraph "emacspeak-speak" "\
Skim next paragraph.

\(fn)" t nil)

(autoload 'emacspeak-speak-skim-buffer "emacspeak-speak" "\
Skim the current buffer  a paragraph at a time.

\(fn)" t nil)

(autoload 'emacspeak-completion-pick-completion "emacspeak-speak" "\
Pick completion and return safely where we came from.

\(fn)" t nil)

(ems-generate-switcher 'emacspeak-toggle-comint-output-monitor 'emacspeak-comint-output-monitor "Toggle state of Emacspeak comint monitor.\nWhen turned on, comint output is automatically spoken.  Turn this on if\nyou want your shell to speak its results.  Interactive\nPREFIX arg means toggle the global default value, and then\nset the current local value to the result.")

(autoload 'emacspeak-speak-comint-send-input "emacspeak-speak" "\
Causes output to be spoken i.e., as if comint autospeak were turned
on.

\(fn)" t nil)

(autoload 'emacspeak-speak-previous-field "emacspeak-speak" "\
Move to previous field and speak it.

\(fn)" t nil)

(autoload 'emacspeak-speak-message-again "emacspeak-speak" "\
Speak the last message from Emacs once again.
The message is also placed in the kill ring for convenient yanking
if `emacspeak-speak-message-again-should-copy-to-kill-ring' is set.

\(fn &optional FROM-MESSAGE-CACHE)" t nil)

(autoload 'emacspeak-speak-window-information "emacspeak-speak" "\
Speaks information about current window.

\(fn)" t nil)

(autoload 'emacspeak-speak-current-window "emacspeak-speak" "\
Speak contents of current window.
Speaks entire window irrespective of point.

\(fn)" t nil)

(autoload 'emacspeak-speak-other-window "emacspeak-speak" "\
Speak contents of `other' window.
Speaks entire window irrespective of point.
Semantics  of `other' is the same as for the builtin Emacs command
`other-window'.
Optional argument ARG  specifies `other' window to speak.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-next-window "emacspeak-speak" "\
Speak the next window.

\(fn)" t nil)

(autoload 'emacspeak-speak-previous-window "emacspeak-speak" "\
Speak the previous window.

\(fn)" t nil)

(autoload 'emacspeak-owindow-scroll-up "emacspeak-speak" "\
Scroll up the window that command `other-window' would move to.
Speak the window contents after scrolling.

\(fn)" t nil)

(autoload 'emacspeak-owindow-scroll-down "emacspeak-speak" "\
Scroll down  the window that command `other-window' would move to.
Speak the window contents after scrolling.

\(fn)" t nil)

(autoload 'emacspeak-owindow-next-line "emacspeak-speak" "\
Move to the next line in the other window and speak it.
Numeric prefix arg COUNT can specify number of lines to move.

\(fn COUNT)" t nil)

(autoload 'emacspeak-owindow-previous-line "emacspeak-speak" "\
Move to the next line in the other window and speak it.
Numeric prefix arg COUNT specifies number of lines to move.

\(fn COUNT)" t nil)

(autoload 'emacspeak-owindow-speak-line "emacspeak-speak" "\
Speak the current line in the other window.

\(fn)" t nil)

(autoload 'emacspeak-speak-predefined-window "emacspeak-speak" "\
Speak one of the first 10 windows on the screen.
Speaks entire window irrespective of point.
In general, you'll never have Emacs split the screen into more than
two or three.
Argument ARG determines the 'other' window to speak.
Semantics  of `other' is the same as for the builtin Emacs command
`other-window'.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-buffer-interactively "emacspeak-speak" "\
Speak the start of, rest of, or the entire buffer.
's' to speak the start.
'r' to speak the rest.
any other key to speak entire buffer.

\(fn)" t nil)

(autoload 'emacspeak-speak-help-interactively "emacspeak-speak" "\
Speak the start of, rest of, or the entire help.
's' to speak the start.
'r' to speak the rest.
any other key to speak entire help.

\(fn)" t nil)

(autoload 'emacspeak-speak-line-interactively "emacspeak-speak" "\
Speak the start of, rest of, or the entire line.
's' to speak the start.
'r' to speak the rest.
any other key to speak entire line.

\(fn)" t nil)

(autoload 'emacspeak-speak-paragraph-interactively "emacspeak-speak" "\
Speak the start of, rest of, or the entire paragraph.
's' to speak the start.
'r' to speak the rest.
any other key to speak entire paragraph.

\(fn)" t nil)

(autoload 'emacspeak-speak-page-interactively "emacspeak-speak" "\
Speak the start of, rest of, or the entire page.
's' to speak the start.
'r' to speak the rest.
any other key to speak entire page.

\(fn)" t nil)

(autoload 'emacspeak-speak-word-interactively "emacspeak-speak" "\
Speak the start of, rest of, or the entire word.
's' to speak the start.
'r' to speak the rest.
any other key to speak entire word.

\(fn)" t nil)

(autoload 'emacspeak-speak-sexp-interactively "emacspeak-speak" "\
Speak the start of, rest of, or the entire sexp.
's' to speak the start.
'r' to speak the rest.
any other key to speak entire sexp.

\(fn)" t nil)

(autoload 'emacspeak-speak-rectangle "emacspeak-speak" "\
Speak a rectangle of text.
Rectangle is delimited by point and mark.
When call from a program,
arguments specify the START and END of the rectangle.

\(fn START END)" t nil)

(autoload 'emacspeak-voicify-rectangle "emacspeak-speak" "\
Voicify the current rectangle.
When calling from a program,arguments are
START END personality
Prompts for PERSONALITY  with completion when called interactively.

\(fn START END &optional PERSONALITY)" t nil)

(autoload 'emacspeak-voicify-region "emacspeak-speak" "\
Voicify the current region.
When calling from a program,arguments are
START END personality.
Prompts for PERSONALITY  with completion when called interactively.

\(fn START END &optional PERSONALITY)" t nil)

(autoload 'emacspeak-speak-spaces-at-point "emacspeak-speak" "\
Speak the white space at point.

\(fn)" t nil)

(autoload 'emacspeak-switch-to-reference-buffer "emacspeak-speak" "\
Switch back to buffer that generated completions.

\(fn)" t nil)

(autoload 'emacspeak-completions-move-to-completion-group "emacspeak-speak" "\
Move to group of choices beginning with character last
typed. If no such group exists, then we try to search for that
char, or dont move. 

\(fn)" t nil)

(defalias 'emacspeak-mark-forward-mark 'pop-to-mark-command)

(autoload 'emacspeak-mark-backward-mark "emacspeak-speak" "\
Cycle backward through the mark ring.

\(fn)" t nil)

(autoload 'emacspeak-speak-and-skip-extent-upto-char "emacspeak-speak" "\
Search forward from point until we hit char.
Speak text between point and the char we hit.

\(fn CHAR)" t nil)

(autoload 'emacspeak-speak-and-skip-extent-upto-this-char "emacspeak-speak" "\
Speak extent delimited by point and last character typed.

\(fn)" t nil)

(autoload 'emacspeak-speak-message-at-time "emacspeak-speak" "\
Set up ring-at-time to speak message at specified time.
Provides simple stop watch functionality in addition to other things.
See documentation for command run-at-time for details on time-spec.

\(fn TIME MESSAGE)" t nil)

(autoload 'emacspeak-speak-load-directory-settings "emacspeak-speak" "\
Load a directory specific Emacspeak settings file.
This is typically used to load up settings that are specific to
an electronic book consisting of many files in the same
directory.

\(fn &optional DIRECTORY)" t nil)

;;;***

;;;### (autoloads (emacspeak-table-make-table) "emacspeak-table"
;;;;;;  "emacspeak-table.el" (18832 52324))
;;; Generated autoloads from emacspeak-table.el

(autoload 'emacspeak-table-make-table "emacspeak-table" "\
Construct a table object from elements.

\(fn ELEMENTS)" nil nil)

;;;***

;;;### (autoloads (emacspeak-table-copy-to-clipboard emacspeak-table-display-table-in-region
;;;;;;  emacspeak-table-view-csv-buffer emacspeak-table-find-csv-file
;;;;;;  emacspeak-table-find-file) "emacspeak-table-ui" "emacspeak-table-ui.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-table-ui.el

(autoload 'emacspeak-table-find-file "emacspeak-table-ui" "\
Open a file containing table data and display it in table mode.
emacspeak table mode is designed to let you browse tabular data using
all the power of the two-dimensional spatial layout while giving you
sufficient contextual information.  The etc/tables subdirectory of the
emacspeak distribution contains some sample tables --these are the
CalTrain schedules.  Execute command `describe-mode' bound to
\\[describe-mode] in a buffer that is in emacspeak table mode to read
the documentation on the table browser.

\(fn FILENAME)" t nil)

(autoload 'emacspeak-table-find-csv-file "emacspeak-table-ui" "\
Process a csv (comma separated values) file.
The processed  data and presented using emacspeak table navigation. 

\(fn FILENAME)" t nil)

(autoload 'emacspeak-table-view-csv-buffer "emacspeak-table-ui" "\
Process a csv (comma separated values) data.
The processed  data and presented using emacspeak table navigation. 

\(fn &optional BUFFER-NAME)" t nil)

(autoload 'emacspeak-table-display-table-in-region "emacspeak-table-ui" "\
Recognize tabular data in current region and display it in table
browsing mode in a a separate buffer.
emacspeak table mode is designed to let you browse tabular data using
all the power of the two-dimensional spatial layout while giving you
sufficient contextual information.  The tables subdirectory of the
emacspeak distribution contains some sample tables --these are the
CalTrain schedules.  Execute command `describe-mode' bound to
\\[describe-mode] in a buffer that is in emacspeak table mode to read
the documentation on the table browser.

\(fn START END)" t nil)

(autoload 'emacspeak-table-copy-to-clipboard "emacspeak-table-ui" "\
Copy table in current buffer to the table clipboard.
Current buffer must be in emacspeak-table mode.

\(fn)" t nil)

;;;***

;;;### (autoloads (ems-tabulate-parse-region emacspeak-tabulate-region)
;;;;;;  "emacspeak-tabulate" "emacspeak-tabulate.el" (18832 52324))
;;; Generated autoloads from emacspeak-tabulate.el

(autoload 'emacspeak-tabulate-region "emacspeak-tabulate" "\
Voicifies the white-space of a table if one found.  Optional interactive prefix
arg mark-fields specifies if the header row information is used to mark fields
in the white-space.

\(fn START END &optional MARK-FIELDS)" t nil)

(autoload 'ems-tabulate-parse-region "emacspeak-tabulate" "\
Parse  region as tabular data and return a vector of vectors

\(fn START END)" nil nil)

;;;***

;;;### (autoloads (emacspeak-tapestry-select-window-by-name emacspeak-tapestry-describe-tapestry)
;;;;;;  "emacspeak-tapestry" "emacspeak-tapestry.el" (18832 52324))
;;; Generated autoloads from emacspeak-tapestry.el

(autoload 'emacspeak-tapestry-describe-tapestry "emacspeak-tapestry" "\
Describe the current layout of visible buffers in current frame.
Use interactive prefix arg to get coordinate positions of the
displayed buffers.

\(fn &optional DETAILS)" t nil)

(autoload 'emacspeak-tapestry-select-window-by-name "emacspeak-tapestry" "\
Select window by the name of the buffer it displays.
This is useful when using modes like ECB or the new GDB UI where
  you want to preserve the window layout 
but quickly switch to a window by name.

\(fn BUFFER-NAME)" t nil)

;;;***

;;;### (autoloads (emacspeak-url-template-fetch emacspeak-url-template-open
;;;;;;  emacspeak-url-template-weather-city-state emacspeak-url-template-load
;;;;;;  emacspeak-url-template-define emacspeak-url-template-get)
;;;;;;  "emacspeak-url-template" "emacspeak-url-template.el" (18832
;;;;;;  52324))
;;; Generated autoloads from emacspeak-url-template.el

(autoload 'emacspeak-url-template-get "emacspeak-url-template" "\
Lookup key and return corresponding template. 

\(fn KEY)" nil nil)

(autoload 'emacspeak-url-template-define "emacspeak-url-template" "\
Define a URL template.

name            Name used to identify template
template        Template URI with `%s' for slots
generators      List of prompters.
                Generators are strings or functions.
                String values specify prompts.
                Function values are called to obtain values.
post-action     Function called to apply post actions.
                Possible actions include speaking the result.
fetcher         Unless specified, browse-url retrieves URL.
                If specified, fetcher is a function of one arg
                that is called with the URI to retrieve.
documentation   Documents this template resource.
dont-url-encode if true then url arguments are not url-encoded 

\(fn NAME TEMPLATE &optional GENERATORS POST-ACTION DOCUMENTATION FETCHER DONT-URL-ENCODE)" nil nil)

(autoload 'emacspeak-url-template-load "emacspeak-url-template" "\
Load URL template resources from specified location.

\(fn FILE)" t nil)

(defvar emacspeak-url-template-weather-city-state "CA/San_Jose" "\
Default city/state for weather forecasts")

(custom-autoload 'emacspeak-url-template-weather-city-state "emacspeak-url-template" t)

(autoload 'emacspeak-url-template-open "emacspeak-url-template" "\
Fetch resource identified by URL template.

\(fn UT)" nil nil)

(autoload 'emacspeak-url-template-fetch "emacspeak-url-template" "\
Fetch a pre-defined resource.
Use Emacs completion to obtain a list of available resources.
Resources typically prompt for the relevant information
before completing the request.
Optional interactive prefix arg displays documentation for specified resource.

\(fn &optional DOCUMENTATION)" t nil)

;;;***

;;;### (autoloads (emacspeak-w3-curl-url-under-point) "emacspeak-w3"
;;;;;;  "emacspeak-w3.el" (18832 52324))
;;; Generated autoloads from emacspeak-w3.el

(autoload 'emacspeak-w3-curl-url-under-point "emacspeak-w3" "\
Display contents of URL under point using Curl and W3.  The
document is displayed in a separate buffer. 

\(fn)" t nil)

(defalias 'make-dtk-speech-style 'make-acss)

;;;***

;;;### (autoloads (emacspeak-w3m-preview-this-buffer) "emacspeak-w3m"
;;;;;;  "emacspeak-w3m.el" (18832 52324))
;;; Generated autoloads from emacspeak-w3m.el

(autoload 'emacspeak-w3m-preview-this-buffer "emacspeak-w3m" "\
Preview this buffer in w3m.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-we-extract-by-property emacspeak-we-xpath-junk-and-follow
;;;;;;  emacspeak-we-xpath-filter-and-follow emacspeak-we-style-filter
;;;;;;  emacspeak-we-follow-and-filter-by-id emacspeak-we-class-filter-and-follow
;;;;;;  emacspeak-we-junk-by-class-list emacspeak-we-extract-by-id-list
;;;;;;  emacspeak-we-extract-by-id emacspeak-we-extract-by-class-list
;;;;;;  emacspeak-we-extract-by-class emacspeak-we-extract-tables-by-match-list
;;;;;;  emacspeak-we-extract-table-by-match emacspeak-we-extract-tables-by-position-list
;;;;;;  emacspeak-we-extract-table-by-position emacspeak-we-extract-nested-table-list
;;;;;;  emacspeak-we-extract-nested-table emacspeak-we-extract-matching-urls
;;;;;;  emacspeak-we-extract-media-streams-under-point emacspeak-we-extract-print-streams
;;;;;;  emacspeak-we-extract-media-streams emacspeak-we-xslt-junk
;;;;;;  emacspeak-we-xslt-filter emacspeak-we-toggle-xsl-keep-result
;;;;;;  emacspeak-we-count-tables emacspeak-we-count-nested-tables
;;;;;;  emacspeak-we-count-matches emacspeak-we-xsl-toggle emacspeak-we-xslt-select
;;;;;;  emacspeak-we-xslt-apply emacspeak-we-cleanup-bogus-quotes
;;;;;;  emacspeak-we-xsl-transform emacspeak-we-xsl-p emacspeak-we-url-rewrite-and-follow)
;;;;;;  "emacspeak-we" "emacspeak-we.el" (18832 52324))
;;; Generated autoloads from emacspeak-we.el

(autoload 'emacspeak-we-url-rewrite-and-follow "emacspeak-we" "\
Apply a url rewrite rule as specified in the current buffer
before following link under point.  If no rewrite rule is
defined, first prompt for one.  Rewrite rules are of the
form `(from to)' where from and to are strings.  Typically, the
rewrite rule is automatically set up by Emacspeak tools like
websearch where a rewrite rule is known.  Rewrite rules are
useful in jumping directly to the printer friendly version of an
article for example.  Optional interactive prefix arg prompts for
a rewrite rule even if one is already defined.

\(fn &optional PROMPT)" t nil)

(defvar emacspeak-we-xsl-p nil "\
T means we apply XSL before displaying HTML.")

(custom-autoload 'emacspeak-we-xsl-p "emacspeak-we" t)

(defvar emacspeak-we-xsl-transform nil "\
Specifies transform to use before displaying a page.
Nil means no transform is used. ")

(custom-autoload 'emacspeak-we-xsl-transform "emacspeak-we" t)

(defvar emacspeak-we-xsl-params nil "\
XSL params if any to pass to emacspeak-xslt-region.")

(defvar emacspeak-we-cleanup-bogus-quotes t "\
Clean up bogus Unicode chars for magic quotes.")

(custom-autoload 'emacspeak-we-cleanup-bogus-quotes "emacspeak-we" t)

(autoload 'emacspeak-we-xslt-apply "emacspeak-we" "\
Apply specified transformation to current Web page.

\(fn XSL)" t nil)

(autoload 'emacspeak-we-xslt-select "emacspeak-we" "\
Select XSL transformation applied to Web pages before they are displayed .

\(fn XSL)" t nil)

(autoload 'emacspeak-we-xsl-toggle "emacspeak-we" "\
Toggle  application of XSL transformations.

\(fn)" t nil)

(autoload 'emacspeak-we-count-matches "emacspeak-we" "\
Count matches for locator  in Web page.

\(fn URL LOCATOR)" t nil)

(autoload 'emacspeak-we-count-nested-tables "emacspeak-we" "\
Count nested tables in Web page.

\(fn URL)" t nil)

(autoload 'emacspeak-we-count-tables "emacspeak-we" "\
Count  tables in Web page.

\(fn URL)" t nil)

(defvar emacspeak-we-xsl-keep-result nil "\
Toggle via command \\[emacspeak-we-toggle-xsl-keep-result].")

(autoload 'emacspeak-we-toggle-xsl-keep-result "emacspeak-we" "\
Toggle xsl keep result flag.

\(fn)" t nil)

(autoload 'emacspeak-we-xslt-filter "emacspeak-we" "\
Extract elements matching specified XPath path locator
from Web page -- default is the current page being viewed.

\(fn PATH URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-xslt-junk "emacspeak-we" "\
Junk elements matching specified locator.

\(fn PATH URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-media-streams "emacspeak-we" "\
Extract links to media streams.
operate on current web page when in a browser buffer; otherwise
 prompt for url.  Optional arg `speak' specifies if the result
 should be spoken automatically.

\(fn URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-print-streams "emacspeak-we" "\
Extract links to printable  streams.
operate on current web page when in a browser buffer; otherwise
 prompt for url.  Optional arg `speak' specifies if the result
 should be spoken automatically.

\(fn URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-media-streams-under-point "emacspeak-we" "\
In browser buffers, extract media streams from url under point.

\(fn)" t nil)

(autoload 'emacspeak-we-extract-matching-urls "emacspeak-we" "\
Extracts links whose URL matches pattern.

\(fn PATTERN URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-nested-table "emacspeak-we" "\
Extract nested table specified by `table-index'. Default is to
operate on current web page when in a browser buffer; otherwise
prompt for URL. Optional arg `speak' specifies if the result should be
spoken automatically.

\(fn INDEX URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-nested-table-list "emacspeak-we" "\
Extract specified list of tables from a Web page.

\(fn TABLES URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-table-by-position "emacspeak-we" "\
Extract table at specified position.
Default is to extract from current page.

\(fn POSITION URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-tables-by-position-list "emacspeak-we" "\
Extract specified list of nested tables from a WWW page.
Tables are specified by their position in the list
 of nested tables found in the page.

\(fn POSITIONS URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-table-by-match "emacspeak-we" "\
Extract table containing  specified match.
 Optional arg url specifies the page to extract content from.

\(fn MATCH URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-tables-by-match-list "emacspeak-we" "\
Extract specified  tables from a WWW page.
Tables are specified by containing  match pattern
 found in the match list.

\(fn MATCH-LIST URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-by-class "emacspeak-we" "\
Extract elements having specified class attribute from HTML. Extracts
specified elements from current WWW page and displays it in a separate
buffer. Interactive use provides list of class values as completion.

\(fn CLASS URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-by-class-list "emacspeak-we" "\
Extract elements having class specified in list `classes' from HTML.
Extracts specified elements from current WWW page and displays it
in a separate buffer.  Interactive use provides list of class
values as completion. 

\(fn CLASSES URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-by-id "emacspeak-we" "\
Extract elements having specified id attribute from HTML. Extracts
specified elements from current WWW page and displays it in a separate
buffer.
Interactive use provides list of id values as completion.

\(fn ID URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-extract-by-id-list "emacspeak-we" "\
Extract elements having id specified in list `ids' from HTML.
Extracts specified elements from current WWW page and displays it in a
separate buffer. Interactive use provides list of id values as completion. 

\(fn IDS URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-junk-by-class-list "emacspeak-we" "\
Junk elements having class specified in list `classes' from HTML.
Extracts specified elements from current WWW page and displays it in a
separate buffer.
 Interactive use provides list of class values as
completion. 

\(fn CLASSES URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-class-filter-and-follow "emacspeak-we" "\
Follow url and point, and filter the result by specified class.
Class can be set locally for a buffer, and overridden with an
interactive prefix arg. If there is a known rewrite url rule, that is
used as well.

\(fn CLASS URL)" t nil)

(autoload 'emacspeak-we-follow-and-filter-by-id "emacspeak-we" "\
Follow url and point, and filter the result by specified id.
Id can be set locally for a buffer, and overridden with an
interactive prefix arg. If there is a known rewrite url rule, that is
used as well.

\(fn ID)" t nil)

(autoload 'emacspeak-we-style-filter "emacspeak-we" "\
Extract elements matching specified style
from HTML.  Extracts specified elements from current WWW
page and displays it in a separate buffer.  Optional arg url
specifies the page to extract contents  from.

\(fn STYLE URL &optional SPEAK)" t nil)

(autoload 'emacspeak-we-xpath-filter-and-follow "emacspeak-we" "\
Follow url and point, and filter the result by specified xpath.
XPath can be set locally for a buffer, and overridden with an
interactive prefix arg. If there is a known rewrite url rule, that is
used as well.

\(fn &optional PROMPT)" t nil)

(autoload 'emacspeak-we-xpath-junk-and-follow "emacspeak-we" "\
Follow url and point, and filter the result by junking
elements specified by xpath.
XPath can be set locally for a buffer, and overridden with an
interactive prefix arg. If there is a known rewrite url rule, that is
used as well.

\(fn &optional PROMPT)" t nil)

(autoload 'emacspeak-we-extract-by-property "emacspeak-we" "\
Interactively prompt for an HTML property, e.g. id or class,
and provide a completion list of applicable  property values. Filter document by property that is specified.

\(fn URL &optional SPEAK)" t nil)

;;;***

;;;### (autoloads (emacspeak-webmarks-add emacspeak-webmarks-history
;;;;;;  emacspeak-webmarks-search emacspeak-webmarks-list) "emacspeak-webmarks"
;;;;;;  "emacspeak-webmarks.el" (18832 52324))
;;; Generated autoloads from emacspeak-webmarks.el

(autoload 'emacspeak-webmarks-list "emacspeak-webmarks" "\
List WebMarks.

\(fn)" t nil)

(autoload 'emacspeak-webmarks-search "emacspeak-webmarks" "\
Search WebMarks.

\(fn QUERY)" t nil)

(autoload 'emacspeak-webmarks-history "emacspeak-webmarks" "\
Search search history.

\(fn QUERY)" t nil)

(autoload 'emacspeak-webmarks-add "emacspeak-webmarks" "\
Add WebMark.

\(fn URL TITLE LABELS NOTES)" t nil)

;;;***

;;;### (autoloads (emacspeak-websearch-usenet emacspeak-websearch-shoutcast-search
;;;;;;  emacspeak-websearch-ebay-search emacspeak-websearch-amazon-search
;;;;;;  emacspeak-websearch-my-rss-search emacspeak-websearch-yahoo-exchange-rate-convertor
;;;;;;  emacspeak-websearch-exchange-rate-convertor emacspeak-websearch-yahoo
;;;;;;  emacspeak-websearch-podscope emacspeak-websearch-people-yahoo
;;;;;;  emacspeak-websearch-wikipedia-search emacspeak-websearch-w3c-search
;;;;;;  emacspeak-websearch-weather emacspeak-websearch-merriam-webster-search
;;;;;;  emacspeak-websearch-recorded-books-search emacspeak-websearch-rpm-find
;;;;;;  emacspeak-websearch-open-directory-search emacspeak-websearch-news-yahoo
;;;;;;  emacspeak-websearch-map-yahoo-directions-search emacspeak-websearch-ask-jeeves
;;;;;;  emacspeak-websearch-google-usenet-advanced emacspeak-websearch-emapspeak-near-my-location
;;;;;;  emacspeak-websearch-emaps-search emacspeak-websearch-google-news
;;;;;;  emacspeak-websearch-google-mobile emacspeak-websearch-google-advanced
;;;;;;  emacspeak-websearch-teoma emacspeak-websearch-technorati
;;;;;;  emacspeak-websearch-google-sak emacspeak-websearch-froogle
;;;;;;  emacspeak-websearch-google-search-in-date-range emacspeak-websearch-google-specialize
;;;;;;  emacspeak-websearch-google-feeling-lucky emacspeak-websearch-accessible-google
;;;;;;  emacspeak-websearch-google emacspeak-websearch-google-number-of-results
;;;;;;  emacspeak-websearch-gutenberg emacspeak-websearch-britannica-search
;;;;;;  emacspeak-websearch-software-search emacspeak-websearch-swik-search
;;;;;;  emacspeak-websearch-cpan-search emacspeak-websearch-ctan-search
;;;;;;  emacspeak-websearch-freshmeat-search emacspeak-websearch-sourceforge-search
;;;;;;  emacspeak-websearch-dictionary-hypertext-webster-search emacspeak-websearch-usenet-search
;;;;;;  emacspeak-websearch-yahoo-historical-chart emacspeak-websearch-company-news
;;;;;;  emacspeak-websearch-quotes-yahoo-search emacspeak-websearch-foldoc-search
;;;;;;  emacspeak-websearch-podzinger-search emacspeak-websearch-blinkx-search
;;;;;;  emacspeak-websearch-bbc-search emacspeak-websearch-citeseer-search
;;;;;;  emacspeak-websearch-biblio-search emacspeak-websearch-altavista-search
;;;;;;  emacspeak-websearch-alltheweb-search emacspeak-websearch-dispatch
;;;;;;  emacspeak-websearch-help emacspeak-websearch) "emacspeak-websearch"
;;;;;;  "emacspeak-websearch.el" (18832 52324))
;;; Generated autoloads from emacspeak-websearch.el

(let ((loads (get 'emacspeak-websearch 'custom-loads))) (if (member '"emacspeak-websearch" loads) nil (put 'emacspeak-websearch 'custom-loads (cons '"emacspeak-websearch" loads))))

(autoload 'emacspeak-websearch-help "emacspeak-websearch" "\
Displays key mapping used by Emacspeak Websearch.

\(fn)" t nil)

(autoload 'emacspeak-websearch-dispatch "emacspeak-websearch" "\
Launches specific websearch queries.
Press `?' to list available search engines.
Once selected, the selected searcher prompts for additional information as appropriate.
When using supported browsers,  this interface attempts to speak the most relevant information on the result page.

\(fn &optional PREFIX)" t nil)

(autoload 'emacspeak-websearch-alltheweb-search "emacspeak-websearch" "\
Perform an AllTheWeb  search.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-altavista-search "emacspeak-websearch" "\
Perform an Altavista search

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-biblio-search "emacspeak-websearch" "\
Search Computer Science Bibliographies.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-citeseer-search "emacspeak-websearch" "\
Perform a CiteSeer search. 

\(fn TERM)" t nil)

(autoload 'emacspeak-websearch-bbc-search "emacspeak-websearch" "\
Search BBC archives.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-blinkx-search "emacspeak-websearch" "\
BlinkX RSS Generator.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-podzinger-search "emacspeak-websearch" "\
Podzinger RSS Generator.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-foldoc-search "emacspeak-websearch" "\
Perform a FolDoc search. 

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-quotes-yahoo-search "emacspeak-websearch" "\
Perform a Quotes Yahoo .
Default tickers to look up is taken from variable
emacspeak-websearch-personal-portfolio.
Default is to present the data in emacspeak's table browsing
mode --optional interactive prefix arg
causes data to be displayed as  a Web page.
You can customize the defaults by setting variable
emacspeak-websearch-quotes-yahoo-options to an appropriate string.

\(fn QUERY &optional PREFIX)" t nil)

(autoload 'emacspeak-websearch-company-news "emacspeak-websearch" "\
Perform an company news lookup.
Retrieves company news, research, profile, insider trades,  or upgrades/downgrades.

\(fn TICKER &optional PREFIX)" t nil)

(autoload 'emacspeak-websearch-yahoo-historical-chart "emacspeak-websearch" "\
Look up historical stock data.
Optional second arg as-html processes the results as HTML rather than data.

\(fn TICKER &optional AS-HTML)" t nil)

(autoload 'emacspeak-websearch-usenet-search "emacspeak-websearch" "\
Search a Usenet newsgroup.

\(fn GROUP)" t nil)

(autoload 'emacspeak-websearch-dictionary-hypertext-webster-search "emacspeak-websearch" "\
Search the Webster Dictionary.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-sourceforge-search "emacspeak-websearch" "\
Search SourceForge Site. 

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-freshmeat-search "emacspeak-websearch" "\
Search Freshmeat  Site. 

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-ctan-search "emacspeak-websearch" "\
Search CTAN Comprehensive TeX Archive Network   Site. 

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-cpan-search "emacspeak-websearch" "\
Search CPAN  Comprehensive Perl Archive Network   Site. 

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-swik-search "emacspeak-websearch" "\
Search swik software community site.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-software-search "emacspeak-websearch" "\
Search SourceForge, Freshmeat and other sites. 

\(fn)" t nil)

(autoload 'emacspeak-websearch-britannica-search "emacspeak-websearch" "\
Search Encyclopedia Britannica.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-gutenberg "emacspeak-websearch" "\
Perform an Gutenberg search

\(fn TYPE QUERY)" t nil)

(defvar emacspeak-websearch-google-number-of-results 25 "\
Number of results to return from google search.")

(custom-autoload 'emacspeak-websearch-google-number-of-results "emacspeak-websearch" t)

(autoload 'emacspeak-websearch-google "emacspeak-websearch" "\
Perform a Google search.
Optional interactive prefix arg `lucky' is equivalent to hitting the
I'm Feeling Lucky button on Google.

\(fn QUERY &optional LUCKY)" t nil)

(autoload 'emacspeak-websearch-accessible-google "emacspeak-websearch" "\
Google Accessible Search -- see http://labs.google.com/accessible

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-google-feeling-lucky "emacspeak-websearch" "\
Do a I'm Feeling Lucky Google search.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-google-specialize "emacspeak-websearch" "\
Perform a specialized Google search. See the Google site for
  what is possible here:
http://www.google.com/options/specialsearches.html 

\(fn SPECIALIZE QUERY)" t nil)

(autoload 'emacspeak-websearch-google-search-in-date-range "emacspeak-websearch" "\
Use this from inside the calendar to do Google date-range searches.

\(fn)" t nil)

(autoload 'emacspeak-websearch-froogle "emacspeak-websearch" "\
Perform a Froogle search.
Optional interactive  prefix arg local-flag prompts for local
  area in which to search.

\(fn QUERY &optional LOCAL-FLAG)" t nil)

(autoload 'emacspeak-websearch-google-sak "emacspeak-websearch" "\
Perform a Google query against a specific index.

\(fn ENGINE QUERY)" t nil)

(autoload 'emacspeak-websearch-technorati "emacspeak-websearch" "\
Perform a Technorati tag search.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-teoma "emacspeak-websearch" "\
Perform an Teoma  search.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-google-advanced "emacspeak-websearch" "\
Present Google advanced search form simplified for speech interaction.

\(fn)" t nil)

(autoload 'emacspeak-websearch-google-mobile "emacspeak-websearch" "\
Google mobile search.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-google-news "emacspeak-websearch" "\
Invoke Google News url template.

\(fn)" t nil)

(defvar emacspeak-websearch-google-maps-uri "http://maps.google.com/maps?q=%s&output=kml" "\
URL template for Google maps.")

(autoload 'emacspeak-websearch-emaps-search "emacspeak-websearch" "\
Perform EmapSpeak search.
Query is a Google Maps query in plain English.
Interactive prefix arg `use-near' searches near our previously cached  location.

\(fn QUERY &optional USE-NEAR)" t nil)

(autoload 'emacspeak-websearch-emapspeak-near-my-location "emacspeak-websearch" "\
Perform search relative to `my-location'.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-google-usenet-advanced "emacspeak-websearch" "\
Present Google Usenet advanced search form simplified for speech interaction.

\(fn)" t nil)

(autoload 'emacspeak-websearch-ask-jeeves "emacspeak-websearch" "\
Ask Jeeves for the answer.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-map-yahoo-directions-search "emacspeak-websearch" "\
Get driving directions from Yahoo.
With optional interactive prefix arg MAP shows the location map instead.

\(fn QUERY &optional MAP)" t nil)

(autoload 'emacspeak-websearch-news-yahoo "emacspeak-websearch" "\
Perform an Yahoo News search.
Optional prefix arg no-rss scrapes information from HTML.

\(fn QUERY &optional NO-RSS)" t nil)

(autoload 'emacspeak-websearch-open-directory-search "emacspeak-websearch" "\
Perform an Open Directory search

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-rpm-find "emacspeak-websearch" "\
Search RPM  catalog  site.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-recorded-books-search "emacspeak-websearch" "\
Present advanced search form for recorded books.

\(fn)" t nil)

(autoload 'emacspeak-websearch-merriam-webster-search "emacspeak-websearch" "\
Search the Merriam Webster Dictionary.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-weather "emacspeak-websearch" "\
Get weather forecast for specified zip code.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-w3c-search "emacspeak-websearch" "\
Search the W3C Site.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-wikipedia-search "emacspeak-websearch" "\
Search Wikipedia

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-people-yahoo "emacspeak-websearch" "\
Perform an Yahoo  people search

\(fn)" t nil)

(autoload 'emacspeak-websearch-podscope "emacspeak-websearch" "\
Perform a PodScope search to locate podcasts.

\(fn)" t nil)

(autoload 'emacspeak-websearch-yahoo "emacspeak-websearch" "\
Perform an Yahoo  search

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-exchange-rate-convertor "emacspeak-websearch" "\
Currency convertor.

\(fn CONVERSION-SPEC)" t nil)

(autoload 'emacspeak-websearch-yahoo-exchange-rate-convertor "emacspeak-websearch" "\
Currency convertor.

\(fn CONVERSION-SPEC)" t nil)

(autoload 'emacspeak-websearch-my-rss-search "emacspeak-websearch" "\
My RSS search.

\(fn QUERY)" t nil)

(autoload 'emacspeak-websearch-amazon-search "emacspeak-websearch" "\
Amazon search.

\(fn)" t nil)

(autoload 'emacspeak-websearch-ebay-search "emacspeak-websearch" "\
Ebay search.

\(fn)" t nil)

(autoload 'emacspeak-websearch-shoutcast-search "emacspeak-websearch" "\
Shoutcast search.

\(fn)" t nil)

(autoload 'emacspeak-websearch-usenet "emacspeak-websearch" "\
Prompt and browse a Usenet newsgroup.
Optional interactive prefix arg results in prompting for a search term.

\(fn GROUP &optional PREFIX)" t nil)

;;;***

;;;### (autoloads (emacspeak-webspace-google emacspeak-webspace-reader-unsubscribe
;;;;;;  emacspeak-webspace-weather emacspeak-webspace-headlines emacspeak-webspace-headlines-view
;;;;;;  emacspeak-webspace-previous-link emacspeak-webspace-next-link
;;;;;;  emacspeak-webspace-filter emacspeak-webspace-open emacspeak-webspace-yank-link
;;;;;;  emacspeak-webspace-transcode) "emacspeak-webspace" "emacspeak-webspace.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-webspace.el

(autoload 'emacspeak-webspace-transcode "emacspeak-webspace" "\
Transcode headline at point by following its link property.

\(fn)" t nil)

(autoload 'emacspeak-webspace-yank-link "emacspeak-webspace" "\
Yank link under point into kill ring.

\(fn)" t nil)

(autoload 'emacspeak-webspace-open "emacspeak-webspace" "\
Open headline at point by following its link property.

\(fn)" t nil)

(autoload 'emacspeak-webspace-filter "emacspeak-webspace" "\
Open headline at point by following its link property and filter for content.

\(fn)" t nil)

(autoload 'emacspeak-webspace-next-link "emacspeak-webspace" "\
Move to next link.

\(fn)" t nil)

(autoload 'emacspeak-webspace-previous-link "emacspeak-webspace" "\
Move to previous link.

\(fn)" t nil)

(autoload 'emacspeak-webspace-headlines-view "emacspeak-webspace" "\
Display all cached headlines in a special interaction buffer.

\(fn)" t nil)

(define-prefix-command 'emacspeak-webspace 'emacspeak-webspace-keymap)

(autoload 'emacspeak-webspace-headlines "emacspeak-webspace" "\
Speak current news headline.

\(fn)" t nil)

(autoload 'emacspeak-webspace-weather "emacspeak-webspace" "\
Speak current weather.

\(fn)" t nil)

(autoload 'emacspeak-webspace-reader-unsubscribe "emacspeak-webspace" "\
Unsubscribe to link under point.

\(fn)" t nil)

(autoload 'emacspeak-webspace-google "emacspeak-webspace" "\
Display Google Search in a WebSpace buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-atom-browse emacspeak-atom-feeds emacspeak-atom
;;;;;;  emacspeak-rss-browse emacspeak-opml-display emacspeak-rss
;;;;;;  emacspeak-webutils-fv emacspeak-webutils-atom-display emacspeak-webutils-rss-display
;;;;;;  emacspeak-webutils-open-in-other-browser emacspeak-webutils-view-feed-via-google-reader
;;;;;;  emacspeak-webutils-play-media-at-point emacspeak-webutils-jump-to-title-in-content
;;;;;;  emacspeak-webutils-transcode-current-url-via-google emacspeak-webutils-transcode-via-google
;;;;;;  emacspeak-webutils-google-similar-to-this-page emacspeak-webutils-google-on-this-site
;;;;;;  emacspeak-webutils-google-extract-from-cache emacspeak-webutils-google-who-links-to-this-page
;;;;;;  emacspeak-webutils-post-process emacspeak-webutils-charent-alist)
;;;;;;  "emacspeak-webutils" "emacspeak-webutils.el" (18832 52324))
;;; Generated autoloads from emacspeak-webutils.el

(defvar emacspeak-web-post-process-hook nil "\
Set locally to a  site specific post processor.
Note that the Web browser should reset this hook after using it.")

(defvar emacspeak-webutils-charent-alist '(("&lt;" . "<") ("&gt;" . ">") ("&quot;" . "\"") ("&apos;" . "'") ("&amp;" . "&")) "\
Entities to unescape when treating badly escaped XML.")

(custom-autoload 'emacspeak-webutils-charent-alist "emacspeak-webutils" t)

(autoload 'emacspeak-webutils-post-process "emacspeak-webutils" "\
Set up post processing steps on a result page.
LOCATOR is a string to search for in the results page.
SPEAKER is a function to call to speak relevant information.
ARGS specifies additional arguments to SPEAKER if any.

\(fn LOCATOR SPEAKER &rest ARGS)" nil nil)

(autoload 'emacspeak-webutils-google-who-links-to-this-page "emacspeak-webutils" "\
Perform a google search to locate documents that link to the
current page.

\(fn)" t nil)

(autoload 'emacspeak-webutils-google-extract-from-cache "emacspeak-webutils" "\
Extract current  page from the Google cache.
With a prefix argument, extracts url under point.

\(fn &optional PREFIX)" t nil)

(autoload 'emacspeak-webutils-google-on-this-site "emacspeak-webutils" "\
Perform a google search restricted to the current WWW site.

\(fn)" t nil)

(autoload 'emacspeak-webutils-google-similar-to-this-page "emacspeak-webutils" "\
Ask Google to find documents similar to this one.

\(fn URL)" t nil)

(defsubst emacspeak-webutils-transcode-this-url-via-google (url) "\
Transcode specified url via Google." (declare (special emacspeak-webutils-google-transcoder-url)) (browse-url (format emacspeak-webutils-google-transcoder-url (emacspeak-url-encode url))))

(autoload 'emacspeak-webutils-transcode-via-google "emacspeak-webutils" "\
Transcode URL under point via Google.
 Reverse effect with prefix arg for links on a transcoded page.

\(fn &optional UNTRANSCODE)" t nil)

(autoload 'emacspeak-webutils-transcode-current-url-via-google "emacspeak-webutils" "\
Transcode current URL via Google.
  Reverse effect with prefix arg.

\(fn &optional UNTRANSCODE)" t nil)

(autoload 'emacspeak-webutils-jump-to-title-in-content "emacspeak-webutils" "\
Jumps to the title in web document.
The first time it is called, it jumps to the first
instance  of the title.  Repeated calls jump to further
instances.

\(fn)" t nil)

(autoload 'emacspeak-webutils-play-media-at-point "emacspeak-webutils" "\
Play media url under point 

\(fn)" t nil)

(autoload 'emacspeak-webutils-view-feed-via-google-reader "emacspeak-webutils" "\
Pulls feed under point via Google Reader.

\(fn)" t nil)

(autoload 'emacspeak-webutils-open-in-other-browser "emacspeak-webutils" "\
Opens link in alternate browser.
 If using default browser is w3, uses w3m and vice-versa

\(fn)" t nil)

(autoload 'emacspeak-webutils-rss-display "emacspeak-webutils" "\
Display RSS feed.

\(fn FEED-URL)" t nil)

(autoload 'emacspeak-webutils-atom-display "emacspeak-webutils" "\
Display ATOM feed.

\(fn FEED-URL)" t nil)

(autoload 'emacspeak-webutils-fv "emacspeak-webutils" "\
Display RSS or ATOM feed URL.

\(fn FEED-URL)" t nil)

(let ((loads (get 'emacspeak-rss 'custom-loads))) (if (member '"emacspeak-webutils" loads) nil (put 'emacspeak-rss 'custom-loads (cons '"emacspeak-webutils" loads))))

(autoload 'emacspeak-opml-display "emacspeak-webutils" "\
Retrieve and display OPML  URL.

\(fn OPML-URL &optional SPEAK)" t nil)

(autoload 'emacspeak-rss-browse "emacspeak-webutils" "\
Browse specified RSS feed.

\(fn FEED)" t nil)

(let ((loads (get 'emacspeak-atom 'custom-loads))) (if (member '"emacspeak-webutils" loads) nil (put 'emacspeak-atom 'custom-loads (cons '"emacspeak-webutils" loads))))

(defvar emacspeak-atom-feeds nil "\
Table of ATOM feeds.")

(custom-autoload 'emacspeak-atom-feeds "emacspeak-webutils" t)

(autoload 'emacspeak-atom-browse "emacspeak-webutils" "\
Browse specified ATOM feed.

\(fn FEED)" t nil)

;;;***

;;;### (autoloads (emacspeak-widget-default-summarize emacspeak-widget-summarize
;;;;;;  emacspeak-widget-summarize-parent) "emacspeak-widget" "emacspeak-widget.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-widget.el

(autoload 'emacspeak-widget-summarize-parent "emacspeak-widget" "\
Summarize parent of widget at point.

\(fn)" t nil)

(autoload 'emacspeak-widget-summarize "emacspeak-widget" "\
Summarize specified widget.

\(fn WIDGET)" nil nil)

(autoload 'emacspeak-widget-default-summarize "emacspeak-widget" "\
Fall back summarizer for all widgets

\(fn WIDGET)" nil nil)

;;;***

;;;### (autoloads (emacspeak-wizards-find-emacspeak-source emacspeak-wizards-popup-input-buffer
;;;;;;  emacspeak-wizards-thanks-mail-signature emacspeak-wizards-add-autoload-cookies
;;;;;;  emacspeak-wizards-unhex-uri emacspeak-wizards-show-commentary
;;;;;;  emacspeak-wizards-shell-bind-keys emacspeak-wizards-refresh-shell-history
;;;;;;  emacspeak-wizards-rivo emacspeak-wizards-js emacspeak-wizards-units
;;;;;;  emacspeak-wizards-toggle-mm-dd-yyyy-date-pronouncer emacspeak-wizards-speak-iso-datetime
;;;;;;  emacspeak-wizards-tramp-open-location emacspeak-wizards-generate-voice-sampler
;;;;;;  emacspeak-wizards-voice-sampler emacspeak-wizards-show-face
;;;;;;  emacspeak-wizards-find-grep emacspeak-wizards-find-longest-paragraph-in-region
;;;;;;  emacspeak-wizards-find-longest-line-in-region emacspeak-wizards-google-transcode
;;;;;;  emacspeak-wizards-google-hits emacspeak-wizards-vc-n emacspeak-wizards-vc-viewer-refresh
;;;;;;  emacspeak-wizards-vc-viewer emacspeak-wizards-fix-read-only-text
;;;;;;  emacspeak-wizards-display-pod-as-manpage emacspeak-wizards-fix-typo
;;;;;;  emacspeak-wizards-spot-words emacspeak-kill-buffer-quietly
;;;;;;  emacspeak-switch-to-previous-buffer emacspeak-wizards-occur-header-lines
;;;;;;  emacspeak-wizards-how-many-matches emacspeak-wizards-count-slides-in-region
;;;;;;  emacspeak-wizards-squeeze-blanks emacspeak-wizards-show-environment-variable
;;;;;;  emacspeak-customize emacspeak-wizards-use-w3-or-w3m emacspeak-wizards-finder-find
;;;;;;  emacspeak-wizards-generate-finder emacspeak-wizards-portfolio-quotes
;;;;;;  emacspeak-wizards-dvi-display emacspeak-wizards-ppt-display
;;;;;;  emacspeak-wizards-pdf-open emacspeak-wizards-xl-display emacspeak-wizards-rpm-query-in-dired
;;;;;;  emacspeak-wizards-shell-toggle emacspeak-annotate-add-annotation
;;;;;;  emacspeak-wizards-get-table-content-from-file emacspeak-wizards-get-table-content-from-url
;;;;;;  emacspeak-wizards-terminal emacspeak-curl emacspeak-lynx
;;;;;;  emacspeak-links emacspeak-skip-blank-lines-backward emacspeak-skip-blank-lines-forward
;;;;;;  emacspeak-show-property-at-point emacspeak-show-personality-at-point
;;;;;;  emacspeak-customize-personal-settings emacspeak-ssh-tts-restart
;;;;;;  emacspeak-emergency-tts-restart emacspeak-wizards-show-memory-used
;;;;;;  emacspeak-wizards-show-eval-result emacspeak-clipboard-paste
;;;;;;  emacspeak-clipboard-copy emacspeak-select-this-buffer-next-display
;;;;;;  emacspeak-select-this-buffer-previous-display emacspeak-select-this-buffer-other-window-display
;;;;;;  emacspeak-speak-this-buffer-next-display emacspeak-speak-this-buffer-previous-display
;;;;;;  emacspeak-speak-this-buffer-other-window-display emacspeak-previous-frame-or-buffer
;;;;;;  emacspeak-next-frame-or-buffer emacspeak-frame-label-or-switch-to-labelled-frame
;;;;;;  emacspeak-generate-texinfo-option-documentation emacspeak-generate-texinfo-command-documentation
;;;;;;  emacspeak-generate-documentation emacspeak-learn-emacs-mode
;;;;;;  emacspeak-wizards-move-and-speak emacspeak-cvs-berlios-get-project-snapshot
;;;;;;  emacspeak-cvs-gnu-get-project-snapshot emacspeak-cvs-sf-get-project-snapshot
;;;;;;  emacspeak-cvs-get-anonymous emacspeak-wizards-vi-as-su-file
;;;;;;  emacspeak-wizards-edit-file-as-root emacspeak-wizards-vpn-toggle
;;;;;;  emacspeak-wizards-ppp-toggle emacspeak-wizards-tpctl-display-status
;;;;;;  emacspeak-wizards-i810-display-status emacspeak-sudo emacspeak-root
;;;;;;  emacspeak-speak-telephone-directory emacspeak-speak-show-active-network-interfaces
;;;;;;  emacspeak-speak-hostname emacspeak-wizards-tex-tie-current-word
;;;;;;  emacspeak-wizards-lacheck-buffer-file emacspeak-wizards-comma-at-end-of-word
;;;;;;  emacspeak-wizards-end-of-word emacspeak-wizards-load-current-file
;;;;;;  emacspeak-wizards-byte-compile-current-buffer emacspeak-speak-popup-messages
;;;;;;  emacspeak-speak-browse-linux-howto emacspeak-speak-run-shell-command
;;;;;;  emacspeak-symlink-current-file emacspeak-link-current-file
;;;;;;  emacspeak-copy-current-file emacspeak-view-emacspeak-faq
;;;;;;  emacspeak-view-emacspeak-tips emacspeak-view-emacspeak-doc
;;;;;;  emacspeak-view-emacspeak-news) "emacspeak-wizards" "emacspeak-wizards.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-wizards.el

(autoload 'emacspeak-view-emacspeak-news "emacspeak-wizards" "\
Display info on recent change to Emacspeak.

\(fn)" t nil)

(autoload 'emacspeak-view-emacspeak-doc "emacspeak-wizards" "\
Display a summary of all Emacspeak commands.

\(fn)" t nil)

(autoload 'emacspeak-view-emacspeak-tips "emacspeak-wizards" "\
Browse  Emacspeak productivity tips.

\(fn)" t nil)

(autoload 'emacspeak-view-emacspeak-faq "emacspeak-wizards" "\
Browse the Emacspeak FAQ.

\(fn)" t nil)

(autoload 'emacspeak-copy-current-file "emacspeak-wizards" "\
Copy file visited in current buffer to new location.
Prompts for the new location and preserves modification time
  when copying.  If location is a directory, the file is copied
  to that directory under its current name ; if location names
  a file in an existing directory, the specified name is
  used.  Asks for confirmation if the copy will result in an
  existing file being overwritten.

\(fn)" t nil)

(autoload 'emacspeak-link-current-file "emacspeak-wizards" "\
Link (hard link) file visited in current buffer to new location.
Prompts for the new location and preserves modification time
  when linking.  If location is a directory, the file is copied
  to that directory under its current name ; if location names
  a file in an existing directory, the specified name is
  used.  Signals an error if target already exists.

\(fn)" t nil)

(autoload 'emacspeak-symlink-current-file "emacspeak-wizards" "\
Link (symbolic link) file visited in current buffer to new location.
Prompts for the new location and preserves modification time
  when linking.  If location is a directory, the file is copied
  to that directory under its current name ; if location names
  a file in an existing directory, the specified name is
  used.  Signals an error if target already exists.

\(fn)" t nil)

(autoload 'emacspeak-speak-run-shell-command "emacspeak-wizards" "\
Invoke shell COMMAND and display its output as a table.  The results
are placed in a buffer in Emacspeak's table browsing mode.  Optional
interactive prefix arg as-root runs the command as root.  Use this for running shell commands that produce
tabulated output.  This command should be used for shell commands that
produce tabulated output that works with Emacspeak's table recognizer.
Verify this first by running the command in a shell and executing
command `emacspeak-table-display-table-in-region' normally bound to
\\[emacspeak-table-display-table-in-region].

\(fn COMMAND &optional AS-ROOT)" t nil)

(autoload 'emacspeak-speak-browse-linux-howto "emacspeak-wizards" "\
Browse a Linux Howto file.
We cleanup underlining, and set up outline mode correctly.

\(fn HOWTO)" t nil)

(autoload 'emacspeak-speak-popup-messages "emacspeak-wizards" "\
Pop up messages buffer.
If it is already selected then hide it and try to restore
previous window configuration.

\(fn)" t nil)

(autoload 'emacspeak-wizards-byte-compile-current-buffer "emacspeak-wizards" "\
byte compile current buffer

\(fn)" t nil)

(autoload 'emacspeak-wizards-load-current-file "emacspeak-wizards" "\
load file into emacs

\(fn)" t nil)

(autoload 'emacspeak-wizards-end-of-word "emacspeak-wizards" "\
move to end of word

\(fn ARG)" t nil)

(autoload 'emacspeak-wizards-comma-at-end-of-word "emacspeak-wizards" "\
Move to the end of current word and add a comma.

\(fn)" t nil)

(autoload 'emacspeak-wizards-lacheck-buffer-file "emacspeak-wizards" "\
Run Lacheck on current buffer.

\(fn)" t nil)

(autoload 'emacspeak-wizards-tex-tie-current-word "emacspeak-wizards" "\
Tie the next n  words.

\(fn N)" t nil)

(autoload 'emacspeak-speak-hostname "emacspeak-wizards" "\
Speak host name.

\(fn)" t nil)

(autoload 'emacspeak-speak-show-active-network-interfaces "emacspeak-wizards" "\
Shows all active network interfaces in the echo area.
With interactive prefix argument ADDRESS it prompts for a
specific interface and shows its address. The address is
also copied to the kill ring for convenient yanking.

\(fn &optional ADDRESS)" t nil)

(autoload 'emacspeak-speak-telephone-directory "emacspeak-wizards" "\
Lookup and display a phone number.
With prefix arg, opens the phone book for editting.

\(fn &optional EDIT)" t nil)

(autoload 'emacspeak-root "emacspeak-wizards" "\
Start a root shell or switch to one that already exists.
Optional interactive prefix arg `cd' executes cd
default-directory after switching.

\(fn &optional CD)" t nil)

(autoload 'emacspeak-sudo "emacspeak-wizards" "\
SUDo command --run command as super user.

\(fn COMMAND)" t nil)

(autoload 'emacspeak-wizards-i810-display-status "emacspeak-wizards" "\
Show display status on thinkpads using i810switch.

\(fn)" t nil)

(autoload 'emacspeak-wizards-tpctl-display-status "emacspeak-wizards" "\
Show display status on thinkpads using tpctl.

\(fn)" t nil)

(autoload 'emacspeak-wizards-ppp-toggle "emacspeak-wizards" "\
Bring up or bring down ppp.

\(fn)" t nil)

(autoload 'emacspeak-wizards-vpn-toggle "emacspeak-wizards" "\
Bring up or bring down vpn.

\(fn)" t nil)

(autoload 'emacspeak-wizards-edit-file-as-root "emacspeak-wizards" "\
Edit file as root using sudo vi.
See /etc/sudoers for how to set up sudo.

\(fn FILENAME)" t nil)

(autoload 'emacspeak-wizards-vi-as-su-file "emacspeak-wizards" "\
Launch sudo vi on specified file in a terminal.

\(fn FILE)" t nil)

(autoload 'emacspeak-cvs-get-anonymous "emacspeak-wizards" "\
Get latest cvs snapshot of emacspeak.

\(fn)" t nil)

(autoload 'emacspeak-cvs-sf-get-project-snapshot "emacspeak-wizards" "\
Grab CVS snapshot  of specified project from sf.
Ask for module name if prefix argument is given

\(fn PROJECT &optional MODULE)" t nil)

(autoload 'emacspeak-cvs-gnu-get-project-snapshot "emacspeak-wizards" "\
Grab CVS snapshot  of specified project from gnu.
Ask for module name if prefix argument is given

\(fn PROJECT &optional MODULE)" t nil)

(autoload 'emacspeak-cvs-berlios-get-project-snapshot "emacspeak-wizards" "\
Grab CVS snapshot  of specified project from berlios.de.
Ask for module name if prefix argument is given

\(fn PROJECT &optional MODULE)" t nil)

(autoload 'emacspeak-wizards-move-and-speak "emacspeak-wizards" "\
Speaks a chunk of text bounded by point and a target position.
Target position is specified using a navigation command and a
count that specifies how many times to execute that command
first.  Point is left at the target position.  Interactively,
command is specified by pressing the key that invokes the
command.

\(fn COMMAND COUNT)" t nil)

(autoload 'emacspeak-learn-emacs-mode "emacspeak-wizards" "\
Helps you learn the keys.  You can press keys and hear what they do.
To leave, press \\[keyboard-quit].

\(fn)" t nil)

(autoload 'emacspeak-generate-documentation "emacspeak-wizards" "\
Generate docs for all emacspeak commands.
Prompts for FILENAME in which to save the documentation.
Warning! Contents of file filename will be overwritten.

\(fn FILENAME)" t nil)

(autoload 'emacspeak-generate-texinfo-command-documentation "emacspeak-wizards" "\
Generate texinfo documentation  for all emacspeak
commands  into file commands.texi.
Warning! Contents of file commands.texi will be overwritten.

\(fn FILENAME)" t nil)

(autoload 'emacspeak-generate-texinfo-option-documentation "emacspeak-wizards" "\
Generate texinfo documentation  for all emacspeak
options  into file filename.
Warning! Contents of file filename will be overwritten.

\(fn FILENAME)" t nil)

(defsubst emacspeak-frame-read-frame-label nil "\
Read a frame label with completion." (interactive) (let* ((frame-names-alist (make-frame-names-alist)) (default (car (car frame-names-alist))) (input (completing-read (format "Select Frame (default %s): " default) frame-names-alist nil t nil (quote frame-name-history)))) (if (= (length input) 0) default)))

(autoload 'emacspeak-frame-label-or-switch-to-labelled-frame "emacspeak-wizards" "\
Switch to labelled frame.
With optional PREFIX argument, label current frame.

\(fn &optional PREFIX)" t nil)

(autoload 'emacspeak-next-frame-or-buffer "emacspeak-wizards" "\
Move to next buffer.
With optional interactive prefix arg `frame', move to next frame instead.

\(fn &optional FRAME)" t nil)

(autoload 'emacspeak-previous-frame-or-buffer "emacspeak-wizards" "\
Move to previous buffer.
With optional interactive prefix arg `frame', move to previous frame instead.

\(fn &optional FRAME)" t nil)

(autoload 'emacspeak-speak-this-buffer-other-window-display "emacspeak-wizards" "\
Speak this buffer as displayed in a different frame.  Emacs
allows you to display the same buffer in multiple windows or
frames.  These different windows can display different
portions of the buffer.  This is equivalent to leaving a
book open at places at once.  This command allows you to
listen to the places where you have left the book open.  The
number used to invoke this command specifies which of the
displays you wish to speak.  Typically you will have two or
at most three such displays open.  The current display is 0,
the next is 1, and so on.  Optional argument ARG specifies
the display to speak.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-speak-this-buffer-previous-display "emacspeak-wizards" "\
Speak this buffer as displayed in a `previous' window.
See documentation for command
`emacspeak-speak-this-buffer-other-window-display' for the
meaning of `previous'.

\(fn)" t nil)

(autoload 'emacspeak-speak-this-buffer-next-display "emacspeak-wizards" "\
Speak this buffer as displayed in a `previous' window.
See documentation for command
`emacspeak-speak-this-buffer-other-window-display' for the
meaning of `next'.

\(fn)" t nil)

(autoload 'emacspeak-select-this-buffer-other-window-display "emacspeak-wizards" "\
Switch  to this buffer as displayed in a different frame.  Emacs
allows you to display the same buffer in multiple windows or
frames.  These different windows can display different
portions of the buffer.  This is equivalent to leaving a
book open at places at once.  This command allows you to
move to the places where you have left the book open.  The
number used to invoke this command specifies which of the
displays you wish to select.  Typically you will have two or
at most three such displays open.  The current display is 0,
the next is 1, and so on.  Optional argument ARG specifies
the display to select.

\(fn &optional ARG)" t nil)

(autoload 'emacspeak-select-this-buffer-previous-display "emacspeak-wizards" "\
Select this buffer as displayed in a `previous' window.
See documentation for command
`emacspeak-select-this-buffer-other-window-display' for the
meaning of `previous'.

\(fn)" t nil)

(autoload 'emacspeak-select-this-buffer-next-display "emacspeak-wizards" "\
Select this buffer as displayed in a `next' frame.
See documentation for command
`emacspeak-select-this-buffer-other-window-display' for the
meaning of `next'.

\(fn)" t nil)

(autoload 'emacspeak-clipboard-copy "emacspeak-wizards" "\
Copy contents of the region to the emacspeak clipboard.
Previous contents of the clipboard will be overwritten.  The Emacspeak
clipboard is a convenient way of sharing information between
independent Emacspeak sessions running on the same or different
machines.  Do not use this for sharing information within an Emacs
session --Emacs' register commands are far more efficient and
light-weight.  Optional interactive prefix arg results in Emacspeak
prompting for the clipboard file to use.
Argument START and END specifies  region.
Optional argument PROMPT  specifies whether we prompt for the name of a clipboard file.

\(fn START END &optional PROMPT)" t nil)

(autoload 'emacspeak-clipboard-paste "emacspeak-wizards" "\
Yank contents of the Emacspeak clipboard at point.
The Emacspeak clipboard is a convenient way of sharing information between
independent Emacspeak sessions running on the same or different
machines.  Do not use this for sharing information within an Emacs
session --Emacs' register commands are far more efficient and
light-weight.  Optional interactive prefix arg pastes from
the emacspeak table clipboard instead.

\(fn &optional PASTE-TABLE)" t nil)

(autoload 'emacspeak-wizards-show-eval-result "emacspeak-wizards" "\
Convenience command to pretty-print and view Lisp evaluation results.

\(fn FORM)" t nil)

(autoload 'emacspeak-wizards-show-memory-used "emacspeak-wizards" "\
Convenience command to view state of memory used in this session so far.

\(fn)" t nil)

(autoload 'emacspeak-emergency-tts-restart "emacspeak-wizards" "\
For use in an emergency.
Will start TTS engine specified by
emacspeak-emergency-tts-server.

\(fn)" t nil)

(autoload 'emacspeak-ssh-tts-restart "emacspeak-wizards" "\
Restart specified ssh tts server.

\(fn)" t nil)

(autoload 'emacspeak-customize-personal-settings "emacspeak-wizards" "\
Create a customization buffer for browsing and updating
personal customizations.

\(fn FILE)" t nil)

(autoload 'emacspeak-show-personality-at-point "emacspeak-wizards" "\
Show value of property personality (and possibly face)
at point.

\(fn)" t nil)

(autoload 'emacspeak-show-property-at-point "emacspeak-wizards" "\
Show value of PROPERTY at point.
If optional arg property is not supplied, read it interactively.
Provides completion based on properties that are of interest.
If no property is set, show a message and exit.

\(fn &optional PROPERTY)" t nil)

(autoload 'emacspeak-skip-blank-lines-forward "emacspeak-wizards" "\
Move forward across blank lines.
The line under point is then spoken.
Signals end of buffer.

\(fn)" t nil)

(autoload 'emacspeak-skip-blank-lines-backward "emacspeak-wizards" "\
Move backward  across blank lines.
The line under point is   then spoken.
Signals beginning  of buffer.

\(fn)" t nil)

(autoload 'emacspeak-links "emacspeak-wizards" "\
Launch links on  specified URL in a new terminal.

\(fn URL)" t nil)

(autoload 'emacspeak-lynx "emacspeak-wizards" "\
Launch lynx on  specified URL in a new terminal.

\(fn URL)" t nil)

(autoload 'emacspeak-curl "emacspeak-wizards" "\
Grab URL using Curl, and preview it with a browser .

\(fn URL)" t nil)

(autoload 'emacspeak-wizards-terminal "emacspeak-wizards" "\
Launch terminal and rename buffer appropriately.

\(fn PROGRAM)" t nil)

(autoload 'emacspeak-wizards-get-table-content-from-url "emacspeak-wizards" "\
Extract table specified by depth and count from HTML
content at URL.
Extracted content is placed as a csv file in task.csv.

\(fn URL DEPTH COUNT)" t nil)

(autoload 'emacspeak-wizards-get-table-content-from-file "emacspeak-wizards" "\
Extract table specified by depth and count from HTML
content at file.
Extracted content is sent to STDOUT.

\(fn FILE DEPTH COUNT)" t nil)

(autoload 'emacspeak-annotate-add-annotation "emacspeak-wizards" "\
Add annotation to the annotation working buffer.
Prompt for annotation buffer if not already set.
Interactive prefix arg `reset' prompts for the annotation
buffer even if one is already set.
Annotation is entered in a temporary buffer and the
annotation is inserted into the working buffer when complete.

\(fn &optional RESET)" t nil)

(autoload 'emacspeak-wizards-shell-toggle "emacspeak-wizards" "\
Switch to the shell buffer and cd to
 the directory of the current buffer.

\(fn)" t nil)

(autoload 'emacspeak-wizards-rpm-query-in-dired "emacspeak-wizards" "\
Run rpm -qi on current dired entry.

\(fn)" t nil)

(autoload 'emacspeak-wizards-xl-display "emacspeak-wizards" "\
Called to set up preview of an XL file.
Assumes we are in a buffer visiting a .xls file.
Previews those contents as HTML and nukes the buffer
visiting the xls file.

\(fn)" t nil)

(autoload 'emacspeak-wizards-pdf-open "emacspeak-wizards" "\
Open pdf file as text.

\(fn FILENAME)" t nil)

(autoload 'emacspeak-wizards-ppt-display "emacspeak-wizards" "\
Called to set up preview of an PPT file.
Assumes we are in a buffer visiting a .ppt file.
Previews those contents as HTML and nukes the buffer
visiting the ppt file.

\(fn)" t nil)

(autoload 'emacspeak-wizards-dvi-display "emacspeak-wizards" "\
Called to set up preview of an DVI file.
Assumes we are in a buffer visiting a .DVI file.
Previews those contents as text and nukes the buffer
visiting the DVI file.

\(fn)" t nil)

(autoload 'emacspeak-wizards-portfolio-quotes "emacspeak-wizards" "\
Bring up detailed stock quotes for portfolio specified by
emacspeak-wizards-personal-portfolio.

\(fn)" t nil)

(autoload 'emacspeak-wizards-generate-finder "emacspeak-wizards" "\
Generate a widget-enabled finder wizard.

\(fn)" t nil)

(autoload 'emacspeak-wizards-finder-find "emacspeak-wizards" "\
Run find-dired on specified switches after prompting for the
directory to where find is to be launched.

\(fn DIRECTORY)" t nil)

(autoload 'emacspeak-wizards-use-w3-or-w3m "emacspeak-wizards" "\
Alternates between using W3 and W3M for browse-url.

\(fn)" t nil)

(autoload 'emacspeak-customize "emacspeak-wizards" "\
Customize Emacspeak.

\(fn)" t nil)

(autoload 'emacspeak-wizards-show-environment-variable "emacspeak-wizards" "\
Display value of specified environment variable.

\(fn V)" t nil)

(autoload 'emacspeak-wizards-squeeze-blanks "emacspeak-wizards" "\
Squeeze multiple blank lines in current buffer.

\(fn START END)" t nil)

(autoload 'emacspeak-wizards-count-slides-in-region "emacspeak-wizards" "\
Count slides starting from point.

\(fn START END)" t nil)

(autoload 'emacspeak-wizards-how-many-matches "emacspeak-wizards" "\
If you define a file local variable
called `emacspeak-occur-pattern' that holds a regular expression
that matches  lines of interest, you can use this command to conveniently
run `how-many' to count  matching header lines.
With interactive prefix arg, prompts for and remembers the file local pattern.

\(fn START END &optional PREFIX)" t nil)

(autoload 'emacspeak-wizards-occur-header-lines "emacspeak-wizards" "\
If you define a file local variable called
`emacspeak-occur-pattern' that holds a regular expression that
matches header lines, you can use this command to conveniently
run `occur' to find matching header lines. With prefix arg,
prompts for and sets value of the file local pattern.

\(fn PREFIX)" t nil)

(autoload 'emacspeak-switch-to-previous-buffer "emacspeak-wizards" "\
Switch to most recently used interesting buffer.
Obsoleted by `previous-buffer' in Emacs 22

\(fn)" t nil)

(autoload 'emacspeak-kill-buffer-quietly "emacspeak-wizards" "\
Kill current buffer without asking for confirmation.

\(fn)" t nil)

(autoload 'emacspeak-wizards-spot-words "emacspeak-wizards" "\
Searches recursively in all files with extension `ext'
for `word' and displays hits in a compilation buffer.

\(fn EXT WORD)" t nil)

(autoload 'emacspeak-wizards-fix-typo "emacspeak-wizards" "\
Search and replace  recursively in all files with extension `ext'
for `word' and replace it with correction.
Use with caution.

\(fn EXT WORD CORRECTION)" t nil)

(autoload 'emacspeak-wizards-display-pod-as-manpage "emacspeak-wizards" "\
Create a virtual manpage in Emacs from the Perl Online Documentation.

\(fn FILENAME)" t nil)

(autoload 'emacspeak-wizards-fix-read-only-text "emacspeak-wizards" "\
Nuke read-only property on text range.

\(fn START END)" t nil)

(autoload 'emacspeak-wizards-vc-viewer "emacspeak-wizards" "\
View contents of specified virtual console.

\(fn CONSOLE)" t nil)

(autoload 'emacspeak-wizards-vc-viewer-refresh "emacspeak-wizards" "\
Refresh view of VC we're viewing.

\(fn)" t nil)

(autoload 'emacspeak-wizards-vc-n "emacspeak-wizards" "\
Accelerator for VC viewer.

\(fn)" t nil)

(autoload 'emacspeak-wizards-google-hits "emacspeak-wizards" "\
Filter Google results after performing search to show just the
hits.

\(fn)" t nil)

(autoload 'emacspeak-wizards-google-transcode "emacspeak-wizards" "\
View Web through Google Transcoder.

\(fn)" t nil)

(autoload 'emacspeak-wizards-find-longest-line-in-region "emacspeak-wizards" "\
Find longest line in region.
Moves to the longest line when called interactively.

\(fn START END)" t nil)

(autoload 'emacspeak-wizards-find-longest-paragraph-in-region "emacspeak-wizards" "\
Find longest paragraph in region.
Moves to the longest paragraph when called interactively.

\(fn START END)" t nil)

(autoload 'emacspeak-wizards-find-grep "emacspeak-wizards" "\
Run compile using find and grep.
Interactive  arguments specify filename pattern and search pattern.

\(fn GLOB PATTERN)" t nil)

(autoload 'emacspeak-wizards-show-face "emacspeak-wizards" "\
Show salient properties of specified face.

\(fn FACE)" t nil)

(autoload 'emacspeak-wizards-voice-sampler "emacspeak-wizards" "\
Read a personality  and apply it to the current line.

\(fn PERSONALITY)" t nil)

(autoload 'emacspeak-wizards-generate-voice-sampler "emacspeak-wizards" "\
Generate a buffer that shows a sample line in all the ACSS settings
for the current voice family.

\(fn STEP)" t nil)

(autoload 'emacspeak-wizards-tramp-open-location "emacspeak-wizards" "\
Open specified tramp location.
Location is specified by name.

\(fn NAME)" t nil)

(autoload 'emacspeak-wizards-speak-iso-datetime "emacspeak-wizards" "\
Make ISO date-time speech friendly.

\(fn ISO)" t nil)

(autoload 'emacspeak-wizards-toggle-mm-dd-yyyy-date-pronouncer "emacspeak-wizards" "\
Toggle pronunciation of mm-dd-yyyy dates.

\(fn)" t nil)

(autoload 'emacspeak-wizards-units "emacspeak-wizards" "\
Run units in a comint sub-process.

\(fn)" t nil)

(autoload 'emacspeak-wizards-js "emacspeak-wizards" "\
Run JS in a comint sub-process.

\(fn)" t nil)

(autoload 'emacspeak-wizards-rivo "emacspeak-wizards" "\
Rivo wizard.
Prompts for relevant information and schedules a rivo job using
  UNIX At scheduling facility.
RIVO is implemented by rivo.pl ---
 a Perl script  that can be used to launch streaming media and record
   streaming media for  a specified duration.

\(fn WHEN CHANNEL STOP-TIME OUTPUT DIRECTORY)" t nil)

(autoload 'emacspeak-wizards-refresh-shell-history "emacspeak-wizards" "\
Refresh shell history from disk.
This is for use in conjunction with bash to allow multiple emacs
  shell buffers to   share history information.

\(fn)" t nil)

(autoload 'emacspeak-wizards-shell-bind-keys "emacspeak-wizards" "\
Set up additional shell mode keys.

\(fn)" nil nil)

(autoload 'emacspeak-wizards-show-commentary "emacspeak-wizards" "\
Display commentary. Default is to display commentary from current buffer.

\(fn &optional FILE)" t nil)

(autoload 'emacspeak-wizards-unhex-uri "emacspeak-wizards" "\
UnEscape URI

\(fn URI)" t nil)

(autoload 'emacspeak-wizards-add-autoload-cookies "emacspeak-wizards" "\
Add autoload cookies to file f.
Default is to add autoload cookies to current file.

\(fn &optional F)" t nil)

(autoload 'emacspeak-wizards-thanks-mail-signature "emacspeak-wizards" "\
insert thanks , --Raman at the end of mail message

\(fn)" t nil)

(autoload 'emacspeak-wizards-popup-input-buffer "emacspeak-wizards" "\
Provide an input buffer in a specified mode.

\(fn MODE)" t nil)

(autoload 'emacspeak-wizards-find-emacspeak-source "emacspeak-wizards" "\
Like find-file, but binds default-directory to emacspeak-directory.

\(fn)" t nil)

;;;***

;;;### (autoloads (emacspeak-xml-shell emacspeak-xml-shell) "emacspeak-xml-shell"
;;;;;;  "emacspeak-xml-shell.el" (18832 52324))
;;; Generated autoloads from emacspeak-xml-shell.el

(let ((loads (get 'emacspeak-xml-shell 'custom-loads))) (if (member '"emacspeak-xml-shell" loads) nil (put 'emacspeak-xml-shell 'custom-loads (cons '"emacspeak-xml-shell" loads))))

(autoload 'emacspeak-xml-shell "emacspeak-xml-shell" "\
Start Xml-Shell on contents of system-id.

\(fn SYSTEM-ID)" t nil)

;;;***

;;;### (autoloads (emacspeak-xslt-view-region emacspeak-xslt-view-xml
;;;;;;  emacspeak-xslt-view emacspeak-xslt-xml-url emacspeak-xslt-url
;;;;;;  emacspeak-xslt-use-wget-to-download emacspeak-xslt-region
;;;;;;  emacspeak-xslt-options) "emacspeak-xslt" "emacspeak-xslt.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-xslt.el

(defsubst emacspeak-xslt-get (style) "\
Return fully qualified stylesheet path." (declare (special emacspeak-xslt-directory)) (expand-file-name style emacspeak-xslt-directory))

(defvar emacspeak-xslt-options "--html --nonet --novalid" "\
Options passed to xsltproc.")

(custom-autoload 'emacspeak-xslt-options "emacspeak-xslt" t)

(autoload 'emacspeak-xslt-region "emacspeak-xslt" "\
Apply XSLT transformation to region and replace it with
the result.  This uses XSLT processor xsltproc available as
part of the libxslt package.

\(fn XSL START END &optional PARAMS NO-COMMENT)" nil nil)

(defsubst emacspeak-xslt-run (xsl start end) "\
Run xslt on region, and return output filtered by sort -u" (declare (special emacspeak-xslt-program emacspeak-xslt-options)) (let ((coding-system-for-read (quote utf-8)) (coding-system-for-write (quote utf-8)) (buffer-file-coding-system (quote utf-8))) (shell-command-on-region start end (format "%s %s %s - 2>/dev/null | sort -u" emacspeak-xslt-program emacspeak-xslt-options xsl) (current-buffer) (quote replace)) (set-buffer-multibyte t) (current-buffer)))

(defvar emacspeak-xslt-use-wget-to-download nil "\
Set to T if you want to avoid URL downloader bugs in libxml2.
There is a bug that bites when using Yahoo Maps that wget can
work around.")

(custom-autoload 'emacspeak-xslt-use-wget-to-download "emacspeak-xslt" t)

(autoload 'emacspeak-xslt-url "emacspeak-xslt" "\
Apply XSLT transformation to url
and return the results in a newly created buffer.
  This uses XSLT processor xsltproc available as
part of the libxslt package.

\(fn XSL URL &optional PARAMS NO-COMMENT)" nil nil)

(autoload 'emacspeak-xslt-xml-url "emacspeak-xslt" "\
Apply XSLT transformation to XML url
and return the results in a newly created buffer.
  This uses XSLT processor xsltproc available as
part of the libxslt package.

\(fn XSL URL &optional PARAMS)" nil nil)

(autoload 'emacspeak-xslt-view "emacspeak-xslt" "\
Browse URL with specified XSL style.

\(fn STYLE URL)" t nil)

(autoload 'emacspeak-xslt-view-xml "emacspeak-xslt" "\
Browse XML URL with specified XSL style.

\(fn STYLE URL &optional UNESCAPE-CHARENT)" t nil)

(autoload 'emacspeak-xslt-view-region "emacspeak-xslt" "\
Browse XML region with specified XSL style.

\(fn STYLE START END &optional UNESCAPE-CHARENT)" t nil)

;;;***

;;;### (autoloads (emacspeak-zinf emacspeak-zinf-zinf-call-command
;;;;;;  emacspeak-zinf-zinf-command) "emacspeak-zinf" "emacspeak-zinf.el"
;;;;;;  (18832 52324))
;;; Generated autoloads from emacspeak-zinf.el

(define-prefix-command 'emacspeak-zinf-prefix-command 'emacspeak-zinf-mode-map)

(autoload 'emacspeak-zinf-zinf-command "emacspeak-zinf" "\
Execute Zinf command.

\(fn CHAR)" t nil)

(autoload 'emacspeak-zinf-zinf-call-command "emacspeak-zinf" "\
Call appropriate zinf command.

\(fn)" t nil)

(autoload 'emacspeak-zinf "emacspeak-zinf" "\
Play specified resource using zinf.
Resource is an  MP3 file or m3u playlist.
The player is placed in a buffer in emacspeak-zinf-mode.

\(fn RESOURCE)" t nil)

;;;***

;;;### (autoloads (tts-eflite) "flite-voices" "flite-voices.el" (18832
;;;;;;  52324))
;;; Generated autoloads from flite-voices.el

(autoload 'tts-eflite "flite-voices" "\
Use eflite TTS server.

\(fn)" t nil)

;;;***

;;;### (autoloads (voice-setup-toggle-silence-personality turn-on-voice-lock
;;;;;;  voice-lock-mode) "voice-setup" "voice-setup.el" (18832 52324))
;;; Generated autoloads from voice-setup.el

(autoload 'voice-lock-mode "voice-setup" "\
Toggle Voice Lock mode.
With arg, turn Voice Lock mode on if and only if arg is positive.

This light-weight voice lock engine leverages work already done by
font-lock.  Voicification is effective only if font lock is on.

\(fn &optional ARG)" t nil)

(autoload 'turn-on-voice-lock "voice-setup" "\
Turn on Voice Lock mode .

\(fn)" nil nil)

(autoload 'voice-setup-toggle-silence-personality "voice-setup" "\
Toggle audibility of personality under point  .
If personality at point is currently audible, its
face->personality map is cached in a buffer local variable, and
its face->personality map is replaced by face->inaudible.  If
personality at point is inaudible, and there is a cached value,
then the original face->personality mapping is restored.  In
either case, the buffer is refontified to have the new mapping
take effect.

\(fn)" t nil)

;;;***

;;;### (autoloads (xml-reformat-tags insert-xml read-xml) "xml-parse"
;;;;;;  "xml-parse.el" (18832 52324))
;;; Generated autoloads from xml-parse.el

(autoload 'read-xml "xml-parse" "\
Parse XML data at point into a Lisp structure.
See `insert-xml' for a description of the format of this structure.
Point is left at the end of the XML structure read.

\(fn)" nil nil)

(autoload 'insert-xml "xml-parse" "\
Insert DATA, a recursive Lisp structure, at point as XML.
DATA has the form:

  ENTRY       ::=  (TAG CHILD*)
  CHILD       ::=  STRING | ENTRY
  TAG         ::=  TAG_NAME | (TAG_NAME ATTR+)
  ATTR        ::=  (ATTR_NAME . ATTR_VALUE)
  TAG_NAME    ::=  STRING
  ATTR_NAME   ::=  STRING
  ATTR_VALUE  ::=  STRING

If ADD-NEWLINES is non-nil, newlines and indentation will be added to
make the data user-friendly.

If PUBLIC and SYSTEM are non-nil, a !DOCTYPE tag will be added at the
top of the document to identify it as an XML document.

DEPTH is normally for internal use only, and controls the depth of the
indentation.

\(fn DATA &optional ADD-NEWLINES PUBLIC SYSTEM DEPTH RET-DEPTH)" nil nil)

(autoload 'xml-reformat-tags "xml-parse" "\
If point is on the open bracket of an XML tag, reformat that tree.
Note that this only works if the opening tag starts at column 0.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("acss-structure.el" "dectalk-voices.el"
;;;;;;  "dtk-interp.el" "dtk-unicode.el" "emacspeak-actions.el" "emacspeak-add-log.el"
;;;;;;  "emacspeak-analog.el" "emacspeak-ansi-color.el" "emacspeak-apt-sources.el"
;;;;;;  "emacspeak-apt-utils.el" "emacspeak-arc.el" "emacspeak-auctex.el"
;;;;;;  "emacspeak-autoload.el" "emacspeak-babel.el" "emacspeak-bbdb.el"
;;;;;;  "emacspeak-bibtex.el" "emacspeak-bmk-mgr.el" "emacspeak-bookmark.el"
;;;;;;  "emacspeak-browse-kill-ring.el" "emacspeak-bs.el" "emacspeak-buff-menu.el"
;;;;;;  "emacspeak-c.el" "emacspeak-calc.el" "emacspeak-calculator.el"
;;;;;;  "emacspeak-cedet.el" "emacspeak-checkdoc.el" "emacspeak-cmuscheme.el"
;;;;;;  "emacspeak-compile.el" "emacspeak-cperl.el" "emacspeak-damlite.el"
;;;;;;  "emacspeak-desktop.el" "emacspeak-dictation.el" "emacspeak-dictionary.el"
;;;;;;  "emacspeak-dired.el" "emacspeak-dismal.el" "emacspeak-dmacro.el"
;;;;;;  "emacspeak-ecb.el" "emacspeak-ediary.el" "emacspeak-ediff.el"
;;;;;;  "emacspeak-emms.el" "emacspeak-enriched.el" "emacspeak-entertain.el"
;;;;;;  "emacspeak-eperiodic.el" "emacspeak-erc.el" "emacspeak-eshell.el"
;;;;;;  "emacspeak-ess.el" "emacspeak-etable.el" "emacspeak-eudc.el"
;;;;;;  "emacspeak-facemenu.el" "emacspeak-find-dired.el" "emacspeak-find-func.el"
;;;;;;  "emacspeak-finder.el" "emacspeak-flyspell.el" "emacspeak-folding.el"
;;;;;;  "emacspeak-generic.el" "emacspeak-gnuplot.el" "emacspeak-gnus.el"
;;;;;;  "emacspeak-gomoku.el" "emacspeak-gud.el" "emacspeak-hideshow.el"
;;;;;;  "emacspeak-ibuffer.el" "emacspeak-ido.el" "emacspeak-ispell.el"
;;;;;;  "emacspeak-iswitchb.el" "emacspeak-jabber.el" "emacspeak-jde.el"
;;;;;;  "emacspeak-js2.el" "emacspeak-kmacro.el" "emacspeak-load-path.el"
;;;;;;  "emacspeak-make-mode.el" "emacspeak-man.el" "emacspeak-message.el"
;;;;;;  "emacspeak-metapost.el" "emacspeak-midge.el" "emacspeak-mpg123.el"
;;;;;;  "emacspeak-mspools.el" "emacspeak-muse.el" "emacspeak-net-utils.el"
;;;;;;  "emacspeak-newsticker.el" "emacspeak-nxml.el" "emacspeak-outline.el"
;;;;;;  "emacspeak-pcl-cvs.el" "emacspeak-perl.el" "emacspeak-php-mode.el"
;;;;;;  "emacspeak-preamble.el" "emacspeak-proced.el" "emacspeak-psgml.el"
;;;;;;  "emacspeak-python.el" "emacspeak-re-builder.el" "emacspeak-redefine.el"
;;;;;;  "emacspeak-reftex.el" "emacspeak-replace.el" "emacspeak-rmail.el"
;;;;;;  "emacspeak-rpm-spec.el" "emacspeak-rpm.el" "emacspeak-ruby.el"
;;;;;;  "emacspeak-sawfish.el" "emacspeak-ses.el" "emacspeak-sgml-mode.el"
;;;;;;  "emacspeak-sh-script.el" "emacspeak-sigbegone.el" "emacspeak-solitaire.el"
;;;;;;  "emacspeak-speedbar.el" "emacspeak-sql.el" "emacspeak-sudoku.el"
;;;;;;  "emacspeak-supercite.el" "emacspeak-swbuff.el" "emacspeak-tar.el"
;;;;;;  "emacspeak-tcl.el" "emacspeak-tdtd.el" "emacspeak-tempo.el"
;;;;;;  "emacspeak-tetris.el" "emacspeak-texinfo.el" "emacspeak-tnt.el"
;;;;;;  "emacspeak-todo-mode.el" "emacspeak-view-process.el" "emacspeak-view.el"
;;;;;;  "emacspeak-vm.el" "emacspeak-wdired.el" "emacspeak-windmove.el"
;;;;;;  "emacspeak-winring.el" "emacspeak-xslide.el" "emacspeak-xslt-process.el"
;;;;;;  "espeak-voices.el" "multispeech-voices.el" "outloud-voices.el"
;;;;;;  "russian-spelling.el" "stack-f.el" "tapestry.el") (18832
;;;;;;  52504 617532))

;;;***

;;;### (autoloads (amixer) "amixer" "amixer.el" (18832 52324))
;;; Generated autoloads from amixer.el

(autoload 'amixer "amixer" "\
Interactively manipulate ALSA settings.
Interactive prefix arg refreshes cache.

\(fn &optional REFRESH)" t nil)

;;;***
