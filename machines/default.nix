{inputs, ...}: {
  flake.nixosConfigurations = let
    makeSys = file:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs =
          inputs
          // {
            lib = inputs.nixpkgs.lib // import ../lib;
          };
        modules = [
          file
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = inputs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.michal_atlas = import ../home;
            };
          }
          inputs.agenix.nixosModules.default
          inputs.nur.nixosModules.nur
          inputs.stevenblackhosts.nixosModule
        ];
      };
  in {
    hydra = makeSys ./hydra;
    dagon = makeSys ./dagon;
  };
}
