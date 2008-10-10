;;;;
;;;; Clojure mode
;;;;
(require 'clojure-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
 
;;;;
;;;; Setup slime
;;;;
;; (require 'slime-autoloads)
;; (slime-setup '(slime-scratch slime-editing-commands))

(setf slime-lisp-implementations `((sbcl ,(concat "/home/james/bin/sbcl --core /home/james/lib/sbcl/sbcl.core"))))
(setq swank-clojure-jar-path "/home/james/src/clojure/target/clojure-lang-1.0-SNAPSHOT.jar")
(require 'swank-clojure-autoload)

;; (require 'swank-clojure)
;; (defalias 'clojure-init 'swank-clojure-init)
 
(defun run-clojure ()
  "Starts clojure in slime"
  (interactive)
  (progn
    (if (featurep 'redshank)
        (unload-feature 'redshank))
    (slime 'clojure)))
