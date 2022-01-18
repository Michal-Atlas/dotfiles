(define-module (atlas system hydra)
  #:use-module (atlas system guix-system)
  #:use-module (gnu))

(define-public hydra-system
  (operating-system
   (inherit atlas-guix-system)
   (host-name "Hydra")
   (swap-devices
    (list (uuid "300928ce-fc87-474c-94e1-19abd760908d")))
   (file-systems
    (cons* (file-system
	    (mount-point "/")
	    (device
	     (uuid "ef7f6173-e33e-423d-973c-b782ff2e94e9"))
	    (type "ext4"))
	   (file-system
	    (mount-point "/boot/efi")
	    (device
	     (uuid "E87D-0473" 'fat32))
	    (type "vfat"))
	   (file-system
	    (mount-point "/home")
	    (device
	     (uuid "bc1de881-5fec-4a9f-a2e7-4fc1db8e6404"))
	    (type "btrfs")
	    (options "subvol=@/home"))
	   (file-system
	    (mount-point "/Games")
	    (device
	     (uuid "f8099f31-3ab1-41d1-95c3-430bda2db004"))
	    (type "ext4"))
	   (file-system
	    (mount-point "/Data")
	    (device
	     (uuid "E84A3BE94A3BB2E4" 'ntfs))
	    (type "ntfs"))
	   %base-file-systems))))

hydra-system
