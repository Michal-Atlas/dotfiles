(&s btrbk
    (config
     (plain-file "btrbk.conf"
                 (let ((schedule
                        (match (gethostname)
                          ("hydra" "24h 31d 4w 12m")
                          ("dagon" "24h 4d"))))
                  (string-append
                   "
backend btrfs-progs-sudo
volume /home
 subvolume .
  snapshot_create onchange
  snapshot_dir .btrfs
  snapshot_preserve " schedule "
  snapshot_preserve_min latest
  timestamp_format long-iso
")))))
