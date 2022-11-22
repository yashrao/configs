;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


;;--------------DOWNLOAD PACKAGES---------------------
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
;; Download Kaolin Themes
(unless (package-installed-p 'kaolin-themes)
  (package-install 'kaolin-themes))
;; Rust Mode
(unless (package-installed-p 'rust-mode)
  (package-install 'rust-mode))

;;--------------ENABLING PACKAGES---------------------
;; Enable Evil
(require 'evil)
(evil-mode 1)
;; Enable Kaolin themes
(require 'kaolin-themes)
(load-theme 'kaolin-shiva t)
;; Apply treemacs customization for Kaolin themes, requires the all-the-icons package.
;(kaolin-treemacs-theme)

;;----------------SET SETTINGS-----------------------
(setq inhibit-startup-message t
      cursor-type 'bar)
(evil-set-initial-state 'Custom-mode 'normal)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode)
(global-hl-line-mode t)
(set-face-attribute 'default nil :font "Source Code Pro-12")
(set-frame-font "Source Code Pro-12" nil t)

;;----------------AUTOMATED--------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e266d44fa3b75406394b979a3addc9b7f202348099cfde69e74ee6432f781336" "11cc65061e0a5410d6489af42f1d0f0478dbd181a9660f81a692ddc5f948bf34" "06ed754b259cb54c30c658502f843937ff19f8b53597ac28577ec33bb084fa52" "f00a605fb19cb258ad7e0d99c007f226f24d767d01bf31f3828ce6688cbdeb22" "3c7a784b90f7abebb213869a21e84da462c26a1fda7e5bd0ffebf6ba12dbd041" default))
 '(package-selected-packages '(evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
