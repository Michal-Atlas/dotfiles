(define-module (hydra)
  #:use-module (guix-system)
  #:use-module (guix scripts system)
  #:use-module (gnu))

(operating-system
 (inherit guix-system)
 (host-name "Hydra")
 (swap-devices
  (list (uuid "300928ce-fc87-474c-94e1-19abd760908d")))
 (file-systems
  (cons* (file-system
	  (mount-point "/")
	  (device
	   (uuid "cf61d583-01b3-4988-90c0-624d69f1d790"))
	  (type "ext4"))
	 (file-system
	  (mount-point "/boot/efi")
	  (device
	   (uuid "10835a8b-b8b3-482d-a2bf-64974e2de9e4"))
	  (type "ext4"))
	 %base-file-systems)))
