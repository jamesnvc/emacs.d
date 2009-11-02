;;; My configurations for icicles mode
;; Based on Rubikitch's Icicles Configuration
(require 'icicles)

;;; I prefer modal cycling.
(setq icicle-cycling-respects-completion-mode-flag t)
;;  I HATE arrow keys.
(setq icicle-modal-cycle-up-key "\C-p")
(setq icicle-modal-cycle-down-key "\C-n")

(setq icicle-reminder-prompt-flag nil)
