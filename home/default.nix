nixpkgs:
{ pkgs, lib, ... }:
let
  inherit (lib.hm.gvariant) mkTuple;
  # my-emacs = nixpkgs.emacsWithPackagesFromUsePackage {
  #   alwaysEnsure = true;
  #   config = ./dotfiles/emacs.el;
  #   package = nixpkgs.emacsGit;
  # };
in
{
  home.username = "michal_atlas";
  home.homeDirectory = "/home/michal_atlas";
  programs.git = {
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
  };

  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "22.11";
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      nix-direnv.enable = true;
      enable = true;
    };
    autojump = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      profileExtra = "keychain";
      enable = true;
      enableVteIntegration = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      autocd = true;
      history.ignoreDups = true;
      initExtra = ''
        function cheat { curl "cheat.sh/$@"' }
      '';
      localVariables = {
        BROWSER = "nyxt";
        EDITOR = "emacsclient -n -c";
        ALTERNATE_EDITOR = "";
        TERM = "xterm-256color";
        MOZ_ENABLE_WAYLAND = "1";
        MOZ_USE_XINPUT2 = "1";
        GRIM_DEFAULT_DIR = "~/tmp";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        PATH = "$PATH:$HOME/.nix-profile/bin/:$HOME/bin/";
        GUILE_LOAD_PATH = "$GUILE_LOAD_PATH:$HOME/bin";
        XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/michal_atlas/.local/share/flatpak/exports/share";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    exa = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
  };
  home.file = {
    # ".config/doom/init.el".source = ./dotfiles/init.el;
    # ".config/doom/config.el".source = ./dotfiles/config.el;
    # ".config/doom/packages.el".source = ./dotfiles/packages.el;
    # ".emacs.d/eshell/aliases".source = ./dotfiles/ealias;
    ".guile".source = ./files/guile.scm;
    # ".mbsyncrc".source = ./dotfiles/mbsyncrc;
    ".sbclrc".source = ./files/sbcl.lisp;
    ".config/common-lisp/source-registry.conf".source = ./files/source-registry.lisp;
    #   ./dotfiles/cl-src-registry.conf;
  };
  xsession.numlock.enable = true;
  programs.home-manager.enable = true;

  services.emacs = {
    enable = true;
    package = nixpkgs.emacsPgtk;
    defaultEditor = true;
    client.enable = true;
  };
  home.packages = with pkgs;
    [
      nixpkgs.emacsPgtk
      (import ./pkgs/mystic.nix pkgs)
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
    "org/gnome/shell/peripherals/touchpad" = { tap-to-click = true; };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Super>t";
        command = ''emacsclient -c -e "(eshell-new)"'';
        name = "TERM";
      };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
      {
        binding = "<Super>Return";
        command = ''emacsclient -c'';
        name = "EMACS";
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
  };
}
