{ config, pkgs, ... }:
let
    tex = (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-basic
        pgf
        environ
        etoolbox
        microtype
        siunitx
        tcolorbox;
    });
in
{
# Home Manager needs a bit of information about you and the paths it should
# manage.
    home.username = "jamesa";
    home.homeDirectory = "/home/jamesa";

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.

# The home.packages option allows you to install Nix packages into your
# environment.
    nixpkgs.config.allowUnfreePredicate = _: true;
    home.packages = with pkgs; [
        htop
        tex
        firefox
        obsidian
        nextcloud-client
        xournalpp
        zsh
        networkmanagerapplet
        lazygit
        zoxide
        ncspot
        kitty
        mathematica
        pavucontrol
        ripgrep
        mailspring
        tree
        tree-sitter
        unzip
        cargo
        libreoffice
        sioyek
        flameshot
        rofi
        rubber
        neofetch
        conda
        rustc
        clang_18
    ];

    home.file = {
        ".config/nvim" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/nvim";
        };

        ".config/kitty" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/kitty";
        };
        ".config/rofi" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/rofi";
        };
        ".config/gtk-3.0/gtk.css" = {
            source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/gtk-3.0/gtk.css";
        };

    };
    
    programs.neovim = {
    	enable = true;
        defaultEditor = true;
        extraPackages = with pkgs; [
            clang-tools
            lua-language-server
            rust-analyzer
        ];
    };

    programs.gh.enable = true;

    programs.git = {
        enable = true;
        userName = "James Aylward";
        userEmail = "james.michael.aylward@gmail.com";
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
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

    home.sessionVariables = {
        EDITOR = "nvim";
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
