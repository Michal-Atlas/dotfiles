(define-module (atlas config home services nix)
  #:use-module (atlas combinators)
  #:use-module (atlas home services nix))

(define-public %nix
  (hm/&s home-nix #:config
         (string-append
          (getenv "DOTFILE_ROOT")
          "/nix")))
