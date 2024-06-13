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
          inputs.nixvim.nixosModules.nixvim
          inputs.agenix.nixosModules.default
          inputs.nur.nixosModules.nur
          inputs.stevenblackhosts.nixosModule
          inputs.flake-gemini.nixosModules.kineto
        ];
      };
  in {
    hydra = makeSys ./hydra;
    dagon = makeSys ./dagon.nix;
    leviathan = makeSys ./leviathan.nix;
  };
}
