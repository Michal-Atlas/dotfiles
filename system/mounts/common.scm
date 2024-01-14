(define-module (system mounts common)
  #:use-module (ice-9 curried-definitions)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system file-systems)
  #:export (lvm fs
                common-options
                common-flags))

(define ((lvm pool) lv)
  (mapped-device
   (source pool)
   (target (string-append pool "-" lv))
   (type lvm-device-mapping)))

(define common-options
  '(("compress" . "zstd")))

(define common-flags
  '(no-atime))

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
