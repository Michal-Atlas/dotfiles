{ config, lib, ... }:
{
  config = lib.mkIf config.hardware.enable {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
    services.displayManager.autoLogin = {
      enable = true;
      user = "michal_atlas";
    };
    programs.kdeconnect.enable = true;
    services.xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
      };
      desktopManager.gnome.enable = true;

      xkb = {
        layout = "us,cz";
        variant = ",ucw";
        options = "grp:caps_switch,lv3:ralt_switch,compose:rctrl-altgr";
      };
    };
    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd = {
      services = {
        "getty@tty1".enable = false;
        "autovt@tty1".enable = false;
      };
    };
    programs.dconf.enable = true;
  };
}
