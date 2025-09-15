{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system-x86_64-linux = "x86_64-linux";
      system-aarch64-linux = "aarch64-linux";
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
              home-manager.users.gh = {
                imports = [ ./users/gh.nix ./modules/gui.nix ];
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
              home-manager.users.gh = {
                imports = [ ./users/gh.nix ./modules/server.nix ];
              };
            }
          ];
        };
      };
    };
}
