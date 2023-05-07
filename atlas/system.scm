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
  #:use-module (nongnu services vpn)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu packages hurd)
  #:use-module (ice-9 textual-ports)
  #:use-module (guix packages))

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
    "firefox" "xscreensaver" "gparted"
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
    
    ;; Emacs
    "emacs"
    ,@(pkg-set
       "emacs"
       `(; "exwm"
         "org-roam"
	     "org-roam-ui"
	     "consult-org-roam"
                                        ;	  "org-roam-timestamps"
	     "engrave-faces"
	     "go-mode"
	     "use-package"
	     "password-store"
	     "password-store-otp"
	     "org-fragtog"
	     "org-modern"
	     "org-superstar"
	     "highlight-indentation"
                                        ;"mode-icons"
	     "doom-modeline"
	     "which-key"
	     "rainbow-identifiers"
	     "rainbow-delimiters"
	     "undo-tree"
	     "ace-window"
	     "eshell-prompt-extras"
	     "eshell-syntax-highlighting"
	     "esh-autosuggest"
	     "git-gutter"
                                        ;"savehist"
	     "anzu"
	     "marginalia"
                                        ;"org-roam"
                                        ;"org-roam-ui"
	     "geiser-racket"
	     "adaptive-wrap"
	     "geiser-guile"
	     "sly"
	     "slime"
	     "geiser"
	     "multiple-cursors"
	     "magit"
	     "helpful"
	     "avy"
	     "browse-kill-ring"
	     "emms"
	     "evil"
	     "vertico"
	     "vertico-posframe"
	     "orderless"
	     "consult"
	     "xah-fly-keys"
	     "ac-geiser"
	     "all-the-icons"
	     "all-the-icons-dired"
	     "auctex"
	     "calfw"
	     "cheat-sh"
	     "circe"
	     "company"
	     "crux"
	     "csv"
	     "csv-mode"
	     "dashboard"
	     "debbugs"
	     "direnv"
	     "ediprolog"
	     "elfeed"
	     "elisp-autofmt"
	     "elpher"
	     "embark"
	     "ement"
	     "eshell-z"
	     "flycheck"
	     "flycheck-haskell"
	     "frames-only-mode"
	     "gdscript-mode"
	     "guix"
	     "haskell-mode"
	     "highlight-indent-guides"
	     "htmlize"
	     "iedit"
	     "lispy"
	     "magit-todos"
	     "monokai-theme"
	     "multi-term"
	     "nix-mode"
	     "on-screen"
	     "ox-gemini"
                                        ;"parinfer"
	     "pdf-tools"
	     "pg"
	     "projectile"
	     "racket-mode"
	     "realgud"
	     "swiper"
	     "tldr"
	     "vterm"
	     "xkcd"
	     "yaml-mode"
	     "yasnippet"
	     "yasnippet-snippets"
	     "zerodark-theme"
	     "gemini-mode"
                                        ;"nov"
	     "dockerfile-mode"
	     "docker"
	     "dmenu"
	     "eglot"
	     "org"
	     "stumpwm-mode"
	     "hackles"
	     "yasnippet-snippets"
	     "consult-yasnippet"
	     "yasnippet"
	     "tramp"
	     "ssh-agency"
	     "password-generator"
	     "mastodon"
	     "stumpwm-mode"))

    "yt-dlp"
    
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

    ;; Toolchains
    "gcc-toolchain" "ccls"
    "cmake" "make" "recutils" "python" "python-ipython"
    "luajit" "perl" "nix"

    "openvpn" "network-manager-openvpn"
    "gnupg" "pinentry"    
    "nss-certs" "xdg-utils"

    "sway"
    "sbcl"
    "stumpwm"
    "buildapp"
    "stumpish"
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
            "collectors" "cl-strings"
            "unix-opts" "cffi" "series"
            "trial" "trees" "sycamore"
            "terminfo" "terminal-size"
            "terminal-keypress" "tar"
            "tailrec" "screamer" "s-xml"))))

(define %system-desktop-manifest
  (map specification->package %system-desktop-manifest-list))

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

(define-public %system-services-manifest
  (cons*
   (service unattended-upgrade-service-type
	    (unattended-upgrade-configuration
	     (channels #~(load #$(local-file "channels.scm")))))
   (service openssh-service-type)
   (service pam-limits-service-type
    (list
     (pam-limits-entry "*" 'both 'nofile 524288)))
   (service gpm-service-type)
   (service docker-service-type)
   (service gnome-desktop-service-type)
   (service tlp-service-type
	    (tlp-configuration
	     (cpu-boost-on-ac? #t)
	     (wifi-pwr-on-bat? #t)))
   (service inputattach-service-type)
   (service qemu-binfmt-service-type
         (qemu-binfmt-configuration
           (platforms (lookup-qemu-platforms "arm" "aarch64" "riscv64"))))
   (zerotier-one-service)
   (service libvirt-service-type
	        (libvirt-configuration
	         (unix-sock-group "libvirt")
	         (tls-port "16555")))
   (service virtlog-service-type
	    (virtlog-configuration
	     (max-clients 1000)))
   (service hurd-vm-service-type
	    (hurd-vm-configuration
	     (disk-size (* 16 (expt 2 30)))
	     (memory-size 2048)))
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
   (service nix-service-type)
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
       (append (list
		"https://substitutes.nonguix.org")
	       %default-substitute-urls))
      (authorized-keys
       (append (list
		(plain-file "non-guix.pub"
			    "(public-key (ecc (curve Ed25519) (q #926B78EBA9416220CA0AFA2EAEC8ED99FC9E9C03AF11CD08AE6F8192BCF68673#)))")
		(plain-file "hydra.pub"
			    "(public-key (ecc (curve Ed25519) (q #5E7373D527DC6566C2601F79EDD33ADDBCB16CDF1D7A8A12565B76058DB6A219#)))")
		(plain-file "dagon.pub"
			    "(public-key (ecc (curve Ed25519) (q #D3D457964156E28FBA767F66ED72CC07DE71B9DBFCEAFDBA00652DBFA80D6B46#)))"))
	       %default-authorized-guix-keys)))))))

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
                    (program (file-append cifs-utils "/sbin/mount.cifs")))
		   (setuid-program
		    (program (file-append light "/bin/light"))))
             %setuid-programs))
    (services
     %system-services-manifest)
    (bootloader
     (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets `("/boot/efi"))))
    (name-service-switch %mdns-host-lookup-nss)))

