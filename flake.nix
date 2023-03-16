{

  description = "Atlas' NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    # emacs-overlay.url =
    #   "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs = {
        nixpkgs.follows = "nixpkgs-stable";
        flake-utils.follows = "flake-utils";
      };
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib.url = "github:hyprwm/contrib";
  };

  outputs = { self, nixpkgs, flake-utils, emacs-overlay, nix-alien, home-manager
    , hyprland, hyprland-contrib, ... }@attrs:
    let sys = "x86_64-linux";
    in {
      nixosConfigurations = builtins.foldl'
        (acc: hostname:
          {
            ${hostname} = nixpkgs.lib.nixosSystem {
              system = sys;
              specialArgs = attrs;
              modules = [
                ./configuration.nix
                ./machines/${hostname}.nix
                ./hardware/${hostname}.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.michal_atlas = import ./home.nix;
                  };
                }
              ];
            };
          } // acc) { } [ "hydra" "dagon" ];
    };
}
