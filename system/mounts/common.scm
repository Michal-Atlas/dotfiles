(define-module (system mounts common)
  #:use-module (ice-9 curried-definitions)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system file-systems)
  #:export (lvm fs
                common-options
                common-flags
                router-disk))

(define ((lvm pool) lv)
  (mapped-device
   (source pool)
   (target (string-append pool "-" lv))
   (type lvm-device-mapping)))

(define common-options
  '(("compress" . "zstd")))

(define common-flags
  '(no-atime))

(define router-disk
  (file-system
    (type "cifs")
    (device "//192.168.0.1/sda1")
    (options "vers=1.0,password=")
    (mount? #f)
    (mount-point "/shares/router-disk")
    (create-mount-point? #t)))

(define* (fs source target
             #:optional (dependencies '())
             #:key (flags '()) (options '()) subvol)
  (file-system
   (mount-point target)
   (device source)
   (type "btrfs")
   (flags (append flags common-flags))
   (options
    (alist->file-system-options
     (let ((opts (append options common-options)))
       (if subvol (cons `("subvol" . ,subvol) opts)
           opts))))
   (dependencies dependencies)))
