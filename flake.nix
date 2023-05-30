{

  description = "Atlas' NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix";
    emacs-overlay.url =
      "github:nix-community/emacs-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nur.url = "github:nix-community/NUR";
    atlas-overlay = {
      url = "sourcehut:~michal_atlas/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home-manager
    , agenix
    , nur
    , atlas-overlay
    , pre-commit-hooks
    , ...
    }@attrs:
    let
      system = "x86_64-linux";
      desktop-modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.michal_atlas = import ./home;
            backupFileExtension = "nix-home.bkp";
          };
        }
        agenix.nixosModules.default
        nur.nixosModules.nur
      ];

    in
    rec {
      images.rpi2 = nixosConfigurations.rpi2.config.system.build.sdImage;
      nixosConfigurations = {
        rpi2 = nixpkgs.lib.nixosSystem {
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
            ./machines/rpi.nix
          ];
        };
        oracle = nixpkgs.lib.nixosSystem {
          modules = [ ./machines/oracle.nix ];
        };
        hydra = nixpkgs.lib.nixosSystem {
          specialArgs = attrs;
          modules = [ ./machines/hydra.nix ] ++ desktop-modules;
        };
        dagon = nixpkgs.lib.nixosSystem {
          specialArgs = attrs;
          modules = [ ./machines/dagon.nix ] ++ desktop-modules;
        };
      };
    } // (flake-utils.lib.eachDefaultSystem (system:
    let pkgs = (import nixpkgs) { inherit system; };
    in {
      checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            # statix.enable = true;
            # shellcheck.enable = true;
            # shfmt.enable = true;

            elisp-autofmt = {
              enable = true;
              name = "Elisp Autofmt";
              entry = "${
                    (pkgs.writeShellScriptBin "autofmt.sh" ''
                      ${
                        (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages
                        (epkgs: with epkgs; [ elisp-autofmt ])
                      }/bin/emacs "$1" --batch --eval "(require 'elisp-autofmt)" -f elisp-autofmt-buffer -f save-buffer --kill'')
                  }/bin/autofmt.sh";
              files = "\\.(el)$";
            };
          };
        };
      };
      devShells.default = nixpkgs.legacyPackages.${system}.mkShell {
        nativeBuildInputs = [
          (pkgs.writeShellScriptBin "recon"
            "sudo nixos-rebuild switch --flake .#$(hostname) $@;")
          (pkgs.writeShellScriptBin "check" "nix flake check")
        ];
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    }));
}
