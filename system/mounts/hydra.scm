(define-module (system mounts hydra)
  #:use-module (system mounts common)
  #:use-module (gnu system file-systems)
  #:export (file-systems
            mapped-devices
            swap-devices))

(define rpool (lvm "rpool"))

(define spool (lvm "spool"))

(define spool-root (spool "root"))

(define root
  (fs "/dev/mapper/spool-root" "/" (list spool-root)
      #:subvol "@guix"
      #:flags '(shared)))

(define efi
  (file-system
    (mount-point "/boot/efi")
    (device (file-system-label "EFIBOOT"))
    (type "vfat")))

(define rpool-home (rpool "home"))

(define home
  (fs "/dev/mapper/rpool-home" "/home" (list rpool-home)
      #:subvol "@home"))

(define rpool-vault (rpool "vault"))

(define file-systems
  (list
   efi root home
   (fs "/dev/mapper/rpool-vault" "/home/michal_atlas/tmp"
       (list home rpool-vault)
       #:subvol "@tmp")
   (fs "/dev/mapper/rpool-vault" "/home/michal_atlas/Downloads"
       (list home rpool-vault)
       #:subvol "@tmp")
   (fs "/dev/mapper/rpool-vault" "/home/michal_atlas/Games"
       (list home rpool-vault)
       #:subvol "@games")
   (fs "/dev/mapper/rpool-vault" "/var/lib/transmission-daemon/downloads/"
       (list rpool-vault)
       #:subvol "@torrents")
   (fs "/dev/mapper/rpool-vault" "/var/lib/libvirt"
       (list rpool-vault)
       #:subvol "@vm")))

(define swap-devices
 (list (swap-space (target (file-system-label "SWAP")))))

(define mapped-devices
 (list
  rpool-vault rpool-home spool-root))
