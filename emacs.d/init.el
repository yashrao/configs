;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")) ;; Based mirror
(package-initialize)

;;--------------USE-PACKAGE SETUP---------------------
;; Download use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

;;--------------DOWNLOAD PACKAGES---------------------
;; Evil 
(unless (package-installed-p 'evil)
  (package-install 'evil))
(unless (package-installed-p 'lsp-mode)
  (package-install 'lsp-mode))
(unless (package-installed-p 'lsp-ui)
  (package-install 'lsp-ui))
(unless (package-installed-p 'ccls)
  (package-install 'ccls))
(unless (package-installed-p 'company)
  (package-install 'company))
(unless (package-installed-p 'doom-modelines)
  (package-install 'doom-themes))
(unless (package-installed-p 'rust-mode)
  (package-install 'rust-mode))
(unless (package-installed-p 'go-mode)
  (package-install 'go-mode))
(unless (package-installed-p 'hl-todo)
  (package-install 'hl-todo))

;; Setup packages
;; Evil - the only way to do things
(use-package evil)
;; LSP Mode - for programming cheats
(use-package lsp-mode :commands lsp
  :config
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)))
  :hook
  ((python-mode . lsp))
)
(use-package lsp-ui :commands lsp-ui-mode)
;; Cheats for C/C++
(use-package ccls      ;; Make sure ccls is installed on the system
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))
;; Company Mode - for completion popups
(use-package company)
;; Appearance
(use-package doom-modeline)
(use-package doom-themes)
;; Rust Mode
(use-package rust-mode)
;; Go Mode
(use-package go-mode)
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
    hl-todo-keyword-faces
    `(("TODO"       warning bold)
    ("FIXME"      error bold)
    ("HACK"       font-lock-constant-face bold)
    ("REVIEW"     font-lock-keyword-face bold)
    ("NOTE"       success bold)
    ("DEPRECATED" font-lock-doc-face bold))))

;;--------------ENABLING PACKAGES---------------------
;; Enable Evil
(require 'evil)
(evil-mode 1)
(require 'doom-modeline)
(doom-modeline-mode 1)

;;----------------SET SETTINGS-----------------------
(setq inhibit-startup-message t
      cursor-type 'bar)
(evil-set-initial-state 'Custom-mode 'normal)
(add-hook 'after-init-hook 'global-company-mode)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode)
(global-hl-line-mode t)
(set-face-attribute 'default nil :font "Roboto Mono-10")
(set-frame-font "Roboto Mono-10" nil t)
(load-theme 'doom-lantern t)
;; Spaces > tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;; Pairing for quotes and parens
(electric-pair-mode)

;; Ask to quit, but not when you're in a terminal
(when (display-graphic-p)
  (setq confirm-kill-emacs 'y-or-n-p)
)

;; For C
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(package-selected-packages '(hl-todo go-mode ccls evil)))

;;; backup/autosave - Changing the location of the autosaving
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

