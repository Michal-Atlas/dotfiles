(define-module (atlas system base)
  #:use-module (atlas system packages)
  #:use-module (atlas system services)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages samba)
  #:use-module (gnu packages linux)
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
		     "video" "libvirt" "kvm")))
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

atlas-guix-system
