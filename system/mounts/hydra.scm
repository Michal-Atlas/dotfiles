(define-module (file-systems hydra)
  #:use-module (file-systems common)
  #:use-module (gnu system file-systems)
  #:export (file-systems
            mapped-devices
            swap-devices))

(define rpool (lvm "rpool"))

(define spool (lvm "spool"))

(define spool-root (spool "root"))

(define root
  (file-system
      (mount-point "/")
      (device "/dev/mapper/spool-root")
      (options
       (alist->file-system-options
        (cons
         '("subvol" . "@guix")
         common-flags)))
      (type "btrfs")
      (dependencies (list spool-root))))

(define efi
  (file-system
    (mount-point "/boot/efi")
    (device (file-system-label "EFIBOOT"))
    (type "vfat")))

(define rpool-home (rpool "home"))

(define home
 (file-system
   (mount-point "/home")
   (device "/dev/mapper/rpool-home")
   (options
    (alist->file-system-options
     (cons
      '("subvol" . "@home")
      common-flags)))
   (type "btrfs")
   (dependencies (list rpool-home))))

(define rpool-vault (rpool "vault"))

(define file-systems
  (list
   efi root home
   (file-system
     (mount-point "/home/michal_atlas/tmp")
     (device "/dev/mapper/rpool-vault")
     (options
      (alist->file-system-options
       (cons
        '("subvol" . "@tmp")
        common-flags)))
     (type "btrfs")
     (dependencies (list home rpool-vault)))
   (file-system
     (mount-point "/home/michal_atlas/Downloads")
     (device "/dev/mapper/rpool-vault")
     (options
      (alist->file-system-options
       (cons
        '("subvol" . "@tmp")
        common-flags)))
     (type "btrfs")
     (dependencies (list home rpool-vault)))
   (file-system
     (mount-point "/home/michal_atlas/Games")
     (device "/dev/mapper/rpool-vault")
     (options
      (alist->file-system-options
       (cons
        '("subvol" . "@games")
        common-flags)))
     (type "btrfs")
     (dependencies (list home rpool-vault)))
   (file-system
     (mount-point "/var/lib/transmission-daemon/downloads/")
     (device "/dev/mapper/rpool-vault")
     (options
      (alist->file-system-options
       (cons
        '("subvol" . "@torrents")
        common-flags)))
     (type "btrfs")
     (dependencies (list rpool-vault)))))

(define swap-devices
 (list (swap-space (target (file-system-label "SWAP")))))

(define mapped-devices
 (list
  rpool-vault rpool-home spool-root))
