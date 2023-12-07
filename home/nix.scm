(define-module (home nix)
  #:use-module (atlas utils services)
  #:use-module (atlas home services nix)
  #:use-module (guix gexp)
  #:export (nix))

(define nix
 (&s home-nix
     (flake
      (local-file "../nix" "nix-home" #:recursive? #t))))
