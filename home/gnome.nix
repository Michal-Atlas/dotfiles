{ pkgs, ... }:
{
  programs.gnome-shell = {
    enable = true;
    extensions =
      with pkgs.gnomeExtensions;
      builtins.map (package: { inherit package; }) [
        appindicator
        mpris-label
        (pano.overrideAttrs {
          version = "23-alpha2";
          src = pkgs.fetchzip {
            name = "pano-src";
            url = "https://github.com/oae/gnome-shell-pano/releases/download/v23-alpha2/pano@elhan.io.zip";
            sha256 = "sha256-Y8WgVUHX094RUwYKdt7OROPZMl3dakK0zOU9OTdyqxc=";
            stripRoot = false;
          };
        })
        removable-drive-menu
        resource-monitor
        caffeine
      ];
  };
}
