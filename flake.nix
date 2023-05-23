{

  description = "Atlas' NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix";
    emacs-overlay.url =
      "github:nix-community/emacs-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home-manager
    , agenix
    , pre-commit-hooks
    , ...
    }@attrs:
    let system = "x86_64-linux";

    in {
      nixosConfigurations = builtins.foldl'
        (acc: hostname:
          {
            ${hostname} = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = attrs // {
                inherit hostname;
              };
              modules = [
                ./configuration.nix
                ./machines/${hostname}.nix
                ./hardware/${hostname}.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.michal_atlas = import ./home;
                  };
                }
                agenix.nixosModules.default
              ];
            };
          } // acc)
        { }
        (with builtins;
        (map (f: head (match "(.*).nix" f))
          (attrNames (readDir ./machines))));
    } // (flake-utils.lib.eachDefaultSystem (system:
    let pkgs = (import nixpkgs) { inherit system; }; in {
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
              entry = "${(pkgs.writeShellScriptBin "autofmt.sh" ''
                ${
                  (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages
                  (epkgs: with epkgs; [ elisp-autofmt ])
                }/bin/emacs "$1" --batch --eval "(require 'elisp-autofmt)" -f elisp-autofmt-buffer -f save-buffer --kill'')}/bin/autofmt.sh";
              files = "\\.(el)$";
            };
          };
        };
      };
      devShells.default = nixpkgs.legacyPackages.${system}.mkShell {
        nativeBuildInputs = [
          (pkgs.writeShellScriptBin "recon"
            "sudo nixos-rebuild switch --flake .#$(hostname) $@;")
          (pkgs.writeShellScriptBin "check"
            "nix flake check")
        ];
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    }
    ));
}
