(define-module (atlas system filesystems)
  #:use-module (gnu system file-systems)
  #:use-module (atlas utils combinators)
  #:use-module (atlas system filesystems mapped))

(define-public %filesystems
  (compose
   (if-host "dagon"
            (file-systems
             (file-system
              (mount-point "/")
              (device "/dev/mapper/rpool-root")
              (type "btrfs")
              (options
               (alist->file-system-options '(("subvol" . "@guix"))))
              (dependencies %mapped-devices-dagon))
             (file-system
              (mount-point "/home")
              (device "/dev/mapper/crypthome")
              (type "btrfs")
              (dependencies %mapped-devices-dagon))
             (file-system
              (mount-point "/boot/efi")
              (device (uuid "D762-6C63" 'fat32))
              (type "vfat"))))
   (if-host "hydra"
            (file-systems
             (file-system
              (mount-point "/boot/efi")
              (device (file-system-label "EFIBOOT"))
              (type "vfat"))
             (file-system
              (mount-point "/")
              (device "/dev/mapper/spool-root")
              (options
               (alist->file-system-options '(("subvol" . "@guix"))))
              (type "btrfs"))
             (file-system
              (mount-point "/home")
              (device "/dev/mapper/spool-root")
              (options
               (alist->file-system-options '(("subvol" . "@home"))))
              (type "btrfs"))
             (file-system
              (mount-point "/home/michal_atlas/tmp")
              (device "/dev/mapper/rpool-vault")
              (options
               (alist->file-system-options '(("subvol" . "@tmp"))))
              (type "btrfs")
              (dependencies %mapped-devices-hydra))
             (file-system
              (mount-point "/home/michal_atlas/Downloads")
              (device "/dev/mapper/rpool-vault")
              (options
               (alist->file-system-options '(("subvol" . "@tmp"))))
              (type "btrfs")
              (dependencies %mapped-devices-hydra))
             (file-system
              (mount-point "/home/michal_atlas/Games")
              (device "/dev/mapper/rpool-vault")
              (options
               (alist->file-system-options '(("subvol" . "@games"))))
              (type "btrfs")
              (dependencies %mapped-devices-hydra))
             (file-system
              (mount-point "/var/lib/transmission-daemon/downloads/")
              (device "/dev/mapper/rpool-vault")
              (options
               (alist->file-system-options '(("subvol" . "@torrents"))))
              (type "btrfs")
              (dependencies %mapped-devices-hydra))))))
