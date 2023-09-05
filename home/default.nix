{ pkgs, lib, ... }:
let
  inherit (lib.hm.gvariant) mkTuple;
in
{
  home = {
    username = "michal_atlas";
    homeDirectory = "/home/michal_atlas";
  };

  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "22.11";
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];

  home.shellAliases = {
    e = "$EDITOR -c -nw";
    g = "git";
    z = "j";
  };
  fonts.fontconfig.enable = true;
  programs = {
    git = import ./git.nix;

    fzf.enable = true;
    dircolors.enable = true;
    keychain.enable = true;
    navi.enable = true;
    direnv = {
      nix-direnv.enable = true;
      enable = true;
    };
    autojump.enable = true;
    zsh = import ./zsh.nix;
    starship.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };
    nix-index.enable = true;
    exa = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
    foot = {
      enable = true;
      server.enable = true;
      settings = {
        colors.alpha = "0.9";
        main = {
          font = "Fira Code:size=12";
          pad = "5x5 center";
          include = "${pkgs.foot.themes}/share/foot/themes/monokai-pro";
        };
      };
    };
    waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          ipc = true;
          id = 0;
          modules-left = [
            "sway/workspaces"
            "sway/mode"
          ];
          modules-center = [
            "sway/windows"
          ];
          modules-right = [
            "idle_inhibitor"
            "pulseaudio"
            "network"
            "cpu"
            "memory"
            "disk"
            "backlight"
            "battery"
            "clock"
            "tray"
          ];
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "\uf06e";
              deactivated = "\uf070";
            };
          };
          disk.format = "{used}/{total}";
          tray.spacing = 10;
          pulseaudio = {
            format-wifi = "{essid} {ipaddr}/{cidr}";
            format-ethernet =
              "{ipaddr}/{cidr}";
            tooltip-format = "{signalStrength}%";
          };
          clock.format = "{:%FT%TZ}";
          cpu.format = "{usage}% \uf2db";
          memory.format = "{}% \uf0c9";
          battery.format = "{}% BAT";
          backlight.format = "{percent}% \uf185";
        };
      };
      style = ''
        * {
            font-size: 14px;
            font-family: "Fira Code";
        }

        window#waybar {
            background-color: rgba(0,0,0,0);
        }

        label {
            background: #292b2e;
            color: #fdf6e3;
            margin: 0 1px;
            border-radius: 5px;
            padding: 0px 5px 0px 5px;
            border-left: 2px solid grey;
            border-right: 2px solid grey;
        }

        #workspaces {
            background: #1a1a1a;
        }

        #workspaces button {
            padding: 0 2px;
            color: #fdf6e3;
        }

        #workspaces button.focused {
            color: #268bd2;
        }

        #pulseaudio {
            color: #268bd2;
        }

        #memory {
            color: #2aa198;
        }

        #cpu {
            color: #6c71c4;
        }

        #battery {
            color: #859900;
        }

        #disk {
            color: #b58900;
        }
      '';
    };

    swaylock = {
      enable = true;
      settings = {
        color = "000000";
        show-failed-attempts = true;
        indicator-idle-visible = true;
      };
    };
  };
  home.file = {
    ".guile".source = ./files/guile.scm;
    ".sbclrc".source = ./files/sbcl.lisp;
    ".inputrc".source = ./files/inputrc;
    ".gtkrc-2.0".source = ./files/gtk2.ini;
    ".config/gtk-3.0/settings.ini".source = ./files/gtk3.ini;
    ".face".source = builtins.fetchurl {
      url = "https://michal_atlas.srht.site/assets/mlxan/carcass-mountain/portraits/weeping-priest.jpeg";
      sha256 = "sha256:05szymcb5745xm8bcj1d8gyiyf1y5m9x6nijyghqz949haqwgjfl";
    };
    ".local/share/nyxt/bookmarks.lisp".source = ./files/nyxt/bookmarks.lisp;
    ".config/nyxt/config.lisp".source = ./files/nyxt/init.lisp;
    ".unison/default.prf".text = ''
      root=/home/michal_atlas
      root=ssh:////home/michal_atlas
      path=Sync
      path=Documents
      path=cl
      path=Zotero
      auto=true
      log=true
      sortbysize=true
    '';
  };
  xsession.numlock.enable = true;
  programs.home-manager.enable = true;

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    emacs = {
      enable = true;
      package = pkgs.atlas-emacs;
      defaultEditor = true;
      client.enable = true;
      socketActivation.enable = true;
    };
    swayidle = {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock";
        }
        {
          event = "after-resume";
          command = "${pkgs.sway}/bin/swaymsg \"\output * dpms on\"";
        }
      ];
      timeouts = [
        {
          timeout = 1200;
          command =
            "${pkgs.sway}/bin/swaymsg \"output * dpms off\"";
        }
      ];
    };
    mako = {
      enable = true;
      defaultTimeout = 10000;
      maxVisible = 10;
    };
  };

  wayland.windowManager.sway = import ./sway.nix { inherit pkgs; inherit lib; };

  home.packages =
    [
      pkgs.atlas-emacs
    ] ++ import ./packages.nix pkgs;

  systemd.user.tmpfiles.rules = [
    "e /home/michal_atlas/Downloads - - - 2d"
    "e /home/michal_atlas/tmp - - - 2d"
  ];
}
