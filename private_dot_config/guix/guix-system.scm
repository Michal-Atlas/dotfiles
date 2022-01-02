(define-module (guix-system)
  #:use-module (gnu)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu services vpn)
  #:use-module (nongnu packages mozilla)
  #:use-module (nongnu packages nvidia)
  #:use-module (nongnu packages gog)
  #:use-module (games packages the-dark-mod)
  #:use-module (games packages diablo))
(use-service-modules
 desktop
 networking
 ssh
 xorg
 pm
 virtualization
 admin
 audio
 databases
 cups
 syncthing)
(use-package-modules
 emacs
 emacs-xyz
 vim
 freedesktop
 pulseaudio
 admin
 disk
 password-utils
 rust-apps
 wine
 image
 xorg
 ncurses
 game-development
 games
 gnuzilla
 llvm
 shells
 inkscape
 gimp
 video
 databases
 libreoffice
 linux
 music
 wm
 graphics
 suckless
 xdisorg
 terminals
 certs
 version-control
 pdf
 image-viewers
 gnome
 web-browsers
 fonts
 kde
 mail
 gnupg
 graphviz
 algebra
 audio
 compression
 bittorrent
 haskell-xyz
 ssh
 lua
 perl
 cmake
 rust
 tex
 lxqt
 cups
 cinnamon
 commencement)

(define-public guix-system
  (operating-system
   (host-name "Phoenix-Phantom")
   (kernel linux)
   (initrd microcode-initrd)
   (firmware (list linux-firmware))
   (locale "en_GB.utf8")
   (timezone "Europe/Prague")
   (keyboard-layout
    (keyboard-layout "us,cz" ",qwerty" #:options '("grp:caps_switch" "lv3:ralt_switch" "compose:rctrl-altgr")))
   (users (cons* (user-account
		  (name "michal-atlas")
		  (comment "Michal Atlas")
		  (group "users")
		  (home-directory "/home/michal-atlas")
		  (shell (file-append zsh "/bin/zsh"))
		  (supplementary-groups
		   '("wheel" "netdev" "audio" "video")))
		 %base-user-accounts))
   (packages
    (cons* emacs-next vim zsh git htop
	   firefox qutebrowser
	   i3-wm i3status i3lock i3lock-fancy
	   emacs-exwm cinnamon-desktop
	   emacs-all-the-icons
	   emacs-dashboard emacs-highlight-indent-guides
	   emacs-doom-themes emacs-doom-modeline
	   emacs-solaire-mode
	   emacs-which-key
	   emacs-company emacs-company-box
	   emacs-rainbow-delimiters emacs-rainbow-identifiers
	   emacs-helpful
	   emacs-clang-format emacs-aggressive-indent
	   emacs-crux emacs-undo-tree
	   emacs-flycheck emacs-yasnippet
	   emacs-projectile emacs-vertico
	   emacs-orderless
	   emacs-lsp-ui emacs-lsp-mode
	   emacs-magit emacs-magit-todos
	   emacs-guix emacs-adaptive-wrap
	   emacs-calfw emacs-pdf-tools
	   emacs-all-the-icons-dired emacs-git-gutter
	   emacs-org-fragtog emacs-avy
	   emacs-anzu emacs-org-present emacs-org-superstar
	   emacs-marginalia emacs-embark
	   emacs-consult
	   emacs-irony-mode emacs-irony-eldoc
	   emacs-elfeed emacs-frames-only-mode
	   emacs-ac-geiser emacs-paredit emacs-iedit
	   emacs-multiple-cursors
	   emacs-gruvbox-theme
	   emacs-on-screen
	   mu isync gnupg pinentry
	   diablo ;; devilutionx
	   graphviz xdot
	   xdotool tree
	   bc unzip
	   pavucontrol
	   transmission
	   lgogdownloader the-dark-mod
	   supertuxkart cataclysm-dda ;; falltergeist
	   gnushogi nethack retux angband opensurge
	   wesnoth
	   feh shotwell
	   font-fira-code font-jetbrains-mono
	   font-awesome font-tamzen
	   font-sil-charis font-adobe-source-han-sans
	   font-wqy-zenhei font-wqy-microhei
	   pavucontrol
	   gparted keepassxc
	   xrandr arandr
	   texlive
	   ncurses
	   dmenu rofi
	   alacritty st bat zoxide exa fzf
	   nautilus okular
	   inkscape gimp blender kdenlive krita
	   audacity
	   gcc-toolchain clang-toolchain rust
	   cmake recutils ncurses pandoc tealdeer
	   mosh luajit perl
	   wine64
	   icedove
	   grim vlc
	   libreoffice
	   xnotify brightnessctl pamixer playerctl
	   nss-certs xdg-utils
	   %base-packages))
   (services
    (cons*
     (service openssh-service-type)
					; (service zerotier-one-service-type)
     (set-xorg-configuration
      (xorg-configuration
       (extra-config (list "
# Touchpad
Section \"InputClass\"
Identifier \"touchpad\"
        Driver \"libinput\"
MatchIsTouchpad \"on\"
Option \"DisableWhileTyping\" \"on\"
Option \"Tapping\" \"1\"
Option \"NaturalScrolling\" \"1\"
Option \"Emulate3Buttons\" \"yes\"
EndSection
# Touchpad:1 ends here
"))
       (keyboard-layout keyboard-layout)))
     (service tlp-service-type
              (tlp-configuration
               (cpu-boost-on-ac? #t)
               (wifi-pwr-on-bat? #t)))
     (service thermald-service-type)
     (service inputattach-service-type)
     (service libvirt-service-type
              (libvirt-configuration
               (unix-sock-group "libvirt")
               (tls-port "16555")))
     (service syncthing-service-type
	      (syncthing-configuration (user "michal-atlas")))
     (service cups-service-type
              (cups-configuration
               (web-interface? #t)
               (extensions
		(list cups-filters hplip-minimal))))
     (service guix-publish-service-type
	      (guix-publish-configuration
	       (advertise? #t)))
     (service unattended-upgrade-service-type
	      (unattended-upgrade-configuration
	       (channels "/run/current-system/channels.scm")))
     (bluetooth-service #:auto-enable? #t)
     (modify-services %desktop-services
		      (guix-service-type config =>
					 (guix-configuration
					  (inherit config)
					  (discover? #t)
					  (substitute-urls
					   (append (list "https://substitutes.nonguix.org")
						   %default-substitute-urls))
					  (authorized-keys
					   (append (list
						    (plain-file "non-guix.pub"
								"(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")
						    (plain-file "phoenix-elite.pub"
								"(public-key (ecc (curve Ed25519)	(q #4D9C8E904BAA7AD5C01C6D1227A7C83C70EB614CDF7E71A00460555A1C713E4C#)))"))
						   %default-authorized-guix-keys)))))))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (target "/boot/efi")))
   (file-systems (list))
   (name-service-switch %mdns-host-lookup-nss)))
