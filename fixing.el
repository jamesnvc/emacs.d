;; There is no way to determine whether some subr is a special form or not,
;; hence we need this list (which is probably out of date):
(defvar ad-special-forms
  (let ((tem '(and catch cond condition-case defconst defmacro
		   defun defvar function if interactive let let*
		   or prog1 prog2 progn quote save-current-buffer
		   save-excursion save-restriction save-window-excursion
		   setq setq-default unwind-protect while
		   with-output-to-temp-buffer)))
    ;; track-mouse could be void in some configurations.
    (if (fboundp 'track-mouse)
	(setq tem (cons 'track-mouse tem)))
    (mapcar 'symbol-function tem)))
