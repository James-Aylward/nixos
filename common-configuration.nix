{ config, pkgs, ... }:

{
# Enable networking
    networking.networkmanager.enable = true;

# Set your time zone.
    time.timeZone = "Australia/Brisbane";

# Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_AU.UTF-8";
        LC_IDENTIFICATION = "en_AU.UTF-8";
        LC_MEASUREMENT = "en_AU.UTF-8";
        LC_MONETARY = "en_AU.UTF-8";
        LC_NAME = "en_AU.UTF-8";
        LC_NUMERIC = "en_AU.UTF-8";
        LC_PAPER = "en_AU.UTF-8";
        LC_TELEPHONE = "en_AU.UTF-8";
        LC_TIME = "en_AU.UTF-8";
    };

# Configure keymap in X11
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
        enable = true;
        windowManager.dwm.enable = true;
        windowManager.dwm.package = pkgs.dwm.overrideAttrs {
            src = ./dotfiles/dwm;
        };
    };

    users.users.jamesa = {
        isNormalUser = true;
        description = "James Aylward";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    nixpkgs.config.allowUnfree = true;
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?
        nix = {
            package = pkgs.nixFlakes;
            extraOptions = ''
                experimental-features = nix-command flakes
                '';
        };
}