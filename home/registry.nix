{ self, lib, ... }:
{
  nix.registry =
    lib.mapAttrs (_: value: { flake = value; })
      self.inputs;
}
