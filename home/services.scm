(define-library (home services)
  (import (scheme base)
          (scheme lazy)
          (except (guile) force delay)
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
      (delay
       (cons*
        (&s home-channels #:config %channels)
        (&s home-dbus)
        (force %files)
        %bash
        %flatpak
        %git
        %mcron
        %shepherd
        %ssh
        %wm)))))
