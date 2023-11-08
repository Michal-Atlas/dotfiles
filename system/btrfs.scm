(define-module (system btrfs)
  #:use-module (atlas utils services)
  #:use-module (ice-9 curried-definitions)
  #:use-module (gnu services mcron)
  #:use-module (srfi srfi-1)
  #:use-module (guix gexp)
  #:use-module (gnu packages linux)
  #:export (btrfs-maid))

(define btrfs-maid
 (+s mcron btrfs-maid
     (let ((filesystems '("/" "/home"))
           (op '("scrub start"
                 "balance start --full-balance")))
       (define ((job fs) op)
         #~(job "0 0 * * 6"
                (string-append
                 #$(file-append btrfs-progs "/bin/btrfs")
                 " " #$op " " #$fs)
                #$(string-append "btrfs-maid " op " (" fs ")")))
       (append-map
        (lambda (fs)
          (map (job fs) op))
        filesystems))))
