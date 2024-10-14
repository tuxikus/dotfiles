;; Start in vi-mode
(lem-vi-mode:vi-mode)


(defvar *window-management-keymap*
  (make-keymap :name '*window-management-keymap*)
  "Keymap for commands related to the frame-multiplexer.")

(define-key *window-management-keymap* "v" 'split-active-window-vertically)
(define-key *window-management-keymap* "s" 'split-active-window-horizontally)
(define-key *window-management-keymap* "d" 'delete-active-window)

(define-key *global-keymap* "C-w" *window-management-keymap*)
