;;; init.el --- Clean Emacs, dark, batteries-included -*- lexical-binding: t; -*-

;;;; Bootstrap package manager + use-package
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

;;;; Sensible basics
(setq ring-bell-function 'ignore
      confirm-kill-emacs 'y-or-n-p
      inhibit-startup-screen t)
(save-place-mode 1)
(global-auto-revert-mode 1)
(recentf-mode 1)
(show-paren-mode 1)
(column-number-mode 1)

;;;; Theme: Catppuccin (dark)
(use-package catppuccin-theme
  :init (setq catppuccin-flavor 'mocha)  ;; options: latte/frappe/macchiato/mocha
  :config (load-theme 'catppuccin :no-confirm))

;;;; Discovery: which-key
(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.4
        which-key-separator " → "
        which-key-max-description-length 40))

;;;; Modern minibuffer/search stack (must-haves)
;; Lightweight, fast, and standard in many modern configs
(use-package vertico :init (vertico-mode))
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles basic orderless)))))
(use-package marginalia :init (marginalia-mode))
(use-package consult
  :bind (("C-s" . consult-line)          ;; better in-buffer search
         ("C-x b" . consult-buffer)      ;; switch buffers/projects
         ("M-y" . consult-yank-pop)))    ;; browse kill-ring
(use-package embark
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)))
(use-package embark-consult :after (embark consult))

;;;; In-buffer completion + LSP (autocompletion)
(use-package corfu :init (global-corfu-mode))
(use-package cape
  :init
  ;; Extra completion sources at point
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))
;; Built-in LSP client (fast & simple)
(use-package eglot :ensure nil
  :hook ((c-mode c-ts-mode
                 c++-mode c++-ts-mode
                 python-mode python-ts-mode
                 js-mode js-ts-mode
                 typescript-ts-mode tsx-ts-mode
                 go-ts-mode
                 rust-ts-mode
                 bash-ts-mode
                 json-ts-mode
                 css-ts-mode
                 html-ts-mode) . eglot-ensure))

;;;; Tree-sitter (modern language modes)
(use-package treesit-auto
  :init
  (setq treesit-auto-install 'prompt) ;; ask to auto-install missing grammars
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;;;; File explorer (modern Dired UI)
;; Dirvish enhances Dired: icons, previews, jumplists, etc., but stays Emacs-y.
(use-package dirvish
  :init (dirvish-override-dired-mode)
  :bind (("C-x C-j" . dirvish)          ;; jump to Dirvish from current buffer
         :map dirvish-mode-map
         ("a" . dirvish-quick-access)   ;; bookmarks/shortcuts
         ("TAB" . dirvish-subtree-toggle)
         ("^" . dirvish-history-last)))
;; NOTE: Open Dired/Dirvish with `C-x d`, then enjoy the nicer UI.

;;;; Git
(use-package magit
  :commands (magit-status)
  :bind (("C-x g" . magit-status)))

;;;; Org-mode (built-in) — folder, agenda, capture, clocking
(use-package org
  :ensure nil
  :config
  ;; Your org home
  (setq org-directory "~/org/"
        ;; Explicit agenda set (matches your files)
        org-agenda-files
        '("~/org/inbox.org"
          "~/org/tasks.org"
          "~/org/tasks-obsidian.org"
          "~/org/log-2025.org"
          "~/org/japan-urlaub-2025.org"
          "~/org/calendar-beorg.org"
          "~/org/reminders-beorg.org"
          "~/org/beorg-customize-init.org")
        ;; UX
        org-startup-indented t
        org-hide-emphasis-markers t
        org-ellipsis " …"
        org-return-follows-link t
        ;; Clocking
        org-clock-persist 'history
        org-clock-idle-time 20      ;; minutes before prompting idle resolve
        org-clock-in-switch-to-state "STARTED")
  (org-clock-persistence-insinuate))

;; Handy Org bindings
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
;; Optional quick clocking keys
(global-set-key (kbd "C-c x i") #'org-clock-in)
(global-set-key (kbd "C-c x o") #'org-clock-out)
(global-set-key (kbd "C-c x g") #'org-clock-goto)
(global-set-key (kbd "C-c x r") #'org-resolve-clocks)

;; Simple capture templates tuned to your files
(setq org-capture-templates
      `(
        ("t" "Todo → inbox" entry
         (file ,(expand-file-name "inbox.org" org-directory))
         "* TODO %?\n  %U\n  %a\n")
        ("T" "Todo → tasks" entry
         (file ,(expand-file-name "tasks.org" org-directory))
         "* TODO %?\n  %U\n  %a\n")
        ("j" "Journal" entry
         (file+datetree ,(expand-file-name "log-2025.org" org-directory))
         "* %U %?\n")
        ("J" "Japan note" entry
         (file ,(expand-file-name "japan-urlaub-2025.org" org-directory))
         "* %?\n  %U\n  %a\n")
        ))

;;;; Markdown
(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :init (setq markdown-fontify-code-blocks-natively t))

;;;; Helpful (better help buffers)
(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)))

;;;; Quality-of-life keys
(global-set-key (kbd "M-g g") #'consult-goto-line)
(global-set-key (kbd "C-x C-r") #'consult-recent-file)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(@ cape catppuccin-theme corfu dirvish embark-consult helpful magit
       marginalia markdown-mode orderless treesit-auto vertico))
 '(warning-suppress-types '((emacs))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
