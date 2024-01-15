(define-module (home base)
  #:use-module (atlas utils services)
  #:use-module (channels)
  #:use-module (gnu home services sound)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services xdg)
  #:use-module (atlas home services bash)
  #:use-module (rde home services desktop)
  #:export (base-services))

(define base-services
 (list
  (&s home-channels #:config %channels)
  (&s home-dbus)
  (&s home-gpg-agent)
  (&s home-pipewire)
  (&s home-direnv-bash)
  (&s home-fzf-history-bash)
  (&s home-fasd-bash)
  (&s home-udiskie)
  (&s home-xdg-mime-applications
      (default
        `(("application/pdf" . "okularApplication_pdf.desktop"))))))
