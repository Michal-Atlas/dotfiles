{lib, ...}: let
  inherit (lib.hm.gvariant) mkTuple;
in {
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "nightthemeswitcher@romainvigier.fr"
        "gnome-extension-all-ip-addresses@havekes.eu"
        "color-picker@tuberry"
        "espresso@coadmunkee.github.com"
        "gnome-clipboard@b00f.github.io"
      ];
    };
    "org/gnome/desktop/peripherals/touchpad" = {tap-to-click = true;};
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/term/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/emacs/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/browser/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/recon/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/term" = {
      binding = "<Super>t";
      command = "kgx";
      name = "TERM";
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
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files" = {
      binding = "<Super>n";
      command = "nautilus";
      name = "FILES";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/recon" = {
      binding = "<Super>u";
      command = "kgx -e 'cd $HOME/cl/dotfiles; nix develop -c recon'";
      name = "RECON";
    };
    "org/gnome/desktop/background" = {
      picture-uri = builtins.fetchurl {
        url = "https://www.gnu.org/graphics/o_espirito_da_liberdade.fondo.big.png";
        sha256 = "sha256:0ipqb8ssz2fs2cwdwp1cvbrsz27n40478bh8h9x9gpbdy2376nzw";
      };
      picture-uri-dark = builtins.fetchurl {
        url = "https://www.gnu.org/graphics/techy-gnu-tux-bivouac-large.jpg";
        sha256 = "sha256:13934pa275b6s27gja545bwic6fzhjb2y6x5bvpn30vmyva09rm0";
      };
    };
    "org/gnome/desktop/input-sources" = {
      sources = [(mkTuple ["xkb" "us"]) (mkTuple ["xkb" "cz+ucw"])];
      xkb-options = ["grp:caps_switch" "lv3:ralt_switch" "compose:rctrl-altgr"];
    };
    "org/gnome/system/location" = {enabled = true;};
    "org/gnome/shell/extensions/nightthemeswitcher/time" = {
      manual-schedule = false;
    };
    "org/gnome/desktop/wm/preferences" = {focus-mode = "sloppy";};
    "org/gnome/settings-daemon/plugins/color" = {night-light-enabled = true;};
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "spotify.desktop"
        "discord.desktop"
        "org.keepassxc.KeePassXC.desktop"
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

    "org/gnome/shell/app-switcher" = {current-workspace-only = true;};
  };
}
