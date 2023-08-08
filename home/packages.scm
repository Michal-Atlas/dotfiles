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
          (gnu packages gnupg)
          (gnu packages gnuzilla)
          (gnu packages graphviz)
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
          (gnu packages xdisorg))
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
             foot
             fzf
             gcc-toolchain
             git
             gnu-make
             gnupg
             gparted
             graphviz
             grim
             htop
             indent
             keepassxc
             lagrange
             mosh
             mpv
             nix
             nyxt
             okular
             p7zip
             pandoc
             pavucontrol
             pinentry
             pkg-config
             prismlauncher
             python-ipython
             recutils
             rsync
             screen
             shotwell
             slurp
             transmission-remote-gtk
             tree
             unzip
             virt-manager
             wl-clipboard
             xdg-utils
             xdot
             yt-dlp)
       %lisp-packages
       %font-packages
       %icon-packages
       %emacs-packages))))
