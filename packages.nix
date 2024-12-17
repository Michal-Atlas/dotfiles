pkgs:
with pkgs;
[
  (pkgs.writeShellScriptBin "bootstrap-eduroam" ''
    ${pkgs.python3.withPackages (py: [ py.dbus-python ])}/bin/python ${
      builtins.fetchurl {
        name = "cateduroam.py";
        url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=2904&device=linux&generatedfor=user&openroaming=0";
        sha256 = "sha256:1lnbzbxfwlqzdrsrdkba5rnqwm6aijkw4xjn56rjqyyjib9h2295";
      }
    }
  '')
  (hiPrio gcc)
  # keep-sorted start
  acl
  alejandra
  ani-cli
  apostrophe
  ascii-draw
  audacity
  bat
  blender
  boxes
  btrfs-progs
  cachix
  caprine-bin
  ccls
  cht-sh
  cifs-utils
  citations
  clang
  clang-tools
  cmake
  compsize
  cryptsetup
  dig
  direnv
  discord
  dust
  ed
  element-desktop
  feh
  ffmpeg
  file
  foliate
  fzf
  gdb
  ghc
  gimp
  git
  gmic
  gnome-decoder
  gnome-frog
  gnome-podcasts
  gnome-secrets
  gnumake
  gnupg
  gparted
  gprolog
  graphs
  graphviz
  guile
  gzdoom
  halftone
  haskell-language-server
  heroic
  hieroglyphic
  hut
  imagemagick
  indent
  inkscape
  inotify-tools
  ipfs
  isync
  jetbrains.clion
  jetbrains.datagrip
  jetbrains.goland
  jetbrains.idea-ultimate
  jetbrains.pycharm-professional
  jetbrains.rust-rover
  jetbrains.webstorm
  jq
  kobodeluxe
  komikku
  krita
  lagrange
  lazygit
  libreoffice
  libtool
  linuxPackages.perf
  lorem
  lsof
  manix
  maxima
  meld
  mosh
  mousai
  mpv
  nethogs
  newsflash
  nil
  nix
  nix-diff
  nix-melt
  nix-output-monitor
  nix-prefetch
  nix-tree
  nixfmt-rfc-style
  nmap
  nodejs
  nurl
  nvd
  okular
  onedrive
  openmw
  openssl
  p7zip
  pandoc
  patchelf
  pkg-config
  playerctl
  polari
  prismlauncher
  protonmail-desktop
  protonvpn-gui
  qbittorrent
  racket
  rclone
  rlwrap
  rsync
  screen
  spotify
  sshfs
  steam-run
  superTux
  superTuxKart
  taisei
  tangram
  teams-for-linux
  telegram-desktop
  texlive.combined.scheme-full
  textpieces
  tldr
  tree
  unison-ucm
  unzip
  uqm
  valgrind
  video-trimmer
  virt-manager
  vlc
  vpsfree-client
  wesnoth
  wget
  whatsapp-for-linux
  wike
  wineWowPackages.full
  winetricks
  wireshark
  wl-clipboard
  xdg-utils
  xdot
  xmlstarlet
  xonotic
  xournalpp
  xxd
  yt-dlp
  zotero
  # keep-sorted end
]
++ [
  (pkgs.python311.withPackages (
    ps: with ps; [
      # keep-sorted start
      dbus-python
      ipython
      matplotlib
      numpy
      pygments
      python
      pytorch
      scipy
      transformers
      # keep-sorted end
    ]
  ))
]
++ (
  let
    packageSet =
      ps: with ps; [
        # keep-sorted start
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
        # keep-sorted end
      ];

  in

  (builtins.map (lisp: lisp.withPackages packageSet) (with pkgs; [ sbcl ]))
  ++ [
    ecl
    abcl
    chez
  ]

)
