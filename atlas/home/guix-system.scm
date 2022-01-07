(define-module (atlas home guix-system)
  #:use-module (atlas home manifests)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages cups)
  #:use-module (nongnu services vpn)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu packages hurd)
  #:export (atlas-guix-system))

(use-service-modules
 desktop
 networking
 ssh
 xorg
 pm
 mcron
 nix
 virtualization
 admin
 audio
 databases
 cups
 syncthing)

(define mbsync-job
  #~(job
     "0 * * * *"
     "mbsync --all"
     #:user "michal-atlas"))

(define-public atlas-guix-system
  (operating-system
   (host-name "Phoenix-Phantom")
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
		   '("wheel" "netdev" "audio" "video" "libvirt" "kvm")))
		 %base-user-accounts))
   (packages
    (append %home-desktop-manifest
	    %base-packages))
   (services
    (cons*
     (service openssh-service-type)
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
     (service gnome-desktop-service-type)
     (simple-service 'cron-jobs mcron-service-type
		     (list mbsync-job))
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
     (service nix-service-type)
     (service unattended-upgrade-service-type
	      (unattended-upgrade-configuration
	       (channels "/run/current-system/channels.scm")))
     (bluetooth-service #:auto-enable? #t)
     (modify-services
      %desktop-services
      (guix-service-type
       config =>
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
			      "(public-key (ecc (curve Ed25519) (q #4D9C8E904BAA7AD5C01C6D1227A7C83C70EB614CDF7E71A00460555A1C713E4C#)))")
		  (plain-file "hydra.pub"
			      "(public-key (ecc (curve Ed25519) (q #7C49484F9CCF50147D7BF1DFFD0F22B2AF424B0CD4228F57CA0C34F80D3A9BDD#)))"))
		 %default-authorized-guix-keys)))))))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets `("/boot/efi"))))
   (file-systems (list))
   (name-service-switch %mdns-host-lookup-nss)))
