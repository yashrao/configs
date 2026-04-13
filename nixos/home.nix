{ config, pkgs, kimi-cli, nix-vscode-extensions, ethereum, plasma-manager, neovim-nightly, ... }:

{
  home.username = "yash";
  home.homeDirectory = "/home/yash";

  # Import files from the current configuration directory into the Nix store,
  # and create symbolic links pointing to those store files in the Home directory.

  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # Import the scripts directory into the Nix store,
  # and recursively generate symbolic links in the Home directory pointing to the files in the store.
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    fastfetch
    onefetch
    cloc
    wget
    curl
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    vscode
    discord
    gimp
    brave
    # telegram-desktop # this isn't working

    # niri related
    rofi
    mako
    xwayland-satellite
    pavucontrol
    blueman
    waybar
    swaybg
    hyprlock

    #random
    inkscape
    
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    fd
    brightnessctl

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # man pages
    man-pages

    btop  # replacement of htop/nmon
    htop

    # useful programs
    helix
    # neovim
    emacs
    git
    tmux
    zellij
    lazygit
    kimi-cli.packages.${pkgs.system}.default
    jq
    devenv
    pnpm
    nodejs_24
    deno
    bun
    niri
    bitwarden-desktop
    libreoffice
    valgrind
    gnumake

    #dev
    pkg-config
    docker
    docker-compose

    # safety
    age

    # languages
    gcc
    # clang
    clang-tools
    zig
    zls
    rustup
    typescript-language-server
    dmd
    uv
    python3
    ruff
    go
    gopls
    libllvm
    gdb
    cmake
    c3c

    ethereum.packages.${pkgs.system}.solidity-language-server
    ethereum.packages.${pkgs.system}.foundry

    pciutils # lspci
    usbutils # lsusb
  ];

  home.file.".config/niri/config.kdl".source = ./niri/config.kdl;
  home.file.".config/rofi".source = ./rofi;
  home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  home.file.".config/waybar".source = ./waybar;
  # emacs configs
  home.file.".emacs.d/lisp".source = ./emacs.d/lisp;
  home.file.".emacs.d/themes".source = ./emacs.d/themes;
  home.file.".emacs.d/init.el".source = ./emacs.d/init.el;
  # programs.niri = {
  #   enabled = true;
  # };

  # neovim config
  home.file.".config/nvim".source = ./nvim;

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      "ldpochfccmkkmhdbclfhpagapcfdljkj" # decentraleyes
      "hipekcciheckooncpjeljhnekcoolahp" # tabliss
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.plasma = {
    enable = true;
    workspace = {
      theme = "Breeze-Dark";
      colorScheme = "BreezeDark";
      # wallpaper = "${pkgs.kdePackages.plasma-workspace}/share/wallpapers/Next";
    };

    hotkeys.commands."launchKitty" = {
      name = "Launch Kitty";
      key = "Meta+Shift+Return";
      command = "kitty";
    };

    # kwin = {
    #   "Make Window Fullscreen" = "Meta+F";
    # };
  };

  programs.neovim = {
    enable = true;
    package = neovim-nightly.packages.${pkgs.system}.default;
  };

  #for font caching
  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Yash Rao";
      user.email = "12raoy1@gmail.com";
    };
  };

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default.enableExtensionUpdateCheck = false;
    profiles.default.enableUpdateCheck = false;
    package = pkgs.vscode;

    # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/refs/heads/master/data/cache/vscode-marketplace-latest.json
    profiles.defualt.extensions = with nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; 
      [
        franciscosilva.gruber-darker
        juanblanco.solidity
        saoudrizwan.claude-dev
        jasew.vscode-helix-emulation
      ];

      
    userSettings = {
      # "workbench.colorTheme" = "One Dark Pro Flat";
      "editor.fontFamily" = "'FiraCode Nerd Font', 'FiraCode Nerd Font Mono', 'monospace', monospace";
    };
  };

  programs.helix = {
    enable = true;
    languages = {
      language-server = {
        nomic-solidity = {
          command = "nomicfoundation-solidity-language-server";
          args = [ "--stdio" ];
        };
      };
      language = [
          {
            name = "solidity";
            language-servers = [ "nomic-solidity" ];
          }
          {
            name = "move";
            language-servers = [ "move-analyzer" ];
          }
          {
            name = "rust";
            auto-format = false;
          }
          {
            name = "c3";
            scope = "source.c3";
            file-types = [ "c3" "c3i" ];
            roots = [ "project.json" ];
            comment-token = "//";
            block-comment-tokens = { start = "/*"; end = "*/"; };
            indent = { tab-width = 4; unit = " "; };
          }
      ];
    };

    settings = {
       theme = "redsayer";
       editor = {
         line-number = "relative";
         true-color = true;
         cursor-shape = {
           insert = "bar";
           normal = "block";
           select = "underline";
         };
       };
    };
  };

  home.file.".config/helix/themes/redsayer.toml".text = ''
    # Syntax highlighting
    "tag" = { fg = "pal_keyword" }
    "attribute" = { fg = "pal_type" }
    "comment" = { fg = "pal_comment" }
    "constant" = { fg = "pal_const" }
    "constant.numeric" = { fg = "pal_const" }
    "constant.builtin" = { fg = "pal_const" }
    "constant.character.escape" = { fg = "pal_const" }
    "constructor" = { fg = "pal_func" }
    "function" = { fg = "pal_func" }
    "function.builtin" = { fg = "pal_func" }
    "function.macro" = { fg = "pal_func" }
    "keyword" = { fg = "pal_keyword" }
    "keyword.control" = { fg = "pal_keyword" }
    "keyword.control.import" = { fg = "pal_keyword" }
    "keyword.directive" = { fg = "pal_keyword" }
    "keyword.storage" = { fg = "pal_keyword" }
    "label" = { fg = "pal_keyword" }
    "namespace" = { fg = "pal_type" }
    "operator" = { fg = "pal_keyword" }
    "keyword.operator" = { fg = "pal_keyword" }
    "special" = { fg = "pal_builtin" }
    "string" = { fg = "pal_str" }
    "type" = { fg = "pal_type" }
    "variable" = { fg = "pal_var" }
    "variable.builtin" = { fg = "pal_var" }
    "variable.parameter" = { fg = "pal_var" }
    "variable.other.member" = { fg = "pal_var" }

    # Markup
    "markup.heading" = { fg = "pal_fg1", modifiers = ["bold"] }
    "markup.raw.inline" = { fg = "pal_builtin" }
    "markup.bold" = { fg = "pal_builtin", modifiers = ["bold"] }
    "markup.italic" = { fg = "pal_builtin", modifiers = ["italic"] }
    "markup.strikethrough" = { modifiers = ["crossed_out"] }
    "markup.list" = { fg = "pal_keyword" }
    "markup.quote" = { fg = "pal_type" }
    "markup.link.url" = { fg = "pal_str", modifiers = ["underlined"] }
    "markup.link.text" = { fg = "pal_var" }

    # Diff
    "diff.plus" = { bg = "pal_diff_add" }
    "diff.delta" = { bg = "pal_diff_change" }
    "diff.minus" = { bg = "pal_diff_delete" }

    # Diagnostics
    "diagnostic.info".underline = { color = "pal_builtin", style = "curl" }
    "diagnostic.hint".underline = { color = "pal_comment", style = "curl" }
    "diagnostic.warning".underline = { color = "pal_warning2", style = "curl" }
    "diagnostic.error".underline = { color = "pal_warning", style = "curl" }
    "diagnostic.unnecessary" = { modifiers = ["dim"] }
    "diagnostic.deprecated" = { modifiers = ["crossed_out"] }
    "info" = { fg = "pal_builtin", modifiers = ["bold"] }
    "hint" = { fg = "pal_comment", modifiers = ["bold"] }
    "warning" = { fg = "pal_warning2", modifiers = ["bold"] }
    "error" = { fg = "pal_warning", modifiers = ["bold"] }

    # UI elements
    "ui.background" = { bg = "pal_bg1" }
    "ui.virtual" = { fg = "pal_fg4" }
    "ui.virtual.indent-guide" = { fg = "pal_indent_guide" }
    "ui.virtual.whitespace" = { fg = "pal_fg4" }
    "ui.virtual.ruler" = { bg = "pal_bg3" }
    "ui.virtual.inlay-hint" = { fg = "pal_fg4" }
    "ui.virtual.jump-label" = { fg = "pal_fg4", modifiers = ["bold"] }
    "ui.cursor" = { bg = "pal_fg4" }
    "ui.cursor.primary" = { bg = "pal_fg4" }
    "ui.cursor.match" = { fg = "pal_bg1", bg = "pal_str" }
    "ui.selection" = { bg = "pal_selection" }
    "ui.selection.primary" = { bg = "pal_selection" }
    "ui.cursorline.primary" = { bg = "pal_bg2" }
    "ui.highlight" = { fg = "pal_fg2", bg = "pal_bg3" }
    "ui.highlight.frameline" = { bg = "pal_bg3" }
    "ui.linenr" = { fg = "pal_fg4" }
    "ui.linenr.selected" = { fg = "pal_fg6", bg = "pal_bg2", modifiers = ["bold"] }
    "ui.statusline" = { fg = "pal_fg4", bg = "pal_bg2", modifiers = ["bold"] }
    "ui.statusline.inactive" = { fg = "pal_var", bg = "pal_bg1" }
    "ui.statusline.normal" = { fg = "pal_bg1", bg = "pal_keyword", modifiers = ["bold"] }
    "ui.statusline.insert" = { fg = "pal_bg1", bg = "pal_str", modifiers = ["bold"] }
    "ui.statusline.select" = { fg = "pal_bg1", bg = "pal_type", modifiers = ["bold"] }
    "ui.bufferline" = { fg = "pal_fg2", bg = "pal_bg2" }
    "ui.bufferline.active" = { fg = "pal_bg1", bg = "pal_keyword", underline = { color = "pal_bg1", style = "line" } }
    "ui.bufferline.background" = { bg = "pal_bg2" }
    "ui.text" = { fg = "pal_fg1" }
    "ui.text.directory" = { fg = "pal_type" }
    "ui.text.focus" = { fg = "pal_fg1", bg = "pal_bg2", modifiers = ["bold"] }
    "ui.help" = { fg = "pal_fg1", bg = "pal_bg2" }
    "ui.popup" = { bg = "pal_bg2" }
    "ui.window" = { fg = "pal_fg3" }
    "ui.menu" = { fg = "pal_fg2", bg = "pal_bg2" }
    "ui.menu.selected" = { fg = "pal_fg3", bg = "pal_bg3" }
    "ui.menu.scroll" = { fg = "pal_fg1", bg = "pal_bg3" }
    "ui.debug" = { fg = "pal_warning" }

    [palette]
    pal_fg1 = "#b0b0b0"
    pal_fg2 = "#a2a2a2"
    pal_fg3 = "#949494"
    pal_fg4 = "#868686"
    pal_fg6 = "#c3c3c3"
    pal_bg1 = "#000000"
    pal_bg2 = "#271414"
    pal_bg3 = "#3a2929"
    pal_bg4 = "#4c3d3d"
    pal_builtin = "#c97f6f"
    pal_keyword = "#59c2ff"
    pal_const = "#7ad0c6"
    pal_comment = "#44b340"
    pal_func = "#c1d1e3"
    pal_str = "#2ec09c"
    pal_type = "#8cde94"
    pal_var = "#c1d1e3"
    pal_selection = "#0000ff"
    pal_warning = "#ff0000"
    pal_warning2 = "#ff8800"
    pal_diff_add = "#004d00"
    pal_diff_delete = "#4d0000"
    pal_diff_change = "#4d4d00"
    pal_indent_guide = "#241717"
  '';

  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Light";
    font.size = 11;
    # custom settings
    settings = {
      extraConfig = ''
        # redsayer theme
        background #000000
        foreground #b0b0b0
        cursor #868686
        cursor_text_color #140000
        selection_background #0000ff
        selection_foreground #b0b0b0

        color0 #b5b57d
        color1 #c97f6f
        color2 #44b340
        color3 #ff8800
        color4 #00aeff
        color5 #c97f6f
        color6 #7ad0c6
        color7 #b0b0b0
        color8 #4c3d3d
        color9 #ff0000
        color10 #8cde94
        color11 #ff8800
        color12 #c1d1e3
        color13 #c97f6f
        color14 #7ad0c6
        color15 #ffffff

        bold_font        none
        italic_font      auto
        bold_italic_font auto
      '';
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      __git_ps1_branch() {
        git branch --show-current 2>/dev/null || echo ""
      }

      PS1='-\[\e[1m\]$(__git_ps1_branch)\[\e[0m\]- \[\e[96m\]\h\[\e[0m\] \[\e[92m\]\w\[\e[91m\]::\[\e[93m\]λ\[\e[0m\] '

      fif() {
        if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
        rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
      }

      EDITOR=nvim
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      nv = "nvim";
      # k = "kubectl";
      # urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      # urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1; # Start window/pane numbers at 1
    keyMode = "vi";
  
    # Additional custom config
    extraConfig = ''
      # Improve colors
      set -g default-terminal "screen-256color"
    
      # Split panes with | and -
      bind | split-window -h
      bind - split-window -v
    
      # Faster escape time
      set -sg escape-time 0
      set -g escape-time 1
      set-option -g history-limit 5000
      bind -r "<" swap-window -d -t -1
      bind -r ">" swap-window -d -t +1
      bind c new-window -c "#{pane_current_path}"

      # NOTE: you can use vars with $<var> and ''${<var>} as long as the str is double quoted: ""
      # WARNING: hex colors can't contain capital letters

      # --> Catppuccin
      thm_bg="#1e1e28"
      thm_fg="#dadae8"
      thm_cyan="#c2e7f0"
      thm_black="#15121c"
      thm_gray="#332e41"
      thm_magenta="#c6aae8"
      thm_pink="#e5b4e2"
      thm_red="#e38c8f"
      thm_green="#b1e3ad"
      thm_yellow="#ebddaa"
      thm_blue="#a4b9ef"
      thm_orange="#f9c096"
      thm_black4="#575268"

      # ----------------------------=== Theme ===--------------------------

      # status
      set -g status-position bottom
      set -g status "on"
      set -g status-bg "''${thm_bg}"
      set -g status-justify "left"
      set -g status-left-length "100"
      set -g status-right-length "100"

      # messages
      set -g message-style fg="''${thm_cyan}",bg="''${thm_gray}",align="centre"
      set -g message-command-style fg="''${thm_cyan}",bg="''${thm_gray}",align="centre"

      # panes
      set -g pane-border-style fg="''${thm_gray}"
      set -g pane-active-border-style fg="''${thm_blue}"

      # windows
      setw -g window-status-activity-style fg="''${thm_fg}",bg="''${thm_bg}",none
      setw -g window-status-separator ""
      setw -g window-status-style fg="''${thm_fg}",bg="''${thm_bg}",none

      # --------=== Statusline

      set -g status-left ""
      set -g status-right "#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics] #[fg=$thm_fg,bg=$thm_gray] #W #{?client_prefix,#[fg=$thm_red],#[fg=$thm_green]}#[bg=$thm_gray]#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg] #[fg=$thm_fg,bg=$thm_gray] #S "

      # current_dir
      setw -g window-status-format "#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} "
      setw -g window-status-current-format "#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "

      # parent_dir/current_dir
      # setw -g window-status-format "#[fg=colour232,bg=colour111] #I #[fg=colour222,bg=colour235] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) "
      # setw -g window-status-current-format "#[fg=colour232,bg=colour208] #I #[fg=colour255,bg=colour237] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) "

      # --------=== Modes
      setw -g clock-mode-colour "''${thm_blue}"
      setw -g mode-style "fg=''${thm_pink} bg=''${thm_black4} bold"

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
