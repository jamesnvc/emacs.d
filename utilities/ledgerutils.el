; miscellaneous emacs utilities for ledger
;
; This has been submitted as a ledger 2.6 svn patch, but changes
; more frequently in the darcs repo at:
; http://joyful.com/darcsweb/darcsweb.cgi?r=ledgertools
; Check out a copy with:
; darcs get http://joyful.com/repos/ledgertools
;
; .emacs:
; (require 'ledger)
; (require 'ledgerutils)
; (global-set-key [(f11)] 'ledger-next-action)
; (global-set-key [(f12)] 'timelog-next-action)
; (hours)

(defun ledgerinfo () "" (interactive)
  (info (expand-file-name "~/src/ledger-2.6.1/ledger.info")))

(defun ledger-period-today ()
  (format "from %s to %s" ; workaround for current 2.6
          (format-time-string "%Y/%m/%d")
          (format-time-string "%Y/%m/%d" (time-add (current-time) (days-to-time 1)))))

(defun ledger-period-this-week ()
  (format "from %s" (format-time-string "%Y/%m/%d" (start-of-week))))

(defun start-of-week ()
  "Return the time corresponding to the start of last monday."
  (let ((time (time-to-seconds (current-time))))
    (setq time (* (round (/ time 86400)) 86400.0))
    (while (/= (nth 6 (decode-time (seconds-to-time time))) 1)
      (setq time (- time 86400)))
    (seconds-to-time time)))

; show updating time balance

(defun hours ()
  "Show today's logged hours, updating every minute."
  (interactive)
  (hours-stop)
  (switch-to-buffer-other-window "hours")
  (other-window -1)
  (hours-update))

(defun hours-update ()
  "Update the hours buffer, using ledger."
  (interactive)
  (with-current-buffer (get-buffer-create "hours")
    (erase-buffer)
    (insert "today:\n\n")
    (call-process
     "ledger2.5" nil t nil
     "-f" (expand-file-name "~/.timelog")
     "-p" (ledger-period-today)
     "--balance-format" "%8T  %2_%-a\n" ; less whitespace
     "-s"                               ; show subaccounts
     "balance")
    (newline)
    (insert "this week:\n\n")
    (call-process
     "ledger2.5" nil t nil
     "-f" (expand-file-name "~/.timelog")
     "-p" (ledger-period-this-week)
     "--balance-format" "%8T  %2_%-a\n"
     "-s"
     "balance")
    (insert (format "\nupdated %s\n" (current-time-string)))
    (goto-char (point-min)))
  (run-at-time 10 nil 'hours-update))

(defun hours-stop ()
  "Stop updating the hours buffer."
  (interactive)
  (cancel-function-timers 'hours-update))

; same for financial balances
; XXX generalise above
;
;      "ledger" nil t nil
;      "-f" "~/finance/ledger.dat" ;XXX emacs in x doesn't have LEDGER env var
;      "-s" "balance" "assets")))

; magic ledger key

(defun ledger-next-action () (interactive)
  (cond
   ((not (and
          (equal "ledger.dat" (condition-case nil (file-name-nondirectory (buffer-file-name)) (error nil)))
          (equal (point) (point-max)))) (show-ledger))
   ((ledger-start-entry))))

(defun ledger-start-entry () (interactive)
  (ledger-add-entry (format-time-string "%Y/%m/%d"))
  (end-of-line)
  (insert " "))

(defun show-ledger () (interactive)
  (find-file (expand-file-name "~/finance/ledger.dat"))
  (end-of-buffer))

; timelog/timeclock stuff.. a bit fragile

(require 'timeclock-x)
(timeclock-initialize)
(timeclock-setup-keys)

(define-key ctl-x-map "tl" 'show-timelog)
(define-key ctl-x-map "ti" 'timelog-clock-in-and-show)
(define-key ctl-x-map "to" 'timelog-clock-out-and-show)
(define-key ctl-x-map "tR" 'timelog-show-register-today)
(define-key ctl-x-map "tB" 'timelog-show-balance-today)
(define-key ctl-x-map "tz" '(lambda () (interactive) (timeclock-initialize)))

(defun show-timelog () (interactive)
  (find-file (expand-file-name "~/.timelog"))
  (end-of-buffer)
  (recenter))

(defun timelog-clock-in-and-show () (interactive)
  (if (timeclock-in-safe) (show-timelog)))

(defun timelog-clock-out-and-show () (interactive)
  (if (timeclock-out-safe) (show-timelog)))

; magic timelog key
(defun timelog-next-action () (interactive)
  ;(timeclock-reread-log) ; too slow
  (cond
   ((window-minibuffer-p) (minibuffer-complete-and-exit))
   ((not (and
          (equal ".timelog" (condition-case nil (file-name-nondirectory (buffer-file-name)) (error nil)))
          (equal (point) (point-max)))) (show-timelog))
   ((timeclock-currently-out-p) (timelog-clock-in-and-show))
   ((timelog-clock-out-and-show))))

(defun timelog-show-register-today () (interactive)
  (shell-command (format "ledger -f ~/.timelog -p '%s' register" (ledger-period-today)) "*timelog*"))

(defun timelog-show-balance-today () (interactive)
  (shell-command (format "ledger -f ~/.timelog -p '%s' -s balance" (ledger-period-today)) "*timelog*"))

; adjust a timelog clock-out record to match the following clock-in time.
; This helps with retroactively entering timelog records: record a bunch
; of clock-in/clock-outs eg using the timelog-next-action key, adjust the
; clock-in times, then move point to the first clock-out line and run this
; a few times.
(fset 'timelog-fix-out-time
   [?\C-\M-s ?^ ?i ?  ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-  ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\M-w ?\C-\M-r ?^ ?o ?  ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?\C-f ?  ?\C-y ?\C-  ?\C-e ?\C-w M-backspace ?0 ?0 ?\C-a ?\C-n ?\C-n])

(provide 'ledgerutils)
