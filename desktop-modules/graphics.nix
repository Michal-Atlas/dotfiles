_: {
  services.xserver = {
  };
  programs.light.enable = true;
  xdg = {
    icons.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };
  services.displayManager.autoLogin = {
    enable = true;
    user = "michal_atlas";
  };
  programs.kdeconnect.enable = true;
  services.xserver = {
    xkb = {
      layout = "us,cz";
      variant = ",ucw";
      options = "grp:caps_switch,lv3:ralt_switch,compose:rctrl-altgr";
    };
  };
  programs.dconf.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd = {
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
  };
}
