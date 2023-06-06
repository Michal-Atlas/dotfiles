pkgs:
with pkgs;
[
  acl2-minimal
  arandr
  atlas-emacs
  audacity
  bat
  bc
  borgbackup
  btop
  btrfs-progs
  caprine-bin
  carp
  ccls
  chicken
  cifs-utils
  cmake
  cryptsetup
  direnv
  discord
  dotnet-sdk
  element-desktop-wayland
  feh
  file
  fira-code
  font-awesome
  fzf
  gallery-dl
  gcc
  gdb
  gerbil
  ghc
  gimp
  gnumake
  gnupg
  gparted
  graphviz
  guile
  gzdoom
  heroic
  htop
  inkscape
  isync
  jetbrains-mono
  keepassxc
  kobodeluxe
  krita
  lagrange
  legendary-gl
  libgccjit
  libreoffice
  libtool
  maxima
  meson
  minecraft
  mosh
  mpv
  mu
  mystic
  neofetch
  nerdfonts
  nixfmt
  nmap
  ocaml
  ocamlPackages.merlin
  okular
  openmw-tes3mp
  pandoc
  patchelf
  picard
  pinentry-curses
  pkg-config
  qt5.qtbase
  racket
  shotwell
  spotify
  steam
  steam-run
  superTux
  superTuxKart
  swiProlog
  taisei
  telegram-desktop
  texlive.combined.scheme-full
  thunderbird
  tldr
  transmission-remote-gtk
  tree
  unzip
  uqm
  valgrind
  vim
  virt-manager
  vlc
  vscode
  wesnoth
  wget
  wineWowPackages.stable
  wxmaxima
  xclip
  xdot
  xonotic
  xorg.xrandr
  yt-dlp
  zotero
] ++ (with gnomeExtensions; [
  all-ip-addresses
  appindicator
  awesome-tiles
  browser-tabs
  bubblemail
  color-picker
  containers
  cpudots
  disk-usage
  espresso
  gnome-clipboard
  night-theme-switcher
]) ++ [
  (pkgs.python3.withPackages
    (ps: with ps; [ dbus-python ipython pygments python ]))
  (pkgs.sbcl.withPackages (ps:
    with ps; [
      alexandria
      cffi
      cl-autowrap
      cl-fuse-meta-fs
      cl-strings
      coleslaw
      collectors
      eclector
      harmony
      linedit
      lparallel
      mcclim
      mcclim-layouts
      optima
      parenscript
      parser-combinators
      s-xml
      screamer
      serapeum
      series
      sycamore
      tailrec
      tar
      terminfo
      trees
      unix-opts
      yacc
    ]))
]
