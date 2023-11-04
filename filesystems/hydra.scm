(begin
  (load "common.scm")
  (define rpool (lvm "rpool"))
  (define spool (lvm "spool"))

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
      (cons*
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
        (dependencies (list rpool-vault)))
       %base-file-systems))
     (swap-devices
      (list (swap-space (target (file-system-label "SWAP")))))
     (mapped-devices
      (list
       rpool-vault rpool-home spool-root)))))
