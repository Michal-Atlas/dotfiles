pkgs:
with pkgs;
[
  rclone
  protonmail-desktop
  openssl
  protonvpn-gui
  nethogs
  brave
  gmic
  nix-prefetch
  nurl
  nixfmt-rfc-style
  xmlstarlet
  ipfs
  haskell-language-server
  gnome-frog
  hieroglyphic
  halftone
  citations
  gnome-decoder
  meld
  lorem
  ascii-draw
  foliate
  video-trimmer
  caprine-bin
  teams-for-linux
  cachix
  ani-cli
  graphs
  komikku
  mousai
  newsflash
  gnome-podcasts
  gnome.polari
  gnome-secrets
  textpieces
  tangram
  wike
  boxes
  nvd
  nix-tree
  nix-melt
  nix-diff
  nix-output-monitor
  nurl
  manix
  apostrophe
  lsof
  cht-sh
  hut
  wireshark
  dig
  whatsapp-for-linux
  racket
  clang-tools
  jq
  (hiPrio gcc)
  acl
  alejandra
  audacity
  bat
  blender
  btrfs-progs
  ccls
  cifs-utils
  clang
  cmake
  compsize
  cryptsetup
  direnv
  discord
  ed
  element-desktop
  feh
  ffmpeg
  file
  fzf
  gdb
  ghc
  gimp
  git
  gnumake
  gnupg
  gparted
  gprolog
  graphviz
  guile
  gzdoom
  heroic
  htop
  imagemagick
  indent
  inkscape
  inotify-tools
  isync
  jetbrains.clion
  jetbrains.idea-ultimate
  jetbrains.rust-rover
  kobodeluxe
  krita
  lagrange
  lazygit
  libreoffice
  libtool
  linuxPackages.perf
  maxima
  mosh
  mpv
  nil
  nix
  nmap
  nodejs
  openmw
  p7zip
  pandoc
  patchelf
  pkg-config
  playerctl
  prismlauncher
  rlwrap
  rsync
  screen
  spotify
  steam-run
  superTux
  superTuxKart
  taisei
  telegram-desktop
  texlive.combined.scheme-full
  tldr
  qbittorrent
  tree
  unison-ucm
  unzip
  uqm
  valgrind
  virt-manager
  vlc
  wesnoth
  wget
  wineWowPackages.full
  winetricks
  wl-clipboard
  xdg-utils
  xdot
  xonotic
  xxd
  yt-dlp
  okular
  zotero
]
++ (with gnomeExtensions; [
  appindicator
  mpris-label
  (pano.overrideAttrs {
    version = "23-alpha2";
    src = fetchzip {
      name = "pano-src";
      url = "https://github.com/oae/gnome-shell-pano/releases/download/v23-alpha2/pano@elhan.io.zip";
      sha256 = "sha256-Y8WgVUHX094RUwYKdt7OROPZMl3dakK0zOU9OTdyqxc=";
      stripRoot = false;
    };
  })
])
++ [
  (pkgs.python311.withPackages (
    ps: with ps; [
      dbus-python
      ipython
      matplotlib
      numpy
      pygments
      python
      scipy
    ]
  ))
]
++ (
  let
    packageSet =
      ps: with ps; [
        alexandria
        cffi
        cl-autowrap
        cl-conspack
        cl-css
        cl-fuse-meta-fs
        cl-strings
        cl-who
        clingon
        clsql
        coleslaw
        collectors
        dbd-sqlite3
        eclector
        generators
        harmony
        hunchentoot
        iterate
        linedit
        log4cl
        lparallel
        mcclim
        mcclim-layouts
        mito
        optima
        parenscript
        parser-combinators
        s-xml
        screamer
        serapeum
        series
        str
        sycamore
        tailrec
        tar
        terminfo
        trees
        unix-opts
        yacc
      ];

  in

  (builtins.map (lisp: lisp.withPackages packageSet) (with pkgs; [ sbcl ]))
  ++ [
    ecl
    abcl
    chez
  ]

)
