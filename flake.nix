{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    menucalc.url = "github:sumnerevans/menu-calc";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      homeManagerConfig = {
        #home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.jamesa = import ./home.nix;
      };
    in
    {
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./common-configuration.nix
            ./hosts/framework/configuration.nix
            home-manager.nixosModules.home-manager
            homeManagerConfig
          ];
        };
        vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./common-configuration.nix
            ./hosts/vm/configuration.nix
            home-manager.nixosModules.home-manager
            homeManagerConfig
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./common-configuration.nix
            ./hosts/laptop/configuration.nix
            home-manager.nixosModules.home-manager
            homeManagerConfig
          ];
        };
      };
    };
}
