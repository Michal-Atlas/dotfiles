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
  };
}
