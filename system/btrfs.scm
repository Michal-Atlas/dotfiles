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
       filesystems)))
