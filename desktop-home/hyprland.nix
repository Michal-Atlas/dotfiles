{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.fuzzel.enable = true;
  programs.hyprlock.enable = true;
  services.dunst.enable = true;
  # wayland.systemd.target = "hyprland-session.target";
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      modules-left = [
        "hyprland/workspaces"
      ];
      modules-center = [ "mpris" ];
      modules-right = [
        "idle_inhibitor"
        "wireplumber"
        "network"
        "cpu"
        "memory"
        "backlight"
        "battery"
        "clock"
        "tray"
      ];
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      disk.format = "{used}/{total}";
      tray.spacing = 10;
      mpris = {
        dynamic-len = 80;
        title-len = 30;
      };
      wireplumber = {
        format = "{volume}";
        format-muted = "--";
        on-click = "${pkgs.qpwgraph}/bin/qpwgraph";
      };
      network = {
        format-wifi = "{essid}";
        format-ethernet = "ETH";
        tooltip-format = "{ipaddr}/{cidr} {signalStrength}%";
      };
      clock.format = "{:%FT%TZ}";
      cpu.format = "{usage}";
      memory.format = "{}";
      battery.format = "{}🔋";
      backlight.format = "{percent}";
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        ", preferred, auto, 1"
      ];
      input = {
        kb_layout = "us,cz";
        kb_variant = ",ucw";
        kb_options = "grp:caps_switch,lv3:ralt_switch,compose:rctrl-altgr";
        follow_mouse = true;
        touchpad.natural_scroll = true;
      };
      "$mainMod" = "SUPER";
      bind =
        [
          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          # LayOut managment
          "$mainMod, P, pseudo,"
          # dwindle
          "$mainMod, J, togglesplit, # dwindle"

          # Window managment key binds
          "$mainMod,     Q, killactive,"
          "$mainMod,     F, fullscreen,"
          "$mainMod, Space, togglefloating,"

          # Move focus with mainMod + arrow keys
          "$mainMod, left,  movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up,    movefocus, u"
          "$mainMod, down,  movefocus, d"

          "$mainMod SHIFT, left,  movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up,    movewindow, u"
          "$mainMod SHIFT, down,  movewindow, d"

          # Basic apps
          "$mainMod,      T, exec, ${pkgs.alacritty}/bin/alacritty -e tmux"
          # "$mainMod,      F, exec, ${pkgs.firefox}/bin/firefox"
          "$mainMod,      M, exit,"
          "$mainMod,      Return, exec, ${config.programs.emacs.package}/bin/emacsclient -c"
          "$mainMod,      C, exec, ${pkgs.fuzzel}/bin/fuzzel"

          "$mainMod, L, exec, swaylock"
          "CTRL SHIFT, Escape, exec, wlogout"
          ", Print, exec, grimblast copy area"

        ]
        ++ builtins.map (n: "bind = $mainMod, ${builtins.toString n}, workspace, ${builtins.toString n}") (
          lib.range 1 9
        )
        ++ builtins.map (
          n: "bind = $mainMod SHIFT, ${builtins.toString n}, movetoworkspace, ${builtins.toString n}"
        ) (lib.range 1 9);

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        # mouse:272 = left  click
        # mouse:273 = right click
        "$mainMod,       mouse:272, movewindow"
        "$mainMod SHIFT, mouse:272, resizewindow"
        "$mainMod,       mouse:273, resizewindow"
      ];
      binde =
        let
          light = "${pkgs.light}/bin/light";
        in
        [
          ### Audio
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@      5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@      5%-"
          ", XF86AudioMute,        exec, wpctl set-mute   @DEFAULT_AUDIO_SINK@   toggle"
          ", XF86AudioMicMute,     exec, wpctl set-mute   @DEFAULT_AUDIO_SOURCE@ toggle"

          # backlight
          ", XF86MonBrightnessUp,   exec, ${light} -A 1.6"
          ", XF86MonBrightnessDown, exec, ${light} -T 0.6"
        ];

      bindl = [
        # media controls
        ", XF86AudioPlay,        exec, playerctl play-pause"
        ", XF86AudioPrev,        exec, playerctl previous"
        ", XF86AudioNext,        exec, playerctl next"
      ];

      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
      };
      gestures = {
        workspace_swipe = true;
      };
    };
  };
}
