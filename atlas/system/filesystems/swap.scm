(define-module (atlas system filesystems swap)
  #:use-module (atlas utils combinators)
  #:use-module (atlas system filesystems mapped)
  #:use-module (gnu system file-systems))

(define-public %swap 
  (compose 
   (if-host "dagon"
            (swap-devices
             (swap-space
              (target "/dev/mapper/rpool-swap")
              (dependencies %mapped-devices-dagon))))
   (if-host "hydra"
            (swap-devices
             (swap-space
              (target (file-system-label "SWAP")))))))
