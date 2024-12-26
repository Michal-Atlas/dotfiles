{
  description = "Atlas' NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    agenix.url = "github:ryantm/agenix";
    emacs-overlay.url = "github:nix-community/emacs-overlay/2118e2829ef4b6dd969684cf9a4e0e771c943761";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    unison-nix.url = "github:ceedubs/unison-nix";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-flake.url = "github:srid/nixos-unified";
    nur.url = "github:nix-community/NUR";
    disko.url = "github:nix-community/disko";
    vpsfreecz.url = "github:vpsfreecz/vpsadminos";
    book-dagon.url = "git+https://gitlab.fit.cvut.cz/zacekmi2/book-daemon.git";
    gemini.url = "github:Michal-Atlas/flake-gemini";
    treefmt.url = "github:numtide/treefmt-nix";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      flake-parts,
      systems,
      pre-commit-hooks,
      nixos-flake,
      treefmt,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      imports = [
        ./devShell.nix
        pre-commit-hooks.flakeModule
        nixos-flake.flakeModule
        treefmt.flakeModule
        ./checks.nix
        ./machines
      ];
      flake.lib = import ./lib;
    };
}
