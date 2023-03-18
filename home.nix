{ pkgs, lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
  myEm = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (epkgs:
    with epkgs; [
      #hackles
      #mode-icons
      #org-roam
      #org-roam-timestamps
      #org-roam-ui
      #parinfer
      #savehist
      ac-geiser
      ace-window
      adaptive-wrap
      all-the-icons
      all-the-icons-dired
      anzu
      auctex
      auto-complete
      avy
      browse-kill-ring
      calfw
      circe
      company
      company-box
      consult
      consult-org-roam
      consult-yasnippet
      crux
      csv
      csv-mode
      dashboard
      debbugs
      direnv
      dmenu
      docker
      dockerfile-mode
      doom-modeline
      ediprolog
      eglot
      elfeed
      elpher
      embark
      ement
      emms
      engrave-faces
      esh-autosuggest
      eshell-prompt-extras
      eshell-syntax-highlighting
      eshell-z
      evil
      exwm
      flycheck
      flycheck-haskell
      frames-only-mode
      gdscript-mode
      geiser
      geiser-guile
      geiser-racket
      gemini-mode
      git-gutter
      go-mode
      haskell-mode
      helpful
      highlight-indent-guides
      highlight-indentation
      htmlize
      hydra
      iedit
      lsp-mode
      lsp-ui
      magit
      magit-todos
      marginalia
      mastodon
      monokai-theme
      multi-term
      multiple-cursors
      nix-mode
      nixos-options
      nov
      on-screen
      orderless
      org
      org-fragtog
      org-modern
      org-roam
      org-roam-ui
      org-superstar
      ox-gemini
      paredit
      password-generator
      password-store
      password-store-otp
      pdf-tools
      pg
      projectile
      racket-mode
      rainbow-delimiters
      rainbow-identifiers
      realgud
      rustic
      slime
      sly
      ssh-agency
      stumpwm-mode
      stumpwm-mode
      swiper
      tldr
      tramp
      undo-tree
      use-package
      use-package
      vertico
      vterm
      which-key
      xah-fly-keys
      xkcd
      yaml-mode
      yasnippet
      yasnippet
      yasnippet-snippets
      yasnippet-snippets
      zerodark-theme
    ]);
in {
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
  programs.bash = {
    enable = true;
    initExtra = ''
      recon () { sudo nixos-rebuild switch --flake .#$(hostname); }
      cheat () { curl "cheat.sh/$@"; }
    '';
  };
  programs.direnv.enable = true;
  programs.autojump.enable = true;

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
  };
  home.file.".emacs.d/init.el".source = ./emacs.el;

  home.file.".guile".source = ./guile;
  home.file.".mbsyncrc".source = ./mbsyncrc;
  home.file.".sbclrc".source = ./sbclrc;
  home.file.".config/common-lisp/source-registry.conf".source =
    ./cl-src-registry.conf;

  home.file.".config/sway/config".source = ./sway.cfg;
  xsession.numlock.enable = true;
  programs.home-manager.enable = true;
  services.emacs = {
    enable = true;
    package = myEm;
  };
  home.packages = with pkgs; [
    myEm
    # clang
    # mathematica
    arandr
    audacity
    bat
    bc
    btrfs-progs
    chicken
    cifs-utils
    cmake
    cryptsetup
    direnv
    discord
    dotnet-sdk
    exa
    fasd
    feh
    file
    fira-code
    firefox
    fzf
    gcc
    gdb
    gimp
    gnomeExtensions.appindicator
    gnomeExtensions.night-theme-switcher
    gnumake
    gnupg
    gparted
    graphviz
    gzdoom
    htop
    inkscape
    isync
    jetbrains-mono
    jetbrains.clion
    jetbrains.datagrip
    jetbrains.rider
    keepassxc
    kobodeluxe
    lagrange
    legendary-gl
    libreoffice
    lispPackages_new.sbclPackages.linedit
    meson
    minecraft
    mosh
    mpv
    mu
    nix-alien
    nix-output-monitor
    nixfmt
    okular
    openmw
    #openmw-tes3mp.override
    pandoc
    patchelf
    pinentry-curses
    pkg-config
    python310Packages.dbus-python
    python310Packages.ipython
    python310Packages.python
    racket
    rare
    sbcl
    shotwell
    steam
    superTux
    superTuxKart
    swiProlog
    taisei
    texlive.combined.scheme-minimal
    thunderbird
    tree
    unzip
    valgrind
    virt-manager
    vlc
    vscode
    wesnoth
    wineWowPackages.stable
    xclip
    xdot
    xonotic
    xorg.xrandr
    youtube-dl
    zotero
  ];

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
      picture-uri = (builtins.fetchurl {
        url = "https://ift.tt/2UDuBqa";
        sha256 = "sha256:1nj5kj4dcxnzazf46dczfvcj8svhv1lhfa8rxn0q418s3j1w5dcb";
      });
      picture-uri-dark = (builtins.fetchurl {
        url = "https://images.alphacoders.com/923/923968.jpg";
        sha256 = "sha256:0z0awasi0cljvvnbkn9kfvjx7rdr3n68xa5vj3a6y9z9rxxyv1hc";
      });
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
