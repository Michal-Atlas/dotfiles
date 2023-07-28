(define-library (system packages)
  (import (scheme base)
          (guile)
          (atlas packages emacs-xyz)
          (guixrus packages emacs)
          (nongnu packages emacs)
          (gnu system)
          (gnu packages admin)
          (gnu packages base)
          (gnu packages bittorrent)
          (gnu packages certs)
          (gnu packages code)
          (gnu packages compression)
          (gnu packages cups)
          (gnu packages databases)
          (gnu packages disk)
          (gnu packages emacs)
          (gnu packages emacs-xyz)
          (gnu packages file)
          (gnu packages fonts)
          (gnu packages fontutils)
          (gnu packages freedesktop)
          (gnu packages games)
          (gnu packages ghostscript)
          (gnu packages gnome)
          (gnu packages gnupg)
          (gnu packages gnuzilla)
          (gnu packages graphviz)
          (gnu packages haskell-xyz)
          (gnu packages image)
          (gnu packages image-viewers)
          (gnu packages kde)
          (gnu packages kde-frameworks)
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
      (cons*
       adwaita-icon-theme
       arandr
       bat
       breeze-icons
       btrfs-progs
       direnv
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
       emacs-hydra
       emacs-iedit
       emacs-magit
       emacs-marginalia
       emacs-markdown-mode
       emacs-monokai-theme
       emacs-multi-term
       emacs-multiple-cursors
       emacs-next-pgtk
       emacs-nix-mode
       emacs-nix-mode
       emacs-on-screen
       emacs-orderless
       emacs-org
       emacs-org-modern
       emacs-org-roam
       emacs-org-roam-ui
       emacs-org-roam-ui
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
       emacs-sly
       emacs-ssh-agency
       emacs-stumpwm-mode
       emacs-stumpwm-mode
       emacs-swiper
       emacs-tldr
       emacs-tuareg
       emacs-undo-tree
       emacs-vertico
       emacs-which-key
       emacs-yaml-mode
       emacs-yasnippet
       emacs-yasnippet
       emacs-yasnippet-snippets
       emacs-zerodark-theme
       fasd
       feh
       file
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
       fontconfig
       foot
       fzf
       git
       (list git "send-email")
       gnu-make
       gnupg
       gparted
       graphviz
       grim
       guix-icons
       hicolor-icon-theme
       htop
       icecat
       indent
       keepassxc
       krita
       lagrange
       mosh
       mpv
       nix
       nss-certs
       nyxt
       okular
       oxygen-icons    
       p7zip
       pandoc
       pavucontrol
       pinentry
       pkg-config
       python-ipython
       recutils
       rsync
       sbcl
       sbcl-alexandria
       sbcl-cffi
       sbcl-cl-yacc
       sbcl-coalton
       sbcl-linedit
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
       sbcl-unix-opts
       screen
       shotwell
       slurp
       sway
       texlive
       texlive-scheme-basic
       texlive-tcolorbox
       transmission-remote-gtk
       tree
       unzip
       virt-manager
       wl-clipboard
       xdg-utils
       xdot
       xonotic
       yt-dlp
       %base-packages))))
