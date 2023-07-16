;; System
;; :PROPERTIES:
;; :header-args+: :tangle system.scm
;; :END:


;; [[file:Dotfiles.org::*System][System:1]]
(define-module (atlas system)
  #:use-module (gnu)
  #:use-module (gnu packages)
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
    "nvi" "patchelf"

    ;; DE
    "fontconfig" "font-ghostscript" "font-dejavu" "font-gnu-freefont"
    "font-adobe-source-han-sans" "font-wqy-zenhei"
    "guix-icons" "breeze-icons" "oxygen-icons"
    "xnotify" "brightnessctl" "pamixer" "playerctl"
    "firefox" "nyxt" "xscreensaver" "gparted"
    "nautilus" "gvfs" "samba"
    "pavucontrol" "screen"
    ;;"sway"
    "i3status" "i3lock"
    "flatpak" "font-fira-code"
    "breeze-icons" "hicolor-icon-theme"
    "adwaita-icon-theme"

    ;; KAB
    "pkg-config" "openssl" "indent"

    ;; Gnome extensions
    "gnome-shell-extensions"
    ,@(pkg-set
       "gnome-shell-extension"
       `("vertical-overview"
	 "unite-shell"
	 "transparent-window"
	 "topicons-redux"
	 "sound-output-device-chooser"
	 "radio"
	 "paperwm"
	 "noannoyance"
	 "just-perfection"
	 "jiggle"
	 "hide-app-icon"
	 "gsconnect"
	 "dash-to-panel"
	 "dash-to-dock"
	 "customize-ibus"
	 "clipboard-indicator"
	 "burn-my-windows"
	 "blur-my-shell"
	 "appindicator"))
    "matcha-theme"

;;; shell-utils
    "file"
    "kitty" "fzf"
    "pandoc" "direnv"
    "vim" "zsh" "git" "git" "htop"
    "xclip" "telescope" "agate"
    "fasd"
    "bat" "zoxide" "exa"
    "tealdeer"
    "password-store"
    "pass-otp"
    "guile-filesystem"
    "transmission-remote-gtk"
    "transmission"
    "pkg-config"

;;; toolchains
    "gdb" "go" "ccls"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh"
    "sbcl" "racket"
    "gnupg" "swi-prolog"
    "sbcl-linedit"

;;; multimedia
    "grim" "vlc" "mpv"
    "libreoffice"
    "audacity"
    "yt-dlp" "picard"

;;; graphics
    "feh" "shotwell"
    "inkscape" "gimp" "krita"
    "font-fira-code" "font-jetbrains-mono"
    "font-awesome" "font-tamzen"
    "font-sil-charis" "font-adobe-source-han-sans"
    "font-wqy-zenhei" "font-wqy-microhei"
    "gparted"
    "xrandr" "arandr"
    "graphviz" "xdot"
    "xdotool" "tree"
    "bc" "unzip"
;;; latex
    "texlive"
    "texlive-tcolorbox"
;;; games
    "lgogdownloader"
    "supertuxkart" "cataclysm-dda"
    "wesnoth"                           ;"steam" "sky" "lure"
                                        ; "endless-sky" "naev"
    "gzdoom"                            ;"tintin++"
    "taisei" "kobodeluxe"               ;"dwarf-fortress"

;;; e-mail
    "pinentry"

;;; desktop
    "fontconfig" "font-ghostscript" "font-dejavu" "font-gnu-freefont"
    "font-adobe-source-han-sans" "font-wqy-zenhei"
    "guix-icons" "breeze-icons" "oxygen-icons"
    "pasystray" "xss-lock"
    "bemenu" "sway" "swayidle" "swaybg" "swayhide"
    "wl-clipboard" "lagrange"
    "grim" "slurp" "foot"
    "nautilus" "gvfs" "okular" "pulseaudio"
    "wob" "font-iosevka" "browserpass-native"
    "xsetroot"

;;; big-games
    #;"the-dark-mod" ;"falltergeist"
    "nethack"                           ;"retux"
    "angband"
                                        ;"retroarch"
    "marble-marcher"
    ;; Packages:1 ends here

    ;; Emacs

    ;; [[file:Dotfiles.org::*Emacs][Emacs:1]]
    "emacs-next-pgtk"
    ;; Emacs:1 ends here

    ;; Libs


    ;; [[file:Dotfiles.org::*Libs][Libs:1]]

    ;; Libs
    "ncurses" "curl" "virt-manager"
    "ntfs-3g" "btrfs-progs"
    "cifs-utils"

    ;; Shell utils
    "file" "screen"
    "fzf"
    "pandoc" "zutils"
    "vim" "git" "htop"
    "mosh" "rsync"
    ;; Libs:1 ends here

    ;; Toolchains


    ;; [[file:Dotfiles.org::*Toolchains][Toolchains:1]]
    "gcc-toolchain" "ccls"
    "cmake" "make" "recutils" "python" "python-ipython"
    "luajit" "perl" "nix"

    "openvpn" "network-manager-openvpn"
    "gnupg" "pinentry"    
    "nss-certs" "xdg-utils"

    "sway"
    "sbcl"
    ,@(pkg-set
       "sbcl"
       `( ;; StumpWM
	 ,@(pkg-set
	    "stumpwm"
	    `("winner-mode"
	      "swm-gaps"
	      "screenshot"
	      "pass"
	      "pamixer"
	      "numpad-layouts"
	      "notify"
	      "kbd-layouts"
	      "disk"
	      "battery-portable"
	      "globalwindows"
	      "wifi"
	      "ttf-fonts"
	      "stumptray"
	      "net"
	      "mem"
	      "cpu"))
	 "linedit" "mcclim"
	 "serapeum" "eclector"
	 "alexandria" "cl-yacc"
	 "cl-autowrap" "optima" "lparallel"
	 "coalton" "coleslaw" "parser-combinators"
	 "collectors" "cl-strings"      ;"virality"
	 "speechless" "mathkit"
	 "sketch" "cl-liballegro" "cl-fast-ecs"
	 "sdl2kit" "harmony" "cl-raylib"
	 "unix-opts" "cffi" "series"
	 "trial" "trees" "sycamore" "parenscript"
	 "terminfo" "terminal-size"
	 "terminal-keypress" "tar"
	 "tailrec" "screamer" "s-xml"))))

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
   (service docker-service-type)
   (service gnome-desktop-service-type)
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
   ;; (service hurd-vm-service-type
   ;; 	    (hurd-vm-configuration
   ;; 	     (disk-size (* 16 (expt 2 30)))
   ;; 	     (memory-size 2048)))
   (service syncthing-service-type
	    (syncthing-configuration (user "michal_atlas")))
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
	      '("experimental-features = nix-command flakes"))))
   (service bluetooth-service-type)
   (modify-services %desktop-services
     (gdm-service-type
      config =>
      (gdm-configuration
       (auto-login? #t)
       (default-user "michal_atlas")
       (wayland? #t)
       (auto-suspend? #f)
       (xorg-configuration
	(xorg-configuration
	 (extra-config (list "# Touchpad
Section \"InputClass\"
Identifier \"touchpad\"
	Driver \"libinput\"
MatchIsTouchpad \"on\"
Option \"DisableWhileTyping\" \"on\"
Option \"Tapping\" \"1\"
Option \"NaturalScrolling\" \"1\"
Option \"Emulate3Buttons\" \"yes\"
EndSection
# Touchpad:1 ends here"))
	(keyboard-layout
	 (keyboard-layout "us,cz" ",ucw" #:options
			  '("grp:caps_switch" #;"ctrl:nocaps" "grp_led"
			    "lv3:ralt_switch" "compose:rctrl-altgr")))))))
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
			    "(public-key (ecc (curve Ed25519) (q #03385757E9801272CAAD8462A6EDA563E83F9633A63C36936A7DD47E22316CDA#)))")
		(plain-file "dagon.pub"
			    "(public-key (ecc (curve Ed25519) (q #DB49668C798D60F0FAE967CB44D6CF2F154EF225B18EBF204263A73B1391D4EE#)))"))
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
    (swap-devices (list (swap-space
			 (target (uuid
				  "bffe4a79-4fe6-4c29-98d2-3b71fd1c83ab")))))
    (mapped-devices (list (mapped-device
			   (source (uuid
				    "13d67955-714a-4427-a24d-eaf26659f256"))
			   (target "cryptroot")
			   (type luks-device-mapping))))
    (file-systems (cons* (file-system
			   (mount-point "/")
			   (device "/dev/mapper/cryptroot")
			   (type "btrfs")
			   (dependencies mapped-devices))
			 (file-system
			  (mount-point "/boot/efi")
			  (device (uuid "D762-6C63"
					'fat32))
			  (type "vfat")) %base-file-systems))))
;; Dagon:1 ends here

;; Hydra

;; [[file:Dotfiles.org::*Hydra][Hydra:1]]
(define hydra
  (operating-system
    (inherit atlas-system-base)
    (host-name "hydra")
    (firmware (list linux-firmware amdgpu-firmware))
    (services (cons*
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
