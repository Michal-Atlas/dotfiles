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

  programs = {
    git = {
      enable = true;
      userName = "Michal Atlas";
      userEmail = "michal_atlas+git@posteo.net";
      extraConfig = {
        filter.lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = true;
        };
      };
      delta.enable = true;
    };

    fzf.enable = true;
    dircolors.enable = true;
    keychain.enable = true;
    navi.enable = true;
    direnv = {
      nix-direnv.enable = true;
      enable = true;
    };
    autojump.enable = true;
    zsh = {
      enable = true;
      enableVteIntegration = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      autocd = true;
      history.ignoreDups = true;
      initExtra = ''
        function cheat { curl "cheat.sh/$@" }

        GUIX_PROFILE="$HOME/.config/guix/current"
        . "$GUIX_PROFILE/etc/profile"

        GUIX_PROFILE="$HOME/.guix-profile"
        . "$GUIX_PROFILE/etc/profile"
      '';
      localVariables = {
        MOZ_ENABLE_WAYLAND = "1";
        MOZ_USE_XINPUT2 = "1";
        GRIM_DEFAULT_DIR = "~/tmp";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        EDITOR = "$EDITOR -c -nw";
      };
    };
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
    password-store.enable = true;
    aerc = {
      enable = true;
      extraConfig.general.unsafe-accounts-conf = true;
    };
  };
  home.file = {
    ".guile".source = ./files/guile.scm;
    ".sbclrc".source = ./files/sbcl.lisp;
    ".face".source = builtins.fetchurl {
      url = "https://michal_atlas.srht.site/assets/mlxan/carcass-mountain/portraits/weeping-priest.jpeg";
      sha256 = "sha256:05szymcb5745xm8bcj1d8gyiyf1y5m9x6nijyghqz949haqwgjfl";
    };
    ".local/share/nyxt/bookmarks.lisp".source = ./files/nyxt/bookmarks.lisp;
    ".config/nyxt/config.lisp".source = ./files/nyxt/init.lisp;
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
    password-store-sync = {
      enable = true;
      frequency = "daily";
    };
    pass-secret-service.enable = true;
  };
  home.packages =
    [
      pkgs.atlas-emacs
    ] ++ import ./packages.nix pkgs;

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
    "org/gnome/desktop/peripherals/touchpad" = { tap-to-click = true; };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Super>t";
        command = "kgx";
        name = "TERM";
      };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
      {
        binding = "<Super>Return";
        command = "emacsclient -c";
        name = "EMACS";
      };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" =
      {
        binding = "<Super>f";
        command = "nyxt";
        name = "BROWSER";
      };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" =
      {
        binding = "<Super>n";
        command = "nautilus";
        name = "FILES";
      };
    "org/gnome/desktop/background" = {
      picture-uri = builtins.fetchurl {
        url = "https://ift.tt/2UDuBqa";
        sha256 = "sha256:1nj5kj4dcxnzazf46dczfvcj8svhv1lhfa8rxn0q418s3j1w5dcb";
      };
      picture-uri-dark = builtins.fetchurl {
        url = "https://images.alphacoders.com/923/923968.jpg";
        sha256 = "sha256:0z0awasi0cljvvnbkn9kfvjx7rdr3n68xa5vj3a6y9z9rxxyv1hc";
      };
    };
    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "cz+ucw" ]) ];
      xkb-options =
        [ "grp:caps_switch" "lv3:ralt_switch" "compose:rctrl-altgr" ];
    };
    "org/gnome/system/location" = { enabled = true; };
    "org/gnome/shell/extensions/nightthemeswitcher/time" = {
      manual-schedule = false;
    };
    "org/gnome/desktop/wm/preferences" = { focus-mode = "sloppy"; };
    "org/gnome/settings-daemon/plugins/color" = { night-light-enabled = true; };
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

    "org/gnome/shell/app-switcher" =
      { current-workspace-only = true; };
  };

  accounts.email = {
    accounts =
      {
        "Posteo" = {
          address = "michal_atlas@posteo.net";
          realName = "Michal Atlas";
          primary = true;
          imap.host = "posteo.de";
          aerc.enable = true;
          passwordCommand = "pass email/michal_atlas@posteo.net";
          smtp.host = "posteo.de";
          userName = "michal_atlas@posteo.net";
        };
        # "CTU" = {
        #   address = "zacekmi2@cvut.cz";
        #   realName = "Michal Žáček";
        #   flavor = "outlook.office365.com";
        #   imap.host = "outlook.office365.com";
        #   imapnotify.enable = true;
        #   neomutt.enable = true;
        #   notmuch = { enable = true; neomutt.enable = true; };
        #   offlineimap.enable = true;
        #   passwordCommand = "pass email/zacekmi2@cvut.cz";
        #   smtp.host = "smtp.office365.com";
        #   userName = "zacekmi2@cvut.cz";
        # };
      };
  };
}
