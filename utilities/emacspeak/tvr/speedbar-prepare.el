;;;$Id: speedbar-prepare.el 4047 2006-08-11 19:11:17Z tv.raman.tv $
(augment-load-path "speedbar" "speedbar")
(load-library "speedbar")
(add-hook 'speedbar-load-hook
          (function
           (lambda nil
             (speedbar-add-supported-extension ".html$")
             (speedbar-add-supported-extension ".py$"))))
(global-set-key '[insert] 'speedbar-get-focus)

(load-library "rpm")
