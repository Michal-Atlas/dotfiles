{ pkgs, ... }:
with pkgs; [
  # clang
  # mathematica
  acl2-minimal
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
  elvish
  feh
  file
  fira-code
  firefox
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
  htop
  inkscape
  isync
  jetbrains-mono
  # jetbrains.clion
  # jetbrains.datagrip
  # jetbrains.rider
  keepassxc
  keychain
  kobodeluxe
  lagrange
  legendary-gl
  libreoffice
  libgccjit
  libtool
  maxima
  wxmaxima
  meson
  minecraft
  mosh
  mpv
  mu
  neofetch
  nerdfonts
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
  roswell
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
++
(with vimPlugins; [
  # elvish-vim
])
