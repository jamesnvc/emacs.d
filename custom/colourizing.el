;; Various color themes to experiment with
(require 'color-theme)

(defun color-theme-jamesnvc ()
  "My colour scheme, created by James Cash 04 Mar 2009 - 11:02 PM"
  (interactive)
  (color-theme-install
   '(color-theme-jamesnvc
     ((foreground-color . "white")
      (background-color . "black")
      (background-mode . dark))
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (default ((t (nil))))
     
     (font-lock-constant-face ((t (:bold t :foreground "#197b6e"))))
     (font-lock-doc-face ((t (:foreground "gray"))))
     (font-lock-comment-face ((t (:italic t :foreground "aquamarine"))))
     (font-lock-doc-face ((t (:bold t :foreground "LightBlue"))))
     (font-lock-builtin-face ((t (:italic t :foreground "#a96da0"))))
     
     (hl-line ((t (:background "#112233"))))
     (mode-line ((t (:foreground "#ffffff" :background "#333333"))))
     (region ((t (:foreground nil :background "#555555"))))
     (show-paren-match-face ((t (:bold t :foreground "SlateBlue1" :background "grey5"))))

     )))

(defun color-theme-djcb-dark ()
  "dark color theme created by djcb, Jan. 2009."
  (interactive)
  (color-theme-install
   '(color-theme-djcb-dark
     ((foreground-color . "#a9eadf")
      (background-color . "black") 
      (background-mode . dark))
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (default ((t (nil))))
       
     (font-lock-builtin-face ((t (:italic t :foreground "#a96da0"))))
     (font-lock-comment-face ((t (:italic t :foreground "#bbbbbb"))))
     (font-lock-comment-delimiter-face ((t (:foreground "#666666"))))
     (font-lock-constant-face ((t (:bold t :foreground "#197b6e"))))
     (font-lock-doc-string-face ((t (:foreground "#3041c4"))))
     (font-lock-doc-face ((t (:foreground "gray"))))
     (font-lock-reference-face ((t (:foreground "white"))))
     (font-lock-function-name-face ((t (:foreground "#356da0"))))
     (font-lock-keyword-face ((t (:bold t :foreground "#bcf0f1"))))
     (font-lock-preprocessor-face ((t (:foreground "#e3ea94"))))
     (font-lock-string-face ((t (:foreground "#ffffff"))))
     (font-lock-type-face ((t (:bold t :foreground "#364498"))))
     (font-lock-variable-name-face ((t (:foreground "#7685de"))))
     (font-lock-warning-face ((t (:bold t :italic nil :underline nil 
                                        :foreground "yellow"))))
     (hl-line ((t (:background "#112233"))))
     (mode-line ((t (:foreground "#ffffff" :background "#333333"))))
     (region ((t (:foreground nil :background "#555555"))))
     (show-paren-match-face ((t (:bold t :foreground "#ffffff" 
                                       :background "#050505"))))
     )))
