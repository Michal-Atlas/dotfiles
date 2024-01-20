(define-module (system dagon)
  #:use-module (atlas utils services)
  #:use-module (gnu services pm)
  #:use-module (gnu services pam-mount)
  #:use-module (system mounts common)
  #:use-module (gnu system file-systems)
  #:use-module (nongnu packages linux)
  #:use-module (gnu services)
  #:export (dagon:services))

(define dagon:services
  (list
   (&s tlp
    (cpu-boost-on-ac? #t)
    (wifi-pwr-on-bat? #t))
   (+s firmware intel (list intel-microcode))))
