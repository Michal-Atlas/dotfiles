(define-module (atlas system system)
  #:use-module (atlas packages system)
  #:use-module (atlas services system)
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

(define-public atlas-guix-system
  (operating-system
   (host-name (vector-ref (uname) 1))
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
   (mapped-devices
    (list (mapped-device
           (source
            (uuid "0c838b98-6046-425d-a3d4-f2de85f2f091"))
           (target "cryptroot")
           (type luks-device-mapping))
          (mapped-device
           (source
            (uuid "30afff6f-00ba-49f8-97cd-e52261b2e1da"))
           (target "crypthome")
           (type luks-device-mapping))))
   (file-systems (cons*
	 	  (file-system
		   (mount-point "/boot/efi")
		   (device (uuid "1261-288E" 'fat32))
		   (type "vfat"))
		  (file-system
		   (mount-point "/")
		   (device "/dev/mapper/cryptroot")
		   (type "ext4")
		   (dependencies mapped-devices))
		  (file-system
		   (mount-point "/home")
		   (device "/dev/mapper/crypthome")
		   (type "ext4")
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
	   (target "/home/michal_atlas/swapfile")
	   (dependencies (filter (file-system-mount-point-predicate "/home") file-systems)))))
   (name-service-switch %mdns-host-lookup-nss)))

atlas-guix-system
