{
  self,
  inputs,
  ...
}:
{
  flake = {
    nixosConfigurations =
      let
        makeSys =
          {
            root,
            extraImports ? [ ],
            desktop ? true,
          }:
          self.nixos-unified.lib.mkLinuxSystem { home-manager = true; } {
            imports = [
              (if desktop then ../desktop-modules else { })
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = ".hm-delete";
                  users.michal_atlas.imports = [
                    (if desktop then self.homeModules.desktop else self.homeModules.default)
                  ];
                };
              }
              # keep-sorted start
              ../modules
              inputs.agenix.nixosModules.default
              inputs.disko.nixosModules.default
              inputs.gemini.nixosModules.kineto
              inputs.nix-index-database.nixosModules.nix-index
              inputs.nur.modules.nixos.default
              inputs.spicetify-nix.nixosModules.default
              inputs.stylix.nixosModules.stylix
              root
              # keep-sorted end
            ] ++ extraImports;
          };
      in
      {
        hydra = makeSys { root = ./hydra; };
        dagon = makeSys { root = ./dagon.nix; };
        leviathan = makeSys { root = ./leviathan.nix; };
        vorpal = makeSys {
          root = ./vpsFree;
          desktop = false;
          extraImports = [
            inputs.book-dagon.nixosModules.default
            inputs.vpsfreecz.nixosConfigurations.container
          ];
        };
      };
    homeModules = rec {
      default = {
        imports = [
          ../home
          inputs.nixvim.homeManagerModules.nixvim
        ];
      };
      desktop = {
        imports = default.imports ++ [
          ../desktop-home
        ];
      };
    };
  };
}