(define dagon
  (operating-system
    (inherit atlas-system-base)
    (host-name "dagon")
    (swap-devices (list (swap-space
			 (target (uuid
				  "3a5ec2f6-0f10-4f18-9a47-d4aa4586b13f")))))
    (mapped-devices (list (mapped-device
                           (source (uuid
                                    "e1651b91-c5f4-465e-94c7-b3197f46a9ee"))
                           (target "cryptroot")
                           (type luks-device-mapping))))

    (file-systems (cons* (file-system
                           (mount-point "/")
                           (device "/dev/mapper/cryptroot")
                           (type "btrfs")
                           (dependencies mapped-devices))
			 (file-system
                           (mount-point "/boot/efi")
                           (device (uuid "3FC5-9472"
					 'fat32))
                           (type "vfat")) %base-file-systems))))

(define hydra
  (operating-system
    (inherit atlas-system-base)
    (host-name "hydra")
    (mapped-devices
     (list (mapped-device
	    (source
	     (uuid "f99a8f6d-23fd-43d9-a9fd-6e08f286e3b8"))
	    (target "luks-f99a8f6d-23fd-43d9-a9fd-6e08f286e3b8")
	    (type luks-device-mapping))))
    (file-systems (cons*
		   (file-system
		     (mount-point "/boot/efi")
		     (device (uuid "6065-21B4" 'fat32))
		     (type "vfat"))
		   (file-system
		     (mount-point "/")
		     (device "/dev/mapper/luks-f99a8f6d-23fd-43d9-a9fd-6e08f286e3b8")
		     (options (alist->file-system-options
			       `(("subvol" . "@"))))
		     (type "btrfs")
		     (dependencies mapped-devices))
		   ;; (file-system
		   ;;  (mount-point "/boot/efi")
		   ;;  (type "vfat")
		   ;;  (device (file-system-label "EFI")))
		   ;; (file-system
		   ;;  (mount-point "/")
		   ;;  (type "ext4")
		   ;;  (device (file-system-label "guix")))
		   ;; CTU
		   ;; (file-system
		   ;;  (device "//drive.fit.cvut.cz/home/zacekmi2")
		   ;;  (mount-point "/fit")
		   ;;  (title 'fit-cifs)
		   ;;  (options "sec=ntlmv2i,fsc,file_mode=0700,dir_mode=0700,uid=1000,user=zacekmi2")
		   ;;  (type "cifs")
		   ;;  (mount? #f)
		   ;;  (create-mount-point? #t))
		   %base-file-systems))
    (swap-devices
     (list (swap-space
	    (target (uuid "a5651b6e-bde2-4a69-ad0a-5857abd8448e")))))))

(assoc-ref
 `(("dagon" . ,dagon)
   ("hydra" . ,hydra))
 (vector-ref (uname) 1))
