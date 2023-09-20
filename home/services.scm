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
	  (home services dconf)
          (gnu home-services gnupg))
  (export %services)
  (begin
    (define (%services host)
      (list
       (&s home-channels #:config %channels)
       (&s home-dbus)
       (%files host)
       %dconf
       %bash
       %flatpak
       %git
       (%mcron host)
       %shepherd
       %ssh
       (&s home-gnupg)))))
