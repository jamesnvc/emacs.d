;;;;
;;;; Clojure mode
;;;;
(require 'clojure-mode)
 
(setq swank-clojure-binary "clj")

(require 'swank-clojure-autoload)

(swank-clojure-config)

(add-to-list 'slime-lisp-implementations
      `(clojure ("clj" "--emacs") :init swank-clojure-init))
      
(require 'clojure-auto)
(require 'swank-clojure-autoload)

(defun run-clojure ()
  "Starts clojure in Slime"
  (interactive)
  (slime 'clojure))

(global-set-key [f5] 'run-clojure)
