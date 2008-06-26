; dvorak-mode.el
;
; by Matthew Weathers, circa 1996, published 2004
;
; http://www.matthewweathers.com/ 
; email address: (my two initials)@matthewweathers.com
;

; This is probably not the best way to do it, but it works, and it is
; what I have been using for 8 years. See also
; http://www.mwbrooks.com/dvorak/qwerty.el for another version, by
; Neil Jerram. My version translates the keys in just the current
; buffer. Neil's version translates the keys in all buffers, and can
; translate the CTRL keys, too. I prefer to use Dvorak just when
; typing text, not in a shell, or with the control sequences.

; Define M-2 (Escape then "2") to turn on Dvorak mode
; Define M-1 to turn it off
; (you may want to set your own keys)
;; (global-set-key "\e1" 'dvorak-off)
;; (global-set-key "\e2" 'dvorak-on)

(define-minor-mode dvorak-mode
  "Toggle Dvorak mode."
  nil
  " Dvorak"
  '(("q" . dvorak-insert)
    ("w" . dvorak-insert)
    ("e" . dvorak-insert)
    ("r" . dvorak-insert)
    ("t" . dvorak-insert)
    ("y" . dvorak-insert)
    ("u" . dvorak-insert)
    ("i" . dvorak-insert)
    ("o" . dvorak-insert)
    ("p" . dvorak-insert)
    ("(" . dvorak-insert)
    (")" . dvorak-insert)
    ("a" . dvorak-insert)
    ("s" . dvorak-insert)
    ("d" . dvorak-insert)
    ("f" . dvorak-insert)
    ("g" . dvorak-insert)
    ("h" . dvorak-insert)
    ("j" . dvorak-insert)
    ("k" . dvorak-insert)
    ("l" . dvorak-insert)
    (";" . dvorak-insert)
    ("'" . dvorak-insert)
    ("z" . dvorak-insert)
    ("x" . dvorak-insert)
    ("c" . dvorak-insert)
    ("v" . dvorak-insert)
    ("b" . dvorak-insert)
    ("n" . dvorak-insert)
    ("m" . dvorak-insert)
    ("," . dvorak-insert)
    ("." . dvorak-insert)
    ("/" . dvorak-insert)
    ))

(defun dvorak-insert ()
  (interactive)
  "Translate typed key into Dvorak keyboard."
  (progn
    (cond
     ((= last-command-char ?m) (insert "a"))
     ((= last-command-char ?q) (insert "'"))
     ((= last-command-char ?w) (insert ","))
     ((= last-command-char ?e) (insert "."))
     ((= last-command-char ?r) (insert "p"))
     ((= last-command-char ?t) (insert "y"))
     ((= last-command-char ?y) (insert "f"))
     ((= last-command-char ?u) (insert "g"))
     ((= last-command-char ?i) (insert "c"))
     ((= last-command-char ?o) (insert "r"))
     ((= last-command-char ?p) (insert "l"))
     ((= last-command-char ?Q) (insert "\""))
     ((= last-command-char ?W) (insert "<"))
     ((= last-command-char ?E) (insert ">"))
     ((= last-command-char ?R) (insert "P"))
     ((= last-command-char ?T) (insert "Y"))
     ((= last-command-char ?Y) (insert "F"))
     ((= last-command-char ?U) (insert "G"))
     ((= last-command-char ?I) (insert "C"))
     ((= last-command-char ?O) (insert "R"))
     ((= last-command-char ?P) (insert "L"))
     ((= last-command-char ?s) (insert "o"))
     ((= last-command-char ?d) (insert "e"))
     ((= last-command-char ?f) (insert "u"))
     ((= last-command-char ?g) (insert "i"))
     ((= last-command-char ?h) (insert "d"))
     ((= last-command-char ?j) (insert "h"))
     ((= last-command-char ?k) (insert "t"))
     ((= last-command-char ?l) (insert "n"))
     ((= last-command-char ?\;) (insert "s"))
     ((= last-command-char ?S) (insert "O"))
     ((= last-command-char ?D) (insert "E"))
     ((= last-command-char ?F) (insert "U"))
     ((= last-command-char ?G) (insert "I"))
     ((= last-command-char ?H) (insert "D"))
     ((= last-command-char ?J) (insert "H"))
     ((= last-command-char ?K) (insert "T"))
     ((= last-command-char ?L) (insert "N"))
     ((= last-command-char ?:) (insert "S"))
     ((= last-command-char ?z) (insert ";"))
     ((= last-command-char ?x) (insert "q"))
     ((= last-command-char ?c) (insert "j"))
     ((= last-command-char ?v) (insert "k"))
     ((= last-command-char ?b) (insert "x"))
     ((= last-command-char ?n) (insert "b"))
     ((= last-command-char ?\,) (insert "w"))
     ((= last-command-char ?\.) (insert "v"))
     ((= last-command-char ?/) (insert "z"))
     ((= last-command-char ?Z) (insert ":"))
     ((= last-command-char ?X) (insert "Q"))
     ((= last-command-char ?C) (insert "J"))
     ((= last-command-char ?V) (insert "K"))
     ((= last-command-char ?B) (insert "X"))
     ((= last-command-char ?N) (insert "B"))
     ((= last-command-char ?<) (insert "W"))
     ((= last-command-char ?>) (insert "V"))
     ((= last-command-char ??) (insert "Z"))
     ((= last-command-char ?\') (insert "-"))
     ((= last-command-char ?\") (insert "_"))
     ((= last-command-char ?\[) (insert "/"))
     ((= last-command-char ?{) (insert "?"))
     ((= last-command-char ?-) (insert "["))
     ((= last-command-char ?_) (insert "{"))
      )
     ))