{ config, pkgs, ... }:
let
    tex = (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-basic
        pgf
        environ
        parskip
        pgfplots
        etoolbox
        float
        microtype
        siunitx
        tcolorbox;
    });
in
{

    home.username = "jamesa";
    home.homeDirectory = "/home/jamesa";
    home.stateVersion = "23.11"; # Please read the comment before changing.

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate = _: true;
    home.packages = with pkgs; [
        zsh
        lazygit
        zoxide
        ncspot
        kitty
        htop

        qutebrowser
        xournalpp
        firefox
        obsidian
        tex
        nextcloud-client
        libreoffice
        sioyek
        mathematica

        pavucontrol
        mailspring
        flameshot
        rofi
        brightnessctl
        tree
        playerctl
        unzip
        networkmanagerapplet
        rubber
        neofetch

        rustc
        cargo

        clang_18
        conda
    ];


    home.file = {
        ".config/nvim" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/nvim";
        };
        ".config/i3" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/i3";
        };
        ".config/polybar" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/polybar";
        };
        ".config/kitty" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/kitty";
        };
        ".config/rofi" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/rofi";
        };
    };
    
    programs.neovim = {
    	enable = true;
        defaultEditor = true;
        extraPackages = with pkgs; [
            tree-sitter
            clang-tools
            texlab
            lua-language-server
            nodePackages.svelte-language-server
            nodePackages.typescript-language-server
            ripgrep
            rust-analyzer
        ];
    };

    programs.direnv.enable = true;

    programs.gh.enable = true;

    programs.git = {
        enable = true;
        userName = "James Aylward";
        userEmail = "james.michael.aylward@gmail.com";
    };

    services.kdeconnect.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        
        shellAliases = {
            lg = "lazygit";
            trash = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
        };

        initExtra = ''
            neofetch
        '';

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "sudo" ];
            theme = "robbyrussell";
        };
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.home-manager.enable = true;

    programs.ssh.enable = true;

    services.playerctld.enable = true;

    services.polybar = {
        enable = true;
        package = pkgs.polybar.override {
            pulseSupport = true;
            i3Support = true;
        };
        script = ''
            polybar &
        '';
    };

    systemd.user.targets.graphical-session-i3 = {
      Unit = {
        Description = "i3 X session";
        BindsTo = [ "graphical-session.target" ];
        Requisite = [ "graphical-session.target" ];
      };
    };
    systemd.user.services.polybar = {
      Unit.PartOf = [ "graphical-session-i3.target" ];
      Install.WantedBy = [ "graphical-session-i3.target" ];
    };

    services.dunst = {
        enable = true;
    };

    home.sessionVariables = {
        EDITOR = "nvim";
    };

}
