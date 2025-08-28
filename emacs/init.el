;;; init.el --- Clean Emacs config -*- lexical-binding: t; -*-

;;; Bootstrap package manager + use-package
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(unless package--initialized (package-initialize))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

;;; Restore GC after startup (paired with early-init)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 64 1024 1024)
                  gc-cons-percentage 0.1)))

;;; Sensible basics
(setq ring-bell-function 'ignore
      confirm-kill-emacs 'y-or-n-p)
(save-place-mode 1)
(global-auto-revert-mode 1)
(recentf-mode 1)
(show-paren-mode 1)
(column-number-mode 1)

;;; Theme: Catppuccin (Mocha dark)
(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm))

;;; which-key (command discovery)
(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 0.4
                which-key-separator " → "
                which-key-max-description-length 40))

;;; Org mode (built-in)
(use-package org
  :ensure nil
  :config
  (setq org-directory "~/org/"
        org-agenda-files
        '("~/org/inbox.org"
          "~/org/tasks.org"
          "~/org/tasks-obsidian.org"
          "~/org/log-2025.org"
          "~/org/japan-urlaub-2025.org"
          "~/org/calendar-beorg.org"
          "~/org/reminders-beorg.org"
          "~/org/beorg-customize-init.org")
        org-startup-indented t
        org-hide-emphasis-markers t
        org-ellipsis " …"
        org-return-follows-link t))

;; Global Org keybindings
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Capture templates (tuned to your files)
(setq org-capture-templates
      `(
        ;; Quick task → inbox
        ("t" "Todo → inbox" entry
         (file ,(expand-file-name "inbox.org" org-directory))
         "* TODO %?\n  %U\n  %a\n")

        ;; Task → main task list
        ("T" "Todo → tasks" entry
         (file ,(expand-file-name "tasks.org" org-directory))
         "* TODO %?\n  %U\n  %a\n")

        ;; Journal entry → log-2025
        ("j" "Journal" entry
         (file+datetree ,(expand-file-name "log-2025.org" org-directory))
         "* %U %?\n")

        ;; Travel note → Japan trip
        ("J" "Japan note" entry
         (file ,(expand-file-name "japan-urlaub-2025.org" org-directory))
         "* %?\n  %U\n  %a\n")
        ))

;;; Helpful (better Emacs help system)
(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)))
