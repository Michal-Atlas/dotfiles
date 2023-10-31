(begin
  (load "common.scm")
  (define rpool (lvm "rpool"))
  (define spool (lvm "spool"))

  (let* ((rpool-root (rpool "root"))
         (rpool-home (rpool "home"))
         (unlock-home
          (mapped-device
           (source "/dev/mapper/rpool-home")
           (target "crypthome")
           (type luks-device-mapping)))
         (root
             (file-system
              (mount-point "/")
              (device "/dev/mapper/rpool-root")
              (type "btrfs")
              (options
               (alist->file-system-options `(("subvol" . "@guix")
                                             ,compress)))
              (dependencies (list rpool-root))))
         (efi
          (file-system
           (mount-point "/boot/efi")
           (device (uuid "D762-6C63" 'fat32))
           (type "vfat")))
         (home
          (file-system
           (mount-point "/home")
           (device "/dev/mapper/crypthome")
           (type "btrfs")
           (options
            (alist->file-system-options `(,compress)))
           (dependencies (list unlock-home)))))
    (if-host "dagon"
             (mapped-devices
              unlock-home rpool-home rpool-root)
             (file-systems
              efi root home)))

  (let* ((spool-root (spool "root"))
         (root
             (file-system
              (mount-point "/")
              (device "/dev/mapper/spool-root")
              (options
               (alist->file-system-options `(("subvol" . "@guix")
                                             ,compress)))
              (type "btrfs")
              (dependencies (list spool-root))))
         (efi
          (file-system
           (mount-point "/boot/efi")
           (device (file-system-label "EFIBOOT"))
           (type "vfat")))
         (rpool-home (rpool "home"))
         (home
          (file-system
           (mount-point "/home")
           (device "/dev/mapper/rpool-home")
           (options
            (alist->file-system-options `(("subvol" . "@home")
                                          ,compress)))
           (type "btrfs")
           (dependencies (list rpool-home))))
         (rpool-vault (rpool "vault")))
    (operating-system
     (host-name #f) (bootloader #f)
     (file-systems
      (list
       efi root home
       (file-system
        (mount-point "/home/michal_atlas/tmp")
        (device "/dev/mapper/rpool-vault")
        (options
         (alist->file-system-options '(("subvol" . "@tmp"))))
        (type "btrfs")
        (dependencies (list home rpool-vault)))
       (file-system
        (mount-point "/home/michal_atlas/Downloads")
        (device "/dev/mapper/rpool-vault")
        (options
         (alist->file-system-options '(("subvol" . "@tmp"))))
        (type "btrfs")
        (dependencies (list home rpool-vault)))
       (file-system
        (mount-point "/home/michal_atlas/Games")
        (device "/dev/mapper/rpool-vault")
        (options
         (alist->file-system-options `(("subvol" . "@games")
                                       ,compress)))
        (type "btrfs")
        (dependencies (list home rpool-vault)))
       (file-system
        (mount-point "/var/lib/transmission-daemon/downloads/")
        (device "/dev/mapper/rpool-vault")
        (options
         (alist->file-system-options `(("subvol" . "@torrents")
                                       ,compress)))
        (type "btrfs")
        (dependencies (list rpool-vault)))))
     (swap-devices
      (list (swap-space (target (file-system-label "SWAP")))))
     (mapped-devices
      (list
       rpool-vault rpool-home spool-root)))))
