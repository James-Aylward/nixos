{ config, pkgs, specialArgs, ... }:

let
  inputs = specialArgs.inputs;
in
{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall = {
   # if packets are still dropped, they will show up in dmesg
   logReversePathDrops = true;
   # wireguard trips rpfilter up
   extraCommands = ''
     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
   '';
   extraStopCommands = ''
     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
   '';
  };



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

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "jamesa" ];
  #virtualisation.virtualbox.
  virtualisation.libvirtd.enable = true;
     virtualisation.virtualbox.host.enableKvm = true;
   virtualisation.virtualbox.host.addNetworkInterface = false;

  services.blueman.enable = true;

  # Configure keymap in X11
  services.xserver = {
    dpi = 144;
    updateDbusEnvironment = true;
    xkb.layout = "us,us";
    xkb.variant = "colemak_dh,";
    xkb.options = "grp:alt_space_toggle";
    enable = true;
    windowManager.dwm.enable = true;
    windowManager.dwm.package = pkgs.dwm.overrideAttrs {
      src = ./dotfiles/dwm;
    };
    displayManager.lightdm = {
      enable = true;
      background = ./backgrounds/nix.png;
      greeters.gtk.theme.package = pkgs.gruvbox-dark-gtk;
    };
  };

  services.clamav = {
    daemon.enable = true;
  };

  programs.steam.enable = true;
  programs.nix-ld.enable = true;

  programs.slock = {
    enable = true;
    package = pkgs.slock.overrideAttrs (oldAttrs: {
      src = ./dotfiles/slock;
      buildInputs = oldAttrs.buildInputs ++ [ pkgs.cairo pkgs.imlib2 ];
    });
  };

  services.autorandr.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };

  users.users.jamesa = {
    isNormalUser = true;
    description = "James Aylward";
    extraGroups = [ "audio" "video" "networkmanager" "wheel" ];
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

  #system.stateVersion = "23.11"; # Did you read the comment?
  nix = {
    package = pkgs.nixVersions.git;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
