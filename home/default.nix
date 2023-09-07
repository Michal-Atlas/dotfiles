{ pkgs, lib, ... }:
{
  imports = [
    ./programs
    ./files
    ./services.nix
    ./dconf.nix
    ./registry.nix
  ];

  home = {
    username = "michal_atlas";
    homeDirectory = "/home/michal_atlas";
  };

  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "22.11";
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];

  home.shellAliases = {
    e = "$EDITOR -c -nw";
    g = "git";
    z = "j";
  };
  fonts.fontconfig.enable = true;
  xsession.numlock.enable = true;
  programs.home-manager.enable = true;

  home.packages =
    [
      pkgs.atlas-emacs
    ] ++ import ./packages.nix pkgs;

  systemd.user.tmpfiles.rules = [
    "e /home/michal_atlas/Downloads - - - 2d"
    "e /home/michal_atlas/tmp - - - 2d"
  ];
}
