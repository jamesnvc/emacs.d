;; List of abbrev tables for snippet.el
;; Expand with C-x ' , or turn on abbrev-mode
(snippet-with-abbrev-table 'python-mode-abbrev-table
			   ("for" .  "for $${element} in $${sequence}:")
			   ("im"  .  "import $$")
			   ("if"  .  "if $${True}:")
			   ("wh"  .  "while $${True}:"))