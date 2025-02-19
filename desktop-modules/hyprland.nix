{ config, ... }:
{
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
    pam.services.hyprlock = { };
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Xwayland can be disabled.
    systemd.setPath.enable = true;
  };
  services = {
    greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          command = "Hyprland";
          user = config.users.users.michal_atlas.name;
        };
      };
    };
  };
}
