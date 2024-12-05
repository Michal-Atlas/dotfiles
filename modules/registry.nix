{ flake, lib, ... }:
{
  nix.registry = {
    np.to = builtins.parseFlakeRef "github:numtide/nixpkgs-unfree/nixos-unstable";
  } // lib.mapAttrs (_: value: { flake = value; }) (builtins.removeAttrs flake.inputs [ "self" ]);
}
