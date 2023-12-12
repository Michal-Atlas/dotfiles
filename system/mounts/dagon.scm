(define-module (system mounts dagon)
  #:use-module (system mounts common)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system file-systems)
  #:export (file-systems
            mapped-devices
            swap-devices))

(define rpool (lvm "rpool"))

(define rpool-root (rpool "root"))

(define rpool-home (rpool "home"))

(define unlock-home
  (mapped-device
   (source "/dev/mapper/rpool-home")
   (target "crypthome")
   (type luks-device-mapping)))

(define root
  (fs "/dev/mapper/rpool-root" "/" (list rpool-root)
      #:subvol "@guix"
      #:flags '(shared)))

(define efi
  (file-system
   (mount-point "/boot/efi")
   (device (uuid "D762-6C63" 'fat32))
   (type "vfat")))

(define home
  (fs "/dev/mapper/crypthome" "/home" (list unlock-home)))

(define rpool-swap (rpool "swap"))

(define swap-devices
  (list
   (swap-space (target "/dev/mapper/rpool-swap")
               (dependencies (list rpool-swap)))))

(define mapped-devices
  (list rpool-swap
        unlock-home
        rpool-home
        rpool-root))

(define file-systems
  (list efi root home
        (fs "/home/michal_atlas/tmp"
            "/home/michal_atlas/Downloads"
            #:flags '(bind-mount))))
