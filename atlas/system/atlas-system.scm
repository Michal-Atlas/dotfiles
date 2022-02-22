(define-module (atlas system atlas-system)
  #:use-module (atlas packages system)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages emacs)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services mcron)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
  #:use-module (nongnu services vpn)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu packages hurd))

(use-service-modules
 desktop
 networking
 ssh
 xorg
 pm
 mcron
 nix
 shepherd
 virtualization
 admin
 audio
 databases
 cups
 syncthing)


(define-public atlas-guix-system
  (operating-system
   (host-name (vector-ref (uname) 1))
   (kernel linux)
   (initrd microcode-initrd)
   (firmware (list linux-firmware))
   (locale "en_US.utf8")
   (timezone "Europe/Prague")
   (keyboard-layout
    (keyboard-layout "us,cz" ",qwerty" #:options '("grp:caps_switch" "lv3:ralt_switch" "compose:rctrl-altgr")))
   (users (cons* (user-account
		  (name "michal-atlas")
		  (comment "Michal Atlas")
		  (group "users")
		  (home-directory "/home/michal-atlas")
		  (shell (file-append (specification->package "zsh") "/bin/zsh"))
		  (supplementary-groups
		   '("wheel" "netdev" "audio"
		     "video" "libvirt" "kvm")))
		 %base-user-accounts))
   (packages
    (append %system-desktop-manifest
	    %base-packages))
   (services
    (cons*
     (service openssh-service-type)
     (simple-service 'custom-udev-rules udev-service-type (list nvidia-driver))
     (set-xorg-configuration
      (xorg-configuration
       (modules (cons* nvidia-driver %default-xorg-modules))
       (drivers '(\"nvidia\"))
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
     (service gnome-desktop-service-type)
     (service mate-desktop-service-type)
     (pam-limits-service
      (list
       (pam-limits-entry "*" 'both 'nofile 524288)))
     (service gpm-service-type)
     (service tlp-service-type
              (tlp-configuration
	       (cpu-boost-on-ac? #t)
	       (wifi-pwr-on-bat? #t)))
     (service thermald-service-type)
     (service inputattach-service-type)
     (zerotier-one-service)
     (service libvirt-service-type
              (libvirt-configuration
	       (unix-sock-group "libvirt")
	       (tls-port "16555")))
     (service virtlog-service-type
              (virtlog-configuration
               (max-clients 1000)))
     (service hurd-vm-service-type)
     (service syncthing-service-type
	      (syncthing-configuration (user "michal-atlas")))
     (service cups-service-type
              (cups-configuration
	       (web-interface? #t)
	       (extensions
		(list cups-filters hplip-minimal))))
     (service guix-publish-service-type
	      (guix-publish-configuration
	       (host "0.0.0.0")
	       (advertise? #t)))
     (service postgresql-service-type)
     (service nix-service-type)
     (service unattended-upgrade-service-type
	      (unattended-upgrade-configuration
	       (channels "/home/michal-atlas/.config/guix/channels.scm")))
     (bluetooth-service #:auto-enable? #t)
     (modify-services
      %desktop-services
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
			      "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")
		  (plain-file "dagon.pub"
			      "(public-key (ecc (curve Ed25519) (q #33173AD94F3854CD3642E21B59802C275A1742C5D0FFC59EE076EDC23FDDFFC6#)))")
		  (plain-file "hydra.pub"
			      "(public-key (ecc (curve Ed25519) (q #7C49484F9CCF50147D7BF1DFFD0F22B2AF424B0CD4228F57CA0C34F80D3A9BDD#)))"))
		 %default-authorized-guix-keys)))))))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets `("/boot/efi"))))
   (file-systems (cons*
		  (file-system
		   (mount-point "/boot/efi")
		   (type "vfat")
		   (device (file-system-label "EFI")))
		  (file-system
		   (mount-point "/")
		   (type "ext4")
		   (device (file-system-label "guix")))
		  %base-file-systems))
   (swap-devices
    (list (swap-space
	   (target (file-system-label "swap")))))
   (name-service-switch %mdns-host-lookup-nss)))

atlas-guix-system
