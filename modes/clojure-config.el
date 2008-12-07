;;;;
;;;; Clojure mode
;;;;
(require 'clojure-mode)
 
(require 'swank-clojure-autoload)

(swank-clojure-config
 (setq swank-clojure-binary "clj-cmd"))

(defvar clj-cmd)
(defvar src-root (expand-file-name "~/src/"))

(setenv "CLJ_CMD" 
	(setq clj-cmd
	      (concat "java "
		      "-server "
		      "-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8888 "
		      "-cp "
		      (concat src-root  "clojure/trunk/clojure.jar:")
		      (concat (expand-file-name "~") "/.clojure:")
		      (concat src-root "clojure-contrib/trunk/clojure-contrib.jar:")
		      " clojure.lang.Repl")))

(eval-after-load "slime"
  '(progn
     (slime-setup)
     (setq slime-lisp-implementations
	   `((clojure ("clj-cmd") :init swank-clojure-init)
	     ,@slime-lisp-implementations))))
      
(require 'clojure-auto)
(require 'swank-clojure-autoload)

(defun slime-java-describe (symbol-name)
  "Get details on Java class/instance at point."
  (interactive (list (slime-read-symbol-name "Java Class/instance: ")))
  (when (not symbol-name)
    (error "No symbol given"))
  (save-excursion
    (set-buffer (slime-output-buffer))
    (unless (eq (current-buffer) (window-buffer))
      (pop-to-buffer (current-buffer) t))
    (goto-char (point-max))
    (insert (concat "(show " symbol-name ")"))
    (when symbol-name
      (slime-repl-return)
      (other-window 1))))

(defun slime-javadoc (symbol-name)
  "Get JavaDoc documentation on Java class at point."
  (interactive (list (slime-read-symbol-name "JavaDoc info for: ")))
  (when (not symbol-name)
    (error "No symbol given"))
  (set-buffer (slime-output-buffer))
  (unless (eq (current-buffer) (window-buffer))
    (pop-to-buffer (current-buffer) t))
  (goto-char (point-max))
  (insert (concat "(clojure.contrib.javadoc/javadoc " symbol-name ")"))
  (when symbol-name
    (slime-repl-return)
    (other-window 1)))

;; (setq slime-browse-local-javadoc-root (concat clj-root "java"))

;; (defun slime-browse-local-javadoc (ci-name)
;;   "Browse local JavaDoc documentation on Java class/Interface at point."
;;   (interactive (list (slime-read-symbol-name "Class/Interface name: ")))
;;   (when (not ci-name)
;;     (error "No name given"))
;;   (let ((name (replace-regexp-in-string "\\$" "." ci-name))
;; 	(path (concat (expand-file-name slime-browse-local-javadoc-root) "/docs/api/")))
;;     (with-temp-buffer
;;       (insert-file-contents (concat path "allclasses-noframe.html"))
;;       (let ((l (delq nil
;; 		     (mapcar #'(lambda (rgx)
;; 				 (let* ((r (concat "\\.?\\(" rgx "[^./]+\\)[^.]*\\.?$"))
;; 					(n (if (string-match r name)
;; 					       (match-string 1 name)
;; 					     name)))
;; 				   (if (re-search-forward (concat "<A HREF=\"\\(.+\\)\" +.*>" n "<.*/A>") nil t)
;; 				       (match-string 1)
;; 				     nil)))
;; 			     '("[^.]+\\." "")))))
;; 	(if l
;; 	    (browse-url (concat "file://" path (car l)))
;; 	  (error (concat "Not found: " ci-name)))))))

(defun run-clojure ()
  "Starts clojure in Slime"
  (interactive)
  (slime 'clojure))

(global-set-key [f5] 'run-clojure)
(global-set-key [(control f11)] 'slime-selector)

(add-hook 'slime-connected-hook (lambda ()
				  (interactive)
				  (slime-redirect-inferior-output)
				  ;; (define-key slime-mode-map (kbd "C-c b") 'slime-browse-local-javadoc)
				  ;; (define-key slime-repl-mode-map (kbd "C-c b") 'slime-browse-local-javadoc)
				  (define-key slime-mode-map (kbd "C-c d") 'slime-java-describe)
				  (define-key slime-repl-mode-map (kbd "C-c d") 'slime-java-describe)
				  (define-key slime-mode-map (kbd "C-c D") 'slime-javadoc)
				  (define-key slime-repl-mode-map (kbd "C-c D") 'slime-javadoc)))