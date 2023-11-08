(define-module (system dagon)
  #:use-module (atlas utils services)
  #:use-module (gnu services pm)
  #:export (dagon:services))

(define dagon:services
  (list
   (&s tlp
    (cpu-boost-on-ac? #t)
    (wifi-pwr-on-bat? #t))))
