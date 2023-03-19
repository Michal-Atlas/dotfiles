nixpkgs:
{ pkgs, lib, ... }:
let
  inherit (lib.hm.gvariant) mkTuple;
  my-emacs = nixpkgs.emacsWithPackagesFromUsePackage {
    alwaysEnsure = true;
    config = ./dotfiles/emacs.el;
    package = nixpkgs.emacsGit;
  };
in
{
  home.username = "michal_atlas";
  home.homeDirectory = "/home/michal_atlas";
  programs.git = {
    enable = true;
    userName = "Michal Atlas";
    userEmail = "michal_atlas+git@posteo.net";
  };

  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "22.11";
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
  home.sessionVariables = { EDITOR = "emacs"; };
  home.shellAliases.gx = "nix-env";
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
      enable = true;
      initExtra = ''
        cheat () { curl "cheat.sh/$@"; }
      '';
      enableVteIntegration = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      autocd = true;
      history.ignoreDups = true;
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
    ".emacs.d/init.el".source = ./dotfiles/emacs.el;
    ".guile".source = ./dotfiles/guile;
    ".mbsyncrc".source = ./dotfiles/mbsyncrc;
    ".sbclrc".source = ./dotfiles/sbclrc;
    ".config/common-lisp/source-registry.conf".source =
      ./dotfiles/cl-src-registry.conf;
  };
  xsession.numlock.enable = true;
  programs.home-manager.enable = true;

  services.emacs = {
    enable = true;
    package = my-emacs;
  };
  home.packages = with pkgs;
    [
      my-emacs
      (pkgs.stdenv.mkDerivation (
        let version = "0.3";
        in {
          buildInputs = [ autoconf automake readline texinfo ];
          pname = "mystic";
          inherit version;
          src = fetchFromSourcehut {
            owner = "~michal_atlas";
            repo = "mystic";
            rev = "v${version}";
            sha256 = "sha256-1492bbgYfgbiRd3ahUFlaFFHrk1Scx+oTIjQamQ+m5o=";
          };
          preConfigurePhases = [ "autogen" ];
          autogen = ''
            ./autogen.sh
          '';
        }
      ))
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
      ];
    };
    "org/gnome/shell/peripherals/touchpad" = { tap-to-click = true; };
    "org/gnome/shell/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/shell/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Super>Return";
        command = "kgx";
        name = "TERM";
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