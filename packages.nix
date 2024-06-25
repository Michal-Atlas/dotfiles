pkgs:
with pkgs;
  [
    whatsapp-for-linux
    racket
    gitkraken
    clang-tools
    jq
    (hiPrio gcc)
    acl
    acl2-minimal
    alejandra
    audacity
    bat
    blender
    browserpass
    btrfs-progs
    caprine-bin
    ccls
    charis-sil
    cifs-utils
    clang
    cmake
    compsize
    cryptsetup
    direnv
    discord
    dotnet-sdk
    ed
    element-desktop
    feh
    ffmpeg
    file
    firefox
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
    haskell-language-server
    heroic
    htop
    imagemagick
    indent
    inkscape
    inotify-tools
    isync
    jetbrains.clion
    keepassxc
    kobodeluxe
    krita
    lagrange
    lazygit
    legendary-gl
    libgccjit
    libreoffice
    libtool
    linuxPackages.perf
    logseq
    maxima
    mosh
    mpv
    neofetch
    nil
    nix
    nmap
    nodejs
    nyxt
    octave
    openmw-tes3mp
    p7zip
    pandoc
    patchelf
    pinentry
    pkg-config
    playerctl
    prismlauncher
    qt5.qtbase
    rlwrap
    rsync
    screen
    shotwell
    slurp
    spotify
    steam-run
    superTux
    superTuxKart
    taisei
    telegram-desktop
    texlive.combined.scheme-full
    tldr
    transmission-remote-gtk
    tree
    unison-ucm
    unzip
    uqm
    valgrind
    virt-manager
    vlc
    wesnoth
    wget
    wineWowPackages.stable
    wl-clipboard
    wxmaxima
    xdg-utils
    xdot
    xonotic
    xorg.xrandr
    xxd
    yt-dlp
    zathura
    zotero
  ]
  ++ (with gnomeExtensions; [
    all-ip-addresses
    appindicator
    awesome-tiles
    browser-tabs
    bubblemail
    color-picker
    containers
    disk-usage
    espresso
    gnome-clipboard
    night-theme-switcher
    paperwm
  ])
  ++ [
    (pkgs.python311.withPackages
      (ps:
        with ps; [
          dbus-python
          ipython
          matplotlib
          numpy
          pygments
          python
          scipy
        ]))
    (pkgs.sbcl.withPackages (ps:
      with ps; [
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
      ]))
  ]
