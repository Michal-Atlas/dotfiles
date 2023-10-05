(define-module (atlas system filesystems mapped)
  #:use-module (scheme base)
  #:use-module (atlas utils combinators)
  #:use-module (gnu system mapped-devices))

(define (lvm pool)
  (lambda (lv)
    (mapped-device
     (source pool)
     (target (string-append pool "-" lv))
     (type lvm-device-mapping))))

(define-public %mapped-devices-hydra
  (append (map (lvm "spool") '("root"))
          (map (lvm "rpool") '("vault"))))

(define-public %mapped-devices-dagon
  (cons
   (mapped-device
    (source "/dev/mapper/rpool-home")
    (target "crypthome")
    (type luks-device-mapping))
   (map (lvm "rpool") '("home" "root" "swap"))))

(define-public %mapped-devices
  (compose
   (if-host "hydra"
            (apply mapped-devices %mapped-devices-hydra))
   (if-host "dagon"
            (apply mapped-devices %mapped-devices-dagon))))
