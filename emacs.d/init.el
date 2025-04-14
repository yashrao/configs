;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")) ;; Based mirror

(package-initialize)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; Custom modes in ~/.emacs.d/lisp/
(require 'odin-mode)

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
(unless (package-installed-p 'mini-modeline)
  (package-install 'mini-modeline))
(unless (package-installed-p 'rust-mode)
  (package-install 'rust-mode))
(unless (package-installed-p 'solidity-mode)
  (package-install 'solidity-mode))
(unless (package-installed-p 'company-solidity)
  (package-install 'company-solidity))
(unless (package-installed-p 'zig-mode)
  (package-install 'zig-mode))
(unless (package-installed-p 'lua-mode)
  (package-install 'lua-mode))
(unless (package-installed-p 'jtsx)
  (package-install 'jtsx))
(unless (package-installed-p 'org-modern)
  (package-install 'org-modern))
(unless (package-installed-p 'go-mode)
  (package-install 'go-mode))
(unless (package-installed-p 'hl-todo)
  (package-install 'hl-todo))
;; themes
(unless (package-installed-p 'doom-themes)
  (package-install 'doom-themes))
(unless (package-installed-p 'modus-themes)
  (package-install 'modus-themes))
(unless (package-installed-p 'catppuccin-theme)
  (package-install 'catppuccin-theme))
(unless (package-installed-p 'hc-zenburn-theme)
  (package-install 'hc-zenburn-theme))
(unless (package-installed-p 'ef-themes)
  (package-install 'ef-themes))
(unless (package-installed-p 'almost-mono-themes)
  (package-install 'almost-mono-themes))
(unless (package-installed-p 'naysayer-theme)
  (package-install 'naysayer-theme))
(unless (package-installed-p 'overcast-theme)
  (package-install 'overcast-theme))
(unless (package-installed-p 'zenburn-theme)
  (package-install 'zenburn-theme))
;;
(unless (package-installed-p 'tree-sitter)
  (package-install 'tree-sitter))
(unless (package-installed-p 'tree-sitter-langs)
  (package-install 'tree-sitter-langs))
(unless (package-installed-p 'fzf)
  (package-install 'fzf))
;; (unless (package-installed-p 'centaur-tabs)
;;   (package-install 'centaur-tabs))
;; Run all-the-icons-install-fonts in emacs for this to work for this to work
(unless (package-installed-p 'all-the-icons)
  (package-install 'all-the-icons))
(unless (package-installed-p 'nyan-mode)
  (package-install 'nyan-mode))
(unless (package-installed-p 'dired-sidebar)
  (package-install 'dired-sidebar))
(unless (package-installed-p 'magit)
  (package-install 'magit))

;; Treesitter
(use-package treesit
      :mode (("\\.tsx\\'" . tsx-ts-mode)
             ("\\.js\\'"  . typescript-ts-mode)
             ("\\.mjs\\'" . typescript-ts-mode)
             ("\\.mts\\'" . typescript-ts-mode)
             ("\\.cjs\\'" . typescript-ts-mode)
             ("\\.ts\\'"  . typescript-ts-mode)
             ("\\.jsx\\'" . tsx-ts-mode)
             ("\\.tsx\\'" . tsx-ts-mode)
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

;; sidebar
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))

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
   ;;(solidity-mode . lsp)
   (tsx-ts-mode . lsp)
   (c-mode . lsp)
   (rust-mode . lsp))
  )

;; sexy tabs
;; (use-package centaur-tabs
;;   :demand
;;   :config
;;   (centaur-tabs-mode t)
;;   :bind
;;   (("C-<tab>" . centaur-tabs-forward)
;;    ("C-<iso-lefttab>" . centaur-tabs-backward)
;;    :map evil-normal-state-map
;;    ("g t" . centaur-tabs-forward)
;;    ("g T" . centaur-tabs-backward)))

;; (setq centaur-tabs-style "bar")
;; (setq centaur-tabs-set-icons t)
;; (setq centaur-tabs-icon-type 'all-the-icons)
;; (setq centaur-tabs-gray-out-icons 'buffer)
;; ;;(setq centaur-tabs-set-bar 'under)
;; ;;(setq x-underline-at-descent-line t)
;; (setq centaur-tabs-close-button "X")
;; (setq centaur-tabs-set-modified-marker t)
;; (setq centaur-tabs-modified-marker "*")
;; (centaur-tabs-change-fonts "JetBrainsMono Nerd Font" 160)

;;(define-key evil-normal-state-map (kbd "g t") 'centaur-tabs-forward)
;;(define-key evil-normal-state-map (kbd "g T") 'centaur-tabs-backward)

;; FZF -- don't forget to actually have fzf installed on the system
(use-package fzf
  :bind
    ;; Don't forget to set keybinds!
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))

;; (use-package lsp-mode
;;   :hook (solidity-mode . lsp-deferred)
;;   :commands (lsp lsp-deferred)
;;   :config
;;   (setq lsp-solidity-server-command '("solc" "--lsp"))
;;   (add-to-list 'lsp-language-id-configuration '(solidity-mode . "solidity")))

(use-package lsp-ui :commands lsp-ui-mode)
;; Cheats for C/C++
(use-package ccls      ;; Make sure ccls is installed on the system
:hook ((c-mode c++-mode objc-mode cuda-mode) .
       (lambda () (require 'ccls) (lsp))))
;; Company Mode - for completion popups
(use-package company)
;; Nyan Mode for the memes 
(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode 1))
;; Appearance
(use-package doom-themes)
;; language modes
(use-package rust-mode)
(use-package go-mode)
(use-package zig-mode)
(use-package lua-mode)
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
;;(setq-default mode-line-format nil) ;; disable mode-line
;;(tab-bar-mode)

;; Setting gc threshold for hopefully increased performance
(setq gc-cons-threshold 100000000)

(ido-mode 1)
(ido-everywhere 1)

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
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font-11")
(set-frame-font "JetBrainsMono Nerd Font-11" nil t)

(load-theme 'redsayer t)
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
 '(custom-safe-themes
   '("676648cf65a3ca76635beba0e39cc8814a958b3d9ce67b3b1d8200c8d8cb48df"
     "6da1ba8724efce585e051f1a589d42f1526769e4b72d1808f178dbd0987d4ad1"
     "ac893acecb0f1cf2b6ccea5c70ea97516c13c2b80c07f3292c21d6eb0cb45239"
     "541282f66e5cc83918994002667d2268f0a563205117860e71b7cb823c1a11e9"
     "3d9938bbef24ecee9f2632cb25339bf2312d062b398f0dfb99b918f8f11e11b1"
     "6af300029805f10970ebec4cea3134f381cd02f04c96acba083c76e2da23f3ec"
     "aff0396925324838889f011fd3f5a0b91652b88f5fd0611f7b10021cc76f9e09"
     "fae5872ff90462502b3bedfe689c02d2fa281bc63d33cb007b94a199af6ccf24"
     "a3a71b922fb6cbf9283884ac8a9109935e04550bcc5d2a05414a58c52a8ffc47"
     "d6b369a3f09f34cdbaed93eeefcc6a0e05e135d187252e01b0031559b1671e97"
     "ae20535e46a88faea5d65775ca5510c7385cbf334dfa7dde93c0cd22ed663ba0"
     "1ad12cda71588cc82e74f1cabeed99705c6a60d23ee1bb355c293ba9c000d4ac"
     "59c36051a521e3ea68dc530ded1c7be169cd19e8873b7994bfc02a216041bf3b"
     "2e7dc2838b7941ab9cabaa3b6793286e5134f583c04bde2fba2f4e20f2617cf7"
     "7746e1f01dae4a96c068d3c0c0357fe14ed02385de04227e4af78fb4ad784e58"
     "daf189a2af425e9f376ddb9e99627e9d8f2ebdd5cc795065da81633f88389b4b"
     "39054dbdf1e3f5b36e91db507f86b4c709bc2bc99fbe5e2ffc600891261f50cd"
     "8a3d04fd24afde8333c1437a3ecaa616f121554041a4e7e48f21b28f13b50246"
     "0013cec68d42e640266e700c09ea4eb55e18668f72da7a5b92f0c22b80581204"
     "9ddb83c12595e789e9abd04a5c0705661748776223a794a6f64669352b956e79"
     "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
     "09b833239444ac3230f591e35e3c28a4d78f1556b107bafe0eb32b5977204d93"
     "add6cd821eb5a8716a91b6f88c897aa31bc1fbf638e9ec707189ef8c9ba6ea49"
     "d46cb99f59fb858b11cac130f3a53688cc4323f3ec4aae80688bdd5d00312b91"
     "144aa208033b570b4c31e054b77afa01b9e2349cdba14bb17c3e484c82effa30"
     "d0dc7861b33d68caa92287d39cf8e8d9bc3764ec9c76bdb8072e87d90546c8a3"
     "9a977ddae55e0e91c09952e96d614ae0be69727ea78ca145beea1aae01ac78d2"
     "f019002925408f081e767c515e4fb4b1d7f1462228d6cd32ff66f06a43671527"
     "7524429b9671ca0ad0e281dc865717f44f358e417c7b587b57772430fcbe552f"
     "b754d3a03c34cfba9ad7991380d26984ebd0761925773530e24d8dd8b6894738"
     "1f292969fc19ba45fbc6542ed54e58ab5ad3dbe41b70d8cb2d1f85c22d07e518"
     "8d146df8bd640320d5ca94d2913392bc6f763d5bc2bb47bed8e14975017eea91"
     "1d6b446390c172036395b3b87b75321cc6af7723c7545b28379b46cc1ae0af9e"
     "8d820dc0b48dae30f0a76629665fc81f3d7dd150c008f48d8533646ba80188de"
     "91692ced59034a31ab8a4b83063e6e0e7605c4d76053ab3208e382ab3b5e680a"
     "f87c86fa3d38be32dc557ba3d4cedaaea7bc3d97ce816c0e518dfe9633250e34"
     "5e41864cbdd81b18d1fa62f09971a55a121a939238ca4c66faafcfcafb976c3e"
     "f8108bbb81e9bae9e4ed27b95e4a1507aa18ecc50193bff08e9b2cc2dcadbfbd"
     "b93039071f490613499b76c237c2624ae67a9aafbc717da9b4d81f456344e56e"
     "c3e62e14eb625e02e5aeb03d315180d5bb6627785e48f23ba35eb7b974a940af"
     "40352d95bc42c2e3acb7fc75afb3029d81a76897e14e9438857729cc87630980"
     "fb7595c9571f2bd41635745d12551f35322296b70330056ddd0020ab2374671c"
     "97283a649cf1ffd7be84dde08b45a41faa2a77c34a4832d3884c7f7bba53f3f5"
     "9fba87dbc0f14d5650006893ed53088be71f16d57b749394d9c485ef2326e85f"
     "29a073e66535bad18e11e9bcaa17d7f2d17e4c79f01023e59e9841633915c232"
     "76ddb2e196c6ba8f380c23d169cf2c8f561fd2013ad54b987c516d3cabc00216"
     "6fc9e40b4375d9d8d0d9521505849ab4d04220ed470db0b78b700230da0a86c1"
     "04aa1c3ccaee1cc2b93b246c6fbcd597f7e6832a97aaeac7e5891e6863236f9f"
     "0279c1b81b569e46a4ee8e87e5e381568bf931257287191fd091f2948f7e2e8e"
     "aa04c854054e8d43245bd67ca619a7bede9171e2a2efb1b2c26caf1d031497eb"
     "01cad03be8c042a9941fda5a484280629ee2cc83fe084af6d19376c83141c91b"
     "8ccbbbf5c197f80c9dce116408a248fde1ac4fedd9b5b7883e729eba83c9c64e"
     "dccf4a8f1aaf5f24d2ab63af1aa75fd9d535c83377f8e26380162e888be0c6a9"
     "c8c4baac2988652a760554e0e7ce11a0fe0f8468736be2b79355c9d9cc14b751"
     "13096a9a6e75c7330c1bc500f30a8f4407bd618431c94aeab55c9855731a95e1"
     "93011fe35859772a6766df8a4be817add8bfe105246173206478a0706f88b33d"
     "4b6cc3b60871e2f4f9a026a5c86df27905fb1b0e96277ff18a76a39ca53b82e1"
     "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd"
     "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69"
     "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874"
     "8f5b54bf6a36fe1c138219960dd324aad8ab1f62f543bed73ef5ad60956e36ae"
     "d0fd069415ef23ccc21ccb0e54d93bdbb996a6cce48ffce7f810826bb243502c"
     "ffba0482d3548c9494e84c1324d527f73ea4e43fff8dfd0e48faa8fc6d5c2bc7"
     "e410458d3e769c33e0865971deb6e8422457fad02bf51f7862fa180ccc42c032"
     "81f53ee9ddd3f8559f94c127c9327d578e264c574cda7c6d9daddaec226f87bb"
     "dfb1c8b5bfa040b042b4ef660d0aab48ef2e89ee719a1f24a4629a0c5ed769e8"
     "2b20b4633721cc23869499012a69894293d49e147feeb833663fdc968f240873"
     "f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66"
     "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e"
     "6e18353d35efc18952c57d3c7ef966cad563dc65a2bba0660b951d990e23fc07"
     "d4b608d76e3a087b124c74c2b642c933d8121b24e53d4bbd5e7327c36cc69ccc"
     "6e33d3dd48bc8ed38fd501e84067d3c74dfabbfc6d345a92e24f39473096da3f"
     "8b148cf8154d34917dfc794b5d0fe65f21e9155977a36a5985f89c09a9669aa0"
     "d481904809c509641a1a1f1b1eb80b94c58c210145effc2631c1a7f2e4a2fdf4"
     "571661a9d205cb32dfed5566019ad54f5bb3415d2d88f7ea1d00c7c794e70a36"
     "34cf3305b35e3a8132a0b1bdf2c67623bc2cb05b125f8d7d26bd51fd16d547ec"
     "48042425e84cd92184837e01d0b4fe9f912d875c43021c3bcb7eeb51f1be5710"
     default))
 '(delete-selection-mode nil)
 '(package-selected-packages
   '(all-the-icons almost-mono-themes catppuccin-theme ccls centaur-tabs
                   company-solidity d-mode dired-sidebar doom-themes
                   ef-themes evil fzf go-mode hc-zenburn-theme hl-todo
                   jtsx lsp-ui lua-mode magit mini-modeline
                   modus-themes naysayer-theme nyan-mode org-modern
                   overcast-theme rust-mode tree-sitter-langs
                   zenburn-theme zig-mode)))
      
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
