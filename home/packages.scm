(define-library (home packages)
  (import (scheme base)
          (only (guile) cons*)
          (games packages minecraft)
          (games packages the-ur-quan-masters)
          (gnu packages admin)
          (gnu packages base)
          (gnu packages bittorrent)
          (gnu packages certs)
          (gnu packages code)
          (gnu packages commencement)
          (gnu packages compression)
          (gnu packages cups)
          (gnu packages databases)
          (gnu packages disk)
          (gnu packages emacs)
          (gnu packages emacs-xyz)
          (gnu packages file)
          (gnu packages fontutils)
          (gnu packages freedesktop)
          (gnu packages games)
          (gnu packages ghostscript)
          (gnu packages gimp)
          (gnu packages gnome)
          (gnu packages gnuzilla)
          (gnu packages graphviz)
          (gnu packages haskell)
          (gnu packages haskell-apps)
          (gnu packages haskell-xyz)
          (gnu packages image)
          (gnu packages image-viewers)
          (gnu packages inkscape)
          (gnu packages kde)
          (gnu packages linux)
          (gnu packages lisp)
          (gnu packages lisp-xyz)
          (gnu packages messaging)
          (gnu packages ocaml)
          (gnu packages package-management)
          (gnu packages password-utils)
          (gnu packages perl)
          (gnu packages pkg-config)
          (gnu packages pulseaudio)
          (gnu packages python)
          (gnu packages python-xyz)
          (gnu packages rsync)
          (gnu packages rust-apps)
          (gnu packages samba)
          (gnu packages screen)
          (gnu packages shells)
          (gnu packages shellutils)
          (gnu packages ssh)
          (gnu packages terminals)
          (gnu packages terminals)
          (gnu packages tex)
          (gnu packages version-control)
          (gnu packages video)
          (gnu packages virtualization)
          (gnu packages web-browsers)
          (gnu packages wm)
          (gnu packages xdisorg)
          (home packages emacs)
          (home packages fonts)
          (home packages gnome)
          (home packages icons)
          (home packages lisp)
          (nongnu packages mozilla))
  (export %packages)
  (begin
    (define %packages
      (append
       (list `(,git "send-email")
             bat
             btrfs-progs
             direnv
             fasd
             feh
             file
             firefox
             foot
             fzf
             gcc-toolchain
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
             keepassxc
             krita
             lagrange
             mosh
             mpv
             nix
             nyxt
             okular
             p7zip
             pandoc
             pavucontrol
             perl
             pkg-config
             pre-commit
             prismlauncher
             python
             python-ipython
             quaternion
             recutils
             rsync
             screen
             shellcheck
             shotwell
             slurp
             supertux
             supertuxkart
             texlive-scheme-basic
             transmission-remote-gtk
             tree
             unison
             unzip
             uqm
             virt-manager
             wl-clipboard
             xdg-utils
             xdot
             xonotic
             yt-dlp)
       %lisp-packages
       %font-packages
       %icon-packages
       %gnome-packages
       %emacs-packages))))
