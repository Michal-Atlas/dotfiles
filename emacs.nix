{pkgs, ...}: let
  configFile =
    files/emacs.el;
  atlas-emacs = pkgs.emacsWithPackagesFromUsePackage {
    defaultInitFile = true;
    alwaysEnsure = true;
    config = configFile;
    package = pkgs.emacs-pgtk;
    extraEmacsPackages = _: [];
  };
in {
  services.emacs = {
    enable = true;
    package = atlas-emacs;
    client.enable = true;
    socketActivation.enable = true;
    defaultEditor = true;
    startWithUserSession = true;
  };
  programs.emacs = {
    enable = true;
    package = atlas-emacs;
  };
  home.file.".emacs.d/init.el".source = configFile;
}
