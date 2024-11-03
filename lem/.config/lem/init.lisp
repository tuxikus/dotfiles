;; Start in vi-mode
(lem-vi-mode:vi-mode)

;; show completion list instand
(add-hook *prompt-after-activate-hook*
          (lambda ()
            (call-command 'lem/prompt-window::prompt-completion nil)))

(add-hook *prompt-deactivate-hook*
          (lambda ()
            (lem/completion-mode:completion-end)))


;; completion list position
(setf lem-core::*default-prompt-gravity* :bottom-display)
(setf lem/prompt-window::*prompt-completion-window-gravity* :horizontally-above-window)
(setf lem/prompt-window::*fill-width* t)

(defvar *window-management-keymap*
  (make-keymap :name '*window-management-keymap*)
  "Keymap for commands related to the frame-multiplexer.")

(define-key *window-management-keymap* "v" 'split-active-window-vertically)
(define-key *window-management-keymap* "s" 'split-active-window-horizontally)
(define-key *window-management-keymap* "d" 'delete-active-window)

(define-key *global-keymap* "C-w" *window-management-keymap*)
