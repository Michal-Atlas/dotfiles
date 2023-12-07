(define-module (home services)
  #:use-module (atlas utils services)
  #:use-module (home base)
  #:use-module (home bash)
  #:use-module (home files)
  #:use-module (home git)
  #:use-module (home lisp)
  #:use-module (home mcron)
  #:use-module (home nix)
  #:use-module (home nyxt)
  #:use-module (home packages)
  #:use-module (home pass)
  #:use-module (home ssh)
  #:use-module (home unison)
  #:use-module (home wm misc)
  #:use-module (home wm sway)
  #:use-module (home wm waybar)
  #:use-module (rde home services bittorrent)
  #:export (get-services))

(define (get-services)
  (cons*
   (&s home-transmission (auto-start? #t))
   pass
   (unison-get)
   bash
   files
   git
   mcron
   nix
   nyxt
   ssh
   wm:sway
   wm:waybar
   (append
    lisp
    packages-services
    wm:misc
    base-services)))
