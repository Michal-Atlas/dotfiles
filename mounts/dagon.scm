(define-module (mounts dagon)
  #:use-module (mounts common)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system file-systems)
  #:export (file-systems
            mapped-devices
            swap-devices))

(define unlock
(mapped-device
                          (source (uuid
                                   "48a7d8c7-dd78-41ea-a54a-d168abbe8bab"))
                          (target "ROOT")
                          (type luks-device-mapping))
  )

(define root
  (fs 
     "/dev/mapper/ROOT"
     "/"
     (list unlock)
     #:flags '(shared))
  )

(define home
  (fs "/dev/mapper/crypthome" "/home/michal_atlas" (list unlock)))

(define efi
  (file-system
    (mount-point "/boot/efi")
    (device (uuid "B08C-A8BE" 'fat32))
    (type "vfat")))

(define swap-devices
  (list
   (swap-space (target (uuid "1fa00e6c-108b-4116-a273-4938182493f4"))
               )))

(define mapped-devices
  (list         unlock
        ))

(define file-systems
  (list efi root))
