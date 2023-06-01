pkgs:
with pkgs; [
  # clang
  # mathematica
  acl2-minimal
  arandr
  atlas-emacs
  audacity
  bat
  bc
  borgbackup
  btop
  btrfs-progs
  chicken
  cifs-utils
  ccls
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
  gimp
  gnumake
  gnupg
  gparted
  graphviz
  gzdoom
  guile
  heroic
  htop
  inkscape
  isync
  jetbrains-mono
  # jetbrains.clion
  # jetbrains.datagrip
  # jetbrains.rider
  keepassxc
  kobodeluxe
  lagrange
  legendary-gl
  libreoffice
  libgccjit
  libtool
  maxima
  wxmaxima
  ocamlPackages.merlin
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
  okular
  openmw-tes3mp
  pandoc
  patchelf
  picard
  pinentry-curses
  pkg-config
  qt5.qtbase
  racket
  sbcl
  shotwell
  spotify
  steam
  steam-run
  superTux
  superTuxKart
  swiProlog
  taisei
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
  xclip
  xdot
  xonotic
  xorg.xrandr
  yt-dlp
  zotero
] ++ (with gnomeExtensions; [
  appindicator
  night-theme-switcher
  all-ip-addresses
  awesome-tiles
  browser-tabs
  espresso
  bubblemail
  color-picker
  containers
  cpudots
  disk-usage
  gnome-clipboard
]) ++
(with python310Packages; [
  dbus-python
  ipython
  python
  pygments
])
  # ++
  # (with lispPackages; [
  #   defstar
  #   serapeum
  #   alexandria
  # ])
++
(with vimPlugins; [

])
