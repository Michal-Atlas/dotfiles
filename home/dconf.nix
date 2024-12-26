{ lib, ... }:
let
  inherit (lib.hm.gvariant) mkTuple mkUint32;
in
{
  dconf.settings = {
    "org/gtk/settings/file-chooser" = {
      clock-format = "24h";
    };
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gnome/shell/extensions/pano" = {
      play-audio-on-copy = false;
      send-notification-on-copy = false;
    };
    "org/gnome/shell/extensions/mpris-label" = {
      auto-switch-to-most-recent = true;
    };
    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 600;
    };
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/term/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/emacs/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/browser/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/recon/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/spotify/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/term" = {
      binding = "<Super>t";
      command = "alacritty -e tmux";
      name = "TERM";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/spotify" = {
      binding = "<Super><Shift>s";
      command = "spotify";
      name = "SPOTIFY";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/emacs" = {
      binding = "<Super>Return";
      command = "emacsclient -c";
      name = "EMACS";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/browser" = {
      binding = "<Super>f";
      command = "nyxt";
      name = "BROWSER";
    };
    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "us"
        ])
        (mkTuple [
          "xkb"
          "cz+ucw"
        ])
      ];
      xkb-options = [
        "grp:caps_switch"
        "lv3:ralt_switch"
        "compose:rctrl-altgr"
      ];
    };
    "org/gnome/system/location" = {
      enabled = true;
    };
    "org/gnome/shell/extensions/nightthemeswitcher/time" = {
      manual-schedule = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "spotify.desktop"
        "discord.desktop"
        "fi.skyjake.Lagrange.desktop"
        "zotero.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/Console" = {
      use-system-font = true;
      # Bat is unreadable
      # theme = "auto";
      ignore-scrollback-limit = true;
      audible-bell = false;
    };

    "org/gabmus/gfeeds" = {
      show-read-items = false;
      show-empty-feeds = false;
      refresh-on-startup = true;
      feeds = builtins.toJSON {
        "https://www.smbc-comics.com/comic/rss" = { };
        "https://xkcd.com/rss.xml" = { };
        "https://the-dam.org/rss.xml" = { };
        "https://fsf.org/blogs/RSS" = { };
        "https://blog.tecosaur.com/tmio/rss.xml" = { };
        "https://guix.gnu.org/feeds/blog.atom" = { };
        "https://vkc.sh/feed/" = { };
      };
    };
  };
}
