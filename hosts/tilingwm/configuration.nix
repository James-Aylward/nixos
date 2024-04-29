{ config, pkgs, inputs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.default
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Services
    services.blueman.enable = true;
    services.printing.enable = true; # CUPS
    services.gnome.gnome-keyring.enable = true;

    # Programs
    programs.zsh.enable = true;

    # Locals
    time.timeZone = "Australia/Brisbane";
    i18n.defaultLocale = "en_AU.UTF-8";
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



    services.xserver = {

        enable = true;

        windowManager.i3.enable = true;
        displayManager.lightdm = {
            enable = true;
            background = "/etc/nixos/backgrounds/background.png";
            greeters.gtk.theme.name = "Adwaita-dark";
        };

        xkb = {
            layout = "au";
            variant = "";
        };

    };

    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.defaultUserShell = pkgs.zsh;
    users.users.jamesa = {
        isNormalUser = true;
        description = "James Aylward";
        extraGroups = [ "video" "networkmanager" "wheel" ];
    };

    home-manager = {
        extraSpecialArgs = { inherit inputs; };
        users = {
            "jamesa" = import ./home.nix;
        };
    };


    # List packages installed in system profile. To search, run:
    #environment.systemPackages = with pkgs; [
    #    gnome.gnome-keyring
    #];

    system.stateVersion = "23.11";

}

