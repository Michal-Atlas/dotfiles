(define-library (home packages)
  (import (scheme base)
          (only (guile) cons*)
          (gnu packages terminals)
          (games packages minecraft)
          (home packages emacs)
          (home packages lisp)
          (home packages fonts)
          (home packages icons)
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
          (gnu packages gnome)
          (gnu packages games)
          (gnu packages ghostscript)
          (gnu packages gnuzilla)
          (gnu packages graphviz)
          (gnu packages haskell-apps)
          (gnu packages haskell-xyz)
          (gnu packages image)
          (gnu packages image-viewers)
          (gnu packages kde)
          (gnu packages linux)
          (gnu packages lisp)
          (gnu packages lisp-xyz)
          (gnu packages ocaml)
          (gnu packages package-management)
          (gnu packages password-utils)
          (gnu packages perl)
          (gnu packages pkg-config)
          (gnu packages pulseaudio)
          (gnu packages python-xyz)
          (gnu packages rsync)
          (gnu packages rust-apps)
          (gnu packages samba)
          (gnu packages screen)
          (gnu packages shells)
          (gnu packages shellutils)
          (gnu packages ssh)
          (gnu packages terminals)
          (gnu packages tex)
          (gnu packages version-control)
          (gnu packages video)
          (gnu packages virtualization)
          (gnu packages web-browsers)
          (gnu packages wm)
          (gnu packages xdisorg)
          (nongnu packages mozilla)
          (gnu packages gimp)
          (gnu packages inkscape)
          (games packages the-ur-quan-masters))
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
             gimp
             git
             gnu-make
             gparted
             graphviz
             grim
             htop
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
             python-ipython
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
       %emacs-packages))))