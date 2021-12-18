(define-module (dagon)
  #:use-module (guix-system)
  #:use-module (gnu))

(operating-system
 (host-name "Phoenix-Dagon")
 (inherit guix-system)

 (file-systems
  (cons* (file-system
	  (mount-point "/")
	  (device
	   (uuid "90040b9b-7b69-489f-b587-06e0c84387e5"
		 'ext4))
	  (type "ext4"))
	 (file-system
	  (mount-point "/boot/efi")
	  (type "vfat")
	  (device "/dev/sda1"))
	 (file-system
	  (mount-point "/home")
	  (type "btrfs")
	  (options "subvol=@/home")
	  (device "/dev/sda4"))
	 %base-file-systems)))
