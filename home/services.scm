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
  #:use-module (rde home services bittorrent)
  #:use-module (rde home services i2p)
  #:export (get-services))

(define (get-services)
  (cons*
   (&s home-i2pd)
   pass
   bash
   git
   mcron
   nix
   nyxt
   ssh
   packages
   (append
    files
    lisp
    base-services)))
