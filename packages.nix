pkgs:
with pkgs;
  [
    acl2-minimal
    alejandra
    arandr
    audacity
    bat
    bc
    blender
    browserpass
    btrfs-progs
    caprine-bin
    ccls
    charis-sil
    chicken
    cifs-utils
    cmake
    compsize
    cryptsetup
    dejavu_fonts
    dina-font
    direnv
    discord
    dotnet-sdk
    ed
    element-desktop
    fasd
    feh
    ffmpeg
    file
    fira-code
    fira-code-symbols
    firefox
    font-awesome
    foot
    fzf
    gallery-dl
    gcc
    gdb
    gerbil
    ghc
    gimp
    git
    gnumake
    gnupg
    gnuplot
    godot_4
    gparted
    gprolog
    graphviz
    grim
    guile
    gzdoom
    haskell-language-server
    heroic
    htop
    imagemagick
    indent
    inkscape
    isync
    jetbrains-mono
    jetbrains.clion
    jetbrains.idea-ultimate
    jetbrains.rider
    jetbrains.webstorm
    keepassxc
    kobodeluxe
    krita
    lagrange
    legendary-gl
    liberation_ttf
    libgccjit
    libreoffice
    libtool
    maxima
    meshlab
    meson
    minecraft
    mosh
    mplus-outline-fonts.githubRelease
    mpv
    mu
    mystic
    neofetch
    nix
    nixfmt
    nmap
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    nyxt
    ocaml
    ocamlPackages.merlin
    octave
    okular
    openmw-tes3mp
    p7zip
    pandoc
    patchelf
    pavucontrol
    picard
    pinentry
    pinentry-curses
    pkg-config
    playerctl
    prismlauncher
    qt5.qtbase
    racket
    recutils
    rsync
    rnix-lsp
    screen
    shotwell
    slurp
    source-han-sans
    spotify
    steam-run
    superTux
    superTuxKart
    taisei
    telegram-desktop
    texlive.combined.scheme-full
    thunderbird
    tldr
    transmission-remote-gtk
    tree
    unison
    unzip
    uqm
    valgrind
    vim
    virt-manager
    vlc
    wesnoth
    wget
    wineWowPackages.stable
    wl-clipboard
    wxmaxima
    xclip
    xdg-utils
    xdot
    xonotic
    xorg.xrandr
    yt-dlp
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
    cpudots
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
