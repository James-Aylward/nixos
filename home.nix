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
        brightnessctl
        pamixer
        networkmanager_dmenu
        libreoffice-fresh
        thunderbird
        networkmanagerapplet
        (nerdfonts.override {fonts = [ "JetBrainsMono" ]; })
        (pkgs.dwmblocks.overrideAttrs {
            src = /etc/nixos/dotfiles/dwmblocks;
        })
	];

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

    programs.ncspot = {
        enable = true;
        settings = {
            use_nerdfont = true;
            notify = true;
            theme = {
                    background = "default";
                    primary = "#EBDBB2";
                    secondary = "#D5C4A1";
                    title = "#D65D0E";
                    playing = "#83a597";
                    playing_selected = "#458588";
                    playing_bg = "#1D2021";
                    highlight = "#D79921";
                    highlight_bg = "#1D2021";
                    error = "#FBF1C7";
                    error_bg = "#CC241D";
                    statusbar = "#282828";
                    statusbar_progress = "#689D6A";
                    statusbar_bg = "#98971A";
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
            rocmPackages.llvm.clang
            rocmPackages.llvm.clang-tools-extra
            nil
            nodejs-slim
            typescript-language-server
            lua-language-server
			ripgrep
            rubber
		];
	};

	programs.zsh = {
		enable = true;
		autosuggestion.enable = true;
		shellAliases = {
			rb = "sudo nixos-rebuild switch --flake /etc/nixos#";
            lg = "lazygit";
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

	programs.home-manager.enable = true;
}
