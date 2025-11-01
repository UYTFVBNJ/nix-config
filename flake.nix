{
  description = "NixOS configuration of Ryan Yin";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
    # nix com    extra-substituters = [munity's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url  = "github:ryantm/agenix";
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };

  };


  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    agenix,
    ...
  }: {
    nixosConfigurations = {
      mars = let 
      system = "x86_64-linux";
        username = "gh"; 
        pkgsUnstable = import inputs.nixpkgs-unstable {
          inherit system; 
          config.allowUnfree = true;
        };
        specialArgs = {
          inherit username; 
          inherit pkgsUnstable;
        };
      in nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;

        modules = [
          ./users/${username}/nixos.nix
          ./hosts/mars
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          ({config, ...}: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = inputs // specialArgs // {
              isDesktop = config.machine.isDesktop or false;
            };
            home-manager.users.${username} = {
              imports = [
                agenix.homeManagerModules.default
                ./users/${username}/home.nix 
              ];
            };
          })
        ];
      };

      moon = let 
      system = "x86_64-linux";
        username = "gh"; 
        pkgsUnstable = import inputs.nixpkgs-unstable {
          inherit system; 
          config.allowUnfree = true;
        };
        specialArgs = {
          inherit username; 
          inherit pkgsUnstable;
        };
      in nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;

        modules = [
          ./users/${username}/nixos.nix
          ./hosts/moon
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          ({config, ...}: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = inputs // specialArgs // {
              isDesktop = config.machine.isDesktop or false;
            };
            home-manager.users.${username} = {
              imports = [
                agenix.homeManagerModules.default
                ./users/${username}/home.nix 
              ];
            };
          })
        ];
      };
    };
  };
}
