{
  description = "Atlas' NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-23.05";
    agenix.url = "github:ryantm/agenix";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nur.url = "github:nix-community/NUR";
    atlas-overlay.url = "sourcehut:~michal_atlas/nur-packages";
    stevenblackhosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
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
      pkgs = (import nixpkgs) { inherit system; };
    in
    {
      nixosConfigurations =
        let
          makeSys = file:
            nixpkgs.lib.nixosSystem {
              specialArgs = attrs // {
                lib = nixpkgs.lib // import ./lib;
              };
              modules = [
                file
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    extraSpecialArgs = attrs;
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
        in
        {
          hydra = makeSys ./system/machines/hydra;
          dagon = makeSys ./system/machines/dagon;
        };

      checks.${system} = {
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
      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        nativeBuildInputs =
          let
            rebuild-cmd = cmd: "nixos-rebuild ${cmd} --flake .#$(hostname) $@;";
            sudo-rebuild-cmd = cmd: "sudo ${rebuild-cmd cmd}";
          in
          [
            (pkgs.writeShellScriptBin "recon" (sudo-rebuild-cmd "switch"))
            (pkgs.writeShellScriptBin "recboot" (sudo-rebuild-cmd "boot"))
            (pkgs.writeShellScriptBin "check" "nix flake check $@;")
            (pkgs.writeShellScriptBin "build" (rebuild-cmd "build"))
            agenix.packages.${system}.default
            (pkgs.writeShellScriptBin "recdiff" ''
              build && ${pkgs.nix-diff}/bin/nix-diff /run/current-system result && rm result
            '')
          ];
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    };
}
