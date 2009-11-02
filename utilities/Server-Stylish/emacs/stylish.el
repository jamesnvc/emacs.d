; connect to a stylish server

(require 'json)
(require 'cl)

(defvar stylish-host "localhost"
  "The host that the Stylish server is running on")

(defvar stylish-port 36227
  "The port that the Stylish server is running on")

(defvar stylish-process "stylish"
  "The name of the Stylish process")

(defvar stylish-server-info-alist nil
  "Information about the Stylish server")

(defvar stylish-partial-message nil
  "Long messages get split; this variable accumulates partial
messages until we get a full one.")

(defvar stylish-post-connect-hook nil
  "Hook that is run after connecting (or reconnecting) to the server.")

(defvar stylish-pre-send-command-hook nil
  "Hook that is run before sending a command to the server (but
after the connection is setup, if necessary).")

(defgroup stylish nil
  "Stylish"
  :prefix "stylish-")

(defun stylish-server-version nil (caddr (assoc :version stylish-server-info-alist)))
(defun stylish-session-id nil (cadr (assoc :session-id stylish-server-info-alist)))

(defvar stylish-dispatch-alist nil
  "Map from message type to handler function")
(setq stylish-dispatch-alist
      '((welcome . stylish-handler-welcome)
        (error . stylish-handler-error)))

(defun stylish-connected-p nil
  "Returns T if we are connected to a Stylish process"
  (if (not (ignore-errors (get-process stylish-process))) nil t))

(defun stylish-connect ()
  "Connect to a stylish Stylish server"
  (interactive)
  (setq stylish-partial-message nil)
  (let ((p (open-network-stream
            stylish-process "*inferior stylish*"
            stylish-host stylish-port)))
    (set-process-coding-system p 'utf-8 'utf-8)
    (set-process-filter p 'stylish-filter)
    p))

(defun stylish nil
  "Connect to the Stylish server, unless already connected.  You
should run this before sending data to the Stylish server."
  (when (not (stylish-connected-p)) (stylish-connect))
  t)

(defun stylish-json-decode (string)
  (let ((json-object-type 'plist)
        (json-array-type 'list))
    (json-read-from-string string)))

(defun stylish-json-encode (data)
  (json-encode data))

(defun stylish-filter (proc string)
  (let* ((attempt (concat stylish-partial-message string))
         (message (stylish-json-decode attempt)))
    (if (not message)

        ;; didn't get the whole message yet
        (setq stylish-partial-message attempt)

      ;; read was OK
      (setq stylish-partial-message nil)
      (let* ((type (intern (car message)))
             (args (cadr message))
             (handler (assoc type stylish-dispatch-alist)))
        (condition-case error
            (if handler
                (apply (cdr handler) args)
              (error "No handler for message type %s" type))
          (error
           (message "Error in stylish filter: %s %s" (car error) (cdr error))))))))

(defun stylish-register-handler (action handler)
  "Register a HANDLER for ACTION."
  (add-to-list 'stylish-dispatch-alist (cons action handler)))

(defun* stylish-handler-welcome (&key version session-id)
  "Show welcome message after connecting to Stylish server"
  (setq stylish-server-info-alist (list :version version :session-id session-id))
  (run-hooks 'stylish-post-connect-hook)
  (message "Connected to %s (sessionid %s)" version session-id))

(defun stylish-handler-error (type message)
  "Handle an error returned by the Stylish server"
  ;(message "Error from Stylish (%s): %s" type message))
  )

(defun stylish-send-command (command &rest args)
  "Send a COMMAND with ARGS to the Stylish server.  The result is returned
asynchronously.  See [stylish-filter] and [stylish-dispatch-alist]."
  (stylish)
  (run-hooks 'stylish-pre-send-command-hook)
  (setq stylish-partial-message nil) ; cancel partial message
  (let ((json (stylish-json-encode (vector command args))))
    (process-send-string "stylish" (concat json "\n"))))


(provide 'stylish)

;(stylish)
;(stylish-send-command 'foo 1 2 3)
;(setq debug-on-error nil)