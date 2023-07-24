(define-module (system)
  #:use-module (atlas packages emacs-xyz)
  #:use-module (atlas services btrfs)
  #:use-module (atlas services morrowind)
  #:use-module (beaver functional-services)
  #:use-module (beaver system)
  #:use-module (gnu services cuirass)
  #:use-module (gnu system setuid)
  #:use-module (gnu)
  #:use-module (guix packages)
  #:use-module (guixrus packages emacs)
  #:use-module (nongnu packages emacs)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu services vpn)
  #:use-module (nongnu system linux-initrd))

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

(define hostname (make-parameter (vector-ref (uname) 1)))
(define (host-keyword) (symbol->keyword (string->symbol (hostname))))
(define (@host . body)
  (let ((self (host-keyword)))
    (let loop ((body body))
      (if (eq? (car body) self) (cadr body)
          (loop (cddr body))))))

(define (@host-if os host fn)
  ((if (eq? host (host-keyword))
       fn identity)
   os))

((@@ (beaver functional-services) define-os-macros-for) btrfs-autosnap)

(define-public atlas-system-base
  (operating-system
   (host-name #f)
   (kernel linux)
   (initrd microcode-initrd)
   (firmware
    (cons linux-firmware
          (@host #:dagon '()
                 #:hydra (list amdgpu-firmware))))
   (locale "en_US.utf8")
   (timezone "Europe/Prague")
   (services
    (append
     (@host
      #:hydra
      (list
       (service cuirass-service-type
                (cuirass-configuration
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
                             %default-channels)))))))
       (service hurd-vm-service-type
        (hurd-vm-configuration
         (disk-size (* 16 (expt 2 30)))
         (memory-size 2048)))
       (service tes3mp-server-service-type)
       (service btrfs-autosnap-service-type
        (btrfs-autosnap-configuration
         (specs
          (list (btrfs-autosnap-spec
                 (name "tes3mp")
                 (retention 31)
                 (schedule "0 9 * * *")
                 (path "/var/lib/tes3mp")))))))
      #:dagon '())
     (cons*
      (zerotier-one-service)
      (service pam-limits-service-type
               (list
                (pam-limits-entry "*" 'both 'nofile 524288)))
      (modify-services %desktop-services
                       (delete gdm-service-type)))))
   (keyboard-layout
    (keyboard-layout "us,cz" ",ucw" #:options
		     '("grp:caps_switch" "grp_led"
		       "lv3:ralt_switch" "compose:rctrl-altgr")))
   (setuid-programs
    (append (list (setuid-program
		   (program (file-append cifs-utils "/sbin/mount.cifs"))))
	    %setuid-programs))
   (mapped-devices
    (@host
     #:hydra '()
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
    (list
     (@host
      #:dagon (swap-space
	       (target "/dev/mapper/rpool-swap")
	       (dependencies mapped-devices))
      #:hydra (swap-space
	       (target (file-system-label "SWAP"))))))
   (file-systems
    (append %base-file-systems
            (@host
             #:dagon (list (file-system
	                    (mount-point "/")
	                    (device "/dev/mapper/rpool-root")
	                    (type "btrfs")
	                    (dependencies mapped-devices))
                           (file-system
                            (mount-point "/home")
                            (device "/dev/mapper/rpool-home-decrypted")
                            (type "btrfs")
                            (dependencies mapped-devices))
                           (file-system
                            (mount-point "/boot/efi")
                            (device (uuid "D762-6C63" 'fat32))
                            (type "vfat")))
             #:hydra (list
                      (file-system
                       (mount-point "/boot/efi")
                       (device (file-system-label "EFIBOOT"))
                       (type "vfat"))
                      (file-system
                       (mount-point "/")
                       (device (uuid
                                "e2f2bd08-7962-4e9d-a22a-c66972b7b1e3"
                                'btrfs))
                       (options
                        (alist->file-system-options '(("subvol" . "@guix"))))
                       (type "btrfs"))
                      (file-system
                       (mount-point "/home")
                       (device (uuid
                                "e2f2bd08-7962-4e9d-a22a-c66972b7b1e3"
                                'btrfs))
                       (options
                        (alist->file-system-options '(("subvol" . "@home"))))
                       (type "btrfs"))
                      (file-system
                       (mount-point "/GAMES")
                       (device (file-system-label "STORAGE"))
                       (options
                        (alist->file-system-options '(("subvol" . "@games"))))
                       (type "btrfs"))
                      (file-system
                       (mount-point "/DOWNLOADS")
                       (device (file-system-label "VAULT"))
                       (options
                        (alist->file-system-options '(("subvol" . "@downloads"))))
                       (type "btrfs"))))))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets `("/boot/efi"))))
   (name-service-switch %mdns-host-lookup-nss)))

(-> atlas-system-base
    (os/hostname (hostname))
    (users (user-account
	    (name "michal_atlas")
	    (comment "Michal Atlas")
	    (group "users")
	    (home-directory "/home/michal_atlas")
	    (supplementary-groups
	     '("wheel" "netdev" "audio" "docker"
	       "video" "libvirt" "kvm" "tty" "transmission"))))
    (packages
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
     flatpak
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
     ;; texlive
     ;; texlive-tcolorbox
     transmission-remote-gtk
     tree
     unzip
     virt-manager
     wl-clipboard
     xdg-utils
     xdot
     xonotic
     yt-dlp)
    (.openssh)
    (.gpm)
    (.screen-locker
     (name "swaylock")
     (program (file-append swaylock
                           "/bin/swaylock"))
     (using-setuid? #f)
     (using-pam? #t))
    (.docker)
    (.yggdrasil
     (autoconf? #t)
     (json-config
      '((peers .
	       #( ;; Czechia
		 "tls://[2a03:3b40:fe:ab::1]:993"
		 "tls://37.205.14.171:993"
		 ;; Germany
		 "tcp://193.107.20.230:7743")))))
    (.tlp
     (cpu-boost-on-ac? #t)
     (wifi-pwr-on-bat? #t))

    (.btrfs-autosnap
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
    (.inputattach)
    (.qemu-binfmt
     (platforms (lookup-qemu-platforms "arm" "aarch64" "riscv64")))
    (.libvirt
     (unix-sock-group "libvirt")
     (tls-port "16555"))
    (.virtlog (max-clients 1000))
    (.cups
     (web-interface? #t)
     (extensions
      (list cups-filters hplip-minimal)))
    (.guix-publish
     (host "0.0.0.0")
     (advertise? #t))
    (.transmission-daemon
     (rpc-bind-address "127.0.0.1")
     (ratio-limit-enabled? #t))
    (.postgresql)
    (.nix (extra-config
	   '("experimental-features = nix-command flakes\n"
             "trusted-users = @wheel\n")))
    (.bluetooth)
    
    (~guix
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
              %default-authorized-guix-keys)))

    (+hosts
     (list (host "200:672d:4835:ed25:662c:6d2e:b972:36d8" "hydra")
           (host "203:3e6f:462d:790f:b89d:11c2:1e7a:2464" "dagon"))))
