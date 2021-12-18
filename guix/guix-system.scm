(use-modules (gnu)
	     (nongnu packages linux)
	     (nongnu system linux-initrd)
	     (nongnu services vpn)
	     (nongnu packages mozilla))
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
 gnuzilla
 shells
 wm
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
 rust
 lxqt
 cups
 cinnamon
 commencement)

(operating-system
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
  (cons* emacs vim zsh git
	 icecat qutebrowser
	 i3-wm i3status i3lock i3lock-fancy
	 emacs-exwm cinnamon-desktop
	 feh shotwell
	 font-fira-code font-jetbrains-mono
	 dmenu rofi
	 alacritty st
	 nautilus okular
	 gcc-toolchain rust
	 nss-certs
	 %base-packages))
 (services
  (cons*
   (service openssh-service-type)
   ;;(service zerotier-one-service)
   (set-xorg-configuration
    (xorg-configuration
     (keyboard-layout keyboard-layout)))
   (service tlp-service-type
            (tlp-configuration
             (cpu-boost-on-ac? #t)
             (wifi-pwr-on-bat? #t)))
   (service thermald-service-type)
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
   (service postgresql-service-type)
   (service mpd-service-type
            (mpd-configuration
             (user "michal-atlas")
             (port "6600")))
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
 (swap-devices
  (list (uuid "5fa1e03e-b1ff-4116-b7e9-2e400775d485")))
 (name-service-switch %mdns-host-lookup-nss))
