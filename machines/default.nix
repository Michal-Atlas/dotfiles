{ self, inputs, ... }:
{
  flake = {
    nixosConfigurations =
      let
        makeSys =
          {
            root,
            enableHM ? true,
            extraImports ? [ ],
          }:
          self.nixos-unified.lib.mkLinuxSystem { home-manager = true; } {
            imports = [
              root
              inputs.nix-index-database.nixosModules.nix-index
              (
                if enableHM then
                  {
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      users.michal_atlas.imports = [ self.homeModules.default ];
                    };
                  }
                else
                  { }
              )
              inputs.agenix.nixosModules.default
              inputs.stevenblackhosts.nixosModule
              inputs.disko.nixosModules.default
            ] ++ extraImports;
          };
      in
      {
        hydra = makeSys { root = ./hydra; };
        dagon = makeSys { root = ./dagon.nix; };
        leviathan = makeSys { root = ./leviathan.nix; };
        oracle = makeSys {
          root = ./oracle.nix;
          enableHM = false;
        };
        vorpal = makeSys {
          root = ./vpsFree.nix;
          enableHM = true;
          extraImports = [
            inputs.book-dagon.nixosModules.default
            inputs.vpsfreecz.nixosConfigurations.container
          ];
        };
      };
    homeModules.default = {
      imports = [
        ../home
        inputs.nur.hmModules.nur
      ];
    };
  };
}
