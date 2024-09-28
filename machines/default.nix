{ self, inputs, ... }:
{
  flake = {
    nixosConfigurations =
      let
        makeSys =
          file:
          self.nixos-flake.lib.mkLinuxSystem { home-manager = true; } {
            imports = [
              file
              inputs.nix-index-database.nixosModules.nix-index
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.michal_atlas.imports = [ self.homeModules.default ];
                };
              }
              inputs.agenix.nixosModules.default
              inputs.stevenblackhosts.nixosModule
            ];
          };
      in
      {
        hydra = makeSys ./hydra;
        dagon = makeSys ./dagon.nix;
        leviathan = makeSys ./leviathan.nix;
      };
    homeModules.default = {
      imports = [ ../home ];
    };
  };
}
