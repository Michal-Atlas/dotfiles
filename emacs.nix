{ pkgs, ... }:
with (import ./lib);
let
  atlas-emacs = mkEmacsPackage {
    inherit pkgs;
    package = pkgs.emacs-pgtk;
  };
in
{
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
  home.file.".emacs.d/init.el".source = emacsConfigFile;
}
