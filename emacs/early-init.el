;; early-init.el
(setq package-enable-at-startup nil) ; don't auto-init package.el
(setq gc-cons-threshold most-positive-fixnum) ; speed up startup

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
