{ pkgs, lib, ... }:
{
  programs.gnome-shell = {
    enable = lib.mkDefault true;
    extensions =
      with pkgs.gnomeExtensions;
      builtins.map (package: { inherit package; }) [
        appindicator
        mpris-label
        pano
        removable-drive-menu
        vitals
        caffeine
        night-theme-switcher
      ];
  };
}
