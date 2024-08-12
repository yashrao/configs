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
(unless (package-installed-p 'doom-modeline)
  (package-install 'doom-modeline))
(unless (package-installed-p 'doom-themes)
  (package-install 'doom-themes))
(unless (package-installed-p 'rust-mode)
  (package-install 'rust-mode))
(unless (package-installed-p 'solidity-mode)
  (package-install 'solidity-mode))
(unless (package-installed-p 'company-solidity)
  (package-install 'company-solidity))
(unless (package-installed-p 'zig-mode)
  (package-install 'zig-mode))
(unless (package-installed-p 'jtsx)
  (package-install 'jtsx))
(unless (package-installed-p 'org-modern)
  (package-install 'org-modern))
(unless (package-installed-p 'ef-themes)
  (package-install 'ef-themes))
(unless (package-installed-p 'almost-mono-themes)
  (package-install 'almost-mono-themes))
(unless (package-installed-p 'go-mode)
  (package-install 'go-mode))
(unless (package-installed-p 'hl-todo)
  (package-install 'hl-todo))
(unless (package-installed-p 'modus-themes)
  (package-install 'modus-themes))
(unless (package-installed-p 'tree-sitter)
  (package-install 'tree-sitter))
(unless (package-installed-p 'tree-sitter-langs)
  (package-install 'tree-sitter-langs))


;; Treesitter
(use-package treesit
      :mode (("\\.tsx\\'" . tsx-ts-mode)
             ("\\.js\\'"  . typescript-ts-mode)
             ("\\.mjs\\'" . typescript-ts-mode)
             ("\\.mts\\'" . typescript-ts-mode)
             ("\\.cjs\\'" . typescript-ts-mode)
             ("\\.ts\\'"  . typescript-ts-mode)
             ("\\.jsx\\'" . tsx-ts-mode)
             ("\\.json\\'" .  json-ts-mode)
             ("\\.Dockerfile\\'" . dockerfile-ts-mode)
             ("\\.prisma\\'" . prisma-ts-mode)
             ;; More modes defined here...
             )
      :preface
      (defun os/setup-install-grammars ()
        "Install Tree-sitter grammars if they are absent."
        (interactive)
        (dolist (grammar
                 '((css . ("https://github.com/tree-sitter/tree-sitter-css" "v0.20.0"))
                   (bash "https://github.com/tree-sitter/tree-sitter-bash")
                   (html . ("https://github.com/tree-sitter/tree-sitter-html" "v0.20.1"))
                   (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "v0.21.2" "src"))
                   (json . ("https://github.com/tree-sitter/tree-sitter-json" "v0.20.2"))
                   (python . ("https://github.com/tree-sitter/tree-sitter-python" "v0.20.4"))
                   (go "https://github.com/tree-sitter/tree-sitter-go" "v0.20.0")
                   (markdown "https://github.com/ikatyang/tree-sitter-markdown")
                   (make "https://github.com/alemuller/tree-sitter-make")
                   (elisp "https://github.com/Wilfred/tree-sitter-elisp")
                   (cmake "https://github.com/uyha/tree-sitter-cmake")
                   (c "https://github.com/tree-sitter/tree-sitter-c")
                   (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
                   (toml "https://github.com/tree-sitter/tree-sitter-toml")
                   (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src"))
                   (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src"))
                   (yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0"))
                   (prisma "https://github.com/victorhqc/tree-sitter-prisma")))
          (add-to-list 'treesit-language-source-alist grammar)
          ;; Only install `grammar' if we don't already have it
          ;; installed. However, if you want to *update* a grammar then
          ;; this obviously prevents that from happening.
          (unless (treesit-language-available-p (car grammar))
            (treesit-install-language-grammar (car grammar)))))

      ;; Optional, but recommended. Tree-sitter enabled major modes are
      ;; distinct from their ordinary counterparts.
      ;;
      ;; You can remap major modes with `major-mode-remap-alist'. Note
      ;; that this does *not* extend to hooks! Make sure you migrate them
      ;; also
      (dolist (mapping
               '((python-mode . python-ts-mode)
                 (css-mode . css-ts-mode)
                 (typescript-mode . typescript-ts-mode)
                 (js-mode . typescript-ts-mode)
                 (js2-mode . typescript-ts-mode)
                 (c-mode . c-ts-mode)
                 (c++-mode . c++-ts-mode)
                 (c-or-c++-mode . c-or-c++-ts-mode)
                 (bash-mode . bash-ts-mode)
                 (css-mode . css-ts-mode)
                 (json-mode . json-ts-mode)
                 (js-json-mode . json-ts-mode)
                 (sh-mode . bash-ts-mode)
                 (sh-base-mode . bash-ts-mode)))
        (add-to-list 'major-mode-remap-alist mapping))
      :config
      (os/setup-install-grammars))

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
((python-mode . lsp)
 (solidity-mode . lsp)
 (tsx-ts-mode . lsp))
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
(use-package zig-mode)
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
;; Add spaces instead of tabs, overriding major mode settings
;; not sure it really works
(add-hook 'after-change-major-mode-hook 
  '(lambda () 
     (setq-default indent-tabs-mode nil)
     (setq c-basic-indent 4)
     (setq tab-width 4)))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode)
(global-hl-line-mode t)
(set-face-attribute 'default nil :font "JetBrains Mono-12")
(set-frame-font "JetBrains Mono-12" nil t)
;;(load-theme 'modus-vivendi t)
;;(load-theme 'ef-bio t)
(load-theme 'almost-mono-black t)
;; Spaces > tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;; Pairing for quotes and parens
(electric-pair-mode)

      ;; Enable tsx-ts-mode for ts files
      (add-to-list 'auto-mode-alist '("\.ts\'" . typescript-mode))
      
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
