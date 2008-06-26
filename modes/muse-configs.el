;; Projects
(eval-after-load "muse-projects"
  (setq muse-project-alist
      `(("Notes" (,@(muse-project-alist-dirs "~/school/engSci/year1") :default "index")
	 ,@(muse-project-alist-styles "~/school/engSci/year1" "~/public_html/notes" "xhtml"))
	 ;;,@(muse-project-alist-styles "~/school/engSci/year1" "~/school/engSci/year1-notes" "pdf"))
	(("Todos" ("~/org" :default "todo" :major-mode org-mode)
	  (:base "html" :path "~/public_html/todo")
	  )))))

