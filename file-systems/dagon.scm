(define-module (file-systems dagon)
  #:use-module (file-systems common)
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
  (file-system
    (mount-point "/")
    (device "/dev/mapper/rpool-root")
    (type "btrfs")
    (options
     (alist->file-system-options `(("subvol" . "@guix")
                                   ,compress)))
    (dependencies (list rpool-root))))

(define efi
  (file-system
   (mount-point "/boot/efi")
   (device (uuid "D762-6C63" 'fat32))
   (type "vfat")))

(define home
 (file-system
   (mount-point "/home")
   (device "/dev/mapper/crypthome")
   (type "btrfs")
   (options
    (alist->file-system-options `(,compress)))
   (dependencies (list unlock-home))))

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
  (list efi root home))
