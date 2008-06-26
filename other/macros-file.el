
(;--------------------------- power-macros ---------------------------
 ;-                 Unbound - specific for c++-mode                  -
 ;--------------------------------------------------------------------
	pm-def-macro
	'insert-vector-iter
	'c++-mode nil
	"Inserts a template for iterating over a vector (using an iterator)"
	"for SPC (vector< C-u C-x q >::iterator SPC C-u C-x q SPC = SPC ESC b
 NUL ESC f C-x r s a C-e v C-h C-u C-x q NUL ESC b C-x r s b C-e
 .begin(); SPC C-x r i a C-e SPC != SPC C-x r i b C-e .end(); SPC ++
 C-x r i a C-e ) LFD { 2*LFD } C-p TAB"
 ;--------------------------------------------------------------------
)

