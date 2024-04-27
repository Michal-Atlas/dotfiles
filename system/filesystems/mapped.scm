(define-library (system filesystems mapped)
  (import (scheme base)
          (utils services)
          (gnu system mapped-devices))
  (export %mapped-devices)
  (begin
    (define (lvm pool)
      (lambda (lv)
      (mapped-device
       (source pool)
       (target (string-append pool "-" lv))
       (type lvm-device-mapping))))

    (define (%mapped-devices host)
      (@host-append host
		    #:hydra
		    (map (lvm "spool") '("root"))
                    #:hydra
                    (map (lvm "rpool") '("vault"))
                    #:dagon
                    (append
                     (map (lvm "rpool") '("home" "root" "swap"))
                     (list
                      (mapped-device
                       (source "/dev/mapper/rpool-home")
                       (target "rpool-home-decrypted")
                       (type luks-device-mapping))))))))
