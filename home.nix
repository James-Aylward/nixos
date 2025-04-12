{ config, pkgs, inputs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
      pgf
      ec
      gensymb
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
    dmenu-rs
    vial
    vlc
    timewarrior
    nix-search-cli
    feh
    nitch
    ncdu
    darktable
    tree
    tex
    brightnessctl
    pamixer
    networkmanager_dmenu
    obsidian
    (pkgs.mathematica.override {
        version = "14.1.0";
    })
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
    (pkgs.dwmblocks.overrideAttrs {
      src = ./dotfiles/dwmblocks;
    })
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
      "100:class_g = 'Darktable'"
      "100:class_g = 'feh'"
      "100:class_g = 'obsidian'"
      "100:class_g = 'org.remmina.Remmina'"
      "100:class_g = 'code'"
      "100:class_g = 'Celeste.bin.c86_64'"
    ];

    fadeExclude = [
      "class_g = 'dmenu'"
    ];
  };

  services.playerctld.enable = true;

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
        feh --bg-fill /etc/nixos/backgrounds/nix.png
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
      rocmPackages.llvm.clang-tools-extra
      pyright
      nixd
      nixpkgs-fmt
      nodejs-slim
      svelte-language-server
      typescript-language-server
      vue-language-server
      lua-language-server
      ripgrep
      rust-analyzer
      rubber
      java-language-server
    ];
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      rb = "sudo nixos-rebuild switch --flake /etc/nixos/.\\?submodules=1#laptop";
      lg  = "lazygit";
      moss = "ssh -A s4743699@moss.labs.eait.uq.edu.au";
    };
    initExtra = ''
      xinput disable 10
      nitch
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
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
