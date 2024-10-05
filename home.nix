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
	home.packages = with pkgs; [
		dmenu-rs
        feh
        nitch
        ncdu
        darktable
		tree
        tex
        libreoffice-fresh
        (nerdfonts.override {fonts = [ "JetBrainsMono" ]; })
	];

    services.network-manager-applet.enable = true;

    services.picom = {
        enable = true;
        fadeDelta = 5;
        fade = true;
    };
    
    services.flameshot = {
        enable = true;
        settings = {
            General = {
                disableTrayIcon = true;
                showStartupLaunchMessage = false;
                uiColor = "#d79921";
                contrastUiColor = "#282828";
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

    programs.lazygit.enable = true;

    programs.sioyek = {
        enable = true;
    };

    programs.firefox = {
        enable = true;
        profiles.jamesa = {
            extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
                ublock-origin
                gruvbox-dark-theme
                to-deepl
                vimium
                libredirect
            ];
        };
        
    };

	programs.alacritty = {
		enable = true;
		settings = {
			import = [ ./dotfiles/alacritty/gruvbox_dark.toml ];
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
            rocmPackages.llvm.clang
            rocmPackages.llvm.clang-tools-extra
            nodejs-slim
			ripgrep
            rubber
		];
	};

	programs.zsh = {
		enable = true;
		autosuggestion.enable = true;
		shellAliases = {
			rb = "sudo nixos-rebuild switch --flake /etc/nixos";
		};
        initExtra = ''
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

	programs.home-manager.enable = true;
}
