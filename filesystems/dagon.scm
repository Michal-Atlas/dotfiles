(begin
  (load "common.scm")

  (define rpool (lvm "rpool"))

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
           (dependencies (list unlock-home))))
         (rpool-swap (rpool "swap")))
    (operating-system
     (host-name #f) (bootloader #f)
     (swap-devices
      (list
       (swap-space (target "/dev/mapper/rpool-swap")
                   (dependencies (list rpool-swap)))))
     (mapped-devices (list rpool-swap
                           unlock-home
                           rpool-home
                           rpool-root))
     (file-systems
      (cons* efi root home %base-file-systems)))))
