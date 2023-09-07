{

  description = "Atlas' NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nur.url = "github:nix-community/NUR";
    atlas-overlay.url = "sourcehut:~michal_atlas/nur-packages";
    stevenblackhosts.url = "github:StevenBlack/hosts";
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
    , stevenblackhosts
    , ...
    }@attrs:
    let
      system = "x86_64-linux";
      desktop-modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = attrs;
            useGlobalPkgs = true;
            useUserPackages = true;
            users.michal_atlas = import ./home;
            backupFileExtension = "nix-home.bkp";
          };
        }
        agenix.nixosModules.default
        nur.nixosModules.nur
        stevenblackhosts.nixosModule
      ];

    in
    {
      nixosConfigurations =
        {
          hydra = nixpkgs.lib.nixosSystem {
            specialArgs = attrs;
            modules = [ ./system/machines/hydra.nix ] ++ desktop-modules;
          };
          dagon = nixpkgs.lib.nixosSystem {
            specialArgs = attrs;
            modules = [ ./system/machines/dagon.nix ] ++ desktop-modules;
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
            statix.enable = true;
            shellcheck.enable = true;
            shfmt.enable = true;

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
        nativeBuildInputs =
          let
            rebuild-cmd = cmd:
              "sudo nixos-rebuild ${cmd} --flake .#$(hostname) $@;";
          in
          [
            (pkgs.writeShellScriptBin "recon" (rebuild-cmd "switch"))
            (pkgs.writeShellScriptBin "recboot" (rebuild-cmd "boot"))
            (pkgs.writeShellScriptBin "check" "nix flake check $@;")
            (pkgs.writeShellScriptBin "build" "nixos-rebuild build --flake .#$(hostname) $@;")
            agenix.packages.${system}.default
          ];
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    }));
}
