{ pkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override (_: {
        extraPkgs = pkgs': (with pkgs'; [
        ]);
      });
    })
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # TM Nations
  networking.firewall.allowedTCPPorts = [ 2350 3450 ];
  networking.firewall.allowedUDPPorts = [ 2350 3450 ];
}
