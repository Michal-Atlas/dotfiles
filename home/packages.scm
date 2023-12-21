(define-module (home packages)
  #:use-module (gnu home services)
  #:use-module (atlas utils services)
  #:use-module (gnu)
  #:use-module (atlas packages emacs-xyz)
  #:use-module (atlas packages shen)
  #:use-module (guixrus packages emacs)
  #:use-module (nongnu packages mozilla)
  #:use-module (games packages the-ur-quan-masters)
  #:use-module (games packages minecraft)
  #:use-module (guix transformations)
  #:use-module (guix cpu)
  #:use-module ((emacs packages melpa)
                #:select (emacs-shen-elisp))
  #:export (packages-services))

(use-package-modules
 admin
 base
 bittorrent
 certs
 chez
 code
 commencement
 compression
 containers
 cups
 curl
 databases
 dictionaries
 disk
 dns
 ed
 elf
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
 gnuzilla
 graphviz
 haskell
 haskell-apps
 haskell-xyz
 image
 image-viewers
 imagemagick
 inkscape
 irc
 kde
 kde-frameworks
 libreoffice
 linux
 lisp
 lisp-xyz
 lsof
 maths
 messaging
 music
 node
 ocaml
 package-management
 parallel
 password-utils
 perl
 prolog
 pkg-config
 pulseaudio
 python
 python-xyz
 readline
 rdesktop
 rsync
 rust-apps
 samba
 screen
 shells
 shellutils
 skribilo
 ssh
 sync
 telegram
 terminals
 tex
 texlive
 tls
 version-control
 video
 virtualization
 web
 web-browsers
 wine
 wm
 xdisorg)

(define tuning-target (cpu->gcc-architecture (current-cpu)))
(define transform
  (options->transformation
   `((tune . ,tuning-target))))

(define-syntax-rule (packages why pkgs ...)
  (+s home-profile why
      (map
       (lambda (p)
         (if (list? p)
             (cons (transform (car p)) (cdr p))
             (transform p)))
       (list pkgs ...))))

(define packages-services
 (list
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
            sbcl-unix-opts)

  (packages emacs
            emacs-ox-reveal
            emacs-org-re-reveal
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
            emacs-zerodark-theme)

  (packages fonts
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
            font-wqy-zenhei)

  (packages icons
            adwaita-icon-theme
            breeze-icons
            guix-icons
            hicolor-icon-theme
            oxygen-icons)

  (packages texlive
            texlive)

  (packages packages
            `(,isc-bind "utils")
            `(,git "send-email")
            bat
            btrfs-progs
            compsize
            curl
            direnv
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
            git-lfs
            gnu-make
            gparted
            graphviz
            grim
            gzdoom
            htop
            icedove/wayland
            imagemagick
            indent
            inkscape
            inotify-tools
            irssi
            jq
            keepassxc
            krita
            lagrange
            libreoffice
            lsof
            maxima
            mosh
            mpv
            nautilus
            netcat
            nheko
            nix
            node
            nyxt
            okular
            openssl
            p7zip
            pandoc
            parallel
            pass-otp
            patchelf
            pavucontrol
            perl
            pkg-config
            playerctl
            podman
            pre-commit
            prismlauncher
            python
            python-ipython
            recutils
            rlwrap
            rsync
            screen
            shellcheck
            shotwell
            skribilo
            slurp
            supertux
            supertuxkart
            telegram-desktop
            tealdeer
            texlive-scheme-basic
            translate-shell
            transmission-remote-gtk
            tree
            unison
            unzip
            uqm
            virt-manager
            vlc
            wine64
            wl-clipboard
            wtype
            xdg-desktop-portal-wlr
            xdg-utils
            xdot
            xonotic
            yt-dlp)

  (packages shen
            emacs-shen-elisp
            carp
            emacs-carp
            swi-prolog
            chez-scheme
            shen-scheme
            shen-c)))
