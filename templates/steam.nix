{ pkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ ... }: {
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
}
