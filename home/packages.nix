{ pkgs, ... }:
with pkgs; [
  # clang
  # mathematica
  arandr
  audacity
  bat
  bc
  btop
  btrfs-progs
  chicken
  cifs-utils
  cmake
  cryptsetup
  direnv
  discord
  dotnet-sdk
  feh
  file
  fira-code
  firefox
  fzf
  gcc
  gdb
  gimp
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
  transmission-remote-gtk
  tree
  unzip
  valgrind
  vim
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
])
# ++
# (with lispPackages; [
#   defstar
#   serapeum
#   alexandria
# ])
