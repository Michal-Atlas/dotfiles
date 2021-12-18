(define-module (xanathos)
  #:use-module (guix-system)
  #:use-module (gnu))

(operating-system
 (inherit guix-system)
 (host-name "Phoenix-Xanathos")

 (file-systems
  (cons* (file-system
	  (mount-point "/")
	  (device "/dev/sda2")
	  (type "ext4"))
	 (file-system
	  (mount-point "/boot/efi")
	  (device "/dev/sda1")
	  (type "ext4"))
	  %base-file-systems)))
