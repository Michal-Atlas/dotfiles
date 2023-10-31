(define ((lvm pool) lv)
  (mapped-device
   (source pool)
   (target (string-append pool "-" lv))
   (type lvm-device-mapping)))

(define compress
  (cons "compress" "zstd"))
