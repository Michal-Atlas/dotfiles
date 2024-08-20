{ flake, lib, ... }:
{
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) flake.inputs;
}
