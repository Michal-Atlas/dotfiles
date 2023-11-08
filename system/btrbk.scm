(define-module (system btrbk)
  #:use-module (atlas utils define)
  #:use-module (atlas utils services)
  #:use-module (atlas services btrbk)
  #:use-module (guix gexp)
  #:export (btrbk))

(define/cp pass (btrbk btrbk-schedule)
  (&s btrbk
      (config
       (plain-file "btrbk.conf"
                   (string-append
                    "
backend btrfs-progs-sudo
volume /home
 subvolume .
  snapshot_create onchange
  snapshot_dir .btrfs
  snapshot_preserve " btrbk-schedule "
  snapshot_preserve_min latest
  timestamp_format long-iso
")))))
