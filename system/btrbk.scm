(define-module (system btrbk)
  #:use-module (atlas utils services)
  #:use-module (atlas services btrbk)
  #:use-module (guix gexp)
  #:export (btrbk
            btrbk-schedule
            btrbk-path))

(define btrbk-schedule (make-parameter "24h"))
(define btrbk-path (make-parameter "/home"))

(define (btrbk)
  (&s btrbk
      (config
       (plain-file "btrbk.conf"
                   (string-append
                    "
backend btrfs-progs-sudo
volume " (btrbk-path) "
 subvolume .
  snapshot_create onchange
  snapshot_dir .btrfs
  snapshot_preserve " (btrbk-schedule) "
  snapshot_preserve_min latest
  timestamp_format long-iso
")))))
