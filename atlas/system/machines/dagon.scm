(define-module (atlas system machines dagon)
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

(define-public dagon
  (operating-system
   (inherit atlas-system-base)
   (host-name "dagon")
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
	   (dependencies (filter (file-system-mount-point-predicate "/home") file-systems)))))))
