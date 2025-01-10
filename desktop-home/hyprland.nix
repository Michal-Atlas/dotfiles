{
  pkgs,
  lib,
  config,
  ...
}:
let
  uwsm = "${pkgs.uwsm}/bin/uwsm";
in
{
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  services.wlsunset = {
    enable = true;
    latitude = 50.08804;
    longitude = 14.42076;
  };
  programs.zathura.enable = true;
  programs.fuzzel.enable = true;
  programs.hyprlock.enable = true;
  services.dunst.enable = true;
  programs.zsh.initExtra = ''
    if uwsm check may-start; then
        exec uwsm start hyprland.desktop
    fi
  '';
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
    style = ''
      .modules-right .module {
        margin: 6px;
        border-radius: 4px;
        background-color: @base05;
        color: @base00;
      }
    '';
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
      tray.spacing = 10;
      mpris = {
        dynamic-len = 80;
        title-len = 30;
      };
      wireplumber = {
        format = "{volume}  ";
        format-muted = "--  ";
        on-click = "${uwsm} app -- ${pkgs.pavucontrol}/bin/pavucontrol";
      };
      network = {
        format-wifi = "{essid}";
        format-ethernet = "ETH";
        tooltip-format = "{ipaddr}/{cidr} {signalStrength}%";
      };
      clock.format = "{:%FT%TZ}";
      cpu.format = "{usage}  ";
      memory.format = "{}  ";
      battery = {
        format-charging = "{} 🔌 ";
        format = "{} 🔋 ";
      };
      backlight.format = "{percent}  ";
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = "systemctl --user start waybar.service";
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
          "$mainMod,      T, exec, ${uwsm} app -- ${pkgs.alacritty}/bin/alacritty -e tmux"
          # "$mainMod,      F, exec, ${pkgs.firefox}/bin/firefox"
          "$mainMod,      M, exit,"
          "$mainMod,      Return, exec, ${uwsm} app -- ${config.programs.emacs.package}/bin/emacsclient -c"
          "$mainMod,      D, exec, ${uwsm} app -- ${pkgs.fuzzel}/bin/fuzzel"

          "$mainMod, L, exec, swaylock"
          "CTRL SHIFT, Escape, exec, wlogout"
          ", Print, exec, grimblast copy area"

        ]
        ++ builtins.concatLists (
          builtins.map (n: [
            "$mainMod, ${builtins.toString n}, workspace, ${builtins.toString n}"
            "$mainMod SHIFT, ${builtins.toString n}, movetoworkspace, ${builtins.toString n}"
          ]) (lib.range 1 9)
        );

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
          ", XF86AudioRaiseVolume, exec, ${uwsm} app -- wpctl set-volume @DEFAULT_AUDIO_SINK@      5%+"
          ", XF86AudioLowerVolume, exec, ${uwsm} app -- wpctl set-volume @DEFAULT_AUDIO_SINK@      5%-"
          ", XF86AudioMute,        exec, ${uwsm} app -- wpctl set-mute   @DEFAULT_AUDIO_SINK@   toggle"
          ", XF86AudioMicMute,     exec, ${uwsm} app -- wpctl set-mute   @DEFAULT_AUDIO_SOURCE@ toggle"

          # backlight
          ", XF86MonBrightnessUp,   exec, ${uwsm} app -- ${light} -A 1.6"
          ", XF86MonBrightnessDown, exec, ${uwsm} app -- ${light} -T 0.6"
        ];

      bindl = [
        # media controls
        ", XF86AudioPlay,        exec, ${uwsm} app -- playerctl play-pause"
        ", XF86AudioPrev,        exec, ${uwsm} app -- playerctl previous"
        ", XF86AudioNext,        exec, ${uwsm} app -- playerctl next"

        ", PRINT,         exec, ${uwsm} app -- ${pkgs.hyprshot}/bin/hyprshot -m region -z"
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

  gtk.iconTheme = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";

    # package =
    #   pkgs.runCommandLocal "Memphis98"
    #     {
    #       pname = "memphis98-icons";
    #       version = "1.2";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "Stanton731";
    #         repo = "Memphis98";
    #         rev = "1.2";
    #         hash = "sha256-Xn17X1NSbm0E5XhCLQTd6aiKrm8XJ3mfMoanlgP1rVc=";
    #       };
    #     }
    #     ''
    #       mkdir -p $out/share/icons/
    #       ln -s $src $out/share/icons/Memphis98
    #     '';
    # name = "Memphis98";
  };
}
