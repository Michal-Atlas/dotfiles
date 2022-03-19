(define-module (atlas system atlas-system)
  #:use-module (atlas packages system)
  #:use-module (atlas services system)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages samba)
  #:use-module (gnu system setuid)
  #:use-module (gnu services desktop)
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

(define (readfile f)
  (call-with-input-file f get-string-all))

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
		  (name "michal_atlas")
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
   (file-systems (cons*
		  (file-system
		   (mount-point "/boot/efi")
		   (type "vfat")
		   (device (file-system-label "EFI")))
		  (file-system
		   (mount-point "/")
		   (type "ext4")
		   (device (file-system-label "guix")))
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
	   (target (file-system-label "swap")))))
   (name-service-switch %mdns-host-lookup-nss)))

atlas-guix-system
