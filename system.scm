;; System
;; :PROPERTIES:
;; :header-args+: :tangle system.scm
;; :END:


;; [[file:Dotfiles.org::*System][System:1]]
(define-module (atlas system)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages wm)
  #:use-module (gnu system setuid)
  #:use-module (gnu services desktop)
  #:use-module (gnu services xorg)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services mcron)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu packages hurd)
  #:use-module (ice-9 textual-ports)
  #:use-module (guix packages))
;; System:1 ends here

;; Packages


;; [[file:Dotfiles.org::*Packages][Packages:1]]
(use-package-modules
 shells emacs samba linux
 cups)

(define (pkg-set name pkgs)
  (map (lambda (q) (string-append name "-" q)) pkgs))

(define %system-desktop-manifest-list
  `(
    ;; DE
    "fontconfig" "font-ghostscript" "font-dejavu" "font-gnu-freefont"
    "font-adobe-source-han-sans" "font-wqy-zenhei"
    "guix-icons" "breeze-icons" "oxygen-icons"    
    "font-fira-code"
    "adwaita-icon-theme"

    "font-jetbrains-mono"
    "font-awesome" "font-tamzen"
    "font-sil-charis" "font-adobe-source-han-sans"
    "font-wqy-zenhei" "font-wqy-microhei"

    ;; Emacs

    ;; [[file:Dotfiles.org::*Emacs][Emacs:1]]

    ;; Emacs:1 ends here

    "nss-certs"

    "sbcl"
    ,@(pkg-set
       "sbcl"
       `("linedit" "mcclim"
         "serapeum"
         "alexandria" "cl-yacc"
         "lparallel"
         "coalton" "unix-opts" "cffi" "series"
         "trial" "trees" "parenscript"
         "terminfo" "terminal-size"
         "terminal-keypress" "tar"
         "tailrec" "s-xml"))
    "nyxt" "gparted" "pavucontrol"
    "screen" "indent" "pkg-config"

    "file" "kitty" "fzf"
    "pandoc" "direnv" "git" "htop"
    "bat" "transmission-remote-gtk"

    "make" "python-ipython" "mpv" "yt-dlp"

    "feh" "shotwell" "krita" "arandr" "graphviz" "xdot"
    "tree" "gnupg" "fasd"
    ;; "texlive" "texlive-tcolorbox"

    "xonotic" "keepassxc"
    "wl-clipboard" "lagrange" "grim"
    "slurp" "okular" "virt-manager" "btrfs-progs"
    "mosh" "rsync" "nix" "recutils" "xdg-utils"

    ,@(pkg-set
       "emacs"
       '("next-pgtk" "hydra"
         "tuareg" "nix-mode" "stumpwm-mode" "password-generator" "ssh-agency"
         "yasnippet" "consult-yasnippet" "hackles" "stumpwm-mode" "dmenu" "docker"
         "dockerfile-mode" "gemini-mode" "zerodark-theme" "yasnippet-snippets"
         "yasnippet" "yaml-mode" "tldr" "swiper" "realgud" "pdf-tools" "ox-gemini"
         "on-screen" "nix-mode" "multi-term" "markdown-mode" "iedit" "htmlize"
         "haskell-mode" "gdscript-mode" "flycheck-haskell" "flycheck" "ement"
         "elpher" "ediprolog" "debbugs" "dashboard" "csv-mode" "csv" "crux"
         "circe" "cheat-sh" "calfw" "all-the-icons-dired" "all-the-icons" "sly"
         "geiser-guile" "adaptive-wrap" "org-roam-ui" "rust-mode" "org-superstar"
         "password-store-otp" "password-store" "go-mode" "engrave-faces"
         "consult-org-roam" "org-roam-ui" "org-roam" "hydra" "consult" "orderless"
         "vertico" "embark" "browse-kill-ring" "avy" "magit" "elfeed"
         "multiple-cursors" "paredit" "geiser" "company" "marginalia" "anzu"
         "git-gutter" "eglot" "eshell-did-you-mean" "fish-completion"
         "eshell-vterm" "eat" "eshell-syntax-highlighting" "eshell-prompt-extras"
         "ace-window" "undo-tree" "rainbow-delimiters" "rainbow-identifiers"
         "which-key" "doom-modeline" "monokai-theme" "direnv"
         "highlight-indentation" "org-modern" "org" "auctex"))))

(define %system-desktop-manifest
  (map specification->package %system-desktop-manifest-list))
;; Toolchains:1 ends here

;; Services


;; [[file:Dotfiles.org::*Services][Services:1]]
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

(use-modules (atlas services btrfs)
             (atlas services morrowind)
             (nongnu services vpn))

