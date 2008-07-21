(add-hook 'remember-mode-hook 'org-remember-apply-template)

(setq org-remember-templates
      '(("Todo"  ?t "** TODO %?\n  %u" "~/todo.org"  "Tasks")
        ("Notes" ?n "* %u %?"         "~/notes.org" "Notes")
        ("Appts" ?a "** APPT %?\n   %^T\n%i\n" "~/todo.org" "Appointments")
        ("Book"  ?b "*** TODO %?\n  %u" "~/todo.org" "Books"))
      )

(setq org-agenda-include-diary t)

