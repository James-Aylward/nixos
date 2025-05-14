{ config, pkgs, inputs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
      pgf
      ec
      gensymb
      listings
      cm-super
      environ
      txfonts
      parskip
      pgfplots
      etoolbox
      stackengine
      advdate
      titlesec
      pdfpages
      pdflscape
      float
      microtype
      siunitx
      tcolorbox;
  });
in
{

  home.username = "jamesa";
  home.homeDirectory = "/home/jamesa";
  home.stateVersion = "24.05";

  fonts.fontconfig.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    imagemagick
    usbutils
    unzip
    playerctl
    zsh-powerlevel10k
    dmenu-rs
    vial
    vlc
    ripgrep
    nix-search-cli
    feh
    nitch
    ncdu
    darktable
    tree
    tex
    brightnessctl
    pamixer
    obsidian
    (pkgs.mathematica.override { version = "14.1.0"; })
    xterm
    libreoffice-fresh
    hunspell
    hunspellDicts.en-au-large
    remmina
    thunderbird
    clamav
    pavucontrol
    qimgv
    networkmanagerapplet
    nerd-fonts.jetbrains-mono
    ghidra
    (pkgs.dwmblocks.overrideAttrs { src = ./dotfiles/dwmblocks; })
    (import ./programs/window-switcher.nix { inherit pkgs; })
    inputs.menucalc.packages.x86_64-linux.menucalc
  ];

  services.blueman-applet.enable = true;

  services.picom = {
    enable = true;
    fadeDelta = 5;
    fade = true;
    activeOpacity = 0.95;
    inactiveOpacity = 0.95;
    opacityRules = [
      "100:class_g = 'firefox'"
      "100:class_g = 'sioyek'"
      "100:class_g = 'darktable'"
      "100:class_g = 'feh'"
      "100:class_g = 'obsidian'"
      "100:class_g = 'org.remmina.Remmina'"
      "100:class_g = 'code'"
      "100:class_g = 'VirtualBox Machine'"
      "100:class_g = 'qimgv'"
      "100:class_g = 'vlc'"
      "100:class_g = 'dmenu'"
      "100:class_g = 'dwm'"
      "100:class_g = 'qutebrowser'"
    ];

    fadeExclude = [
      "class_g = 'dmenu'"
    ];
  };

  services.playerctld.enable = true;

  services.copyq.enable = true;

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        showStartupLaunchMessage = false;
        uiColor = "#d79921";
        contrastUiColor = "#282828";
      };
    };
  };


  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#d79921";
        background = "#282828";
      };
    };
  };

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  home.file.".config/btop/themes".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/btop/themes;
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.lazygit.enable = true;

  programs.sioyek = {
    enable = true;
  };

  programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      "change-background" = ''
        feh --bg-fill ${./backgrounds/nix.png}
      '';
    };
  };
  services.autorandr.enable = true;

  programs.ncspot = {
    enable = true;
    settings = {
      use_nerdfont = true;
      notify = true;
      gapless = true;
      flip_status_indicators = true;
      theme = {
        background = "default";
        primary = "#EBDBB2";
        secondary = "#D5C4A1";
        title = "#fc7e18"; #done
        playing = "#83a597";
        playing_selected = "#458588";
        playing_bg = "#1D2021";
        highlight = "#D79921";
        highlight_bg = "#1D2021";
        error = "#eeeeee"; #done
        error_bg = "#a50000"; #done
        statusbar = "#eeeeee"; #done
        statusbar_progress = "#fc7e18"; #done
        statusbar_bg = "#fc7e18"; # done
        cmdline = "#1D2021";
        cmdline_bg = "#FE8019";
        search_match = "#fabd2f";
      };
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.qutebrowser = {
    enable = true;
    extraConfig = ''
c.qt.highdpi = True
c.hints.chars = "arstgmneio"

c.colors.webpage.preferred_color_scheme = 'dark'
my_orange = "#fc7e18"
my_bg_dark = "#282828"

bg0_hard = "#1d2021"
bg0_soft = '#32302f'
bg0_normal = '#282828'

bg0 = bg0_normal
bg1 = "#3c3836"
bg2 = "#504945"
bg3 = "#665c54"
bg4 = "#7c6f64"

fg0 = "#fbf1c7"
fg1 = "#ebdbb2"
fg2 = "#d5c4a1"
fg3 = "#bdae93"
fg4 = "#a89984"

bright_red = "#fb4934"
bright_green = "#b8bb26"
bright_yellow = "#fabd2f"
bright_blue = "#83a598"
bright_purple = "#d3869b"
bright_aqua = "#8ec07c"
bright_gray = "#928374"
bright_orange = "#fe8019"

dark_red = "#cc241d"
dark_green = "#98971a"
dark_yellow = "#d79921"
dark_blue = "#458588"
dark_purple = "#b16286"
dark_aqua = "#689d6a"
dark_gray = "#a89984"
dark_orange = "#d65d0e"

c.colors.completion.fg = [fg1, bright_aqua, bright_yellow]

c.colors.completion.odd.bg = bg0
c.colors.completion.even.bg = c.colors.completion.odd.bg

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = bright_blue

# Background color of the completion widget category headers.
c.colors.completion.category.bg = bg1

# Top border color of the completion widget category headers.
c.colors.completion.category.border.top = c.colors.completion.category.bg

# Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = c.colors.completion.category.bg

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = fg0

# Background color of the selected completion item.
c.colors.completion.item.selected.bg = bg4

# Top border color of the selected completion item.
c.colors.completion.item.selected.border.top = bg2

# Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = c.colors.completion.item.selected.border.top

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = bright_orange

# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = c.colors.completion.item.selected.match.fg

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = c.colors.completion.item.selected.fg

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = c.colors.completion.category.bg

### Context menu

# Background color of disabled items in the context menu.
c.colors.contextmenu.disabled.bg = bg3

# Foreground color of disabled items in the context menu.
c.colors.contextmenu.disabled.fg = fg3

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = bg0

# Foreground color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.fg =  fg2

# Background color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.bg = bg2

#Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.fg = c.colors.contextmenu.menu.fg

### Downloads

# Background color for the download bar.
c.colors.downloads.bar.bg = bg0

# Color gradient start for download text.
c.colors.downloads.start.fg = bg0

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = bright_blue

# Color gradient end for download text.
c.colors.downloads.stop.fg = c.colors.downloads.start.fg

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = bright_aqua

# Foreground color for downloads with errors.
c.colors.downloads.error.fg = bright_red

### Hints

# Font color for hints.
c.colors.hints.fg = bg0

# Background color for hints.
c.colors.hints.bg = 'rgba(250, 191, 47, 200)'  # bright_yellow

# Font color for the matched part of hints.
c.colors.hints.match.fg = bg4

### Keyhint widget

# Text color for the keyhint widget.
c.colors.keyhint.fg = fg4

# Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = fg0

# Background color of the keyhint widget.
c.colors.keyhint.bg = bg0

### Messages

# Foreground color of an error message.
c.colors.messages.error.fg = bg0

# Background color of an error message.
c.colors.messages.error.bg = bright_red

# Border color of an error message.
c.colors.messages.error.border = c.colors.messages.error.bg

# Foreground color of a warning message.
c.colors.messages.warning.fg = bg0

# Background color of a warning message.
c.colors.messages.warning.bg = bright_purple

# Border color of a warning message.
c.colors.messages.warning.border = c.colors.messages.warning.bg

# Foreground color of an info message.
c.colors.messages.info.fg = fg2

# Background color of an info message.
c.colors.messages.info.bg = bg0

# Border color of an info message.
c.colors.messages.info.border = c.colors.messages.info.bg

### Prompts

# Foreground color for prompts.
c.colors.prompts.fg = fg2

# Border used around UI elements in prompts.
c.colors.prompts.border = f'1px solid {bg1}'

# Background color for prompts.
c.colors.prompts.bg = bg3

# Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = bg2

### Statusbar

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = fg2

# Background color of the statusbar.
c.colors.statusbar.normal.bg = bg0

# Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = bg0

# Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = dark_aqua

# Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = bg0

# Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = dark_blue

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = bright_purple

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = bg0

# Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = fg3

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = bg1

# Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = c.colors.statusbar.private.fg

# Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = c.colors.statusbar.command.bg

# Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = bg0

# Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = dark_purple

# Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = c.colors.statusbar.caret.fg

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = bright_purple

# Background color of the progress bar.
c.colors.statusbar.progress.bg = bright_blue

# Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = fg4

# Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = dark_red

# Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = bright_orange

# Foreground color of the URL in the statusbar on successful load
# (http).
c.colors.statusbar.url.success.http.fg = bright_red

# Foreground color of the URL in the statusbar on successful load
# (https).
c.colors.statusbar.url.success.https.fg = fg0

# Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = bright_purple

### tabs

# Background color of the tab bar.
c.colors.tabs.bar.bg = bg0

# Color gradient start for the tab indicator.
c.colors.tabs.indicator.start = bright_blue

# Color gradient end for the tab indicator.
c.colors.tabs.indicator.stop = bright_aqua

# Color for the tab indicator on errors.
c.colors.tabs.indicator.error = bright_red

# Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = fg2

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = bg2

# Foreground color of unselected even tabs.
c.colors.tabs.even.fg = c.colors.tabs.odd.fg

# Background color of unselected even tabs.
c.colors.tabs.even.bg = bg3

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = fg2

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = bg0

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = c.colors.tabs.selected.odd.fg

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = bg0

# Background color of pinned unselected even tabs.
c.colors.tabs.pinned.even.bg = bright_green

# Foreground color of pinned unselected even tabs.
c.colors.tabs.pinned.even.fg = bg2

# Background color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.bg = bright_green

# Foreground color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.fg = c.colors.tabs.pinned.even.fg

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = bg0

# Foreground color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.fg = c.colors.tabs.selected.odd.fg

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = c.colors.tabs.pinned.selected.even.bg

# Foreground color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.fg = c.colors.tabs.selected.odd.fg

# Background color for webpages if unset (or empty to use the theme's
# color).
# c.colors.webpage.bg = bg4

c.colors.tabs.even.bg = my_bg_dark
c.colors.tabs.odd.bg = my_bg_dark

c.colors.tabs.selected.even.bg = my_orange
c.colors.tabs.selected.odd.bg = c.colors.tabs.selected.even.bg

c.colors.tabs.selected.odd.fg = my_bg_dark
c.colors.tabs.selected.even.fg = c.colors.tabs.selected.odd.fg
    '';
  };

  programs.firefox = {
    enable = true;
    profiles.jamesa = {
      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        gruvbox-dark-theme
        to-deepl
        vimium
        vue-js-devtools
        libredirect
      ];
    };

  };

  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ ./dotfiles/alacritty/gruvbox_dark.toml ];
      font = {
        size = 8;
      };
    };
  };

  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/nvim;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      tree-sitter
      texlab
      rocmPackages.llvm.clang
      pyright
      haskellPackages.haskell-language-server
      nixd
      nixpkgs-fmt
      nodejs-slim
      lua-language-server
      ripgrep
      rust-analyzer
      rubber
    ];
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      rb = "sudo nixos-rebuild switch --flake /etc/nixos/.\\?submodules=1#laptop";
      lg  = "lazygit";
      moss = "ssh -A s4743699@moss.labs.eait.uq.edu.au";
    };
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ${./dotfiles/.p10k.zsh} ]] || source ${./dotfiles/.p10k.zsh}
      nitch
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "copyfile" ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userEmail = "james.michael.aylward@gmail.com";
    userName = "James Aylward";
  };

  programs.gh = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xsession.numlock.enable = true;
  programs.home-manager.enable = true;
}
