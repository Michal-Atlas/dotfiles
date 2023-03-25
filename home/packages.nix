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
  ccls
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
  neofetch
  nix-alien
  nix-output-monitor
  nixfmt
  nmap
  okular
  openmw
  #openmw-tes3mp.override
  pandoc
  patchelf
  picard
  pinentry-curses
  pkg-config
  racket
  rare
  sbcl
  shotwell
  steam
  superTux
  superTuxKart
  swiProlog
  taisei
  texlive.combined.scheme-full
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
