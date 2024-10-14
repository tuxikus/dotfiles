(setq org-directory "~/org/")

;; modern
(with-eval-after-load 'org (global-org-modern-mode))

;; log time of done
(setq org-log-done 'time)

;; roam
(setq org-roam-directory (concat org-directory "roam/")
      org-roam-db-location (concat org-roam-directory "org-roam.db"))

;; org roam ui
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; pomodoro
(setq org-pomodoro-length 45
      org-pomodoro-short-break-length 5
      org-pomodoro-long-break-length 15)

;; better org download timestamp
(after! org-download (setq org-download-timestamp "%Y%m%d-%H%M%S-"))

;; property inheritance
;;(setq org-use-property-inheritance t)

;; habits
;;(add-to-list 'org-config 'org-habit t)
;;(setq org-habit-show-all-today t)

(org-babel-do-load-languages 'org-babel-load-languages '((lua . t)))

(setq yas-snippet-dirs '("~/.config/doom/snippets"))

(setq doom-font (font-spec :family "BlexMono Nerd Font" :size 18))

(add-to-list 'load-path "~/.config/doom/lisp/")
(add-to-list 'exec-path "~/.local/bin/")

(add-to-list 'auto-mode-alist '("\\.sls\\'" . yaml-mode))

(setq doom-theme 'catppuccin)

(setq delete-by-moving-to-trash t trash-directory "~/.local/share/Trash/files/")

;; vim movement in dired
(general-define-key
 :states 'normal
 :keymaps 'dired-mode-map
 "h" 'dired-up-directory
 "l" 'dired-find-file
 "m" 'dired-mark
 "u" 'dired-unmark)

(setq display-line-numbers-type 'relative
      display-line-numbers-width 5)

(setq window-divider-default-right-width 3
      window-divider-default-bottom-width 3)

;; color
(custom-set-faces! '(vertical-border :foreground "white"))

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

(defun tuxikus/get-random-splash-image ()
  (let* ((images (directory-files (concat doom-private-dir "splash/")))
         (images (delete "." images))
         (images (delete ".." images)))
    (concat (concat doom-private-dir "splash/") (nth (random (length images)) images))))

(setq fancy-splash-image (tuxikus/get-random-splash-image))

(defun tuxikus/change-org-directory ()
  "Change the active org directory."
  (interactive)
  (let ((selection (completing-read "Select: " '("~/org" "~/org-edu"))))
    (setq org-directory selection
          org-attach-id-dir (concat org-directory "/.attach")
          org-roam-directory (concat org-directory "/roam")
          org-roam-db-location (concat org-directory "/org-roam.db"))))

(defun tuxikus/get-bookmarks-from-file ()
  "Get bookmarks from the bookmark file"
  (with-temp-buffer
    (insert-file-contents "~/.bookmarks.org")
    (org-mode)
    (let (bookmarks)
      (org-element-map (org-element-parse-buffer) 'link
        (lambda (l)
          (let* ((link (org-element-property :raw-link l))
                 (name (org-element-interpret-data (org-element-contents l)))
                 (tags (org-element-property :tags (org-element-property :parent l))))
            (push (concat name
                          "\n"
                          link
                          "\n"
                          (format "[%s]" (mapconcat #'identity tags ", "))) bookmarks))))
      bookmarks)))

(defun tuxikus/add-bookmark ()
  "Add a new bookmark to the bookmark file."
  (interactive)
  (let* ((title (read-from-minibuffer "Title: "))
         (url (read-from-minibuffer "URL: "))
         (tags (read-from-minibuffer "Tags: ")))
    (write-region (format "* [[%s][%s]] %s" url title tags) nil "~/.bookmarks.org" 'append)))

(defun tuxikus/edit-bookmark ()
  "TODO implement."
  (interactive)
  (message "Not implemented."))

(defun tuxikus/delete-bookmark ()
  "TODO implement."
  (interactive)
  (message "Not implemented."))

(defun tuxikus/open-bookmark ()
  "Select a bookmark and open it."
  (interactive)
  (browse-url
   (seq-elt (split-string
             (completing-read "Open: " (tuxikus/get-bookmarks-from-file))
             "\n") 1)))

(defun tuxikus/get-jira-ticket-number (branch)
  (when (string-match "[A-Z]\\{8\\}-[0-9]*" branch)
    (message (match-string 0 branch))))

(add-hook 'git-commit-setup-hook '(lambda () (insert (tuxikus/get-jira-ticket-number) (magit-get-current-branch))))
