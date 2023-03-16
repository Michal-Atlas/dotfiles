{ self, config, pkgs, emacs-overlay, ... }:

let
  myEm = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (epkgs:
    with epkgs; [
      use-package
      org-roam
      org-roam-ui
      consult-org-roam
      #org-roam-timestamps
      engrave-faces
      go-mode
      use-package
      password-store
      password-store-otp
      org-fragtog
      org-modern
      org-superstar
      highlight-indentation
      #mode-icons
      doom-modeline
      which-key
      rainbow-identifiers
      rainbow-delimiters
      undo-tree
      ace-window
      eshell-prompt-extras
      eshell-syntax-highlighting
      esh-autosuggest
      git-gutter
      #savehist
      anzu
      marginalia
      #org-roam
      #org-roam-ui
      auto-complete
      geiser-racket
      adaptive-wrap
      geiser-guile
      sly
      slime
      geiser
      multiple-cursors
      magit
      helpful
      avy
      browse-kill-ring
      emms
      evil
      exwm
      vertico
      orderless
      consult
      xah-fly-keys
      ac-geiser
      all-the-icons
      all-the-icons-dired
      auctex
      calfw
      circe
      company
      company-box
      crux
      csv
      csv-mode
      dashboard
      debbugs
      direnv
      ediprolog
      elfeed
      elpher
      embark
      ement
      lsp-mode
      lsp-ui
      rustic
      eshell-z
      hydra
      flycheck
      flycheck-haskell
      frames-only-mode
      gdscript-mode
      haskell-mode
      highlight-indent-guides
      htmlize
      iedit
      magit-todos
      monokai-theme
      multi-term
      nix-mode
      on-screen
      ox-gemini
      #parinfer
      paredit
      pdf-tools
      pg
      projectile
      racket-mode
      realgud
      swiper
      tldr
      vterm
      xkcd
      yaml-mode
      yasnippet
      yasnippet-snippets
      zerodark-theme
      gemini-mode
      nov
      dockerfile-mode
      docker
      dmenu
      eglot
      org
      stumpwm-mode
      #hackles
      yasnippet-snippets
      consult-yasnippet
      yasnippet
      tramp
      ssh-agency
      password-generator
      mastodon
      stumpwm-mode
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
    dotnet-sdk
    rare
    legendary-gl
    nixfmt
    firefox
    thunderbird
    gparted
    jetbrains.clion
    jetbrains.datagrip
    jetbrains.rider
    steam
    sbcl
    patchelf
    cifs-utils
    btrfs-progs
    file
    fzf
    pandoc
    texlive.combined.scheme-minimal
    htop
    gcc
    # clang
    gnumake
    cmake
    meson
    python310Packages.python
    python310Packages.ipython
    python310Packages.dbus-python
    mosh
    gnupg
    direnv
    xclip
    fasd
    bat
    zotero
    exa
    pkg-config
    gdb
    chicken
    racket
    swiProlog
    lispPackages_new.sbclPackages.linedit
    vlc
    mpv
    libreoffice
    vscode
    audacity
    feh
    shotwell
    inkscape
    gimp
    fira-code
    jetbrains-mono
    xorg.xrandr
    arandr
    graphviz
    xdot
    tree
    bc
    unzip
    superTuxKart
    wesnoth
    gzdoom
    taisei
    kobodeluxe
    mu
    isync
    lagrange
    youtube-dl
    okular
    discord
    xonotic
    wineWowPackages.stable
    nix-output-monitor
    minecraft
    # mathematica
    cryptsetup
    keepassxc
    valgrind
    virt-manager
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
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
        url = "https://pbs.twimg.com/media/EaOkegwX0Aww2WW.jpg";
        sha256 = "sha256:0972r5d7k70ls87pjrx0s4jqmd2kmhc7f9r9ypa0d8ikqgwpnfhx";
      });
      picture-uri-dark = (builtins.fetchurl {
        url = "https://i.imgur.com/LdaFp48.jpeg";
        sha256 = "sha256:1h12bzll6wfwna3nswdi50cnmcrdx0gl6irgzxg60yvc7izz4kk3";
      });
    };
    "org/gnome/desktop/input-sources" = {
      sources = [ "('xkb', 'us')" "('xkb', 'cz+ucw')" ];
      xkb-options =
        [ "grp:caps_switch" "lv3:ralt_switch" "compose:rctrl-altgr" ];
    };
  };
}
