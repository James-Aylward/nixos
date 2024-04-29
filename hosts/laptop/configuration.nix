{ config, pkgs, inputs, ... }:

{
    imports = [
        ./hardware-configuration.nix
            inputs.home-manager.nixosModules.default
    ];

# Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

        nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
    networking.networkmanager.enable = true;
    services.blueman.enable = true;

# Set your time zone.
    time.timeZone = "Australia/Brisbane";

# Select internationalisation properties.
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

# Enable the X11 windowing system.
    services.displayManager.defaultSession = "xfce";
    services.xserver = {

        enable = true;

        xkb = {
            layout = "au";
            variant = "";
        };

        desktopManager = {
            xfce.enable = true;
        };

        displayManager.lightdm.background = "/etc/nixos/backgrounds/background.png";
        displayManager.lightdm.greeters.gtk.theme.name = "Adwaita-dark";

        
    };



# Enable CUPS to print documents.
    services.printing.enable = true;

# Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = true;


# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.jamesa = {
        isNormalUser = true;
        description = "James Aylward";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };

    home-manager = {
        extraSpecialArgs = { inherit inputs; };
        users = {
            "jamesa" = import ./home.nix;
        };
    };

# Allow unfree packages
    nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
    environment.systemPackages = with pkgs; [
        fprintd
            xfce.xfce4-pulseaudio-plugin
            xfce.xfconf
            gnome.gnome-keyring
    ];
    programs.zsh.enable = true;

    services.gnome.gnome-keyring.enable = true;
    services.fprintd.enable = true;
    security.pam.services.login.fprintAuth = true;

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

    users.defaultUserShell = pkgs.zsh;

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?

}