(define-public %system-services-manifest
  (cons*
;; Services:1 ends here

;; [[file:Dotfiles.org::*Services][Services:3]]
   (service openssh-service-type)
   (service pam-limits-service-type
    (list
     (pam-limits-entry "*" 'both 'nofile 524288)))
   (service gpm-service-type)
   (service screen-locker-service-type
            (screen-locker-configuration
             (name "swaylock")
             (program (file-append swaylock
                                   "/bin/swaylock"))))
   (service docker-service-type)
   (zerotier-one-service)
   (service yggdrasil-service-type
	    (yggdrasil-configuration
	     (autoconf? #t)
	     (json-config
	      '((peers .
		       #(
			 ;; Czechia
			 "tls://[2a03:3b40:fe:ab::1]:993"
			 "tls://37.205.14.171:993"
			 ;; Germany
			 "tcp://193.107.20.230:7743"))))))
   (service tlp-service-type
	    (tlp-configuration
	     (cpu-boost-on-ac? #t)
	     (wifi-pwr-on-bat? #t)))
   (service btrfs-autosnap-service-type
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
              (path "/home"))))
   (service inputattach-service-type)
   (service qemu-binfmt-service-type
	 (qemu-binfmt-configuration
	   (platforms (lookup-qemu-platforms "arm" "aarch64" "riscv64"))))
   (service libvirt-service-type
		(libvirt-configuration
		 (unix-sock-group "libvirt")
		 (tls-port "16555")))
   (service virtlog-service-type
	    (virtlog-configuration
	     (max-clients 1000)))
   (service cups-service-type
	    (cups-configuration
	     (web-interface? #t)
	     (extensions
	      (list cups-filters hplip-minimal))))
   (service guix-publish-service-type
	    (guix-publish-configuration
	     (host "0.0.0.0")
	     (advertise? #t)))
   (service transmission-daemon-service-type
	    (transmission-daemon-configuration
	     (rpc-bind-address "127.0.0.1")
	     (ratio-limit-enabled? #t)))
   (service postgresql-service-type)
   (service nix-service-type
	    (nix-configuration
	     (extra-config
	      '("experimental-features = nix-command flakes\n"
                "trusted-users = @wheel\n"))))
   (service bluetooth-service-type)
   (modify-services %desktop-services
     (delete gdm-service-type)
    (guix-service-type
     config =>
     (guix-configuration
      (inherit config)
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
;; Services:3 ends here

;; Base Config


;; [[file:Dotfiles.org::*Base Config][Base Config:1]]
(define-public atlas-system-base
  (operating-system
    (host-name #f)
    (file-systems #f)
    (kernel linux)
    (initrd microcode-initrd)
    (firmware (list linux-firmware))
    (locale "en_US.utf8")
    (timezone "Europe/Prague")
    (keyboard-layout
     (keyboard-layout "us,cz" ",ucw" #:options
		      '("grp:caps_switch" #;"ctrl:nocaps" "grp_led"
			"lv3:ralt_switch" "compose:rctrl-altgr")))
    (users (cons* (user-account
		   (name "michal_atlas")
		   (comment "Michal Atlas")
		   (group "users")
		   (home-directory "/home/michal_atlas")
		   (supplementary-groups
		    '("wheel" "netdev" "audio" "docker"
		      "video" "libvirt" "kvm" "tty" "transmission")))
		  %base-user-accounts))
    (packages
     (append %system-desktop-manifest
	     %base-packages))
    (setuid-programs
     (append (list (setuid-program
		    (program (file-append cifs-utils "/sbin/mount.cifs"))))
	     %setuid-programs))
    (services
     %system-services-manifest)
    (bootloader
     (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets `("/boot/efi"))))
    (name-service-switch %mdns-host-lookup-nss)))
;; Base Config:1 ends here

;; Dagon


;; [[file:Dotfiles.org::*Dagon][Dagon:1]]
(define dagon
  (operating-system
    (inherit atlas-system-base)
    (host-name "dagon")
    (mapped-devices (let* ((rpool-lvm (lambda (lv)
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
                         (type luks-device-mapping))))))
    (swap-devices (list (swap-space
			 (target "/dev/mapper/rpool-swap")
			 (dependencies mapped-devices))))
    (file-systems (cons* (file-system
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
			  (type "vfat"))
                         %base-file-systems))))
;; Dagon:1 ends here

;; Hydra

;; [[file:Dotfiles.org::*Hydra][Hydra:1]]
(define hydra
  (operating-system
    (inherit atlas-system-base)
    (host-name "hydra")
    (firmware (list linux-firmware amdgpu-firmware))
    (services (cons*
               (service hurd-vm-service-type
	                (hurd-vm-configuration
	                 (disk-size (* 16 (expt 2 30)))
	                 (memory-size 2048)))
               (service tes3mp-service-type "/tes3mp")
               (service btrfs-autosnap-service-type
                        (list (btrfs-autosnap-spec
                               (name "tes3mp")
                               (retention 31)
                               (schedule "0 9 * * *")
                               (path "/tes3mp"))))
               %system-services-manifest))
    (file-systems
     (cons*
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
       (mount-point "/tes3mp")
       (device (uuid
                "e2f2bd08-7962-4e9d-a22a-c66972b7b1e3"
                'btrfs))
       (options
        (alist->file-system-options '(("subvol" . "@tes3mp"))))
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
       (type "btrfs"))
      %base-file-systems))
    (swap-devices
     (list (swap-space
	    (target (file-system-label "SWAP")))))))
;; Hydra:1 ends here

;; Hurd


;; [[file:Dotfiles.org::*Hurd][Hurd:1]]
(define-public startide
  (operating-system
    (host-name "startide")
    (file-systems %base-file-systems)
    (kernel hurd)
    (locale "en_US.utf8")
    (timezone "Europe/Prague")
    (users (cons* (user-account
		   (name "michal_atlas")
		   (comment "Michal Atlas")
		   (group "users")
		   (home-directory "/home/michal_atlas")
		   (supplementary-groups
		    '("wheel" "netdev" "audio" "video")))
		  %base-user-accounts))
    (bootloader
     (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets `("/boot/efi"))))
    (name-service-switch %mdns-host-lookup-nss)))
;; Hurd:1 ends here

;; Machine Selection


;; [[file:Dotfiles.org::*Machine Selection][Machine Selection:1]]
(assoc-ref
 `(("dagon" . ,dagon)
   ("hydra" . ,hydra))
 (vector-ref (uname) 1))
;; Machine Selection:1 ends here
