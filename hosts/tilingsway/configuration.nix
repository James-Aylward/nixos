{ config, pkgs, inputs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in
{
    imports = [
        ./hardware-configuration.nix
            inputs.home-manager.nixosModules.default
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    networking.firewall = { 
        enable = true;
        allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
        ];  
        allowedUDPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
        ];  
    };  

    # Services
    services.blueman.enable = true;
    services.printing.enable = true; # CUPS
    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;

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
        #desktopManager.gnome.enable = true;
        displayManager.gdm.wayland = false;
    };
    services.greetd = {
        enable = true;
        settings = rec {
            initial_session = {
                command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
                user = "jamesa";
            };
            default_session = initial_session;
        };
    };

    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };
    programs.waybar.enable = true;

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

    system.stateVersion = "23.11";

}

