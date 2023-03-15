{ config, pkgs, home-manager, emacs-overlay, ... }:

{
  home.username = "michal_atlas";
  home.homeDirectory = "/home/michal_atlas";
  programs.git = {
    enable = true;
    userName = "Michal Atlas";
    userEmail = "michal_atlas+git@posteo.net";
  };

  programs.emacs = {
    enable = true;
    # package = pkgs.emacsWithPackagesFromUsePackage {
    #   package = pkgs.emacs;
    #   alwaysEnsure = true;
    #   config = ./emacs.el;
    #   extraEmacsPackages = epkgs: [ epkgs.use-package ];
    # };
  };

  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "22.11";
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
  home.sessionVariables = { EDITOR = "emacs"; };
  home.shellAliases.gx = "nix-env";
  programs.bash.initExtra = ''
    recon () { sudo sh -c 'nixos-rebuild switch -I nixos-config=$HOME/dotfiles/configuration.nix |& nom'; }
  '';
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
  home.packages = with pkgs; [
    rare
    legendary-gl
    nixfmt
    firefox
    thunderbird
    gparted
    jetbrains.clion
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
    python
    python39Packages.ipython
    mosh
    gnupg
    direnv
    xclip
    fasd
    bat
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
    wine
    nix-output-monitor
    minecraft
    # mathematica
    cryptsetup
    keepassxc
    valgrind
  ];
}
