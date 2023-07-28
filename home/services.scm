(define-library (home services)
  (import (scheme base)
          (guile)
          (utils services)
          (channels)
          (gnu home services guix)
          (gnu home services desktop)
          (home files)
          (home services bash)
          (home services flatpak)
          (home services git)
          (home services mcron)
          (home services shepherd)
          (home services ssh)
          (home services wm))
  (export %services)
  (begin
    (define %services
     (cons*
      (&s home-channels #:config %channels)
      (&s home-dbus)
      %files
      %bash
      %flatpak
      %git
      %mcron
      %shepherd
      %ssh
      %wm))))
