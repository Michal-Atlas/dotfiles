(define-module (atlas system)
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
	  (uuid "736b8145-cb48-4581-84a5-55bfe47b5d6d"))
	 (target "cryptroot")
	 (type luks-device-mapping))))
 (file-systems (cons*
	 	(file-system
		 (mount-point "/boot/efi")
		 (device (uuid "D7BD-12CE" 'fat32))
		 (type "vfat"))
		(file-system
		 (mount-point "/")
		 (device "/dev/mapper/cryptroot")
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
	 (target (uuid "e85e8826-9652-4e93-a135-5645ea1558fb")))))))

(assoc-ref
       `(("dagon" . ,dagon)
	 ("hydra" . ,hydra))
        (vector-ref (uname) 1))
