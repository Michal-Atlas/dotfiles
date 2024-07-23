{pkgs, ...}: {
  services = {
    spotifyd = {
      enable = true;
      package = pkgs.spotifyd.override {withMpris = true;};
      settings.global = rec {
        username = "michal_atlas+spotify@posteo.net";
        password_cmd = "pass spotify.com/${username}";
        zeroconf_port = 1234;
        use_mpris = true;
      };
    };
  };
}
