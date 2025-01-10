_: {
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
  security = {
    soteria.enable = true;
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (subject.isInGroup("wheel"))
            return polkit.Result.YES;
        });
      '';
    };
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };
  security.pam.services.hyprlock = { };
}
