_: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };
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
    xkb = {
      layout = "us,cz";
      variant = ",ucw";
      options = "grp:caps_switch,lv3:ralt_switch,compose:rctrl-altgr";
    };
  };
  programs.dconf.enable = true;
}
