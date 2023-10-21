(define-module (atlas config system filesystems)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:use-module (atlas combinators))

(define rpool (lvm "rpool"))

(define spool (lvm "spool"))

(define %swap
  (compose
   (if-host "dagon"
            ((mapped-swap-devices (rpool "swap"))
             (swap-space (target "/dev/mapper/rpool-swap"))))
   (if-host "hydra"
            (swap-devices
             (swap-space (target (file-system-label "SWAP")))))))

(define compress
  (cons "compress" "zstd"))

(define-public %filesystems
  (compose
   %swap
   (if-host "dagon"
            (file-systems
             (file-system
              (mount-point "/boot/efi")
              (device (uuid "D762-6C63" 'fat32))
              (type "vfat")))
            ((mapped-file-systems
              (rpool "home")
              (mapped-device
               (source "/dev/mapper/rpool-home")
               (target "crypthome")
               (type luks-device-mapping)))
             (file-system
              (mount-point "/home")
              (device "/dev/mapper/crypthome")
              (type "btrfs")))
            ((mapped-file-systems (rpool "root"))
             (file-system
              (mount-point "/")
              (device "/dev/mapper/rpool-root")
              (type "btrfs")
              (options
               (alist->file-system-options `(("subvol" . "@guix")
                                             ,compress))))))
   (if-host "hydra"
            (file-systems
             (file-system
              (mount-point "/boot/efi")
              (device (file-system-label "EFIBOOT"))
              (type "vfat")))
            ((mapped-file-systems
              (spool "root"))
             (file-system
              (mount-point "/")
              (device "/dev/mapper/spool-root")
              (options
               (alist->file-system-options `(("subvol" . "@guix")
                                             ,compress)))
              (type "btrfs")))
            ((mapped-file-systems
              (rpool "home"))
             (file-system
              (mount-point "/home")
              (device "/dev/mapper/rpool-home")
              (options
               (alist->file-system-options `(("subvol" . "@home")
                                             ,compress)))
              (type "btrfs")))
            ((mapped-file-systems
              (rpool "vault"))
             (file-system
              (mount-point "/home/michal_atlas/tmp")
              (device "/dev/mapper/rpool-vault")
              (options
               (alist->file-system-options '(("subvol" . "@tmp"))))
              (type "btrfs"))
             (file-system
              (mount-point "/home/michal_atlas/Downloads")
              (device "/dev/mapper/rpool-vault")
              (options
               (alist->file-system-options '(("subvol" . "@tmp"))))
              (type "btrfs"))
             (file-system
              (mount-point "/home/michal_atlas/Games")
              (device "/dev/mapper/rpool-vault")
              (options
               (alist->file-system-options `(("subvol" . "@games")
                                             ,compress)))
              (type "btrfs"))
             (file-system
              (mount-point "/var/lib/transmission-daemon/downloads/")
              (device "/dev/mapper/rpool-vault")
              (options
               (alist->file-system-options `(("subvol" . "@torrents")
                                             ,compress)))
              (type "btrfs"))))))
