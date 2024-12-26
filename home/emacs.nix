{
  flake,
  config,
  pkgs,
  lib,
  ...
}:
with flake.self.lib;
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
      client.enable = true;
      socketActivation.enable = true;
      defaultEditor = true;
      startWithUserSession = true;
    };
    programs.emacs =
      let
        emacsConfigFile = ../home/files/emacs.el;
        parse = pkgs.callPackage (flake.inputs.emacs-overlay + /parse.nix) { };
      in
      {
        enable = true;
        package = pkgs.emacs-pgtk;
        extraPackages =
          epkgs:
          builtins.map (name: builtins.getAttr name epkgs) (
            parse.parsePackagesFromUsePackage {
              alwaysEnsure = true;
              configText = builtins.readFile emacsConfigFile;
            }
          );
        extraConfig = ''
          (load "${emacsConfigFile}")
        '';
      };
  };
}
