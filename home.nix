{ config, pkgs, inputs, ... }:

{
	home.username = "jamesa";
	home.homeDirectory = "/home/jamesa";

	home.stateVersion = "24.05";

	home.packages = with pkgs; [
		dmenu-rs
        feh
        nitch

		tree
	];


    services.picom = {
        enable = true;
        fadeDelta = 5;
        fade = true;
    };
    
    services.flameshot = {
        enable = true;
        settings = {
            General = {
                uiColor = "#d79921";
                contrastUiColor = "#282828";
            };
        };
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
			ripgrep
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
