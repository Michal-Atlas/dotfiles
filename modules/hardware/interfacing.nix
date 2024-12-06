{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.hardware.enable {
    programs.adb.enable = true;
    services = {
      printing.enable = true;
      udev.packages = with pkgs; [ gnome-settings-daemon ];
    };
  };
}
