(define-module (system firmware)
  #:use-module (atlas utils services)
  #:use-module (gnu services)
  #:use-module (nongnu packages linux)
  #:export (firmware))

(define-public firmware
  (+s firmware linux (list linux-firmware)))
