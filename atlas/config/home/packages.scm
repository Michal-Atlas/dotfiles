(define-module (atlas config home packages)
  #:use-module (gnu)
  #:use-module (gnu home services)
  #:use-module (atlas combinators)
  #:use-module (games packages minecraft)
  #:use-module (games packages the-ur-quan-masters)
  #:use-module (atlas packages emacs-xyz)
  #:use-module (guixrus packages emacs)
  #:use-module (nongnu packages mozilla))

(use-package-modules
 admin
 base
 bittorrent
 certs
 code
 commencement
 compression
 cups
 curl
 databases
 disk
 ed
 emacs
 emacs-xyz
 file
 fonts
 fontutils
 freedesktop
 games
 gdb
 ghostscript
 gimp
 gnome
 gnome-xyz
 gnuzilla
 graphviz
 haskell
 haskell-apps
 haskell-xyz
 image
 image-viewers
 inkscape
 irc
 kde
 kde-frameworks
 libreoffice
 linux
 lisp
 lisp-xyz
 lsof
 messaging
 ocaml
 package-management
 parallel
 password-utils
 perl
 pkg-config
 pulseaudio
 python
 python-xyz
 rsync
 rust-apps
 samba
 screen
 shells
 shellutils
 ssh
 terminals
 tex
 version-control
 video
 virtualization
 web-browsers
 wm
 xdisorg)

(define-syntax-rule (packages why pkgs ...)
  (hm/+s home-profile why (list pkgs ...)))

(define %lisp-packages
  (packages lisp
         sbcl
         sbcl-alexandria
         sbcl-cffi
         sbcl-cl-yacc
         sbcl-clingon
         sbcl-coalton
         sbcl-iterate
         sbcl-linedit
         sbcl-log4cl
         sbcl-lparallel
         sbcl-mcclim
         sbcl-parenscript
         sbcl-s-xml
         sbcl-serapeum
         sbcl-series
         sbcl-tailrec
         sbcl-tar
         sbcl-terminal-keypress
         sbcl-terminal-size
         sbcl-terminfo
         sbcl-trees
         sbcl-trial
         sbcl-unix-opts))

(define %emacs-packages
  (packages emacs
   emacs-ace-window
   emacs-adaptive-wrap
   emacs-all-the-icons
   emacs-all-the-icons-dired
   emacs-anzu
   emacs-auctex
   emacs-avy
   emacs-bind-map
   emacs-browse-kill-ring
   emacs-calfw
   emacs-cheat-sh
   emacs-circe
   emacs-company
   emacs-consult
   emacs-consult-org-roam
   emacs-consult-yasnippet
   emacs-crux
   emacs-csv
   emacs-csv-mode
   emacs-dashboard
   emacs-debbugs
   emacs-direnv
   emacs-dmenu
   emacs-docker
   emacs-dockerfile-mode
   emacs-doom-modeline
   emacs-eat
   emacs-ediprolog
   emacs-eglot
   emacs-elfeed
   emacs-elpher
   emacs-embark
   emacs-ement
   emacs-engrave-faces
   emacs-eshell-did-you-mean
   emacs-eshell-prompt-extras
   emacs-eshell-syntax-highlighting
   emacs-eshell-vterm
   emacs-fish-completion
   emacs-flycheck
   emacs-flycheck-haskell
   emacs-gdscript-mode
   emacs-geiser
   emacs-geiser-guile
   emacs-gemini-mode
   emacs-git-gutter
   emacs-go-mode
   emacs-guix
   emacs-hackles
   emacs-haskell-mode
   emacs-highlight-indentation
   emacs-htmlize
   emacs-hydra
   emacs-iedit
   emacs-magit
   emacs-marginalia
   emacs-markdown-mode
   emacs-monokai-theme
   emacs-multi-term
   emacs-multiple-cursors
   emacs-pgtk
   emacs-nix-mode
   emacs-on-screen
   emacs-orderless
   emacs-org
   emacs-org-modern
   emacs-org-roam
   emacs-org-superstar
   emacs-ox-gemini
   emacs-paredit
   emacs-password-generator
   emacs-password-store
   emacs-password-store-otp
   emacs-pdf-tools
   emacs-rainbow-delimiters
   emacs-rainbow-identifiers
   emacs-realgud
   emacs-rust-mode
   emacs-scala-mode
   emacs-sly
   emacs-ssh-agency
   emacs-stumpwm-mode
   emacs-swiper
   emacs-tldr
   emacs-undo-tree
   emacs-vertico
   emacs-which-key
   emacs-yaml-mode
   emacs-yasnippet
   emacs-yasnippet-snippets
   emacs-zerodark-theme))

(define %font-packages
  (packages fonts
   font-adobe-source-han-sans
   font-adobe-source-han-sans
   font-awesome
   font-dejavu
   font-fira-code
   font-ghostscript
   font-gnu-freefont
   font-jetbrains-mono
   font-sil-charis
   font-tamzen
   font-wqy-microhei
   font-wqy-zenhei
   font-wqy-zenhei
   fontconfig))

(define %gnome-packages
  (packages gnome
   gnome-shell-extension-appindicator
   gnome-shell-extension-blur-my-shell
   gnome-shell-extension-burn-my-windows
   gnome-shell-extension-clipboard-indicator
   gnome-shell-extension-customize-ibus
   gnome-shell-extension-dash-to-dock
   gnome-shell-extension-dash-to-panel
   gnome-shell-extension-gsconnect
   gnome-shell-extension-hide-app-icon
   gnome-shell-extension-jiggle
   gnome-shell-extension-just-perfection
   ;; gnome-shell-extension-night-theme-switcher
   gnome-shell-extension-noannoyance
   gnome-shell-extension-paperwm
   gnome-shell-extension-radio
   gnome-shell-extension-sound-output-device-chooser
   gnome-shell-extension-topicons-redux
   gnome-shell-extension-transparent-window
   gnome-shell-extension-unite-shell
   gnome-shell-extension-vertical-overview
   gnome-shell-extension-vitals))

(define %icon-packages
  (packages icons
   adwaita-icon-theme
   breeze-icons
   guix-icons
   hicolor-icon-theme
   oxygen-icons))

(define-public %packages
  (compose
   %lisp-packages
   %font-packages
   %icon-packages
   %gnome-packages
   %emacs-packages
   (packages packages
    `(,git "send-email")
    bat
    btrfs-progs
    direnv
    curl
    ed
    fasd
    feh
    file
    firefox
    foot
    fzf
    gcc-toolchain
    gdb
    ghc
    gimp
    git
    gnu-make
    gparted
    graphviz
    grim
    gzdoom
    htop
    icedove/wayland
    indent
    inkscape
    irssi
    keepassxc
    krita
    lagrange
    libreoffice
    lsof
    mosh
    mpv
    nheko
    nix
    nyxt
    okular
    p7zip
    pandoc
    parallel
    pavucontrol
    perl
    pkg-config
    pre-commit
    ;; prismlauncher
    python
    python-ipython
    recutils
    rsync
    screen
    shellcheck
    shotwell
    slurp
    supertux
    supertuxkart
    tealdeer
    texlive-scheme-basic
    transmission-remote-gtk
    tree
    unison
    unzip
    uqm
    virt-manager
    vlc
    wl-clipboard
    xdg-utils
    xdot
    xonotic
    yt-dlp)))
