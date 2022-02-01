(define-module (atlas system dagon)
  #:use-module (atlas system guix-system)
  #:use-module (gnu))

(define-public dagon-system
  (operating-system
   (inherit atlas-guix-system)
   (host-name "Dagon")
   (swap-devices
    (list
     (swap-space
      (target (uuid "5fa1e03e-b1ff-4116-b7e9-2e400775d485")))))
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
	   %base-file-systems))))

dagon-system
