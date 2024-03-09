{pkgs, ...}: {
  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    emacs = {
      enable = true;
      package = pkgs.atlas-emacs;
      defaultEditor = true;
      client.enable = true;
      socketActivation.enable = true;
    };
  };
}
