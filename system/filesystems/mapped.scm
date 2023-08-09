(define-library (system filesystems mapped)
  (import (scheme base)
          (utils services)
          (gnu system mapped-devices))
  (export %mapped-devices)
  (begin
    (define (rpool-lvm lv)
      (mapped-device
       (source "rpool")
       (target (string-append "rpool-" lv))
       (type lvm-device-mapping)))
    
    (define (%mapped-devices host)
      (@host-append host
                    #:hydra
                    (map rpool-lvm '("vault"))
                    #:dagon
                    (append
                     (map rpool-lvm '("home" "root" "swap"))
                     (list
                      (mapped-device
                       (source "/dev/mapper/rpool-home")
                       (target "rpool-home-decrypted")
                       (type luks-device-mapping))))))))
