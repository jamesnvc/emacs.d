;;;;
;;;; Clojure mode
;;;;
(require 'clojure-mode)
 
(setq swank-clojure-binary "clj")

(require 'swank-clojure-autoload)

(clojure-slime-config)

;; (require 'clojure-auto)
;; (require 'swank-clojure-autoload)

(defun run-clojure ()
  "Starts clojure in Slime"
  (interactive)
  (slime 'clojure))
