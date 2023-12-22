(define-module (system dagon)
  #:use-module (atlas utils services)
  #:use-module (gnu services pm)
  #:use-module (gnu services pam-mount)
  #:use-module (system mounts common)
  #:use-module (gnu system file-systems)
  #:export (dagon:services))

(define dagon:services
  (list
   (&s tlp
    (cpu-boost-on-ac? #t)
    (wifi-pwr-on-bat? #t))

   (+s pam-mount-volume encrypted-home
       (list (pam-mount-volume
              (user-name "michal_atlas")
              (file-system-type "crypt")
              (file-name "/dev/mapper/rpool-home")
              (mount-point "~")
              (options
               (alist->file-system-options
                common-options)))))))
