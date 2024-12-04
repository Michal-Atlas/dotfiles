{ pkgs, ... }:
{
  programs.gnome-shell = {
    enable = true;
    extensions =
      with pkgs.gnomeExtensions;
      builtins.map (package: { inherit package; }) [
        appindicator
        mpris-label
        pano
        removable-drive-menu
        resource-monitor
        caffeine
        tailscale-status
      ];
  };
}
