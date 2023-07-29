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
	                 (dependencies (%mapped-devices host)))
               #:dagon (file-system
                         (mount-point "/home")
                         (device "/dev/mapper/rpool-home-decrypted")
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
                         (device (uuid
                                  "e2f2bd08-7962-4e9d-a22a-c66972b7b1e3"
                                  'btrfs))
                         (options
                          (alist->file-system-options '(("subvol" . "@guix"))))
                         (type "btrfs"))
               #:hydra (file-system
                         (mount-point "/home")
                         (device (uuid
                                  "e2f2bd08-7962-4e9d-a22a-c66972b7b1e3"
                                  'btrfs))
                         (options
                          (alist->file-system-options '(("subvol" . "@home"))))
                         (type "btrfs"))
               #:hydra (file-system
                         (mount-point "/GAMES")
                         (device (file-system-label "VAULT"))
                         (options
                          (alist->file-system-options '(("subvol" . "@games"))))
                         (type "btrfs"))
               #:hydra (file-system
                         (mount-point "/var/lib/ipfs")
                         (device (file-system-label "VAULT"))
                         (options
                          (alist->file-system-options '(("subvol" . "@ipfs"))))
                         (type "btrfs"))
               #:hydra (file-system
                         (mount-point "/DOWNLOADS")
                         (device (file-system-label "VAULT"))
                         (options
                          (alist->file-system-options '(("subvol" . "@downloads"))))
                         (type "btrfs"))
               #:hydra (file-system
                         (mount-point "/var/lib/transmission-daemon/downloads/")
                         (device (file-system-label "VAULT"))
                         (options
                          (alist->file-system-options '(("subvol" . "@torrents"))))
                         (type "btrfs")))))))
