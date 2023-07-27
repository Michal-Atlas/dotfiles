(define-module (system)
  #:use-module (atlas packages emacs-xyz)
  #:use-module (atlas services btrfs)
  #:use-module (atlas services morrowind)
  #:use-module (gnu services cuirass)
  #:use-module (gnu system setuid)
  #:use-module (gnu)
  #:use-module (guix packages)
  #:use-module (guixrus packages emacs)
  #:use-module (nongnu packages emacs)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu services vpn)
  #:use-module (nongnu system linux-initrd)
  #:use-module (atlas utils services)
  #:use-module (ice-9 textual-ports)
  #:use-module (ice-9 popen))

(define (getlabel system)
  (chdir (dirname (current-filename)))
  (string-join
   (list
    (operating-system-default-label system)
    (string-trim-both
     (get-string-all
      (open-pipe* OPEN_READ
                  "git" "log" "-1" "--pretty=%B"))))
   " - "))

(use-package-modules
 admin
 bittorrent
 certs
 code
 compression
 cups
 databases
 disk
 emacs
 emacs-xyz
 file
 fonts
 fontutils
 freedesktop
 games
 ghostscript
 gnome
 gnupg
 gnuzilla
 graphviz
 haskell-xyz
 image
 image-viewers
 kde
 kde-frameworks
 linux
 lisp
 lisp-xyz
 ocaml
 package-management
 password-utils
 pkg-config
 pulseaudio
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

(use-service-modules
 admin
 audio
 cups
 databases
 desktop
 docker
 file-sharing
 linux
 mcron
 messaging
 networking
 nix
 pm
 sddm
 shepherd
 ssh
 syncthing
 virtualization
 vpn
 xorg)

(operating-system
 (host-name (hostname))
 (kernel linux)
 (initrd microcode-initrd)
 (label (getlabel this-operating-system))
 (users (list (user-account
	       (name "michal_atlas")
	       (comment "Michal Atlas")
	       (group "users")
	       (home-directory "/home/michal_atlas")
	       (supplementary-groups
	        '("wheel" "netdev" "audio" "docker"
	          "video" "libvirt" "kvm" "tty" "transmission")))))
 (packages
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
   %base-packages))
 (firmware
  (@host
   linux-firmware
   #:hydra amdgpu-firmware))
 (locale "en_US.utf8")
 (timezone "Europe/Prague")
 (services
  (append
   (@host
    #:hydra
    (&s cuirass
        (interval (* 60 60))
        (host "0.0.0.0")
        (use-substitutes? #t)
        (specifications
         #~(list (specification
                  (name "atlas")
                  (build '(channels atlas))
                  (channels
                   (cons
                    (channel
                     (name 'atlas)
                     (url "https://git.sr.ht/~michal_atlas/guix-channel")
                     (introduction
                      (make-channel-introduction
                       "f0e838427c2d9c495202f1ad36cfcae86e3ed6af"
                       (openpgp-fingerprint
                        "D45185A2755DAF831F1C3DC63EFBF2BBBB29B99E"))))
                    %default-channels))))))
    #:hydra
    (&s hurd-vm
        (disk-size (* 16 (expt 2 30)))
        (memory-size 2048))
    #:hydra
    (&s tes3mp-server)
    #:hydra
    (&s btrfs-autosnap
        (specs
         (list (btrfs-autosnap-spec
                (name "tes3mp")
                (retention 31)
                (schedule "0 9 * * *")
                (path "/var/lib/tes3mp")))))
    (zerotier-one-service)
    (&s pam-limits #:config
        (list
         (pam-limits-entry "*" 'both 'nofile 524288)))

    (+s hosts
        (list (host "200:ac59:de15:abe5:650e:7139:f561:c2fb" "hydra")
              (host "201:12bb:d969:58b6:f1d2:1142:e377:d99c" "dagon"))))
   (macromap
    &s
    (openssh)
    (gpm)
    (screen-locker
     (name "swaylock")
     (program (file-append swaylock
                           "/bin/swaylock"))
     (using-setuid? #f)
     (using-pam? #t))
    (docker)
    (yggdrasil
     (autoconf? #t)
     (json-config
      '((peers .
	       #(;; Czechia
	         "tls://[2a03:3b40:fe:ab::1]:993"
	         "tls://37.205.14.171:993"
	         ;; Germany
	         "tcp://193.107.20.230:7743")))))
    (tlp
     (cpu-boost-on-ac? #t)
     (wifi-pwr-on-bat? #t))

    (btrfs-autosnap
     (specs
      (list
       (btrfs-autosnap-spec
        (name "frequent")
        (retention 4)
        (schedule "*/15 * * * *")
        (path "/home"))
       (btrfs-autosnap-spec
        (name "hourly")
        (retention 24)
        (schedule "0 * * * *")
        (path "/home"))
       (btrfs-autosnap-spec
        (name "daily")
        (retention 7)
        (schedule "0 9 * * *")
        (path "/home"))
       (btrfs-autosnap-spec
        (name "weekly")
        (retention 5)
        (schedule "0 0 * * 0")
        (path "/home"))
       (btrfs-autosnap-spec
        (name "monthly")
        (retention 12)
        (schedule "0 0 1 * *")
        (path "/home")))))
    (inputattach)
    (qemu-binfmt
     (platforms (lookup-qemu-platforms "arm" "aarch64" "riscv64")))
    (libvirt
     (unix-sock-group "libvirt")
     (tls-port "16555"))
    (virtlog (max-clients 1000))
    (cups
     (web-interface? #t)
     (extensions
      (list cups-filters hplip-minimal)))
    (guix-publish
     (host "0.0.0.0")
     (advertise? #t))
    (transmission-daemon
     (rpc-bind-address "127.0.0.1")
     (ratio-limit-enabled? #t))
    (postgresql)
    (nix (extra-config
          '("experimental-features = nix-command flakes\n"
            "trusted-users = @wheel\n")))
    (bluetooth)
    (ipfs (gateway "/ip4/0.0.0.0/tcp/8080"))
    (quassel))
   (modify-services %desktop-services
                    (delete gdm-service-type)
                    (guix-service-type configuration =>
                                       (guix-configuration
                                        (discover? #t)
                                        (substitute-urls
                                         (cons "https://substitutes.nonguix.org"
                                               %default-substitute-urls))
                                        (authorized-keys
                                         (append (list
                                                  (plain-file "non-guix.pub"
                                                              "(public-key (ecc (curve Ed25519) (q #926B78EBA9416220CA0AFA2EAEC8ED99FC9E9C03AF11CD08AE6F8192BCF68673#)))")
                                                  (plain-file "hydra.pub"
                                                              "(public-key (ecc (curve Ed25519) (q #51C7C5CF4DA2EF64351B7AFE4998058F454622B8493EC6C96DDA8A2681EE5A2D#)))")
                                                  (plain-file "dagon.pub"
                                                              "(public-key (ecc (curve Ed25519) (q #F5E876A29802796DBA7BAD8B7C0FEE90BDD784A70CB2CC8A1365A47DA03AADBD#)))"))
                                                 %default-authorized-guix-keys)))))))
 (keyboard-layout
  (keyboard-layout "us,cz" ",ucw" #:options
		   '("grp:caps_switch" "grp_led"
		     "lv3:ralt_switch" "compose:rctrl-altgr")))
 (setuid-programs
  (append (list (setuid-program
		 (program (file-append cifs-utils "/sbin/mount.cifs"))))
	  %setuid-programs))
 (mapped-devices
  (@host-append
   #:dagon
   (let* ((rpool-lvm (lambda (lv)
                       (mapped-device
                        (source "rpool")
                        (target (string-append "rpool-" lv))
			(type lvm-device-mapping))))
          (lvm-maps
           (map rpool-lvm
                '("home" "root" "swap"))))
     (append
      lvm-maps
      (list
       (mapped-device
        (source "/dev/mapper/rpool-home")
        (target "rpool-home-decrypted")
        (type luks-device-mapping)))))))
 (swap-devices
  (@host
   #:dagon (swap-space
	    (target "/dev/mapper/rpool-swap")
	    (dependencies mapped-devices))
   #:hydra (swap-space
	    (target (file-system-label "SWAP")))))
 (file-systems
  (append %base-file-systems
          (@host
           #:dagon (file-system
	            (mount-point "/")
	            (device "/dev/mapper/rpool-root")
	            (type "btrfs")
	            (dependencies mapped-devices))
           #:dagon (file-system
                    (mount-point "/home")
                    (device "/dev/mapper/rpool-home-decrypted")
                    (type "btrfs")
                    (dependencies mapped-devices))
           #:dagon (file-system
                    (mount-point "/boot/efi")
                    (device (uuid "D762-6C63" 'fat32))
                    (type "vfat"))
           #:hydra (file-system
                    (mount-point "/boot/efi")
                    (device (file-system-label "EFIBOOT"))
                    (type "vfat"))
           #:hydra (file-system
                    (mount-point "/")
                    (device (uuid
                             "e2f2bd08-7962-4e9d-a22a-c66972b7b1e3"
                             'btrfs))
                    (options
                     (alist->file-system-options '(("subvol" . "@guix"))))
                    (type "btrfs"))
           #:hydra (file-system
                    (mount-point "/home")
                    (device (uuid
                             "e2f2bd08-7962-4e9d-a22a-c66972b7b1e3"
                             'btrfs))
                    (options
                     (alist->file-system-options '(("subvol" . "@home"))))
                    (type "btrfs"))
           #:hydra (file-system
                    (mount-point "/GAMES")
                    (device (file-system-label "VAULT"))
                    (options
                     (alist->file-system-options '(("subvol" . "@games"))))
                    (type "btrfs"))
           #:hydra (file-system
                    (mount-point "/var/lib/ipfs")
                    (device (file-system-label "VAULT"))
                    (options
                     (alist->file-system-options '(("subvol" . "@ipfs"))))
                    (type "btrfs"))
           #:hydra (file-system
                    (mount-point "/DOWNLOADS")
                    (device (file-system-label "VAULT"))
                    (options
                     (alist->file-system-options '(("subvol" . "@downloads"))))
                    (type "btrfs"))
           #:hydra (file-system
                    (mount-point "/var/lib/transmission-daemon/downloads/")
                    (device (file-system-label "VAULT"))
                    (options
                     (alist->file-system-options '(("subvol" . "@torrents"))))
                    (type "btrfs")))))
 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets `("/boot/efi"))))
 (name-service-switch %mdns-host-lookup-nss))

