(define-library (home services)
  (import (scheme base)
          (guile)
          (atlas utils services)
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
          (gnu home-services gnupg)
          (unwox home pipewire)
          (atlas home services bash))
  (export %services)
  (begin
    (define (%services host)
      (append
       (list
        (%files host)
        %dconf
        %bash
        %flatpak
        %git
        (%mcron host)
        %shepherd
        %ssh)
       (macromap &s
                 (home-channels #:config %channels)
                 (home-dbus)
                 (home-gnupg)
                 (home-pipewire)
                 (home-direnv-bash)
                 (home-fzf-history-bash)
                 (home-fasd-bash))))))
