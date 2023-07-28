(define-library (system filesystems mapped)
  (import (scheme base)
          (scheme lazy)
          (utils services)
          (gnu system mapped-devices))
  (export %mapped-devices)
  (begin
   (define %mapped-devices
     (delay
      (@host-append
       #:dagon
       (let* ((rpool-lvm (lambda (lv)
                           (mapped-device
                            (source "rpool")
                            (target (string-append "rpool-" lv))
		            (type lvm-device-mapping))))
              (lvm-maps
               (map rpool-lvm
                    '("home" "root" "swap"))))
         (append
          lvm-maps
          (list
           (mapped-device
            (source "/dev/mapper/rpool-home")
            (target "rpool-home-decrypted")
            (type luks-device-mapping))))))))))
