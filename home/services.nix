{pkgs, ...}: {
  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    emacs = {
      enable = true;
      package = pkgs.atlas-emacs;
      client.enable = true;
      socketActivation.enable = true;
    };

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
