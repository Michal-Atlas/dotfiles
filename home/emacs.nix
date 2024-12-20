{
  flake,
  config,
  pkgs,
  lib,
  ...
}:
with flake.self.lib;
let
  atlas-emacs = mkEmacsPackage {
    inherit pkgs;
    package = pkgs.emacs-pgtk;
  };
in
{
  options = {
    emacs.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  config = lib.mkIf config.emacs.enable {
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
    home.file = {
      ".emacs.d/init.el".source = emacsConfigFile;
    };
  };
}
