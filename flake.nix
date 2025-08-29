{
  description = "Unified NixOS and macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-darwin, home-manager, darwin }:
    let
      system-x86_64-linux = "x86_64-linux";
      system-aarch64-linux = "aarch64-linux";
      system-x86_64-darwin = "x86_64-darwin";
      system-aarch64-darwin = "aarch64-darwin";
      
      mkSystem = { system, modules ? [], homeModules ? [] }: {
        nixosConfigurations = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = modules ++ [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lighthouse = { imports = homeModules; };
            }
          ];
        };
      };
      
      mkDarwin = { system, modules ? [], homeModules ? [] }: {
        darwinConfigurations.default = darwin.lib.darwinSystem {
          inherit system;
          modules = modules ++ [
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lighthouse = { imports = homeModules; };
            }
          ];
        };
      };
    in
    {
      nixosConfigurations = {
        nixos-desktop = nixpkgs.lib.nixosSystem {
          system = system-x86_64-linux;
          modules = [
            ./systems/nixos-desktop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lighthouse = {
                imports = [ ./users/lighthouse.nix ./modules/gui.nix ];
              };
            }
          ];
        };
        
        nixos-server = nixpkgs.lib.nixosSystem {
          system = system-x86_64-linux;
          modules = [
            ./systems/nixos-server.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lighthouse = {
                imports = [ ./users/lighthouse.nix ./modules/server.nix ];
              };
            }
          ];
        };
      };

      darwinConfigurations = {
        macos = darwin.lib.darwinSystem {
          system = system-aarch64-darwin;
          modules = [
            ./systems/macos.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lighthouse = {
                imports = [ ./users/lighthouse.nix ./modules/macos.nix ];
              };
            }
          ];
        };
      };
    };
}