{
  description = "Atlas' NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-23.11";
    agenix.url = "github:ryantm/agenix";
    emacs-overlay.url = "github:nix-community/emacs-overlay/aee5e8a427c8a942458d2bad7b97cbad30b75aec";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nur.url = "github:nix-community/NUR";
    atlas-overlay.url = "sourcehut:~michal_atlas/nur-packages";
    stevenblackhosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    nur,
    pre-commit-hooks,
    stevenblackhosts,
    flake-parts,
    systems,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;}
    {
      systems = import systems;
      flake = {
        nixosConfigurations = let
          makeSys = file:
            nixpkgs.lib.nixosSystem {
              specialArgs =
                inputs
                // {
                  lib = nixpkgs.lib // import ./lib;
                };
              modules = [
                file
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    extraSpecialArgs = inputs;
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.michal_atlas = import ./home;
                  };
                }
                agenix.nixosModules.default
                nur.nixosModules.nur
                stevenblackhosts.nixosModule
              ];
            };
        in {
          hydra = makeSys ./machines/hydra;
          dagon = makeSys ./machines/dagon;
        };
      };
      perSystem = {
        system,
        pkgs,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = let
            rebuild-cmd = cmd: ''nixos-rebuild ${cmd} --flake . "$@";'';
            sudo-rebuild-cmd = cmd: "sudo ${rebuild-cmd cmd}";
          in [
            (pkgs.writeShellScriptBin "recon" (sudo-rebuild-cmd "switch"))
            (pkgs.writeShellScriptBin "recboot" (sudo-rebuild-cmd "boot"))
            (pkgs.writeShellScriptBin "check" "nix flake check $@;")
            (pkgs.writeShellScriptBin "build" (rebuild-cmd "build"))
            agenix.packages.${system}.default
            (pkgs.writeShellScriptBin "recdiff" ''
              build && ${pkgs.nix-diff}/bin/nix-diff /run/current-system result && rm result
            '')
            pkgs.commitizen
          ];
          inherit (self.checks.${system}.pre-commit-check) shellHook;
        };

        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              alejandra.enable = true;
              shellcheck.enable = true;
              shfmt.enable = true;
              nil.enable = true;
              deadnix.enable = true;
              commitizen.enable = true;

              elisp-autofmt = {
                enable = true;
                name = "Elisp Autofmt";
                entry = "${
                  (pkgs.writeShellScriptBin "autofmt.sh" ''
                    ${
                      (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages
                      (epkgs: with epkgs; [elisp-autofmt])
                    }/bin/emacs "$1" --batch --eval "(require 'elisp-autofmt)" -f elisp-autofmt-buffer -f save-buffer --kill'')
                }/bin/autofmt.sh";
                files = "\\.(el)$";
              };
            };
          };
        };
      };
    };
}
