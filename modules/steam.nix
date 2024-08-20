_: {
  nixpkgs.overlays = [
    (_: prev: {
      steam = prev.steam.override (_: {
        extraPkgs = _: [ ];
      });
    })
  ];
  programs.steam = {
    enable = true;
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
}
