(define-module (home nix)
  #:use-module (atlas utils services)
  #:use-module (atlas home services nix)
  #:export (nix))

(define nix
 (&s home-nix #:config
     (string-append
      (getenv "DOTFILE_ROOT")
      "/nix")))
