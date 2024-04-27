(define-module (system btrbk)
  #:use-module (atlas utils services)
  #:use-module (atlas services btrbk)
  #:use-module (guix gexp)
  #:use-module (rde features)
  #:export (feature-btrbk))

(define* (feature-btrbk
          #:key
          (schedule "24h")
          (path "/home"))
  (define (get-system-services config)
    (list
     (&s btrbk
         (config
          (plain-file "btrbk.conf"
                      (string-append
                       "
backend btrfs-progs-sudo
volume " path "
 subvolume .
  snapshot_create onchange
  snapshot_dir .btrfs
  snapshot_preserve " schedule "
  snapshot_preserve_min latest
  timestamp_format long-iso
"))))))
  (feature
   (name 'btrbk)
   (system-services-getter get-system-services)))
