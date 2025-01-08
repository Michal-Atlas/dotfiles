{ lib, ... }:
{
  imports = [ ./syncthing.nix ];
  services.gvfs.enable = lib.mkDefault true;
}
