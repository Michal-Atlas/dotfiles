(define-module (file-systems common)
  #:use-module (ice-9 curried-definitions)
  #:use-module (gnu system mapped-devices)
  #:export (lvm compress))

(define ((lvm pool) lv)
  (mapped-device
   (source pool)
   (target (string-append pool "-" lv))
   (type lvm-device-mapping)))

(define compress
  (cons "compress" "zstd"))