{ lib, ... }:
{
  nixpkgs.overlays = [
    (_: prev: {
      steam = prev.steam.override (_: {
        extraPkgs = _: [ ];
      });
    })
  ];
  programs.steam = {
    enable = lib.mkDefault true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # TM Nations
  networking.firewall.allowedTCPPorts = [
    2350
    3450
  ];
  networking.firewall.allowedUDPPorts = [
    2350
    3450
  ];
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };
}
