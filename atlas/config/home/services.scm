(define-module (atlas config home services)
  #:use-module (atlas combinators)
  #:use-module (atlas config channels)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services desktop)
  #:use-module (atlas config home files)
  #:use-module (atlas config home services bash)
  #:use-module (atlas config home services git)
  #:use-module (atlas config home services mcron)
  #:use-module (atlas config home services ssh)
  #:use-module (atlas config home services nyxt)
  #:use-module (atlas config home services lisp)
  #:use-module (atlas config home services nix)
  #:use-module (atlas config home services wm)
  #:use-module (gnu home-services gnupg)
  #:use-module (unwox home pipewire)
  #:use-module (atlas home services bash)
  #:use-module (rde home services desktop)
  #:use-module (rde home services gtk))

(define-public %services
  (compose
   %bash
   %git
   %nix
   %mcron
   %nyxt
   %lisp
   %ssh
   %files
   %wm
   (hm/&s home-channels #:config %channels)
   (hm/&s home-dbus)
   (hm/&s home-gnupg)
   (hm/&s home-pipewire)
   (hm/&s home-direnv-bash)
   (hm/&s home-fzf-history-bash)
   (hm/&s home-fasd-bash)
   (hm/&s home-udiskie)))
