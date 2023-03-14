{

  description = "NixOS configuration";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
  inputs.flake-utils.url = github:numtide/flake-utils;
  inputs.emacs-overlay.url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";

   outputs = inputs @ { self, nixpkgs, flake-utils, emacs-overlay, ... }:
   flake-utils.lib.eachDefaultSystem (system:
      {
      nixosConfigurations = {
        hydra = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
          ];
        };
      };
    });
}