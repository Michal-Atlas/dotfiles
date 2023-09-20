(define-library (system filesystems)
  (import (scheme base)
          (gnu system file-systems)
          (utils services)
          (system filesystems mapped))
  (export %filesystems)
  (begin
    (define (%filesystems host)
      (append %base-file-systems
              (@host host
               #:dagon (file-system
	                 (mount-point "/")
	                 (device "/dev/mapper/rpool-root")
	                 (type "btrfs")
                         (options
                          (alist->file-system-options '(("subvol" . "@guix"))))
	                 (dependencies (%mapped-devices host)))
               #:dagon (file-system
                         (mount-point "/home")
                         (device "/dev/mapper/crypthome")
                         (type "btrfs")
                         (dependencies (%mapped-devices host)))
               #:dagon (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "D762-6C63" 'fat32))
                         (type "vfat"))
               #:hydra (file-system
                         (mount-point "/boot/efi")
                         (device (file-system-label "EFIBOOT"))
                         (type "vfat"))
               #:hydra (file-system
                         (mount-point "/")
                         (device "/dev/mapper/spool-root")
                         (options
                          (alist->file-system-options '(("subvol" . "@guix"))))
                         (type "btrfs"))
               #:hydra (file-system
                         (mount-point "/home")
                         (device "/dev/mapper/spool-root")
                         (options
                          (alist->file-system-options '(("subvol" . "@home"))))
                         (type "btrfs"))
               #:hydra (file-system
                         (mount-point "/home/michal_atlas/tmp")
                         (device "/dev/mapper/rpool-vault")
                         (options
                          (alist->file-system-options '(("subvol" . "@tmp"))))
                         (type "btrfs")
                         (dependencies (%mapped-devices host)))
               #:hydra (file-system
                         (mount-point "/home/michal_atlas/Downloads")
                         (device "/dev/mapper/rpool-vault")
                         (options
                          (alist->file-system-options '(("subvol" . "@tmp"))))
                         (type "btrfs")
                         (dependencies (%mapped-devices host)))
               #:hydra (file-system
                         (mount-point "/home/michal_atlas/Games")
                         (device "/dev/mapper/rpool-vault")
                         (options
                          (alist->file-system-options '(("subvol" . "@games"))))
                         (type "btrfs")
                         (dependencies (%mapped-devices host)))
               #:hydra (file-system
                         (mount-point "/var/lib/transmission-daemon/downloads/")
                         (device "/dev/mapper/rpool-vault")
                         (options
                          (alist->file-system-options '(("subvol" . "@torrents"))))
                         (type "btrfs")
                         (dependencies (%mapped-devices host))))))))
