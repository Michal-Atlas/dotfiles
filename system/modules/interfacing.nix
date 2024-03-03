{ pkgs, ... }: {
  programs.adb.enable = true;
  services = {
    printing.enable = true;
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];
  };
}
