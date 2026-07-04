(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(set-frame-font "Iosevka Nerd Font 24" nil t)

(load-theme 'modus-operandi)
;; (load-theme 'modus-vivendi)

(setq ring-bell-function 'ignore)
(setq make-backup-files nil)
(setq auto-save-default nil)

(global-hl-line-mode t)
(display-fill-column-indicator-mode)

(setq inhibit-startup-screen t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(global-set-key (kbd "C-.") #'tuxikus/copy-line)
(global-set-key (kbd "C-.") #'tuxikus/copy-line)
(global-set-key (kbd "C-c e b") #'eval-buffer)
(global-set-key (kbd "C-x B") #'ibuffer)
(global-set-key (kbd "C-c g") #'magit)
(global-set-key (kbd "C-c c") #'compile)

(defun tuxikus/copy-line ()
  (interactive)
  (let ((col (current-column))
        (text (buffer-substring-no-properties
               (line-beginning-position)
               (line-end-position))))
    (end-of-line)
    (newline)
    (insert text)
    (move-to-column col)))

(use-package which-key
  :init
  (which-key-mode 1))

(use-package elec-pair
  :init
  (electric-pair-mode 1))

;; vertico is managing completion
;; (use-package icomplete
;;   :init
;;   (fido-mode 1)
;;   (fido-vertical-mode 1))

(use-package savehist
  :init
  (savehist-mode))

(use-package emacs
  :custom
  (context-menu-mode t)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(use-package markdown-mode
  :ensure t)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

(use-package go-mode
  :ensure t)

(use-package magit
  :ensure t)

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode))

(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-package move-text
  :ensure t
  :bind
  ("M-p" . move-text-up)
  ("M-n" . move-text-down))

(use-package multiple-cursors
  :ensure t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->"         . mc/mark-next-like-this)
  ("C-<"         . mc/mark-previous-like-this)
  ("C-c C-<"     . mc/mark-all-like-this)
  ("C-\\"        . mc/skip-to-next-like-this)
  ("C-:"         . mc/skip-to-previous-like-this))

(use-package avy
  :ensure t
  :bind
  ("M-g w" . avy-goto-word-1)
  ("M-g e" . avy-goto-word-0)
  ("M-g f" . avy-goto-line))

(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(load custom-file 'noerror)
